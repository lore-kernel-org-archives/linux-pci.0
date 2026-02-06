Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF046346E5D;
	Fri,  6 Feb 2026 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770365637; cv=none; b=WCyQjoDBpQM8Va3IfhfEIAWC1dabjQoS7iYwEv+Rip5cHeXsQ6E8rV0OgM+aNdts7hh8RS3kZQJfDk7RQXsuyo6QbJClJCr52j25ugvGAm33a+Wh0T3Uwy1kl9809RxwwMCHoD0DQKnEHrvYH6JsQXrpHzWKyeSkzgBBVLclU3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770365637; c=relaxed/simple;
	bh=oy/otTbHSce3nVZgddrnlWWy3qDVPEmvgxADEwnIyIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRqCyLp3qavFs6KGlz//EUKoats0okMWAu6MCl7B+94UCp01u9V/3QCo/DbSdy7bN+leTR6OxUiR0JZ85tQFLYX7C1Qk5kqp3a5jpbx91MYZweyZeiqboSLeWAu+8GfquPNyjfWW8wG+tpyduko9Ba8awTNJaupEewsb9i6Rhg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kbceRJYN; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kbceRJYN"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770365627; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=SUR3J96tpew0aIA17uFoZSxztnE+e1qWG/WJy7zluF0=;
	b=kbceRJYNcSfDe1CZWFXAk7RTtnNCZa/8I1sNeOj88/VSONwFlIMsWCbI7zrIHcQSeyyQrh1iExnhFOGMSfBOexVQZ0HuPkFUfg6nOeif55W6NdqNeleJxmoibFQhpEwDqL6dZhq9EUKLp4GcOtadIKiKFCEZYVkC6nwqf73s/fM=
Received: from 30.246.162.188(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WydyNkV_1770365626 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Feb 2026 16:13:47 +0800
Message-ID: <83411a03-e5f8-4f28-b781-b4010a785f1b@linux.alibaba.com>
Date: Fri, 6 Feb 2026 16:12:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] PCI/AER: Only clear error bits in
 pcie_clear_device_status()
To: Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, terry.bowman@amd.com, tianruidong@linux.alibaba.com
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-6-xueshuai@linux.alibaba.com>
 <20260127104520.0000579c@huawei.com>
 <881e57b7-aa73-4df6-b37b-d71571567436@linux.alibaba.com>
 <aYGne72Gjb_d9Myd@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aYGne72Gjb_d9Myd@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/3/26 3:44 PM, Lukas Wunner wrote:
> On Wed, Jan 28, 2026 at 08:45:36PM +0800, Shuai Xue wrote:
>> The revised the commit message is:
>>
>> PCI/AER: Only clear error bits in PCIe Device Status register
>>
>> Currently, pcie_clear_device_status() clears the entire PCIe Device
>> Status register (PCI_EXP_DEVSTA), which includes both error status bits
>> and other status bits.
>>
>> According to PCIe Base Spec r6.0 sec 7.5.3.5, the Device Status register
>> contains different types of status bits:
> 
> Always cite the latest spec revision, i.e. PCIe r7.0 sec 7.5.3.5.

Sure, I will update the cite version.

> 
>> - RW1C (read/write 1 to clear) non-error bits: For example, Emergency
>>    Power Reduction Detected (bit 6). Unconditionally clearing these bits
>>    can interfere with other drivers or subsystems that rely on them.
> 
> It would be good to explicitly call out that this bit was introduced with
> PCIe r5.0 in 2019 and that it's currently the only writable bit in the
> register besides the error bits.

Sure, will add it.

> 
>> - Reserved bits: May be used for future features and should be preserved.
> 
> Wrong, they're marked "RsvdZ" (not "RsvdP"), so they're supposed to be
> written as zero (not preserved).

Thanks for correcting me. Will fix it.

> 
> Thanks,
> 
> Lukas


Thanks for valuable comments.
Shuai

