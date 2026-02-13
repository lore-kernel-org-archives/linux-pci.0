Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2117D361664
	for <linux-pci@vger.kernel.org>; Fri, 13 Feb 2026 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771002510; cv=none; b=q0+kJv5Z+VxTcIx28M/zV49VJHwhPGCOYKhAuVWuH0pfjlELNOHFvKjNg7ihsMIDFOef8afEZ9QCVrcHBKtSAEQirfgobClLiXuJLJA9IXk23pxErzReF9+Gf9msjFobu5ijXixk8+xx6ArZsqaXQFuo9Dh89cnIZ+vNN25ttmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771002510; c=relaxed/simple;
	bh=N3Eqyt+4NC5mG6rp46SmBlyT6KbE/gyPQCjvlfiJyag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fSOXIEVCDYt2RcHclGg8TCr6ShKZjSveRSzbQK8CCDLL+Cf+qaxJ46P/GvIfcYUxnQYpLlZpoQ17pdhL3r9EzuMj4z70XfRuEPaKPOjtTmUMemEvTmjhZEO0VglBNBJN/+LJt/e+eW4pOf03MSSu4mMt5sBkTMUmIJNKs+X9uak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AM3k9Xlc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AM3k9Xlc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771002509; x=1802538509;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N3Eqyt+4NC5mG6rp46SmBlyT6KbE/gyPQCjvlfiJyag=;
  b=AM3k9XlcKUE4+tGgts/7nf930rBVP4c4hkr7u2wRCadJ0ynNpaD8iMij
   Ub5FIvRl7lRrw5fVeI3XBoB6RB0TG7dTHvVhE2e3FklUMwY6vScz+KyBe
   vSSqHz2Nt5Dc6nfHrFy99PlqrNEyh9cfpSaEjQm+Ad5rR254f0Ux2WGlV
   bpJTNalJr72/QTffOkmoSfXvca0+iFscmNlpOAVhDhraZpY48rMfhDSQH
   +jt5DFTcAQlHI5NB6ucqlAVoxR50k6/9u6M6hYTWBC3TvehXpmyBVBBtF
   BoZnHksC/hXMQ0L/YOLM5FYSRnvyE4B1YGFtuRAm+J1u0tPni/GUNKvQ/
   A==;
X-CSE-ConnectionGUID: FHfSds07QzCjqc1j53lChQ==
X-CSE-MsgGUID: NWiNY8Q8Qiy4DUsfW4xJVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="72084874"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="72084874"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 09:08:28 -0800
X-CSE-ConnectionGUID: HYDkI30sQ86L9ozPD6zfSg==
X-CSE-MsgGUID: 4YNUytmtTLOKMusPVGdZ0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="213074425"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 09:08:28 -0800
Message-ID: <837fc537-ea84-44c0-ba86-8ec4f1ba8230@linux.intel.com>
Date: Fri, 13 Feb 2026 09:08:28 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/DPC: Clear Interrupt Status in dpc_reset_link()
To: Keith Busch <kbusch@kernel.org>
Cc: Danielle Costantino <dcostantino@meta.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
References: <20260212191818.3625264-1-dcostantino@meta.com>
 <20260212191818.3625264-2-dcostantino@meta.com>
 <9b75cf12-a0b4-49bf-b261-cbe02c0fe310@linux.intel.com>
 <aY5E4OWE_v0Jdyd1@kbusch-mbp>
 <9a7a176d-4450-47ac-859c-0ce69a19afee@linux.intel.com>
 <aY5QMlr_7XLIbOsV@kbusch-mbp>
 <8b4800cf-7e8a-42f7-a84a-5081afe00048@linux.intel.com>
 <aY586W1YoKVyfBJZ@kbusch-mbp>
 <bf28da73-7189-412f-808a-2dbb6d241b4d@linux.intel.com>
 <aY8uy9BZyLMYgKua@kbusch-mbp>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <aY8uy9BZyLMYgKua@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/13/2026 6:01 AM, Keith Busch wrote:
> On Thu, Feb 12, 2026 at 08:28:15PM -0800, Sathyanarayanan Kuppuswamy wrote:
>> Hi Keith,
>>
>> On 2/12/26 5:22 PM, Keith Busch wrote:
>>> On Thu, Feb 12, 2026 at 02:51:46PM -0800, Kuppuswamy Sathyanarayanan wrote:
>>>> On 2/12/2026 2:12 PM, Keith Busch wrote:
>>>>
>>>> As per EDR flow, firmware waits for _OST reply from OS to complete the
>>>> current interrupt handling. After receiving _OST, firmware decides whether
>>>> recovery should continue or if the link should be disabled. When/how firmware
>>>> handles subsequent DPC events depends on firmware's implementation.
>>> You at least agree the OS controls the "Trigger Status". That controls
>>> whether the link stays contained or not, but now you're saying the
>>> firmware gets to yank the link after the OS returns _OST success?
>>> There's no flow in the spec suggesting any such behavior.
>>
>> I was referring to the flow chart and notes on page 85, in PCI firmware spec,
>> v3.3, which mention firmware can choose to disable the link in certain
>> cases (notes 3,5).
>  
> Err, what? No, there is no path for firmware to disable the link if OS
> returns _OST  0x80 (success). The path says firmware is supposed to
> "Clear ...  Disable Link", not to disable the link.

Let me list the firmware path after OS sends _OST(0xF, BDF<<16+0x80) indicating
success (PCI Firmware Spec v3.3, page 85):

1. "Capture error status. Optionally, validate if device should be recovered" (note 3)
2. Decision point: "Continue Recovery?"
    If YES: Return from _OST (recovery complete)
    If NO: Execute "Clear error status. DPC Software Trigger or Disable Link" (note 5)

Note 3 states: "FW/OS may rely on past device history, type of error, etc. to
determine if the recovery should be performed/continued."
Note 5 states: "If setting Disable Link and port supports DPC, DPC should be
disabled prior to setting Disable Link."

If firmware decides not to continue, it can disable link. Please correct me if
my interpretation is wrong.

> 
> If the firmware wants to disable the link permanently, it does so before
> considering DPC and makes it a hotplug event instead.  

Yes, it does it once before considering the DPC. And another time after
OS completes the recovery.

> 
> But in all honesty, that diagram is a complete mess and very poorly
> captures what an OS is supposed to do for a DPC. You don't unbind the
> drivers when you're trying to recover the devices they're driving.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

