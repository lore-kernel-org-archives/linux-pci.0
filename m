Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16743A383A;
	Fri, 29 May 2026 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036209; cv=none; b=mTEOOo85oA7oW0LKkhCUyq5DHmPf27aJR8kIP9bsdd8WRFTFOBXih/V/MRzKb7WnZsOYayqDTf7qXndSGoAJQWMcS+/KU8/GvtEiw9ZKqab/6wnG4mcjOT2cLhkQ3EfhfSd2rWxzL54qB3FLB2Xu+GWdwmDW1Cft7J4g8IiQ9Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036209; c=relaxed/simple;
	bh=XVFL5+u3D8+RPR15Py+42blBLqa7fTFoC0PlHXHmIt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDyST6BIntNPlhx8NCX1SGKW6CqzADyHA41p7RpLNHoO0J0syQfX2EVbAK8puFW898L4Avr6G1Z+20YJhoROK9v6EZT7rPyd8erRGmBH5bR2234FdpanoE+9nh7cEMlXNXZGgSWs/FiIWLFyQZ73rJbfi8qcMFaMMgTVYntPNQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PMhYoAq9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PMhYoAq9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780036208; x=1811572208;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XVFL5+u3D8+RPR15Py+42blBLqa7fTFoC0PlHXHmIt4=;
  b=PMhYoAq9XXjIjWwdpR9i+WAYKLEtDO/1UdCzEh6fh9CEW6SzDdcu6u3l
   emc0j/RCIc5TYXJ6DwKtpcqo1DLUujTfZg99yCIo7GRy+I7T0wnrpD89W
   YCoqDjgYCMMdVt51jblVYMkzOyM151MyPCduW/FzuoB+4vnRV4WN7UOCS
   PIrcdLsJtmUGRnIWJjX2Iy6/FXWwJDSk27kPhkAbpsN8CY8j1p6HTsa06
   BaX3EsO/418IVENyicnJLFIdsdx68HjcN2gEsf6oWOIJJ9UdQH7Q9zcHh
   1sx9KDzluKbvbIucZDH80pnwZCrvbjVCufq07NIa8+/ByuYOoRVQpdxHw
   w==;
X-CSE-ConnectionGUID: x3B3+L6tRs6cYrY+0vxsaQ==
X-CSE-MsgGUID: 9CiC1tX2RhiFraE/GOKBUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="98301249"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="98301249"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 23:30:07 -0700
X-CSE-ConnectionGUID: +jpgAPLmQcWBIl/7yRujyw==
X-CSE-MsgGUID: gAS04WXOTxOmUFitPNnflQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="241947410"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 23:30:03 -0700
Message-ID: <2693467a-eb86-4cb9-9161-db6042b0335d@linux.intel.com>
Date: Fri, 29 May 2026 14:29:16 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] PCI/ATS: Decouple pci_ats_supported() from
 pci_prepare_ats()
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
 David Matlack <dmatlack@google.com>, Samiullah Khawaja
 <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Mostafa Saleh <smostafa@google.com>
References: <20260528202353.3422206-1-praan@google.com>
 <20260528202353.3422206-4-praan@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260528202353.3422206-4-praan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/26 04:23, Pranjal Shrivastava wrote:
> Currently, pci_prepare_ats() internally calls pci_ats_supported() and
> returns -EINVAL if the device does not support ATS. While this provides
> a safety check, it conflates support detection with configuration.
> 
> Update pci_prepare_ats() to remove the internal support check. This
> decouples support verification from the configuration phase, ensuring
> that drivers can distinguish between a device that does not support ATS
> and one that has a true configuration error (e.g. STU mismatch).
> 
> Update the function documentation to mandate that callers must verify
> ATS support (via pci_ats_supported()) before calling pci_prepare_ats().
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>   drivers/pci/ats.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 8057c24b0469..92c2a6bc2dcc 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -56,7 +56,9 @@ EXPORT_SYMBOL_GPL(pci_ats_supported);
>    * @ps: the IOMMU page shift
>    *
>    * This must be done by the IOMMU driver on the PF before any VFs are created to
> - * ensure that the VF can have ATS enabled.
> + * ensure that the VF can have ATS enabled. Callers must verify that ATS is
> + * supported by the device (e.g. via pci_ats_supported()) before calling this
> + * function.
>    *
>    * Returns 0 on success, or negative on failure.
>    */
> @@ -64,9 +66,6 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
>   {
>   	u16 ctrl;
>   
> -	if (!pci_ats_supported(dev))
> -		return -EINVAL;
> -
>   	if (WARN_ON(dev->ats_enabled))
>   		return -EBUSY;
>   

I am not sure that the removal above ensures that 'drivers can
distinguish between a device that does not support ATS and one that has
a true configuration error (e.g., STU mismatch)', especially considering
that this helper already has a return value that explicitly conveys the
failure reason.

Furthermore, if a caller misuses this API by calling it against a non-
ATS device, the following code executes:

         ctrl = PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
         pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);

This causes the driver to attempt a write to an invalid or non-existent
PCI configuration space address. Instead of removing the check from the
function entirely, how about adding a WARN_ON() around it?

	if (WARN_ON(!pci_ats_supported(dev)))
		return -EINVAL;

Thanks,
baolu
