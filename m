Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70E12ECD32
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708675; cv=none; b=Lj/XsDmCV7e1DndruiKZg2M1mork3x59Vei/0HBvJl56cPvgwkoau5vs/SeUNX0STMaDrs1C9qg51SjVBvmyJhzjAo6nlS5/CcQAEKLR2YYgr1nSYtxI7bgrazc32HZph7NoYCHtKfrBqQ/GORS5SFemreJC/NYMaE+SUjYMdL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708675; c=relaxed/simple;
	bh=f1c3sUGqi+deJ+NQMwk/OC4eFoFzb20BlqMUp5oX7gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AswJYHkYttc+4ncixpSJ3tlVIXy0kUq0tLD9D3xF/lnj4cPV8TQS+8ZiZGsENAxp3gmsU9P3f0Xw+JX8PxsM2uamG2cJSrZdH9GmiEdeXPeRLkd/yRBa7VwI3eYFp80JkzivCMo9lEDb6o4doE/CL3mz2aeLnBaViaP1upwRFYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftQJecT4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftQJecT4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790708674; x=1822244674;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f1c3sUGqi+deJ+NQMwk/OC4eFoFzb20BlqMUp5oX7gc=;
  b=ftQJecT4POZloYlo64z7y4XsA8TNb3ot9jTRQWzK5ec1Eh3jpablw64u
   feBtW5PhPGAxhHDZmv9LsT6z01ijmpq3fWQ1uxCnKQeEm7GTMDxWBCI4B
   9htdc7CQzhNYncuZIJeluTWaLlSAVlEccNmKq81/xgQ1VW8Up8p9Y7LpO
   nyA+bmZjhB28nPGiBOOcpApAx4bsEirwQO6J4XQDi3PWQQktv821AzCA0
   8V5mMLT1SxDpfIfnmHW7ZgwfHl39Ckb+rC36r+5GmWsrWfFx7MI5Mw2ra
   VxszJIBh8XFhYhBIRj+X4/Gp/rpwWTvj1TVdr88Iv99ywZzWnP9bGiCu3
   A==;
X-CSE-ConnectionGUID: 2yqgSWrqRJKDHEfCrz7w1Q==
X-CSE-MsgGUID: U6m6yfa7Q6GUnhp/0qkHig==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="101602110"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="101602110"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:04:33 -0700
X-CSE-ConnectionGUID: WUP40NglQyinD+BUi9cmJw==
X-CSE-MsgGUID: nKfrBZ80R6yk9u2fSDFk5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="303418463"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:04:32 -0700
Message-ID: <02a33171-b901-400b-921a-c40fe167b424@linux.intel.com>
Date: Tue, 29 Sep 2026 12:04:32 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] PCI/DPC: Reinstate support for AER-incapable ports
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Raag Jadav <raag.jadav@intel.com>, Riana Tauro <riana.tauro@intel.com>,
 Yury Murashka <yurypm@arista.com>, Matthew W Carlis <mattc@purestorage.com>,
 linux-pci@vger.kernel.org
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
 Srinivasa Adatrao <srinivasa.adatrao@intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>
References: <cover.1790531238.git.lukas@wunner.de>
 <2ce502e5caa57db01e0a7bbc781210b66b73bec8.1790531238.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <2ce502e5caa57db01e0a7bbc781210b66b73bec8.1790531238.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/27/2026 11:02 AM, Lukas Wunner wrote:
> Downstream Port Containment does not mandate presence of an Advanced Error
> Reporting capability, so a Downstream Port may support DPC, but not AER
> (PCIe r7.1 sec 6.2.11.2).
> 
> Commit 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER
> ownership") seemingly inadvertently constrained DPC to AER-supporting
> Downstream Ports by inserting a call to pcie_aer_is_native() in
> dpc_probe(), which implicitly checks for presence of an AER capability.
> 
> Drop the call.  It is superfluous because it duplicates the conditions
> applied by the PCIe port service driver when it decides whether to
> instantiate a DPC port service (see get_port_device_capability()).
> If the conditions are not met, no port service is instantiated and
> dpc_probe() isn't executed.
> 
> The only difference between the conditions in dpc_probe() and the ones in
> get_port_device_capability() is the check for the AER capability, so by
> removing the checks from dpc_probe(), DPC is supported on AER-incapable
> Downstream Ports again.
> 
> Fixes: 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER ownership")

I don't think 708b20003624 changed behavior here.  At the time,
get_port_device_capability() only instantiated the DPC service if
pcie_ports_dpc_native was set or the AER service was instantiated,
and the latter required dev->aer_cap and native AER control:

	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
	    pci_aer_available() &&
	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
		services |= PCIE_PORT_SERVICE_DPC;

So without dpc-native, the pcie_aer_is_native() check in dpc_probe()
could never fail, and with dpc-native it was bypassed.

The check only became effective with 97ca178c899d ("PCI/DPC: Allow DPC
on all Downstream Ports when OS controls AER"), which replaced
"services & PCIE_PORT_SERVICE_AER" with "host->native_aer".  Since then
a DPC service is instantiated on AER-incapable ports, but dpc_probe()
rejects it.

So I think this should rather be:

  Fixes: 97ca178c899d ("PCI/DPC: Allow DPC on all Downstream Ports when OS controls AER")

Also, for stable kernels, is there any way to note that this patch needs
to be picked with patch 1. Otherwise DPC driver might access AER config
without aer_cap.

Otherwise it looks good.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v5.8+
> ---
>  drivers/pci/pcie/dpc.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 793a799053f1..104ff2b91f1f 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -474,9 +474,6 @@ static int dpc_probe(struct pcie_device *dev)
>  	int status;
>  	u16 cap;
>  
> -	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
> -		return -ENOTSUPP;
> -
>  	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
>  					   dpc_handler, IRQF_SHARED,
>  					   "pcie-dpc", pdev);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

