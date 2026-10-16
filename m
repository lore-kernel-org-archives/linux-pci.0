Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21363D5C06;
	Fri, 16 Oct 2026 20:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792181436; cv=none; b=T6xk0e5A7Vc4Pu3dQPt5mCPrer/DSHrHMNGVArmnTixe44jpmEn+xmfoNrF+VT8APnVlOhQDz6b0PwfY7CfLSl1h+F+0b12KB98dAQFp/W3X3113CEjsC/tIaSiwLsfpCUyWV7mY6EQ6nK/TLJv2mRl66EUBfQuZ308EQzwudoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792181436; c=relaxed/simple;
	bh=TGRKCqcM8wtCgAwvh0/4E7uvPhaoPBzUamFXlq+7dG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TngoQkewrNnKkqsjRc4i7/PEJcbuU8QSupJOC6oFiXeKHm51unPpfO7sbltSOBMkZjH6+elvxPZUvTilZE8wJUBuo5tCFcVkAvZNkWxbuNgJXY1QHoPm0wAubomvkmvQ3L9Wfjn3Ae5t54dlD8MdIJxg9XMsawFHX1Mh958mojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZquliao; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZquliao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E201F000C4;
	Fri, 16 Oct 2026 20:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792181434;
	bh=DLpgKGQp8T1NzqmFrpLhW5VkyIVBtZn3g2ShHAUV1fI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RZquliao9IYErFXqpqzk1toqYSIFPmUqm1YM0Q48SUPs9yzVnHoFlDYr8MR0IwAKg
	 alm9gnRYCIMw/iN0zc96XfDXEeC6QDlo7SCSksBG80kVx4C+l+6t2E7FEUZqgG/LPu
	 VNwZYIy6109R40bV4jhCN4GnxX0tuAFPF/ogy3gbF6oaJu1k72Dh2Kxu15cuDpntOB
	 beZ+gnaVsxLwRDqYroiYGFFEm/gpHQf7mAwQii7d7InI5VN/p65MirzptuuEOKHAtU
	 6z2Shb7ibcfSBkEGhPrrzV1Hmc5WLG335KF/JiAMBg7r+zNoWlL0pvrXEpsn1A0pE3
	 KrkzfqBF/wMbg==
Message-ID: <309f6f13-b010-4818-936d-4b7b4b389239@kernel.org>
Date: Fri, 16 Oct 2026 23:10:27 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: iproc-msi: Bound events handled per IRQ
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261016182124.GA1884550@bhelgaas>
Content-Language: en-US
From: Eugen Hristev <ehristev@kernel.org>
In-Reply-To: <20261016182124.GA1884550@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/26 21:21, Bjorn Helgaas wrote:
> On Fri, Oct 16, 2026 at 03:18:53PM +0300, Eugen Hristev wrote:
>> Limit each iProc MSI parent IRQ to 16 event-queue entries.
>>
>> A continuously fed queue could otherwise keep the chained handler running
>> and starve other work. The budget still drains pending events and lets the
>> next parent interrupt continue processing, improving fairness and bounding
>> interrupt-handler latency.
>>
>> Without this starvation avoidance, one CPU can stall indefinitely
>> in the loop and not serve other interrupts, timers, etc.
>>
>> While testing it with an Ethernet NIC,  when too many MSI interrupts
>> come in, CPU might get starved:
>>
>> Connecting to host 192.168.30.1, port 5201
>> [  5] local 192.168.30.2 port 52586 connected to 192.168.30.1 port 5201
>> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
>> [  5]   0.00-1.00   sec   240 MBytes  2.01 Gbits/sec    2    334 KBytes
>> [  5]   1.00-2.00   sec  63.2 MBytes   531 Mbits/sec    1   1.41 KBytes
>> [  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
>> [  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
>> [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
>> [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
>> [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
>> [  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
>> [  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
>> [  177.568497] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>> [  177.568913] rcu:     0-...!: (1 GPs behind) idle=28ac/1/0x4000000000000002 softirq=28922/28930 fqs=1
>> [  177.569457] rcu:     (detected by 1, t=5256 jiffies, g=21629, q=819 ncpus=4)
>> [  177.569870] Sending NMI from CPU 1 to CPUs 0:
>>
>> With this bounded approach, IRQ handler will complete and continue
>> to serve MSI events on the next handler invocation.
> 
> Is there something unique about iproc that makes this an issue, or do
> we need to worry about this in every MSI interrupt handler?
> 
This is not specific to iPROC, so in theory it can happen to any other
MSI interrupt handler. If the handler has no way to break the loop, and
the condition that generates the MSI IRQ happens continuously, the same
situation will happen.
Some other drivers e.g. take the IRQ state into a local variable, do the
task, clear it up, and don't care to read it again, like the iPROC is
doing, unless another MSI fires.
