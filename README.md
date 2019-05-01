# Secure multi-party linear regression at plaintext speed
##### [Jonathan Bloom](https://www.broadinstitute.org/bios/jonathan-bloom)

We detail a scheme for scalable, secure multi-party linear regression at essentially the same speed as plaintext regression. While the core ideas are simple, the recognition of their broad utility when combined is novel. By leveraging a recent advance in secure multi-party principal component analysis, our scheme opens the door to efficient and secure genome-wide association studies across multiple biobanks.

[arXiv preprint](https://arxiv.org/pdf/1901.09531.pdf).

[R demo](https://github.com/jbloom22/DASH/blob/master/dash.r) of the distributed association scan hammer (DASH). Note that by compressing directly with `C_i^T` rather than `Q_i^T`, the global `R` need not be shared publically and covariates may be selected post-compression.

Coming to [Hail](https://hail.is/about.html) someday.

Feedback welcome! Contact Jon: jbloom@broadinstitute.org
