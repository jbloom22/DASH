# Secure multi-party linear regression at plaintext speed
##### [Jonathan M. Bloom](https://www.broadinstitute.org/bios/jonathan-bloom), [Hail Team](hail.is) / [Neale Lab](http://www.nealelab.is) / [Stanley Center for Psychiatric Research](https://www.broadinstitute.org/stanley), [Broad Institute of MIT and Harvard](https://www.broadinstitute.org/about-us)

We detail distributed algorithms for scalable, secure multi-party linear regression and feature selection at essentially the same speed as plaintext regression. While the core geometric ideas are simple, their broad utility in combination is novel. Our scheme opens the door to efficient and secure genome-wide association studies across multiple biobanks.

Read the [arXiv preprint](https://arxiv.org/abs/1901.09531).

Run the [Python demo](https://github.com/jbloom22/DASH/blob/master/secure_linear_regression.ipynb) of secure multi-party linear regression in Section 2.

Run the [Python demo](https://github.com/jbloom22/DASH/blob/master/dash.ipynb) and [R demo](https://github.com/jbloom22/DASH/blob/master/dash.r) of the distributed association scan hammer (DASH) in Section 4.

[Hail](https://hail.is/about.html) uses the single-party distributed algorithm to enable [massive genomic analyses](http://www.nealelab.is/uk-biobank/) and will include multi-party algorithms someday. Also check out the exciting work on secure genomics by [Hoon Cho](https://hhcho.com/) and colleagues.

Implementation in the core OpenMined code base is being supported by an [RAAIS OpenMined Grant](https://blog.openmined.org/raais/).

Feedback welcome! Write Jon: jbloom@broadinstitute.org
