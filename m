Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC27636B907
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 19:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711250; cv=none; b=H2tEKcYRWrtAeoPH+cAZrEPogLjU2iWcceZYgJ3HCHOJK9wfpbmIhe7aqMuteuLfKszGimmUYHwcSi0uncK3zYoJVyP1NMl3KkWz7F3+xTjVmB1tFodtcUC276Mu+5j0GMvAL5radZ6o+vZJbugRElxumv/rTiPpYbOngCa1N7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711250; c=relaxed/simple;
	bh=3NWf6YzouodGzD9ZeLjDoxA0+aThZPU6xI8Jf36A4ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7UoOPEexi9onJSJugiD/TOfn0qg9ACzffGjXyLX+aN+FBHPgZE22BrNmU6tVwTTQGJa5CqCniy8XNNpeeQKzc+i0ASuDILoJMulRRLknQ3Rzt1Zx52KV1OyHAw45VLRxb4l1xhUFX57Kg8T4uHkDWzrwtRUf0eSdi1X6SBEseE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+0kH9N9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+0kH9N9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790711248; x=1822247248;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3NWf6YzouodGzD9ZeLjDoxA0+aThZPU6xI8Jf36A4ek=;
  b=Z+0kH9N9uV5MH8eTn6CVwuv8GUz5sE5bQeyLaOmIpqFJvbZ4s9wltl7B
   Mob9Fi5K6015z8/Ho6E7H17kivlm32rwlovC8N8Nw1ISHyJ+yyQBkCIMK
   i2Y5/buc70Q75513tkrimsD+RpDcDMQN1F9gmb3akiHND5cjRfw7iu+hm
   mx1FM2DifjZ/cfGcMEwlXu86TonHS9WKzwj5b3/rEF2ieiq17Cy9LjLGE
   /Y7wcvvyI5DXcyLamJgNedpVdnbi69//NxenqMb5fzeV9NpmzBLjc6hRr
   Ws3BP0fBLtMceVvyRqbxUPTuAVJ7eZigmckofBkgGcKLos8jEXzSK8YKp
   Q==;
X-CSE-ConnectionGUID: dgeuU1ukTfip814pDpJ6Wg==
X-CSE-MsgGUID: NIvRGHRuTI+SJOiNdOy5iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="79004648"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="79004648"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:47:26 -0700
X-CSE-ConnectionGUID: FWtVTot8QBGWMFXHZaW26w==
X-CSE-MsgGUID: WiM4jFowQryUdJ7Id+9OhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="274672254"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:47:26 -0700
Message-ID: <7d21f908-ea38-4b8c-9646-0aaaa520206a@linux.intel.com>
Date: Tue, 29 Sep 2026 12:47:26 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] PCI/AER: Move AER capability check out of
 pcie_aer_is_native()
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
 <6a21637111397810d75679d1ca597766f3bf5605.1790531238.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <6a21637111397810d75679d1ca597766f3bf5605.1790531238.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/27/2026 11:02 AM, Lukas Wunner wrote:
> When firmware grants control of Advanced Error Reporting to the operating
> system, that not only encompasses the AER capability, but also error
> enable/status bits in the Device Control and Device Status registers
> (PCI Firmware r3.3 table 4-6 bit 3).
> 
> PCIe devices without AER capability still support baseline capability
> error reporting through these enable/status bits (PCIe r7.1 sec 6.2.1),
> but the bits must not be modified unless AER control was granted.
> 
> pcie_aer_is_native() is unsuitable to check for control of AER-incapable
> devices because it implicitly checks for presence of an AER capability.
> 
> Move that check to its callers (where needed) to allow using the function
> for the imminent baseline capability error reporting.

Agreed that ownership and AER presence are separate questions, but
changing the semantics while keeping the name may trip up callers that
assume "native" implies "present".  Would a separate ownership-only
helper (e.g. pcie_err_is_native()) be cleaner?  It could also replace
cxl_error_is_native().

I think you also need to fix kernel-doc of pci_aer_unmask_internal_errors().
it says to check AER support with pcie_aer_is_native().  That's no longer
sufficient, and the function has no aer_cap check, Please update the comment
and ideally add an "if (!aer) return;".


> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/pcie/aer.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d8dcd238fda1..34a8eddc427a 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -257,9 +257,6 @@ int pcie_aer_is_native(struct pci_dev *dev)
>  {
>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>  
> -	if (!dev->aer_cap)
> -		return 0;
> -
>  	return pcie_ports_native || host->native_aer;
>  }
>  EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
> @@ -280,7 +277,7 @@ int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  	int aer = dev->aer_cap;
>  	u32 status, sev;
>  
> -	if (!pcie_aer_is_native(dev))
> +	if (!aer || !pcie_aer_is_native(dev))
>  		return -EIO;
>  
>  	/* Clear status bits for ERR_NONFATAL errors only */
> @@ -299,7 +296,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>  	int aer = dev->aer_cap;
>  	u32 status, sev;
>  
> -	if (!pcie_aer_is_native(dev))
> +	if (!aer || !pcie_aer_is_native(dev))
>  		return;
>  
>  	/* Clear status bits for ERR_FATAL errors only */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

