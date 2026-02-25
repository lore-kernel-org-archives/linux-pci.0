Received: from mail-m32124.qiye.163.com (mail-m32124.qiye.163.com [220.197.32.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AA12BAF7;
	Wed, 25 Feb 2026 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983037; cv=none; b=J3uTuQxmqO1qDNRN0lHZuWG/uLsvqa4o1G7Cp415os6ZtJkS9V0rIHlEIHqW/++aqkE9mX6gY61ihwRf3L0585ufij2XUMORr89Pfz1Ku40l5d0oNgGKW33IZWpWhMHEyXRI8xHO1f09QtPIvJOgmSJ03JV/aTATz3Y//op+0eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983037; c=relaxed/simple;
	bh=Ug82X9tXIuChRCBmaGWUTNeo2LrKxHM2wDugXAPpDIk=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sAFwJ+6DmTZchG22X08rgSEqpHqU0xHFc9v76FPkLxPrT/biECWub6Faud98pG0l13a2JNVhL384X9lAEAGs6+atEBaimaLVzwT5XpbLok17z/hpla3VLv5X55PJaBBC8w294i2/lcuwFgHE6ID/copoSUFiwpN/lE/E14B5Wnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=RiMeCrvR; arc=none smtp.client-ip=220.197.32.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="RiMeCrvR"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34da72a41;
	Wed, 25 Feb 2026 09:25:19 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-rockchip@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 3/3] PCI: dw-rockchip: Add pcie_ltssm_state_transition
 trace support
To: Steven Rostedt <rostedt@goodmis.org>
References: <1769047340-113287-1-git-send-email-shawn.lin@rock-chips.com>
 <1769047340-113287-4-git-send-email-shawn.lin@rock-chips.com>
 <20260224091115.6e32c38e@fedora> <20260224091601.48a7b3c0@fedora>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <6177ba1f-c89e-486a-fdb5-9344c6551d72@rock-chips.com>
Date: Wed, 25 Feb 2026 09:25:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260224091601.48a7b3c0@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c92668ac109cckunmeceb3770aa21f8
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGklLH1YaTk8aTEoeHx5PTxlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=RiMeCrvRtgt2dVUqWRNBLAEdv/gUkM8HUNynK7JgMxgcbJgnI6ZKCOOx73UIwBa1xRky8AyaFrhrH9CDX8pr5HST31qHk2zWxCEZGGMYFnnbVr5zTq+YlNDlYdI5XB3g7ro7PPjsgC0GPfHPxC1n9BdiS+07+yxSACr+MNIAboE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=0CtRRU86YFrtubdwShhQPgmlG8739fPgSVh2JLGIN0w=;
	h=date:mime-version:subject:message-id:from;

Hi Steven,

在 2026/02/24 星期二 22:16, Steven Rostedt 写道:
> On Tue, 24 Feb 2026 09:11:15 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>>> +#ifdef CONFIG_TRACING
>>> +static void rockchip_pcie_ltssm_trace_work(struct work_struct *work)
>>> +{
>>> +	struct rockchip_pcie *rockchip = container_of(work,
>>> +						struct rockchip_pcie,
>>> +						trace_work.work);
>>> +	struct dw_pcie *pci = &rockchip->pci;
>>> +	enum dw_pcie_ltssm state;
>>> +	u32 i, l1ss, prev_val = DW_PCIE_LTSSM_UNKNOWN, rate, val;
>>> +
>>> +	if (!pci_ltssm_tp_enabled())
>>> +		goto skip_trace;
>>
>> You can use:
>>
>> 	if (!trace_pcie_ltssm_state_transition_enabled())
>> 		goto skip_trace;
>>
>> The above is a static branch. That means when tracing is disabled, it is
>> basically:
>>
>> 	goto skip_trace;
>>
>> and when tracing is enabled it is a nop.

I must admit I borrow it from arch/powerpc/include/asm/trace.h and
include/trace/events/i2c.h for reference, where the reg and unreg
just increase and decrease the ref count to indicate if the tp
should be continued. Sure, the static branch could be used instead,
even without reg and unreg implementation.

>>

..

>>> +}
>>> +
> 
> Hmm, so basically you only want to call the work when tracing is
> enabled? That's what I was thinking should be enabled by the reg and
> unreg functions. That is, the reg should enabled the delayed work, and
> the unreg should disable it from being called.
> 
> This looks like it calls the work regardless of if tracing is enabled
> or not. Why waste the cycles when tracing is disabled?

I looked into implementing reg and unreg callbacks to directly schedule
and cancel the delayed work. The challenge is that this tracepoint
belongs to the shared PCI subsystem trace hierarchy, while the polling
work itself is per-controller. I haven't found a clean way to register
per-driver callbacks in this common context.

Creating a separate Rockchip-specific tracepoint via
tracepoint_probe_register() would detach it from the standard PCIe trace
event hierarchy, which seems undesirable.

As a practical middle ground, I implement reg and unreg to maintain a
user count like this v4. All drivers using this tracepoint would then
rely on the count to gate their work execution, making the delayed work
essentially a no-op when tracing is disabled.

Alternatively, we could simply revert to the V3 approach and rely
entirely on the trace_pcie_ltssm_state_transition_enabled() static
branch check, which would remove the need for reg and unreg altogether.

If you have better suggestions or can point me to a preferred pattern 
for this, I'd appreciate your advice.

> 
> -- Steve
> 
