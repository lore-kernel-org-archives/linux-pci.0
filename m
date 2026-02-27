Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0592C330D38;
	Fri, 27 Feb 2026 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195302; cv=none; b=cgrSFqjU6dQQvcyXe4RgHhTQs1DNDWxIv5ZshhIrYQ/8C+vflWmgTa/nhWy423o//9CnOACiDAam5geEmI2Jz/ZNNqdWb3C+acmaizX4DwOf2lmni0Z9kOHa9ORBYPBKzSE88UUSb4oFR9YXj2CSeBFf60/0qT/l0gKL80iQ7H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195302; c=relaxed/simple;
	bh=Mv70mm7t3/c0nlLKKNC4TuiIrdJ2d+luTMklA7OKYbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTCIpoxzQnLbJdtr+kJ9PQzGGHjCZKVhq18aJZ3uisPpGCfE2bRLxYAD3Yp7jyyw57csxJkVkiXKYyL6WLNlmLaCQc21Dg9aq6YPnRkxprnUy5IK5UaUX/a+lfvQA0LMlJyXAnAzrdjmP1wFbxJc7OTYOCFxQcHjwT/YgdWtGKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YomNEceZ; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YomNEceZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772195292; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YAnptZhgz1649pWMwYw9NqZhdnSslf/yjACo95roL/I=;
	b=YomNEceZ3ysp8+JUISPjrHsAF/8PJb6HBodhOyRV4PmhNG59focYSsjULk04IdbdYlraH5+KUIQYEvNtW8jpM2teDCWwmzc+DH+O0VSX4Vp+668yACJNI0uPiMfWluQfmSGN86z5EyOK6YYSQUxgTs+F9GIYai2MrOIIlLjx3Ak=
Received: from 30.246.163.43(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WzuNC9i_1772195290 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Feb 2026 20:28:11 +0800
Message-ID: <a0ec1ce8-06cc-463d-86b4-a6d6a625a808@linux.alibaba.com>
Date: Fri, 27 Feb 2026 20:28:17 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] PCI/DPC: Run recovery on device that detected the
 error
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Jonathan.Cameron@huawei.com, terry.bowman@amd.com,
 tianruidong@linux.alibaba.com
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-3-xueshuai@linux.alibaba.com>
 <aYCujqZIvxElSsOE@wunner.de> <aYESh4bCE2lzTg2S@wunner.de>
 <924dce22-171e-4508-907c-74f57f1bdea8@linux.alibaba.com>
 <234dcf9e-05ff-485c-a330-019a4fbb5f3b@linux.alibaba.com>
 <aaF2PAOZsHr4PuC_@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aaF2PAOZsHr4PuC_@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/27/26 6:47 PM, Lukas Wunner wrote:
> On Fri, Feb 27, 2026 at 04:28:59PM +0800, Shuai Xue wrote:
>> On 2/7/26 3:48 PM, Shuai Xue wrote:
>>> Regarding pci_restore_state() in slot_reset(): I see now that it does
>>> call pci_aer_clear_status(dev) (at line 1844 in pci.c), which will
>>> clear the AER Status registers. So if we walk the hierarchy after
>>> the slot_reset callbacks, the error bits accumulated during DPC will
>>> already be cleared.
>>>
>>> To avoid losing those errors, I think the walk should happen after
>>> dpc_reset_link() succeeds but *before* pcie_do_recovery() invokes the
>>> slot_reset callbacks. That way, we can capture the AER Status bits
>>> before pci_restore_state() clears them.
>>>
>>> Does that sound like the right approach, or would you prefer a
>>> different placement?
> 
> The problem is that if the hierarchy that was reset is deeper than
> one level, you first need to call pci_restore_state() on all the
> PCIe Upstream and Downstream Ports that were reset before you can
> access the Endpoints at the bottom of the hierarchy.
> 
> E.g. if DPC occurs at a Root Port with multiple nested PCIe switches
> below, the Endpoints at the "leafs" of that tree are only accessible
> once Config Space has been restored at all the PCIe switches
> in-between the Endpoints and the DPC-capable Root Port.
> 
> Hence your proposal unfortunately won't work.
> 
> I think the solution is to move pci_aer_clear_status() out of
> pci_restore_state() into the callers that actually need it.
> But that requires going through every single caller.
> I've begun doing that last week and am about 60% done.
> 
> Once pci_restore_state() no longer clears the error bits, we can
> report and clear them after the "report_slot_reset" stage (which
> is where drivers call pci_restore_state()).
> 
> I've also changed my mind and I think reporting and clearing
> the error bits *could* happen in pcie_do_recovery() even if it
> were used for EEH and s390 because those platforms may plug in
> AER-capable devices as well and so we do need to clear the bits
> regardless of the error recovery mechanism used.
> 
> Let me get back to you once I've gone through all the callers of
> pci_restore_state().  Please be patient.
> 

Sure, glad to hear you have been working on that.


Thanks.
SHuai

