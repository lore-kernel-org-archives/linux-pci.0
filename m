Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1616241441B;
	Wed, 14 Oct 2026 05:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791956721; cv=none; b=ca0vsO7/+reEnyKztR4VVScz6F1JvvLyWH0m9USx8lK3V4++mXXRD7HCsRf1qghG/7B57et8YXKes8KwL152AVtw6Urx2NhcXIW4fTy22cNhlE4kQFFMbKG/r36iioN6iBdQCZjrjIyVJcS+bAhJEa+qmDGwmHQ+FqMW4Gsqjk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791956721; c=relaxed/simple;
	bh=Jnf0FCcfke7gUv0R7M7ypMdUqYRTd0Xv8vtrMPLoLf0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=TIA6yzQjxVbXBCAzJdmB2XfHOuXMJCkz5bxPIJMCrcSVX8ct/t/ZA+oScp7Pp8IJnVKNPmf4ByjxdCIgGSzPbzVy6OvY/IQ8GgiB6EfwAwgFQ0CNT6Tk/FbSq8Pu2/PmyN+dBivuwy3L+HWLbL0/ofDYgW/AbV8YigiNW2Mdh9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxWUdPRD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxWUdPRD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB26C1F000FF;
	Wed, 14 Oct 2026 05:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791956719;
	bh=1X5yqwpkf3L2VKSGYmfCEEpKajfky1TfN2qPEbXGdd4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=HxWUdPRD3Q10kkNXWkIm47VuspQ/jsVzWy9Z/+ECn/ksgrvbN1PvUx6Pe+yiCM97g
	 nfvUgH8mnSo+PSVn9cnIO5qDNcWzFCo6fvUM1wh/N5+F09uIIC7qS0u1PDtQOdUwEa
	 778Jf4jfYiztrOt+K3YRGL76thnNn9+uC1y0WrpzRXTEtOcHzlE2GimVFtU3zbZKHj
	 coGjmj2ZBEKLt/5IdcPLUJreqhClwn22crusllQItTMOzTTfu+vMFNuHPTB7RloK0B
	 6qlgdo8OYVUK/pCUeBVCV8Hc9itzD2LVK6w6LktbVbUYEnqXPrFBMwzaZiJgbgkXpA
	 +W7gyTEVnjqfg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/1] PCI: imx6: Use dev_err_probe
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, imx@lists.linux.dev, 
 Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260619113624.A90AE1F000E9@smtp.kernel.org>
References: <20260619112535.1127850-1-alexander.stein@ew.tq-group.com>
 <20260619113624.A90AE1F000E9@smtp.kernel.org>
Date: Wed, 14 Oct 2026 11:15:13 +0530
Message-Id: <179195671396.12828.11278782950659497508.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2385; i=mani@kernel.org;
 h=from:subject:message-id; bh=Jnf0FCcfke7gUv0R7M7ypMdUqYRTd0Xv8vtrMPLoLf0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqzxbslunjinVY+MvuwtRevxLCnPfRcSlW8fbnO
 Wj2TgubxxyJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas8W7AAKCRBVnxHm/pHO
 9RFPCACHXkdxxriPkzkitZlbfCz82n8m0mQhLWsdVVLGnnUuzxx/YfyjfWFiV+5ysQLiaXU+iOz
 LFznnnY7LhoNkGhQg1Vb4kcwQKfEUioHh7HSlYtGjpkLMIAiA03gwlnnulhN5hlgLbt6YjAHaQi
 l0gJICoboaXAs9qL12apokCdMnFWVJ3SgrkTj+i4msKmO+y5gyTE/n+cMrsIwTD3O8z4ptgFFB5
 dcd+EdIWr1MQ8bht6UMOfV3r2AMGqIl6NIEy0yOJVgFwlEqRmiXbUglJA5rN1RqkbDo4c0hpblI
 syiejSpy3WhiwAUNJJna8eGOdYW7qCJICR2ktcLF1u5aSj9b
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-06-19 11:36 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The return value of imx_pcie_host_init() is ignored in imx_add_pcie_ep(), leading to a system crash when pwrctrl devices trigger a probe deferral.
> --
> 
> commit 177305e0f76751d4a9bafb983aa8f962639d5a3b
> Author: Alexander Stein <alexander.stein@ew.tq-group.com>
> 
> PCI: imx6: Use dev_err_probe
> 
> pci_pwrctrl_power_on_devices() might return -EPROBE_DEFER resulting in
> an error message. Use dev_err_probe to silence this non-error message.
> 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 98e1db751132a..b7a502e9a1c59 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1381,7 +1381,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> >  
> >  	ret = pci_pwrctrl_power_on_devices(dev);
> >  	if (ret) {
> > -		dev_err(dev, "failed to power on pwrctrl devices\n");
> > +		dev_err_probe(dev, ret, "failed to power on pwrctrl devices\n");
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but since 
> pci_pwrctrl_power_on_devices() might return -EPROBE_DEFER (as anticipated by
> this change), does this lead to a system crash during endpoint initialization?
> 
> In drivers/pci/controller/dwc/pci-imx6.c:imx_add_pcie_ep(),
> imx_pcie_host_init() is called but its return value is ignored:
> 
> 	imx_pcie_host_init(pp);
> 	ep = &pci->ep;
> 
> If imx_pcie_host_init() fails and returns -EPROBE_DEFER, imx_add_pcie_ep()
> blindly proceeds to execute dw_pcie_ep_init_registers() and
> imx_pcie_host_post_init() on unpowered hardware.
> 
> This causes the kernel to attempt MMIO reads and writes on unclocked and
> unpowered PCIe Endpoint DBI registers, which triggers a synchronous external
> abort and panics the system on ARM/i.MX platforms.
> 
> Could we add a check for the return value of imx_pcie_host_init() in
> imx_add_pcie_ep()?
> 

Actually, I wonder why the driver is calling imx_pcie_host_init() in the EP
path. Most of the code inside this function is RC specific. If EP just wants the
resource initialization part, those should be moved to a helper function and
get called.

- Mani

