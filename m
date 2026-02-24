Received: from mail-m49209.qiye.163.com (mail-m49209.qiye.163.com [45.254.49.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16813286A9;
	Tue, 24 Feb 2026 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922995; cv=none; b=VzXOVc1o/Z0CZ4TpCV1S9QpvLpZK8+qMyuzdhbPlJwSSlyYl1Dybc5Qc2NG+WjJcgDyiwYZvhnfT2eUEH/SnW4I/JLD1ARxG+3JW7FV0oThLyZWrBADfwLY2HfJ5NTLmIuDJEC8DKiWbGYM3v1LcIrKAE3qyhCIqmuSvNu8uUKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922995; c=relaxed/simple;
	bh=uU7ldyVWgJ3IjjXxuYKTDQ44EeBd9vmenmQj+XJ45rU=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jqtKu8my8M+iEFFuoKTIh+gTUfpP6pFL7MqeCiL7smhJWze/H1aNZJvQYFuEh799G4bEWQ3ELo7bCkOM7rcSZKH1/S5meoFnm2ohJpaI8Qc1EEsvCqlY789EP7QWPC8VGmhcwshY+H14xGBpkjU42QvNtOh9YjU9skazxiKAEzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=K8bae7uI; arc=none smtp.client-ip=45.254.49.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="K8bae7uI"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34c8ca9e5;
	Tue, 24 Feb 2026 16:49:48 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v4 0/3] PCI Controller event and LTSSM tracepoint support
To: Steven Rostedt <rostedt@goodmis.org>
References: <1769047340-113287-1-git-send-email-shawn.lin@rock-chips.com>
 <9e06e69c-d10a-1f21-cbf7-204319549612@rock-chips.com>
 <u3es7h4mgzdqfhvpl52s3x4vcisrpazcm4qb6x7lu4srmagxpn@hca2begqypeu>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <5549b86e-36f7-e5b2-e16c-f70e328ca6c2@rock-chips.com>
Date: Tue, 24 Feb 2026 16:49:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <u3es7h4mgzdqfhvpl52s3x4vcisrpazcm4qb6x7lu4srmagxpn@hca2begqypeu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c8ed71d8609cckunm615550f2a3d87c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxlIH1ZIGR1OSUtMSB1LSxlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=K8bae7uIKn3Hztc6iPpwFtwdRlGkBsbKJTFptSlPv4liR8OW0OZH3rWthDv9UXzbJvF+a+fMe1JysyBcQwGcBsZA0xW+brsXCOsFqwo9R0uTblifkeQAcRBeOWwjVGKFKZx7kPL7GLmFRpBWB43xnpuvCndkEuk9Z06xyCJCbl0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=1ZtDx6p9eQciNBSS2yVaAQSBq8mXFIkhNhuoivr3Ggo=;
	h=date:mime-version:subject:message-id:from;

Hi Steven,

在 2026/02/11 星期三 23:40, Manivannan Sadhasivam 写道:
> On Wed, Feb 11, 2026 at 09:13:50PM +0800, Shawn Lin wrote:
>> 在 2026/01/22 星期四 10:02, Shawn Lin 写道:
>>> This patch-set adds new pci controller event and LTSSM tracepoint used by host drivers
>>> which provide LTSSM trace functionality. The first user is pcie-dw-rockchip with a 256
>>> Bytes FIFO for recording LTSSM transition.
>>>
>>
>> Gentle ping...
>>
> 
> Merge window is open now, so we can't accept any patches until -rc1. And I'm
> also waiting for an Ack from Steven for the tracing part.
> 

I'd appreciate it if you could share any concerns you might have about 
v4. :)

Thanks.

> - Mani
> 
>>> Testing
>>> =========
>>>
>>> This series was tested on RK3588/RK3588s EVB1 with NVMe SSD connected to PCIe3 and PCIe2
>>> root ports.
>>>
>>> echo 1 > /sys/kernel/debug/tracing/events/pci_controller/pcie_ltssm_state_transition/enable
>>> cat /sys/kernel/debug/tracing/trace_pipe
>>>
>>>    # tracer: nop
>>>    #
>>>    # entries-in-buffer/entries-written: 64/64   #P:8
>>>    #
>>>    #                                _-----=> irqs-off/BH-disabled
>>>    #                               / _----=> need-resched
>>>    #                              | / _---=> hardirq/softirq
>>>    #                              || / _--=> preempt-depth
>>>    #                              ||| / _-=> migrate-disable
>>>    #                              |||| /     delay
>>>    #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>>>    #              | |         |   |||||     |         |
>>>         kworker/0:0-9       [000] .....     5.600194: pcie_ltssm_state_transition: dev: a40000000.pcie state: DETECT_ACT rate: Unknown
>>>         kworker/0:0-9       [000] .....     5.600198: pcie_ltssm_state_transition: dev: a40000000.pcie state: DETECT_WAIT rate: Unknown
>>>         kworker/0:0-9       [000] .....     5.600199: pcie_ltssm_state_transition: dev: a40000000.pcie state: DETECT_ACT rate: Unknown
>>>         kworker/0:0-9       [000] .....     5.600201: pcie_ltssm_state_transition: dev: a40000000.pcie state: POLL_ACTIVE rate: Unknown
>>>         kworker/0:0-9       [000] .....     5.600202: pcie_ltssm_state_transition: dev: a40000000.pcie state: POLL_CONFIG rate: Unknown
>>>         kworker/0:0-9       [000] .....     5.600204: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_LINKWD_START rate: Unknown
>>>         kworker/0:0-9       [000] .....     5.600206: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_LINKWD_ACEPT rate: Unknown
>>>         kworker/0:0-9       [000] .....     5.600207: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_LANENUM_WAI rate: Unknown
>>>         kworker/0:0-9       [000] .....     5.600208: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_LANENUM_ACEPT rate: Unknown
>>>         kworker/0:0-9       [000] .....     5.600210: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_COMPLETE rate: Unknown
>>>         kworker/0:0-9       [000] .....     5.600212: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_IDLE rate: Unknown
>>>         kworker/0:0-9       [000] .....     5.600213: pcie_ltssm_state_transition: dev: a40000000.pcie state: L0 rate: 2.5 GT/s
>>>         kworker/0:0-9       [000] .....     5.600214: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: Unknown
>>>         kworker/0:0-9       [000] .....     5.600216: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_RCVRCFG rate: Unknown
>>>         kworker/0:0-9       [000] .....     5.600217: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_SPEED rate: Unknown
>>>         kworker/0:0-9       [000] .....     5.600218: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: Unknown
>>>         kworker/0:0-9       [000] .....     5.600220: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_EQ1 rate: Unknown
>>>         kworker/0:0-9       [000] .....     5.600221: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_EQ2 rate: 8.0 GT/s
>>>         kworker/0:0-9       [000] .....     5.600222: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_EQ3 rate: 8.0 GT/s
>>>         kworker/0:0-9       [000] .....     5.600224: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: 8.0 GT/s
>>>         kworker/0:0-9       [000] .....     5.600225: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_RCVRCFG rate: 8.0 GT/s
>>>         kworker/0:0-9       [000] .....     5.600226: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_IDLE rate: 8.0 GT/s
>>>         kworker/0:0-9       [000] .....     5.600227: pcie_ltssm_state_transition: dev: a40000000.pcie state: L0 rate: 8.0 GT/s
>>>         kworker/0:0-9       [000] .....     5.600228: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: 8.0 GT/s
>>>         kworker/0:0-9       [000] .....     5.600229: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_RCVRCFG rate: 8.0 GT/s
>>>         kworker/0:0-9       [000] .....     5.600231: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_IDLE rate: 8.0 GT/s
>>>         kworker/0:0-9       [000] .....     5.600232: pcie_ltssm_state_transition: dev: a40000000.pcie state: L0 rate: 8.0 GT/s
>>>         kworker/0:0-9       [000] .....     5.600233: pcie_ltssm_state_transition: dev: a40000000.pcie state: L123_SEND_EIDLE rate: 8.0 GT/s
>>>         kworker/0:0-9       [000] .....     5.600234: pcie_ltssm_state_transition: dev: a40000000.pcie state: L1_IDLE rate: 8.0 GT/s
>>>         kworker/0:0-9       [000] .....     5.600236: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: 8.0 GT/s
>>>         kworker/0:0-9       [000] .....     5.600237: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_RCVRCFG rate: 8.0 GT/s
>>>         kworker/0:0-9       [000] .....     5.600238: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_IDLE rate: 8.0 GT/s
>>>         kworker/0:0-9       [000] .....     5.600239: pcie_ltssm_state_transition: dev: a40000000.pcie state: L0 rate: 8.0 GT/s
>>>
>>>
>>> Changes in v4:
>>> - use TRACE_EVENT_FN to notify when to start and stop the tracepoint,
>>>     and export pci_ltssm_tp_enabled() for host drivers to use
>>> - skip trace if pci_ltssm_tp_enabled() is false.(Steven)
>>> - wrap into 80 columns(Bjorn)
>>>
>>> Changes in v3:
>>> - add TRACE_DEFINE_ENUM for all enums(Steven Rostedt)
>>> - Add toctree entry in Documentation/trace/index.rst(Bagas Sanjaya)
>>> - fix mismatch section underline length(Bagas Sanjaya)
>>> - Make example snippets in code block(Bagas Sanjaya)
>>> - warp context into 80 columns and fix the file name(Bjorn)
>>> - reorder variables(Mani)
>>> - rename loop to i; rename en to enable(Mani)
>>> - use FIELD_GET(Mani)
>>> - add comment about how the FIFO works(Mani)
>>>
>>> Changes in v2:
>>> - use tracepoint
>>>
>>> Shawn Lin (3):
>>>     PCI: trace: Add PCI controller LTSSM transition tracepoint
>>>     Documentation: tracing: Add PCI controller event documentation
>>>     PCI: dw-rockchip: Add pcie_ltssm_state_transition trace support
>>>
>>>    Documentation/trace/events-pci-controller.rst |  42 ++++++++++
>>>    Documentation/trace/index.rst                 |   1 +
>>>    drivers/pci/controller/dwc/pcie-dw-rockchip.c | 111 ++++++++++++++++++++++++++
>>>    drivers/pci/trace.c                           |  20 +++++
>>>    include/linux/pci.h                           |   4 +
>>>    include/trace/events/pci_controller.h         |  57 +++++++++++++
>>>    6 files changed, 235 insertions(+)
>>>    create mode 100644 Documentation/trace/events-pci-controller.rst
>>>    create mode 100644 include/trace/events/pci_controller.h
>>>
> 
