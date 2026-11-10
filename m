Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794301126;
	b=njAFnJjQN62xTjAvHlpUk1Nh9FhExEN7YL2fGaP3mMJx8espmAc8sKdk9eV0AkFOUOL9
	 xqLDAB0xdjMwlac8dE5k0+JFPJT4ai9CPu38ZGJT0RH6Qhk3yCrmDpRnuxxs8AxxuGzcE
	 SksVNQYLUp5NqtyNmB5d3d4BdD8YkyNNGu+NF9fjnJ8s68GRMz5RT88CdzILpvjT/STRf
	 nZrpG35bH/X30me96cKXZFhzt7GBKctO35uScoaVcsq+gi6xlyqfeW1wh5muStSwQbUN9
	 0B1PvNPEgQppfSONGhkebGONQ3HoQDGQ6zzSGKZkXI7hGfoLzeb7rO7tVh4UFzmWs+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301126;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xhVWndVR0o6SKTuadyxAZL9oN674X8yuA97DrjcZg2U=;
	b=gr3Yi33KQmP9P5/f3312InAfNv9S2LJFUYrjQz8PgMABM4wkMfz8mqLJnScz8ZpzcNFs
	 DDnjsHjQnh5Rt66jg114Sh/3j6ua0UZAsVBnxahQLs9zMOEaGI4fngjEZ4syhd+OyuQ4o
	 jScXyehzb7zYFgAZI9VlrYT7vTIiPnMBEP1OnwJpkMbPar59SNEae0IMwQHRduPOSVdOM
	 jUubp3h9lchgrnBDV9WKdxIadEOGcbkeGpLCUR6479KlhA/L803t2GGu7/5tx8iCmZI/0
	 ao9RY6I5v2vB1a1bKY+74RBAdYVRevS4/+dDjI5Qy7M+vsowO1bbAY5IFdrI5+LisDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IyFZ8v5T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CE260A2628;
	Tue, 10 Nov 2026 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IyFZ8v5T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC311F008BF;
	Tue, 10 Nov 2026 08:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794301125;
	bh=xhVWndVR0o6SKTuadyxAZL9oN674X8yuA97DrjcZg2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IyFZ8v5TTlePo0Hh6D34oCUkZXHkZ+RStYOGMjLX/lhAydKK0ImkZpbPY63VaEM3X
	 CzRFuMGnfo7toJncmsXEra2YY1kkz9Q3wMo+dPTboBrk5bVLx5EaFPBB/HAMJboH4W
	 YWvwB8M5eckqkHS8IXhqgpFoVNuSRNjnnk1R9fxZLSussCl2qc2e01pJPuysgai8WB
	 YdImJniSPcQCI5iESIwCpV2Z64cf1aiaaFXnMuLrKVKwJ+MNzLB+CjkbVZVf8/sgG1
	 HQv4Q1lmB30nvU6w+S9Rmojz3sOKacWMvohK/M960IRdKbI20mGZOEe6y/m0737r0F
	 b1CIc+RvKDj/w==
Message-ID: <sashiko-outbox-206684@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/10] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20261110082459.1798763-10-den@valinux.co.jp>
References: <20261110082459.1798763-1-den@valinux.co.jp>
 <20261110082459.1798763-10-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:58:45 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] NTB: ntb_hw_epf: DMA IRQ reservation conflicts with vNTB tail
  doorbell vector
--

commit f7a63c5c0603979fdb93290006c7e19909b1a6bf
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_hw_epf: Discover vNTB-embedded DMA

This commit decodes the vNTB endpoint-local DMA extension in ntb_hw_epf
and registers advertised DW eDMA channels before registering the NTB
device.

> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_=
epf.c
> index ff92c2a61ce7d..e0016128b95c0 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c

[ ... ]

> @@ -347,16 +581,20 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *nde=
v, int msi_min, int msi_max)
>  {
>  	struct pci_dev *pdev =3D ndev->ntb.pdev;
>  	struct device *dev =3D ndev->dev;
> +	unsigned int dma_max =3D ndev->dma.nr_irqs;
> +	unsigned int dma_min;
>  	u32 argument =3D EPF_NTB_MSIX_ENABLE;
> +	unsigned int ntb_irqs;
>  	int irq;
>  	int ret;
>  	int i;
> =20
> -	irq =3D pci_alloc_irq_vectors(pdev, msi_min, msi_max, PCI_IRQ_MSIX);
> +	irq =3D pci_alloc_irq_vectors(pdev, msi_min,
> +				    msi_max + dma_max, PCI_IRQ_MSIX);
>  	if (irq < 0) {
>  		dev_dbg(dev, "Failed to get MSIX interrupts\n");
> -		irq =3D pci_alloc_irq_vectors(pdev, msi_min, msi_max,
> -					    PCI_IRQ_MSI);
> +		irq =3D pci_alloc_irq_vectors(pdev, msi_min,
> +					    msi_max + dma_max, PCI_IRQ_MSI);
>  		if (irq < 0) {
>  			dev_err(dev, "Failed to get MSI interrupts\n");
>  			return irq;
> @@ -364,8 +602,17 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev=
, int msi_min, int msi_max)
>  		argument &=3D ~EPF_NTB_MSIX_ENABLE;
>  	}
> =20
> -	ndev->db_count =3D irq - 1;
> -	for (i =3D 0; i < irq; i++) {
> +	dma_min =3D dma_max && irq > msi_min;
> +	/* Reserve one shared DMA IRQ when available, then give the rest to NTB=
. */
> +	ntb_irqs =3D min_t(unsigned int, irq - dma_min, msi_max);
> +	ndev->dma.nr_irqs =3D irq - ntb_irqs;
> +	if (dma_max && !ndev->dma.nr_irqs) {
> +		dev_warn(dev,
> +			 "No IRQ available for endpoint DMA, continuing without DMA\n");
> +		ndev->dma.type =3D 0;
> +	}
> +	ndev->db_count =3D ntb_irqs - 1;
> +	for (i =3D 0; i < ntb_irqs; i++) {
>  		ndev->irq_ctx[i].ndev =3D ndev;
>  		ndev->irq_ctx[i].irq_no =3D i;
>  		ret =3D request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
> @@ -377,7 +624,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev,=
 int msi_min, int msi_max)
>  	}
> =20
>  	ret =3D ntb_epf_send_command(ndev, EPF_NTB_COMMAND_CONFIGURE_DOORBELL,
> -				   argument | irq);
> +				   argument | ntb_irqs);

[Severity: Medium]
Does reserving tail vectors for DMA here conflict with the endpoint's
last doorbell vector?

In MSI-X mode, pci-epf-vntb sets the MSI-X table size to ntb->db_count
(at most 32), so pci_alloc_irq_vectors() returns irq =3D ntb->db_count <=3D
msi_max.  When irq > msi_min, dma_min is 1, which sets ntb_irqs =3D
ntb->db_count - 1 and assigns 0-based vector ntb->db_count - 1 to
dw_edma via ntb_epf_dw_edma_irq_vector().  However, pci-epf-vntb ignores
the vector count in argument:

drivers/pci/endpoint/functions/pci-epf-vntb.c:epf_ntb_cmd_handler() {
	case EPF_NTB_COMMAND_CONFIGURE_DOORBELL:
		...
		ntb->peer_msix =3D argument & EPF_NTB_MSIX_ENABLE;
		ctrl->command_status =3D EPF_NTB_COMMAND_STATUS_OK;
		break;
}

Because vntb_epf_db_valid_mask() still exposes all ntb->db_count - 2
doorbells on the endpoint, ringing doorbell bit ntb->db_count - 3 raises
vector ntb->db_count - 1 on the host, routing the doorbell interrupt to
dw_edma instead of ntb_epf_vec_isr().  The mismatched
ntb_db_valid_mask() between host and endpoint also causes
ntb_transport_probe() to compute a different qp_count on each side when
mw_count >=3D ntb->db_count - 3, preventing the transport link from coming
up.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110082459.1798=
763-1-den@valinux.co.jp?part=3D9
