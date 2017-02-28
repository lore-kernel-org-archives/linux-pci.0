Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-co1nam03on0040.outbound.protection.outlook.com ([104.47.40.40]:33010
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751665AbdCABqz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Feb 2017 20:46:55 -0500
From: "Madhani, Himanshu" <Himanshu.Madhani@cavium.com>
To: "Madhani, Himanshu" <Himanshu.Madhani@cavium.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH] PCI/MSI: Only disable affinity settings if pre and post
 vector count is equal to max_vecs and not min_vecs
Date: Tue, 28 Feb 2017 22:05:35 +0000
Message-ID: <SN1PR0701MB1837A1C658B0AEF245917829F5560@SN1PR0701MB1837.namprd07.prod.outlook.com>
References: <1487883699-3528-1-git-send-email-himanshu.madhani@cavium.com>
In-Reply-To: <1487883699-3528-1-git-send-email-himanshu.madhani@cavium.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Christoph, Bjorn,=20

Does this updated patch looks good. Please review.=20

Thanks,
Himanshu


> -----Original Message-----
> From: Himanshu Madhani [mailto:himanshu.madhani@cavium.com]
> Sent: Thursday, February 23, 2017 1:02 PM
> To: bhelgaas@google.com; linux-pci@vger.kernel.org; hch@lst.de
> Cc: Madhani, Himanshu <Himanshu.Madhani@cavium.com>
> Subject: [PATCH] PCI/MSI: Only disable affinity settings if pre and post =
vector
> count is equal to max_vecs and not min_vecs
>=20
> From: Michael Hernandez <michael.hernandez@cavium.com>
>=20
> min_vecs is the minimum amount of vectors needed to operate in MSI-X
> mode which may just include the vectors that don't need affinity.
>=20
> Disabling affinity settings causes the qla2xxx driver scsi_add_host to fa=
il
> when blk_mq is enabled as the blk_mq_pci_map_queues expects affinity
> masks on each vector.
>=20
> v1 --> v2
>=20
> o Moved the check from pci_alloc_irq_vectors_affinity() to
>   __pci_enable_{msi|msix}_range()
>=20
> Fixes: dfef358 ("PCI/MSI: Don't apply affinity if there aren't enough vec=
tors
> left")
> Signed-off-by: Michael Hernandez <michael.hernandez@cavium.com>
> Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/msi.c |   32 ++++++++++++++++++++++----------
>  1 files changed, 22 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c index 7f73bac..c61039b
> 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1091,6 +1091,17 @@ static int __pci_enable_msi_range(struct pci_dev
> *dev, int minvec, int maxvec,
>=20
>  	for (;;) {
>  		if (affd) {
> +			if (affd->pre_vectors + affd->post_vectors > nvec)
> +				return -EINVAL;
> +			/*
> +			 * If there aren't any vectors left after applying the
> +			 * pre/post vectors don't bother with assigning
> +			 * affinity.
> +			 */
> +			if (affd->pre_vectors + affd->post_vectors =3D=3D nvec)
> +				affd =3D NULL;
> +		}
> +		if (affd) {
>  			nvec =3D irq_calc_affinity_vectors(nvec, affd);
>  			if (nvec < minvec)
>  				return -ENOSPC;
> @@ -1138,6 +1149,17 @@ static int __pci_enable_msix_range(struct pci_dev
> *dev,
>=20
>  	for (;;) {
>  		if (affd) {
> +			if (affd->pre_vectors + affd->post_vectors > nvec)
> +				return -EINVAL;
> +			/*
> +			 * If there aren't any vectors left after applying the
> +			 * pre/post vectors don't bother with assigning
> +			 * affinity.
> +			 */
> +			if (affd->pre_vectors + affd->post_vectors =3D=3D nvec)
> +				affd =3D NULL;
> +		}
> +		if (affd) {
>  			nvec =3D irq_calc_affinity_vectors(nvec, affd);
>  			if (nvec < minvec)
>  				return -ENOSPC;
> @@ -1206,16 +1228,6 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev
> *dev, unsigned int min_vecs,
>  	if (flags & PCI_IRQ_AFFINITY) {
>  		if (!affd)
>  			affd =3D &msi_default_affd;
> -
> -		if (affd->pre_vectors + affd->post_vectors > min_vecs)
> -			return -EINVAL;
> -
> -		/*
> -		 * If there aren't any vectors left after applying the pre/post
> -		 * vectors don't bother with assigning affinity.
> -		 */
> -		if (affd->pre_vectors + affd->post_vectors =3D=3D min_vecs)
> -			affd =3D NULL;
>  	} else {
>  		if (WARN_ON(affd))
>  			affd =3D NULL;
> --
> 1.7.1
