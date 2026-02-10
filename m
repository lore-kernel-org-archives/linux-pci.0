Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FB631E0FB;
	Tue, 10 Feb 2026 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770735925; cv=none; b=ERSJWxQQf4onJ7JGnEEQDvW8SndoGP7u5W6yuWOwCWmkOPXUzNgOLlgIcqdnQGERBg51sEEif/ZQS+MfTW6eKY/OUR0ERfknoXQlPV0gvacV8lWuXr0yRF2iEBMRLGd6XlVlPmlB7IPb8lYFjRas+1qcFezU/mIjNzPLiMNAU7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770735925; c=relaxed/simple;
	bh=LdZySO7c1znb1CVlkP5s7Fz2dtyTTif4M/JRWZC0Khg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sS0NHH/JNNzcjEf4tQVulADzCMqi8cHcpNN3hZIQA5nPWF2wbEfGBHmtuCQ0xt4pRkh2ne4yUPxSQlWHX4VUFc4XqnkpF5/zOpBOGWWERYt/7Z85Jo+uY6RKM5hFnMLgK30Mrz2sBdgEayzJ6qvR3iuQ7zTvldkra/CwXsezKW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwF/4usJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwF/4usJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770735924; x=1802271924;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LdZySO7c1znb1CVlkP5s7Fz2dtyTTif4M/JRWZC0Khg=;
  b=gwF/4usJIusM8YG49d3mfy1k1yBT+RcN/+89I+BfGiTnE7Hm3oe1JVp6
   aBaHnB9G8H1mHSWCZJIB+8MKr1nMwG30zPyAmlYzf55SU570eLUOBgYs5
   DsbOOLis9ulb+77k/atLyxYOmO0lV4VcPhpGFx92OKdsOKDJ+anwlAPF6
   Cm40p7CEHYntl3XCuHFGpicfpH7qSnzkuTa98g51R1ua5UM/ohsOd8pDh
   VCgHSzvvhZ1qHcwd1thQyRu/8Q/4AEwP7bdzv7st1tRMozPotLWcJPT7s
   zYyV/6LJQFGY+sSSH0yczY0x/pxYnFMdwIbbOEnbBEaIVXwJukhmYjhYa
   Q==;
X-CSE-ConnectionGUID: SsU+iuOpTtiTqx4m+3Rfzg==
X-CSE-MsgGUID: hCaXo1iMSoeYXIC+719D0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71763274"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71763274"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 07:05:23 -0800
X-CSE-ConnectionGUID: qBpva9J5TgmZov/TDo1kdQ==
X-CSE-MsgGUID: NT2Hg0T9QyCoAIRzqQVBgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="249589411"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.108.49]) ([10.125.108.49])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 07:05:22 -0800
Message-ID: <a6b2ba96-ce22-426b-8277-8121ed77fa55@intel.com>
Date: Tue, 10 Feb 2026 08:05:21 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] cxl/mem: Introduce cxl_memdev_attach for
 CXL-dependent operation
To: Gregory Price <gourry@gourry.net>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, alison.schofield@intel.com,
 terry.bowman@amd.com, alejandro.lucero-palau@amd.com,
 linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
 Ben Cheatham <benjamin.cheatham@amd.com>, Alejandro Lucero <alucerop@amd.com>
References: <20251216005616.3090129-1-dan.j.williams@intel.com>
 <20251216005616.3090129-7-dan.j.williams@intel.com>
 <aYq_zpNAgNgJY_P8@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aYq_zpNAgNgJY_P8@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/9/26 10:19 PM, Gregory Price wrote:
> On Mon, Dec 15, 2025 at 04:56:16PM -0800, Dan Williams wrote:
>> @@ -1081,6 +1093,18 @@ static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
>>  {
>>  	int rc;
>>  
>> +	/*
>> +	 * If @attach is provided fail if the driver is not attached upon
>> +	 * return. Note that failure here could be the result of a race to
>> +	 * teardown the CXL port topology. I.e. cxl_mem_probe() could have
>> +	 * succeeded and then cxl_mem unbound before the lock is acquired.
>> +	 */
>> +	guard(device)(&cxlmd->dev);
>> +	if (cxlmd->attach && !cxlmd->dev.driver) {
>> +		cxl_memdev_unregister(cxlmd);
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>>  	rc = devm_add_action_or_reset(cxlmd->cxlds->dev, cxl_memdev_unregister,
>>  				      cxlmd);
>>  	if (rc)
> 
> 
> This caused a deadlock when trying to unbind cxl_pci and bind a custom
> driver. 
> 
> The followwing analysis was produced by Chris Mason's kreview scripts,
> but it did resolve my deadlock, and the analysis seems pretty straight
> forward. 

The suggested resolution looks reasonable. Can you post a fix patch? Will need to apply it against 7.0-rc. It's too late to get it into the 7.0 merge PR.

DJ

> 
> Although it was likely caused by a qemu quirk I was dealing with at the
> same time (see the note about topology failing to enumerate).
> 
> ~Gregory
> 
> ---
> 
>     cxl_memdev_autoremove() takes device_lock(&cxlmd->dev) via guard(device)
>     and then calls cxl_memdev_unregister() when the attach callback was
>     provided but cxl_mem_probe() failed to bind.
> 
>     cxl_memdev_unregister() calls cdev_device_del() → device_del() →
>     bus_remove_device() → device_release_driver() which also takes
>     device_lock(), deadlocking the calling thread.
> 
>     This path is reached when a driver uses the @attach parameter to
>     devm_cxl_add_memdev() and the CXL topology fails to enumerate (e.g.
>     DVSEC range registers decode outside platform-defined CXL ranges,
>     causing the endpoint port probe to fail).
> 
>     Fix by using scoped_guard() and breaking out of the guard scope before
>     calling cxl_memdev_unregister(), so device_lock() is released first.
> 
> It suggested:
> ---
> 
> static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
> {
>         int rc;
> 
>         /*
>          * If @attach is provided fail if the driver is not attached upon
>          * return. Note that failure here could be the result of a race to
>          * teardown the CXL port topology. I.e. cxl_mem_probe() could have
>          * succeeded and then cxl_mem unbound before the lock is acquired.
>          *
>          * Check under device_lock but unregister outside of it:
>          * cxl_memdev_unregister() calls cdev_device_del() → device_del()
>          * → device_release_driver() which also takes device_lock().
>          */
>         scoped_guard(device, &cxlmd->dev) {
>                 if (cxlmd->attach && !cxlmd->dev.driver) {
>                         /* Drop lock before unregister to avoid deadlock */
>                         break;
>                 }
> 
>                 rc = devm_add_action_or_reset(cxlmd->cxlds->dev,
>                                               cxl_memdev_unregister, cxlmd);
>                 if (rc)
>                         return ERR_PTR(rc);
> 
>                 return cxlmd;
>         }
> 
>         /* Reached only when attach failed — lock is released */
>         cxl_memdev_unregister(cxlmd);
>         return ERR_PTR(-ENXIO);
> }
> 

