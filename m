Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B282F42BC4E;
	Tue, 14 Jul 2026 21:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064498; cv=none; b=XB3A3aFU0g3uZQUFWOLHpH1O5AKYDGdutWDZwQUwCJM8/0gSn21z+2lLBa7ve4ca/lnyy6Wli5jv55CUzPGkawfKxbllWAcxV7FOlu2GwZ0y3uguZgFB2CbAI6uvpZ4lX1DT4aSD9T/cJsqZ9/LSxDtnHM/iGj1SFaZBRIrPPIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064498; c=relaxed/simple;
	bh=dC7FO9EuqSL1GJSW94qVbC0G9eIpR3H6GzZfJOsoRzU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KSDFr1X++taHsJbc+wkdSrLeJYWv3tk0ekj35OQqz8JeroOQPQeW89agDh3AgTSwP4gff8shVk0EMcxqjyuYstqQ8O/auaYOeivPCOQamGcwmnemHdOtRrUklf2SoAC1SwuxTsmQdj+DQB0wuKlnVYOl6fXZJ5F1QiCN+rRCIeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTJTSO6H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTJTSO6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE8B1F000E9;
	Tue, 14 Jul 2026 21:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784064497;
	bh=OpPBs/D9pAT5aSLmK/5VbMpGlQoR6KdUBfhIo/+im9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BTJTSO6HR5XU4rdBqAK5KBV+gMQlyG4MdN8Jr83Xon64YC+vJOKdIpdPZAFoogoFe
	 bM4SDinupwyV41CurjiI5wH85sd5TF4krm6E924QNae9NBSrmG7+dfp/6e5VYfai8T
	 RBZJb10QGko6mTcbOuUdPMJhe+Y35vjzMfKmHORjbv1Yg4h8bDmCGwia4r7qfSCVKL
	 lqV3qbHMFFpAOTPFyxdqOFmURAaCKxhICA2g+GuD8gTNSsNo/KJC63UgIKkH4T4Quf
	 /ZBYYDT6Fod3vQkgmRHAh3MU7OJnJAtSMB05lixjXRyNaTp0geKSVbcg8d3wOESj0F
	 iZWiwvBtm8TWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] dmaengine: switchtec-dma: Add PCI1008 device ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260714212010.230606-2-logang@deltatee.com>
References: <20260714212010.230606-1-logang@deltatee.com>
 <20260714212010.230606-2-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 21:28:16 +0000
Message-Id: <20260714212817.4DE8B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch adds the PCI1008 device ID to the switchtec-dma driver=
 but omits it from the core switchtec management driver, resulting in parti=
al and incomplete device support.
--

--- Patch [1]: [PATCH v1 1/3] dmaengine: switchtec-dma: Add PCI1008 device =
ID ---
commit d1b7f8eab84fc5cd5b1fe8dcb694ed9d25f8d8e7
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: Add PCI1008 device ID

This commit adds the PCI1008 device ID to the switchtec-dma driver's
supported device table.

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 3ef9286406159..02083e3f6ebea 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1424,6 +1424,7 @@ static const struct pci_device_id switchtec_dma_pci=
_tbl[] =3D {
>  	SW_ID(PCI_VENDOR_ID_EFAR,      0x1004), /* PCI1004 16XG4 */
>  	SW_ID(PCI_VENDOR_ID_EFAR,      0x1005), /* PCI1005 16XG4 */
>  	SW_ID(PCI_VENDOR_ID_EFAR,      0x1006), /* PCI1006 16XG4 */
> +	SW_ID(PCI_VENDOR_ID_EFAR,      0x1008), /* PCI1008 16XG4 */

[Severity: Medium]
Does this new device ID also need to be added to switchtec_pci_tbl in
drivers/pci/switch/switchtec.c?

If the companion ID is omitted from the core management driver, the DMA
engine will bind, but the core management function will not. Would this
leave the character device, NTB features, and hardware telemetry
inaccessible for the PCI1008 device?

>  	{0}
>  };
>  MODULE_DEVICE_TABLE(pci, switchtec_dma_pci_tbl);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714212010.2306=
06-1-logang@deltatee.com?part=3D1
