Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822300;
	b=IlIXiiXQJ3lBEOi+J6/f4cyQvpbVI73T5mgXRttLk2IckRBWVlfFL3wuT1Fpl7wI59Q+
	 vSsvHuup9t6lw8LPANBJWorYMMeYlosN/swBuYgrH4+XN2CyoTgu+/2scMWubOW+NXDsQ
	 qCWM+lRTC68UmKtHyoll0MKy/STR0Fm8aq4Xk/GjNXLZ4Sesi0qS2uW9RkRk/VOxXIjew
	 EASXzP4qzbc2yzjLsEm9gXWrGkSyMUjOeBw3xiq+l4tnJCL7Avl65sfd0Nn77vjO911Hf
	 Wn3Qgx5KPF+6dr4b6y774I6BzT7eVhPNAf5esAI0Ke9oCDDIMV5ayddvX9RTJHgVWxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822300;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=57vfrI08RU+BjdVlt6HNqo3GZbH4J3dGXlSjxWrO5dY=;
	b=MSmPk7/u6aipW/p1vOBJJzk72PZX5EMQ2BAXvG3RoIepxyziU5ktzUvNanGvRek5WiVT
	 ksC5ce1baom69GOEQxuszazoG9UtaRLI2eIGNlHHHKjdw+uoupnn0aLH7hGZr2Z3zwFSw
	 AW8xyK83uiWylKRspGaq09G1CF0WBlKCk0xJPCQNodB8nLC1IyurGSCtHBk3FpAZzCY0N
	 TQ5haDyOGlU884MVHJEF+cT4OQ+J169tgHU5Hb5x21AeMX8YCaroqlbsy8Ie3+tP3sC61
	 pA6hHMZc55iPi4Sze0tT40djFd2Nq1jOdr0w7h9uptqZp7aVHSarg/5ZjOTt5NzmGFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KhCF2oMx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603D06079740;
	Wed,  4 Nov 2026 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KhCF2oMx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B98F1F000C1;
	Wed,  4 Nov 2026 19:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822300;
	bh=57vfrI08RU+BjdVlt6HNqo3GZbH4J3dGXlSjxWrO5dY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KhCF2oMxoz87W+u3A5bPcohuwPziaHxHMdwPT9EHqJ1WeQ7Nwxoh++Ajbwa4VXkEf
	 rftxIrr3F6NQKo+MYYg9bZOqAibrI8VBkMa1zVx7apyjbD/7FuNCXleWStsd5LAHiD
	 5Ywpwm3UmY0EFN7vQkoIBuRcs/4XsyOuhJHfMtU9URbH+uwKPjzJQgTzjcLwxad9Z/
	 px0i4V7Rg89xGist/Lg0p7U1XDvkFOGnCDelizxvwsQOoYOc1r3C6zDthUr6clx+o1
	 4yrL1gdCU18Tg+KbxHhpIoEhrTYkbcsYS+RSxnWvDG46Uv2cJ7kkkBtJTQ0wjYEN7/
	 nUe0GMemw82lQ==
Message-ID: <de273977-8e8d-410e-8424-e99a0b4080b7@kernel.org>
Date: Wed, 4 Nov 2026 21:58:13 +0200
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: iproc-msi: Bound events handled per IRQ
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261016182124.GA1884550@bhelgaas>
 <309f6f13-b010-4818-936d-4b7b4b389239@kernel.org>
 <179338093960.40615.2809022600772649565.b4-reply@b4>
Content-Language: en-US
From: Eugen Hristev <ehristev@kernel.org>
In-Reply-To: <179338093960.40615.2809022600772649565.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/26 19:22, Manivannan Sadhasivam wrote:
> On 2026-10-16 23:10 +0300, Eugen Hristev wrote:
>> On 10/16/26 21:21, Bjorn Helgaas wrote:
>>> On Fri, Oct 16, 2026 at 03:18:53PM +0300, Eugen Hristev wrote:
>>>> Limit each iProc MSI parent IRQ to 16 event-queue entries.
>>>>
>>>> A continuously fed queue could otherwise keep the chained handler running
>>>> and starve other work. The budget still drains pending events and lets the
>>>> next parent interrupt continue processing, improving fairness and bounding
>>>> interrupt-handler latency.
>>>>
>>>> Without this starvation avoidance, one CPU can stall indefinitely
>>>> in the loop and not serve other interrupts, timers, etc.
>>>>
>>>> While testing it with an Ethernet NIC,  when too many MSI interrupts
>>>> come in, CPU might get starved:
>>>>
>>>> Connecting to host 192.168.30.1, port 5201
>>>> [  5] local 192.168.30.2 port 52586 connected to 192.168.30.1 port 5201
>>>> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
>>>> [  5]   0.00-1.00   sec   240 MBytes  2.01 Gbits/sec    2    334 KBytes
>>>> [  5]   1.00-2.00   sec  63.2 MBytes   531 Mbits/sec    1   1.41 KBytes
>>>> [  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
>>>> [  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
>>>> [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
>>>> [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
>>>> [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
>>>> [  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
>>>> [  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
>>>> [  177.568497] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>>>> [  177.568913] rcu:     0-...!: (1 GPs behind) idle=28ac/1/0x4000000000000002 softirq=28922/28930 fqs=1
>>>> [  177.569457] rcu:     (detected by 1, t=5256 jiffies, g=21629, q=819 ncpus=4)
>>>> [  177.569870] Sending NMI from CPU 1 to CPUs 0:
>>>>
>>>> With this bounded approach, IRQ handler will complete and continue
>>>> to serve MSI events on the next handler invocation.
>>>
>>> Is there something unique about iproc that makes this an issue, or do
>>> we need to worry about this in every MSI interrupt handler?
>>>
>> This is not specific to iPROC, so in theory it can happen to any other
>> MSI interrupt handler. If the handler has no way to break the loop, and
>> the condition that generates the MSI IRQ happens continuously, the same
>> situation will happen.
> 
>> Some other drivers e.g. take the IRQ state into a local variable, do the
>> task, clear it up, and don't care to read it again, like the iPROC is
>> doing, unless another MSI fires.
>>
> 
> You should rework the iproc handler to read head and tail outside of the loop
> and handle the recorded events inside the loop. This will avoid using any
> arbitrary max event limit and allow other handlers to also run.

Hi Mani,

Thanks for the feedback, I changed it as you said, sent a v2.

Eugen>
> - Mani
> 

