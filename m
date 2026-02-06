Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D4E2D0C92;
	Fri,  6 Feb 2026 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770367336; cv=none; b=WV0rS6W+IEdkkzL5RdKScItqsaK/RlAf+P67LgWY+qMAGkPmgLIEm7DsJLx9o2mn3dq5yNbt5fixQ1RU8Bk7Rj84zL9jmIya8K/1guRy/5sY5OIVBJIBimsJM3M9omabqrPbHyKueMNyUwIxZWN1UuFdRFl76Ne/sZ7rSFijMfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770367336; c=relaxed/simple;
	bh=VxCCmk6iK/ER2S5jKaIIe/8IZwRN634S4YuLM5qS8QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Czj/141CAL+qpcUeAVE9J6AGj7RqkuPAfSvDpQILrQXBbHy+gLGJjtXRwMcBrhjAGMgIj6vKpMZ2Vl1GCasP7BfHt/r4DefC+vEEhECDECcRFB415xlEba9n3u972eyXxyNZpKDfrmS+Uefara/dk/xXFKpklGjGrO4alXGBY/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gohYLNbV; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gohYLNbV"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770367333; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=roeuOg0Rv1qCNNC6wf86NafkQzf+jUxSv4eS8pnA4tE=;
	b=gohYLNbVzytaYCW7mOEIUN0kcpre53VQHtG8upTdSNs+iJ+G6slh6m/SeiOtGC5y3kWRTeMiHBUuaEGpEcWVa183Zjd5mIAMJotASeilPgJs87t2VOpxr9coGxld0uVMZ0sGO9KsR0sjYmXs7e1D+mWmLYeRkYeS1OlS99+nJm8=
Received: from 30.246.162.188(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wye3ZUk_1770367332 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Feb 2026 16:42:13 +0800
Message-ID: <ab4dd988-8140-4ade-b26f-e6f9e4e8e67d@linux.alibaba.com>
Date: Fri, 6 Feb 2026 16:41:06 +0800
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
 <aYCujqZIvxElSsOE@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aYCujqZIvxElSsOE@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/2/26 10:02 PM, Lukas Wunner wrote:
> On Sat, Jan 24, 2026 at 03:45:54PM +0800, Shuai Xue wrote:
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -372,10 +388,11 @@ static irqreturn_t dpc_handler(int irq, void *context)
>>   		return IRQ_HANDLED;
>>   	}
>>   
>> -	dpc_process_error(err_port);
>> +	err_dev = dpc_process_error(err_port);
>>   
>>   	/* We configure DPC so it only triggers on ERR_FATAL */
>> -	pcie_do_recovery(err_port, pci_channel_io_frozen, dpc_reset_link);
>> +	pcie_do_recovery(err_dev, pci_channel_io_frozen, dpc_reset_link);
>> +	pci_dev_put(err_dev);
>>   
>>   	return IRQ_HANDLED;
>>   }
> 
> You're assuming that the parent of the Requester is always identical
> to the containing Downstream Port.  But that's not necessarily the case:
> 
> E.g., imagine a DPC-capable Root Port with a PCIe switch below
> whose Downstream Ports are not DPC-capable.  Let's say an Endpoint
> beneath the PCIe switch sends ERR_FATAL upstream.  AFAICS, your patch
> will cause pcie_do_recovery() to invoke dpc_reset_link() with the
> Downstream Port of the PCIe switch as argument.  That function will
> then happily use pdev->dpc_cap even though it's 0.

I see. Goot point.

> 
> A possible solution may be to amend dpc_reset_link() to walk upwards,
> starting at pdev, and search for a pci_dev whose pdev->dpc_cap is
> non-zero.  That should be the containing DPC-capable port.

See my reply in your later patch.

> 
> I don't really like the err_dev and err_port terminology invented here.
> We generally use spec terms to make it easy to connect the code to the
> spec.  The spec uses the term "Downstream Port" to denote the containing
> Downstream Port, so a name such as "dport" may be better than "err_port".
 >
> 
> Similarly, the spec uses "Requester" or "Source" for the reporting agent,
> so "req", "requester", "src" or "source" may all be better names than
> "err_dev".

Sure, I wll use the common "dport" and "req" term from spec to make it more readable.


> 
> Thanks,
> 
> Lukas

Thanks for valuable comments.
Shuai

