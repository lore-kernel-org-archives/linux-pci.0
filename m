Received: from mail-m32107.qiye.163.com (mail-m32107.qiye.163.com [220.197.32.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0FC2F851;
	Tue,  3 Mar 2026 04:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772510445; cv=none; b=KrgSqtipTpGzjupqRMRaUxxdRymg9q54RTSn+kHO/yto3e78QjXLDW12QYTcKawZrqh/8Yo8H1/IOQcgwWwyPNvuBXjYL4986g0XIAZFb3CfIykekIRABAjdBt6kd1eXplxjkB+yjUhuJqNYielmIU+6C2d76DeIRLliooRH3Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772510445; c=relaxed/simple;
	bh=wc+eqZZVfxysn7nqDrFIPL65yksKv2aJmNV0TCBsyxw=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UDAhtWF4F/hiJuHtuHoivNUuYbs/Yi1JvZPCmGrnx34D0w1doz/NQNPPVflWpYXGMhKuI9OI7mEBHamhdrbdzEnE/nABRiei3G7lb7BEWtFaeJahtAC89ycJhOM9v+sK76RQVnWht9VjYrbZ7zrC1IMXuVfiC5eFuxTF7uLnXsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fcOCZunh; arc=none smtp.client-ip=220.197.32.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fcOCZunh"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 35873ab86;
	Tue, 3 Mar 2026 11:25:04 +0800 (GMT+08:00)
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
Message-ID: <9c58271e-394c-a49e-ab2f-797f31ac9a79@rock-chips.com>
Date: Tue, 3 Mar 2026 11:25:03 +0800
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
X-HM-Tid: 0a9cb1ba533c09cckunm664397451064e69
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkNCHVYZQx1JSUkZQkNCHkhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=fcOCZunhr7Y/DHLUF7L3Wb8FLFNDfUkfU7AkKjjWaKuAbLrt3jIhPnhzA3AfgYiNDKuBBUgCaVP6YnlBWUypnln5kdTxA1wA8MCwJG7nI/KUvkm9UqLMCPMd3+zrOwRI+sCwIUCV6TH0CvJ8RlVDvwmPBaPnXAX33ISLhEt1JS8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=o7qDpfAmCY+KKmwW4NiVQPzaWeAB3Pm4lOV/bydwgz8=;
	h=date:mime-version:subject:message-id:from;

Hi Steven,

在 2026/02/24 星期二 22:16, Steven Rostedt 写道:
> On Tue, 24 Feb 2026 09:11:15 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 

...

>>> +	}
>>> +
>>> +skip_trace:
>>> +	schedule_delayed_work(&rockchip->trace_work, msecs_to_jiffies(5000));
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
> 


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

> -- Steve
> 
