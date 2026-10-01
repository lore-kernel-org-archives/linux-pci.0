Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03453E51FC;
	Thu,  1 Oct 2026 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790896040; cv=none; b=DHrBvarTdEjiqvqhWvT43BYLVSUny41qTPH3qdO+1kVq36gLd/FUSOl7Quf18zSsyjpmXWpsLowUB7ttXDl+JYNwURp1OptiW7yprmcl7INnZlLIq5TUmOVgf30YjkXjES7j5OIt/tsCBy89kGEJcHxH4tCj3XvhjtHkqSCn6Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790896040; c=relaxed/simple;
	bh=PqJ80S6Vs8Wg5pX65UgwrGW/vOcciXfmy+v16R1QBZY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aFhBFKXToHUzFdatGz0iFTf41KT+KFJfqt0DxZjlehJqVngYk1PjTA8R2axD+CO2RIYbugCLslln5O4nENqq+xXZzyixkj9Gx1iG7TDlRal4nCOJFU/llHT2vc11sTkVvfoW6OgKzh2/cEn9mxm2AEGHOdiTyoKYN/0umZLB6IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4MC/xRJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4MC/xRJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7ECB1F000FF;
	Thu,  1 Oct 2026 23:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790896039;
	bh=lYDN2EBTMqVMIwPcPNFaRe6IY/Q4nRv3WEjn49Ix3aA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=R4MC/xRJSxcbXpvObFnBkQY3uBp5iyJ8NHdLiZtJfPZTDVbB+32qsrgbom+lZwHDG
	 ysSxG/KPS9Hha9XS0NxAhqX/Isyec6XuaR5YptUFide6IvrAEFeTccwKp/d3XiaxLG
	 rNJFwF6e4Hj8v7zeA95HbTYKELnAQoh/1mXrJPqEAYDMSLm0e0dxScBJno01qDdiHu
	 nr0J5cyJn5Lip9FVSTjaao3bIvCsqoVSmMUFKsosp9N+aAtP5l2Ef/Bkudk7ufN5xI
	 uh69jnzZj+Drh/g8AWftmXKTRvY+ll2xDZKc+hJ5gZwAEwovEqT1UMJyz4lIQMXpJr
	 dRAU+qxmkmVsA==
Date: Thu, 1 Oct 2026 18:07:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vladimir Nedoshivin <gvozd188@mail.ru>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, linux-pci@vger.kernel.org,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Rickey Bartlett <subtexel@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Enable interrupt ordering quirk for Arrow Lake
Message-ID: <20261001230717.GA2742668@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260910200539.10862-1-gvozd188@mail.ru>

On Fri, Sep 11, 2026 at 12:05:39AM +0400, Vladimir Nedoshivin wrote:
> Intel Arrow Lake VMD device 0xad0b is affected by ARL004. The VMD may
> signal an MSI before preceding posted writes from the child device have
> reached memory, which can cause the demuxed handler to observe stale
> completion data.
> 
> The existing VMD_FEAT_INTERRUPT_QUIRK implements Intel's documented
> workaround by issuing a configuration-space read to the MSI initiator
> before dispatching the interrupt.
> 
> Enable the existing quirk for 0xad0b as well as 0x7d0b and make the
> comments describe both MTL016 and ARL004.
> 
> Tested on an MSI Vector 17 HX AI with Intel VMD 8086:ad0b and an NVMe
> device behind VMD. With the quirk enabled, the NVMe completion stalls
> observed without the workaround are no longer reproduced.
> 
> Link: https://bugs.launchpad.net/bugs/2166325
> Signed-off-by: Vladimir Nedoshivin <gvozd188@mail.ru>

Applied on pci/controller/vmd, thanks!

I added the erratum source and text to the commit logs of both the
Meteor Lake quirk and this one:

  PCI: vmd: Flush DMA writes before handling MSI on Arrow Lake

  Per the Intel Core Ultra Processors (Series 2) Specification Update
  (ID 834774 of 9/1/2026), the Arrow Lake VMD device 0xad0b is affected by an
  MSI erratum:

    ARL004: MSI from VMD-Owned Device May Pass Memory Write

    Problem      When the storage subsystem is configured to operate in RAID
		 0 or 1 mode, a Message Signaled Interrupt (MSI) from an
		 Intel® Volume Management Device (Intel® VMD) owned device
		 may interrupt a core before a previous write from the device
		 is completed.

    Workaround   None identified. The VMD MSI interrupt-handler should
		 initially perform a dummy register read to the MSI initiator
		 device prior to any writes to ensure proper PCIe ordering.

  ...

> ---
>  drivers/pci/controller/vmd.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index e45ef8cb16e..9d97a832785 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -94,7 +94,8 @@ enum vmd_features {
>  	VMD_FEAT_USE_BIOS_INFO		= (1 << 6),
>  
>  	/*
> -	 * Meteor Lake VMD (device ID 0x7d0b) is affected by erratum MTL016:
> +	 * Some Intel VMD devices are affected by interrupt ordering errata,
> +	 * including MTL016 (0x7d0b) and ARL004 (0xad0b):
>  	 * the VMD may signal its MSI before the posted writes that carry the
>  	 * child device's DMA data have landed in memory.  The demuxed handler
>  	 * then runs against a not-yet-coherent completion queue and misses the
> @@ -131,7 +132,7 @@ static DEFINE_RAW_SPINLOCK(list_lock);
>   * @enabled:	true if driver enabled IRQ
>   * @virq:	the virtual IRQ value provided to the requesting driver.
>   * @flush_addr:	config space address of the initiating device, read before
> - *		demuxing to flush its posted writes (MTL016); NULL if the
> + *		demuxing to flush its posted writes; NULL if the
>   *		VMD is not affected.
>   *
>   * Every MSI/MSI-X IRQ requested for a device in a VMD domain will be mapped to
> @@ -1300,7 +1301,7 @@ static const struct pci_device_id vmd_ids[] = {
>  	{PCI_VDEVICE(INTEL, 0x7d0b),
>  		.driver_data = VMD_FEATS_CLIENT | VMD_FEAT_INTERRUPT_QUIRK,},
>  	{PCI_VDEVICE(INTEL, 0xad0b),
> -		.driver_data = VMD_FEATS_CLIENT,},
> +		.driver_data = VMD_FEATS_CLIENT | VMD_FEAT_INTERRUPT_QUIRK,},
>  	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
>  		.driver_data = VMD_FEATS_CLIENT,},
>  	{PCI_VDEVICE(INTEL, 0xb60b),
> 
> base-commit: 95ac22dd4bf13373f90bb6d51bcd1fd1d8f5db54
> -- 
> 2.53.0
> 
