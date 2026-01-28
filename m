Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2831D86FF;
	Wed, 28 Jan 2026 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769604386; cv=none; b=q+s1K8UtnCu0Guwv4hUvAYT7jUR7QAfm07sl2mDQgie8QYplQ6oAgJb4E7cNlfjZcwllAwk/2w8u/uV4zU+ja65u2fO9FsLUrhAlfbCByQQl3dhVAFBIZfkqrMr3uYC4RGhPb4guN4pfadPyHh2K3zTwpJpZhEHGfvIkM///SmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769604386; c=relaxed/simple;
	bh=GZlyN+H5vttDaWtbdvA7QrRisDTSjustcKB4x5osdN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCCxwJQkGM4sTg0QIbxAFv5LCkOQaA2EeZWi6GdXPOEpsRic1RtQlAh86Ueb4tn2cIpakrVW4oLRzPMiddspAlzXcI3x8JahV+Co0xPjevbpERrKIu88jS18ieyJuBUqtP0q3h6DSsyfRd6zJ/q4SmOPsvJ850n0BRz/0ZX5ZYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K+jL5h2b; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K+jL5h2b"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769604375; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5H1octHPUjq8reaBdfqr3YD7JWEdTZNHksph57o+qWM=;
	b=K+jL5h2bKihFStA1PGTChJGBcJkMiucwKXn7y2YjQ8ct9sYkAEKhaIqwy2UoSj6NsCp4Ch+5Imf7iyWupkxmDij9SGICQVRcoFKQVvDACtA5wM3yItkSZFVDt+VF76vG2dYJBiuiPhrArGl1aCRHw38gPO/z/prXBLNBaAiGBWA=
Received: from 30.246.162.115(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wy3VVn-_1769604373 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Jan 2026 20:46:14 +0800
Message-ID: <881e57b7-aa73-4df6-b37b-d71571567436@linux.alibaba.com>
Date: Wed, 28 Jan 2026 20:45:36 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] PCI/AER: Only clear error bits in
 pcie_clear_device_status()
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, terry.bowman@amd.com, tianruidong@linux.alibaba.com,
 lukas@wunner.de
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-6-xueshuai@linux.alibaba.com>
 <20260127104520.0000579c@huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260127104520.0000579c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/27/26 6:45 PM, Jonathan Cameron wrote:
> On Sat, 24 Jan 2026 15:45:57 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> Currently, pcie_clear_device_status() clears the entire PCIe Device
>> Status register (PCI_EXP_DEVSTA), which includes both error status bits
>> and other status bits such as AUX Power Detected (AUXPD) and
>> Transactions Pending (TRPND).
>>
>> Clearing non-error status bits can interfere with other drivers or
>> subsystems that may rely on these bits. To fix it, only clear the error
>> bits (0xf) while preserving other status bits.
>>
>> Fixes: ec752f5d54d7 ("PCI/AER: Clear device status bits during ERR_FATAL and ERR_NONFATAL")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Similar to previous. Drag to start of series to make backports easier if
> we think this is a fix that affects real cases.  

Thank you for the detailed feedback.

I'll move this patch to the start of the series for easier backporting.

> For stuff that's defined
> in the PCI 6.2 spec, AUX power and Transactions Pending are RO, but
> the interesting one is Emergency Power Reduction Detected which is RW1C
> and hence reason this fix is potentially needed  + future features using
> remaining bits.
> 
> I'd be more explicit in the commit message for that.  Talk about it not
> mattering for AUXPD or TRPND because they are RO, vs the ones we
> aren't using yet in Linux with the emergency power reduction detected
> as an example that clearly shows we need to mask this!
> 

You're absolutely right - the commit
message should be more explicit about the different bit types and their
implications.

The revised the commit message is:

PCI/AER: Only clear error bits in PCIe Device Status register

Currently, pcie_clear_device_status() clears the entire PCIe Device
Status register (PCI_EXP_DEVSTA), which includes both error status bits
and other status bits.

According to PCIe Base Spec r6.0 sec 7.5.3.5, the Device Status register
contains different types of status bits:

- Read-only bits (AUXPD, TRPND): Writing to these has no effect, but
   clearing them is unnecessary.

- RW1C (read/write 1 to clear) non-error bits: For example, Emergency
   Power Reduction Detected (bit 6). Unconditionally clearing these bits
   can interfere with other drivers or subsystems that rely on them.

- Reserved bits: May be used for future features and should be preserved.

To prevent unintended side effects, modify pcie_clear_device_status() to
only clear the four error status bits (CED, NFED, FED, URD) while
preserving all other status bits.

Fixes: ec752f5d54d7 ("PCI/AER: Clear device status bits during ERR_FATAL and ERR_NONFATAL")
Cc: stable@vger.kernel.org
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

> J

Thanks.

Best Regards,
Shuai
