Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE441A6836;
	Thu,  9 Jul 2026 01:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783560024; cv=none; b=t1QrCOF5Slz84w4szmQ58DqdO28SaatHNl7p/0TmFbGru8YeQUvIw2SAS6rtrx2MlaQvPnf9exYboX5pgyCy3dxlsQO1c9D2BBje9V01jVeqneh5BOL+IqsYvUeJ6DwulfB7HCVoYm/9MNHNNtAtr8cvqylJSQSaMqA8kIt0lDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783560024; c=relaxed/simple;
	bh=+iZ5Wu7mOJCVtM+qc4Ka7t6v/isc3p8LA8SYpOWbaC8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HNKJBDfFCgA8AYPgcRg9h7+E6/RzXaYgGnUG2NdAkMh1eqstY2dlaGAbbYbLkaVAYuiHpuUO3d5X5AqCEBZiMkmCbj17Xhh2doMx1WqQe3BDapFoCAlvtEsziFYd3F4HRtZ03SNj3DUGJgKwIqBn1i404E0UAqfP4IWWwrWPyTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjvrSnyu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjvrSnyu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DCA1F000E9;
	Thu,  9 Jul 2026 01:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783560023;
	bh=uxoV8tAnVlrB9aHh59xG/Ec/6ybc5vw1dPWD2Zozw3w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZjvrSnyuqe9XI2XS041GV3O9gmrzur09a6tCrGlgzDOB17ncd/y+Va4IFvEF9QEle
	 Wo2drnRQ+HqaaiTxiIyr1DVN9OwAFU+NJmD4Zi3QWiUOKh0cuUPpGumrd8snrooo95
	 WfMEjGX2AYqFNxbD7HJEvvRhiyE27kTBGDdFlB5b+XLpRtiaeRFQDWYwJd0JXSM0Bq
	 1rpirL9RAWksWUCllrhn+UFJYwcV9TVOD73PBcyRy/GtVa+2rnb3Qh9lDc9MNYOYS+
	 sHjkt+FKP2nV6iQNpaJO6PO/rAD/KCqp0XtXnD74SvbAPScuD+T/H/WXZRSGntgfqr
	 uCm/e6wMQAeIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 11/11] PCI/CXL: Restore HDM state after CXL bus reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260709010304.680422-12-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
 <20260709010304.680422-12-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 01:20:22 +0000
Message-Id: <20260709012023.24DCA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] HDM decoder restoration is performed before the PCI device's BARs =
are restored, causing MMIO writes to be dropped by the hardware or triggeri=
ng Unsupported Requests.
--

--- Patch [11]: [PATCH v9 11/11] PCI/CXL: Restore HDM state after CXL bus r=
eset ---
commit 4e02f0f18a7abbebc3cc9b8384269906531ad726
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/CXL: Restore HDM state after CXL bus reset

This commit restores cached HDM state after a successful CXL bus reset while
the IOMMU reset block remains active. It introduces a helper to restore the
state and calls it directly from the PCI reset path.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ef25ba5f7fe95..b394704950a5f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5004,6 +5004,9 @@ static int cxl_reset_bus_function(struct pci_dev *d=
ev, bool probe)
>  		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
>  				      reg);
> =20
> +	if (!rc)
> +		rc =3D cxl_restore_hdm_after_pci_reset(dev);
> +

[Severity: High]
Is it safe to restore the HDM decoders here before the PCI state (including
BARs) has been restored?

When pci_reset_bus_function() is called earlier in this function, the
hardware reset clears the device's BARs to 0. The caller of the reset
function typically restores the saved PCI state after this returns.

However, cxl_restore_hdm_after_pci_reset() calls cxl_restore_hdm(), which
enables memory decoding and writes to the cached BAR address:

drivers/cxl/core/reset.c:cxl_restore_hdm() {
    ...
    rc =3D cxl_hdm_enable_mem(pdev, &command, &restore_command);
    ...
    writel(global_ctrl, hdm + CXL_HDM_DECODER_CTRL_OFFSET);
    ...
}

Because the hardware BARs are still 0 at this point, will enabling
PCI_COMMAND_MEMORY cause the device to incorrectly claim physical address 0?

Furthermore, will the MMIO writes to the cached BAR address result in PCIe
Unsupported Requests (Master Aborts) since the hardware isn't actually
decoding the cached address yet?

>  	pci_dev_reset_iommu_done(dev);
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709010304.6804=
22-1-smadhavan@nvidia.com?part=3D11
