Received: from mail-m3269.qiye.163.com (mail-m3269.qiye.163.com [220.197.32.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805222C11CD;
	Wed, 11 Feb 2026 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770820193; cv=none; b=Cct7W76XWrpWyEKirNBZo9aRheecl8+4Vj8+8bigwsVOg8WwdzLaTwmcRlj40zTITUqK+Rw5lQi+m7EAE/mCLQLwk+BB2pV9FpWsjjOIU+XA85KQ0pFsKTNpVInp4NobT+d5ssxYQ/hqinDFIKFPa0sA0JH0gM9piD7lTYE0DZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770820193; c=relaxed/simple;
	bh=ebQPio9qXpyIkIpTjwKBzvWCx52EmSX59ZF3ys+6H1w=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hLbFFRkbCuNb0i7bZ0hMETFxz01WwVyt0fzLD60TeFhoZQtnlkYNktCFZ77tknclcBgdmIazZ6JY3YQr7EqtEFMnCuHbmQLR37p78gMeZ1Nd3FWMMJ7O5lUFE6haIFWwsuomG4UIwJArv0dgL0wOGidqtYS1NLw5UQp2/fMoh9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Nz3YWhDZ; arc=none smtp.client-ip=220.197.32.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Nz3YWhDZ"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 33dfe5d17;
	Wed, 11 Feb 2026 21:13:52 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 0/3] PCI Controller event and LTSSM tracepoint support
To: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <1769047340-113287-1-git-send-email-shawn.lin@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <9e06e69c-d10a-1f21-cbf7-204319549612@rock-chips.com>
Date: Wed, 11 Feb 2026 21:13:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1769047340-113287-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c4cd6343f09cckunm214ede4110c896
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUIfT1YdHRlOTE1PS0kaHU5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Nz3YWhDZm0LmR1of8XMDaWu+kLjneRk8YY4evasBfpH4icvK+sR+yeTRbZ+U+4vK6Wj1TY5aIqPAsEA/NqflH6k2azbWKsLScTq+LECC+KPqin3M+b/pni4W6+hSNIkT/zBFC5Fx04iYKD1wrgqmYOX87DOoxjsXIKwuy/ZQIbk=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Q3+gv+s4ouicFuyqVv3c4xE+kWTdo3QY3eezy0POmeY=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/22 星期四 10:02, Shawn Lin 写道:
> This patch-set adds new pci controller event and LTSSM tracepoint used by host drivers
> which provide LTSSM trace functionality. The first user is pcie-dw-rockchip with a 256
> Bytes FIFO for recording LTSSM transition.
> 

Gentle ping...

> Testing
> =========
> 
> This series was tested on RK3588/RK3588s EVB1 with NVMe SSD connected to PCIe3 and PCIe2
> root ports.
> 
> echo 1 > /sys/kernel/debug/tracing/events/pci_controller/pcie_ltssm_state_transition/enable
> cat /sys/kernel/debug/tracing/trace_pipe
> 
>   # tracer: nop
>   #
>   # entries-in-buffer/entries-written: 64/64   #P:8
>   #
>   #                                _-----=> irqs-off/BH-disabled
>   #                               / _----=> need-resched
>   #                              | / _---=> hardirq/softirq
>   #                              || / _--=> preempt-depth
>   #                              ||| / _-=> migrate-disable
>   #                              |||| /     delay
>   #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>   #              | |         |   |||||     |         |
>        kworker/0:0-9       [000] .....     5.600194: pcie_ltssm_state_transition: dev: a40000000.pcie state: DETECT_ACT rate: Unknown
>        kworker/0:0-9       [000] .....     5.600198: pcie_ltssm_state_transition: dev: a40000000.pcie state: DETECT_WAIT rate: Unknown
>        kworker/0:0-9       [000] .....     5.600199: pcie_ltssm_state_transition: dev: a40000000.pcie state: DETECT_ACT rate: Unknown
>        kworker/0:0-9       [000] .....     5.600201: pcie_ltssm_state_transition: dev: a40000000.pcie state: POLL_ACTIVE rate: Unknown
>        kworker/0:0-9       [000] .....     5.600202: pcie_ltssm_state_transition: dev: a40000000.pcie state: POLL_CONFIG rate: Unknown
>        kworker/0:0-9       [000] .....     5.600204: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_LINKWD_START rate: Unknown
>        kworker/0:0-9       [000] .....     5.600206: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_LINKWD_ACEPT rate: Unknown
>        kworker/0:0-9       [000] .....     5.600207: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_LANENUM_WAI rate: Unknown
>        kworker/0:0-9       [000] .....     5.600208: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_LANENUM_ACEPT rate: Unknown
>        kworker/0:0-9       [000] .....     5.600210: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_COMPLETE rate: Unknown
>        kworker/0:0-9       [000] .....     5.600212: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_IDLE rate: Unknown
>        kworker/0:0-9       [000] .....     5.600213: pcie_ltssm_state_transition: dev: a40000000.pcie state: L0 rate: 2.5 GT/s
>        kworker/0:0-9       [000] .....     5.600214: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: Unknown
>        kworker/0:0-9       [000] .....     5.600216: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_RCVRCFG rate: Unknown
>        kworker/0:0-9       [000] .....     5.600217: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_SPEED rate: Unknown
>        kworker/0:0-9       [000] .....     5.600218: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: Unknown
>        kworker/0:0-9       [000] .....     5.600220: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_EQ1 rate: Unknown
>        kworker/0:0-9       [000] .....     5.600221: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_EQ2 rate: 8.0 GT/s
>        kworker/0:0-9       [000] .....     5.600222: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_EQ3 rate: 8.0 GT/s
>        kworker/0:0-9       [000] .....     5.600224: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: 8.0 GT/s
>        kworker/0:0-9       [000] .....     5.600225: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_RCVRCFG rate: 8.0 GT/s
>        kworker/0:0-9       [000] .....     5.600226: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_IDLE rate: 8.0 GT/s
>        kworker/0:0-9       [000] .....     5.600227: pcie_ltssm_state_transition: dev: a40000000.pcie state: L0 rate: 8.0 GT/s
>        kworker/0:0-9       [000] .....     5.600228: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: 8.0 GT/s
>        kworker/0:0-9       [000] .....     5.600229: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_RCVRCFG rate: 8.0 GT/s
>        kworker/0:0-9       [000] .....     5.600231: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_IDLE rate: 8.0 GT/s
>        kworker/0:0-9       [000] .....     5.600232: pcie_ltssm_state_transition: dev: a40000000.pcie state: L0 rate: 8.0 GT/s
>        kworker/0:0-9       [000] .....     5.600233: pcie_ltssm_state_transition: dev: a40000000.pcie state: L123_SEND_EIDLE rate: 8.0 GT/s
>        kworker/0:0-9       [000] .....     5.600234: pcie_ltssm_state_transition: dev: a40000000.pcie state: L1_IDLE rate: 8.0 GT/s
>        kworker/0:0-9       [000] .....     5.600236: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: 8.0 GT/s
>        kworker/0:0-9       [000] .....     5.600237: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_RCVRCFG rate: 8.0 GT/s
>        kworker/0:0-9       [000] .....     5.600238: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_IDLE rate: 8.0 GT/s
>        kworker/0:0-9       [000] .....     5.600239: pcie_ltssm_state_transition: dev: a40000000.pcie state: L0 rate: 8.0 GT/s
> 
> 
> Changes in v4:
> - use TRACE_EVENT_FN to notify when to start and stop the tracepoint,
>    and export pci_ltssm_tp_enabled() for host drivers to use
> - skip trace if pci_ltssm_tp_enabled() is false.(Steven)
> - wrap into 80 columns(Bjorn)
> 
> Changes in v3:
> - add TRACE_DEFINE_ENUM for all enums(Steven Rostedt)
> - Add toctree entry in Documentation/trace/index.rst(Bagas Sanjaya)
> - fix mismatch section underline length(Bagas Sanjaya)
> - Make example snippets in code block(Bagas Sanjaya)
> - warp context into 80 columns and fix the file name(Bjorn)
> - reorder variables(Mani)
> - rename loop to i; rename en to enable(Mani)
> - use FIELD_GET(Mani)
> - add comment about how the FIFO works(Mani)
> 
> Changes in v2:
> - use tracepoint
> 
> Shawn Lin (3):
>    PCI: trace: Add PCI controller LTSSM transition tracepoint
>    Documentation: tracing: Add PCI controller event documentation
>    PCI: dw-rockchip: Add pcie_ltssm_state_transition trace support
> 
>   Documentation/trace/events-pci-controller.rst |  42 ++++++++++
>   Documentation/trace/index.rst                 |   1 +
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 111 ++++++++++++++++++++++++++
>   drivers/pci/trace.c                           |  20 +++++
>   include/linux/pci.h                           |   4 +
>   include/trace/events/pci_controller.h         |  57 +++++++++++++
>   6 files changed, 235 insertions(+)
>   create mode 100644 Documentation/trace/events-pci-controller.rst
>   create mode 100644 include/trace/events/pci_controller.h
> 
