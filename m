Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0D819BC8;
	Thu, 15 Oct 2026 03:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035855; cv=none; b=EG+Yq2v1KmC1K4ogmGGrRY3fZjFxI70DufiOOrC2vOnyDVD8jPd277/OLgvnA9vBlf/McSkhEkGSNkwhm927qgwAALf9Tz6ANatI5GI+l2/AtyuSnQ1l6lj+/V1O43rC8kUdFTggj3KNDxyPqrsSjSD+/0PqiOBgvQjCPArFGz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035855; c=relaxed/simple;
	bh=Tt1tcquwM54PxWYG/uqLlVVbozwAXfG8t7IMFmDpV3k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gONF6eok1qiGZx/D+dErzMNokESezAjcl1F0CxSo7b9oj7egG2BxJsKFI5zQetiSFG4agD7HNOHupckRIKb7EIsLxA2z+RyZhCo/W9ZUAklBGKGzs/Z0uqWI8Y8HmudjMuMduX6lGkMerfb8bh2k9s8ldTISSIZ5LTS52GI5mSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1paJUPv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1paJUPv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773DE1F000C4;
	Thu, 15 Oct 2026 03:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792035854;
	bh=k/EMLrvZUUvBEWkdJbaEVlQz8PTI+nCBNvhe6s/yivw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T1paJUPve5OgVgVEjjJDpoZstmmJqsyFOIQnb29piqWddMJQOnHyfVF2zIwT63cNw
	 ZAm6DyyKPbFh/gH5B9XhwoaUqtYwHMRqIhV3wTWcDJvjCZPmArKCrTc2zx2NdQT8kO
	 Q7x5hctxiw5etZhgwVx9WV4OEetUiyWoOs+NXBFYnD2+jTZDdxeN5Be6eGC9SdBNvx
	 Pk+SOrkKMHxz9/14WfEoWqbolK3g6M69Z2dVdbSNXMFqLwKNixY+KuqGswvL4ZbAwO
	 30Ge8s/Pj2d3/XmTvXFbEX2wOxdvYeRydM8ncXDhTRi97prC2k2V1SJAi3koZF+JMd
	 N7ZU47Xr+SW7A==
Message-ID: <sashiko-outbox-172221@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/18] PCI: dwc: Free the MSI domain after the host
 .deinit() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261015033103.3076869-11-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-11-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 03:44:13 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: dwc: missing synchronize_irq() after removing chained MSI han=
dlers
--

commit 5f29144f527d9dfd0c8c7686f0d2791d38c14098
Author: Koichiro Den <den@valinux.co.jp>

PCI: dwc: Free the MSI domain after the host .deinit() callback

dw_pcie_host_deinit() frees the iMSI-RX domain before calling the host
.deinit() callback. For a core-owned parent interrupt,
dw_pcie_free_msi() removes the chained handler right before the domain.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index 63b38532d069a..774e1936d9991 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -228,7 +228,7 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_allocate_domains);
> =20
> -void dw_pcie_free_msi(struct dw_pcie_rp *pp)
> +static void dw_pcie_remove_msi_handlers(struct dw_pcie_rp *pp)
>  {
>  	u32 ctrl;
> =20
> @@ -236,8 +236,18 @@ void dw_pcie_free_msi(struct dw_pcie_rp *pp)
>  		if (pp->msi_irq[ctrl] > 0)
>  			irq_set_chained_handler_and_data(pp->msi_irq[ctrl], NULL, NULL);
>  	}
> +}

[Severity: High]
Does this code need a call to synchronize_irq() here?

irq_set_chained_handler_and_data() uninstalls the handler but does not wait
for concurrent executions to finish. This means an interrupt handler like
dw_chained_msi_isr() could still be executing on another CPU.

[ ... ]

> @@ -718,11 +730,14 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
>  	dw_pcie_edma_remove(pci);
> =20
>  	if (pp->use_imsi_rx)
> -		dw_pcie_free_msi(pp);
> +		dw_pcie_remove_msi_handlers(pp);
> =20
>  	if (pp->ops->deinit)
>  		pp->ops->deinit(pp);

[Severity: High]
Could the lack of interrupt synchronization cause a regression here?

If the unsynchronized interrupt handler is still in flight, pp->ops->deinit=
(pp)
might power down the controller out from under it.

If the in-flight handler proceeds to call dw_handle_msi_irq(), it will read
PCIE_MSI_INTR0_STATUS from the powered-down hardware, potentially resulting=
 in
an asynchronous SError (bus crash) or use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015033103.3076=
869-1-den@valinux.co.jp?part=3D10
