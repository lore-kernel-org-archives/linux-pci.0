Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCAA48988B;
	Tue, 25 Aug 2026 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672466; cv=none; b=NQT3YaOmphHzzUnoJPe8QqevkgsiSCEG3gMSNu4MjI/nEDopJLCJITSFmPWQeNPQvqKs0dof3fiFeG0TYt5/UPdeMj1F1PvzMgMH7DHIX3dbki4ZblBYKMkvGCyX7GD8oM2cdFPg6c8/RG/oNEwgX/JK5IJ/EqFbxkDx/6I7TR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672466; c=relaxed/simple;
	bh=hc3IvSpENjrpVq13EWw+QKgooKsRRbKeik+4hcfoU4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uIm3zqoSXu4513ALW5Xg2j3xTP3imFG7Iyaxev/q2bnuOIMCtkGAE8KxsIQh4svrBeezyyMrsPG3GFS3DjlGKcY6EP+1W/ibGUWs/AwOgk2iJSzqipAlOwCCOZ8eZTTXD2V0ThpXBoFKkiaRk+kUVOP1nUGPPt/lqEU8esHoB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bGyNy6Or; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bGyNy6Or"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787672463; x=1819208463;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hc3IvSpENjrpVq13EWw+QKgooKsRRbKeik+4hcfoU4g=;
  b=bGyNy6OrCVzdSzoyVAYjzs9e3CbvCwz567JxFoCYxLGJ5UpJZnHIZyIH
   XIg37PisLTiycmdBTphlmg8M33Oz1QrA/uBHZR/dVemHkNCLaLPOIhTdG
   fV3VNHz28cg3T1xBWeBVQN/UPO6b/OqEJhBflxhgdxHxUwopxs1Vuo+x0
   tiA422mIdM0mnUO9Rx71h4mDBCy+FhGeg5VHrikjmpPLbNG8chh0G2ftZ
   RT8fSAMA1E6HifeNGoL0UyWiO/N9BQps3rjG2zLKRF07fb0YuuCpEdhLk
   5+II+YgibJYBASJER57DLippBOTY9v/tF07iN/CX7SFiZCihKdVPTQ0Us
   g==;
X-CSE-ConnectionGUID: nfhSJi9gSKWxCBkPzaKrbA==
X-CSE-MsgGUID: j1hG4P7ZRRuVPRCVjD5inQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="91958012"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="91958012"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 08:41:02 -0700
X-CSE-ConnectionGUID: jWjfPHDRR0y2PYrsylJBeA==
X-CSE-MsgGUID: f4V2HXYyTDKg0QfRDyqgdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="297230947"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.2]) ([10.125.109.2])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 08:41:01 -0700
Message-ID: <de7ca1b4-55e6-49d4-a7f2-7981df7df1d7@intel.com>
Date: Tue, 25 Aug 2026 08:41:00 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI/AER: Export pcie_aer_is_native() to AER
 namespace
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 iweiny@kernel.org, ming.li@zohomail.com, bhelgaas@google.com,
 linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 lukas@wunner.de, riana.tauro@intel.com, michal.wajdeczko@intel.com,
 matthew.d.roper@intel.com
References: <20260825054312.1319951-1-raag.jadav@intel.com>
 <20260825054312.1319951-2-raag.jadav@intel.com> <ao2kIepOqKnJUgVq@intel.com>
 <37843d00-c9c7-439d-830a-33c6fb89f1b3@intel.com> <ao20B1jwAre5A_h0@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <ao20B1jwAre5A_h0@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/25/26 8:25 AM, Rodrigo Vivi wrote:
> On Tue, Aug 25, 2026 at 08:05:36AM -0700, Dave Jiang wrote:
>>
>>
>> On 8/25/26 7:18 AM, Rodrigo Vivi wrote:
>>> On Tue, Aug 25, 2026 at 11:12:50AM +0530, Raag Jadav wrote:
>>>> pcie_aer_is_native() was originally exported to CXL namespace in commit
>>>> 49f776724e64 ("PCI/AER: Export pcie_aer_is_native()"). This is a bit
>>>> misleading as the symbol or its underlying implementation does not reflect
>>>> any distinguishable CXL functionality.
>>>>
>>>> Change this and export pcie_aer_is_native() to AER namespace, which is
>>>> cleaner and more suitable for its implementation.
>>>>
>>>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>>>> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
>>>> ---
>>>>  drivers/cxl/port.c     | 1 +
>>>>  drivers/pci/pcie/aer.c | 2 +-
>>>
>>> PCI and CXL folks, ack to get this through drm-next branches towards 7.4?
>>> Or any of you wanting to pull this through your trees for 7.3-rc1?
>>
>> It's not really a fix and with no fixes tag. Also it's not a bug that popped up in the 7.3 merge window. It'll have to be 7.4. I can pull it through CXL when all the appropriate tags show up or you can take it through DRM. Probably more reasonable for the DRM tree given the second patch is what needs the change. Just make it clear to the maintainers how you want to do this.
> 
> Since it is 7.4 anyway I prefer to take already with drm-next.
> 
> CLX and PCI maintainers, ack on that?

I gave the CXL ack. You just need a Bjorn ack. 

> 
>>
>> DJ
>>
>>>
>>> Thanks,
>>> Rodrigo.
>>>
>>> btw:
>>>
>>> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
>>>
>>>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>>>> index 99cf77b6b699..00f675163b3d 100644
>>>> --- a/drivers/cxl/port.c
>>>> +++ b/drivers/cxl/port.c
>>>> @@ -340,5 +340,6 @@ module_exit(cxl_port_exit);
>>>>  
>>>>  MODULE_DESCRIPTION("CXL: Port enumeration and services");
>>>>  MODULE_LICENSE("GPL v2");
>>>> +MODULE_IMPORT_NS("AER");
>>>>  MODULE_IMPORT_NS("CXL");
>>>>  MODULE_ALIAS_CXL(CXL_DEVICE_PORT);
>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>> index c4fd9c0b2a54..8660b18bac8b 100644
>>>> --- a/drivers/pci/pcie/aer.c
>>>> +++ b/drivers/pci/pcie/aer.c
>>>> @@ -248,7 +248,7 @@ int pcie_aer_is_native(struct pci_dev *dev)
>>>>  
>>>>  	return pcie_ports_native || host->native_aer;
>>>>  }
>>>> -EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
>>>> +EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "AER");
>>>>  
>>>>  static int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>>>>  {
>>>> -- 
>>>> 2.43.0
>>>>
>>

