Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9B30C60D;
	Wed, 11 Feb 2026 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770824435; cv=none; b=VGoSN+eCeQDiX60yZDZBBuUUBa4HBIONCgeJTdo8+SJ4hUpRgc2JKE4CCm/kvuOBEKKZyRcKlelIiilpjisIvwdj3YtjNyEjs5miXPIT+swFvtOabftwzlAViiEN+cSuWDbl0otXWIRkB+M0A0i2u7tzU6XJr9lmmSOiP2f8Ccw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770824435; c=relaxed/simple;
	bh=4XK13jjYLred8II2iFJoWFOdf1Y9k6sr2e/uAGf5JAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGdylnsmVFuMrwpBJu6KLac3gm7rhsm+MpvIzDXB0ofWsjslHrmH9LjhXv7+4CBTblLe9Vb/t6fTHU0eZzspvb/QqSROUMMKdarw9h+aunpyStrox9I50uaRMUfcfNufnIQZ0MeCLlczVbrJzeKl2bkydnjjYhHIlX/F2j24sNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Osf1+son; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Osf1+son"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6D8C4CEF7;
	Wed, 11 Feb 2026 15:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770824435;
	bh=4XK13jjYLred8II2iFJoWFOdf1Y9k6sr2e/uAGf5JAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Osf1+sonyielfcfujsc2iqg2UF+lVBoIHnyPSvXNLhEj+wiJlUY7u3mDE0d93zCzE
	 zBpVIqAZfadRZsH27h80LwM9BD0DSwj5cnui9xvD9fUafzn7f0owQ9Uq1ji2Owlwpo
	 Z4s8PcmJBy8StkHpDAil94og0/4FRu5S+tbUBlzhwRuWJxa79omP4GgLLrh+kRBlYH
	 0oU2c8wRD5ooc9cUjEyj4ly0fTzufA5SbP4ZpE4vLJxNYiGci+frhgviGdMTK5BCa8
	 Huv/5f4XXc6H66h5N4v3lOaLSO49WYhSRPqQD61EimKM8C6aQodJSCEI2ajsqeGca8
	 M7AnWKSbXHOIg==
Date: Wed, 11 Feb 2026 21:10:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 0/3] PCI Controller event and LTSSM tracepoint support
Message-ID: <u3es7h4mgzdqfhvpl52s3x4vcisrpazcm4qb6x7lu4srmagxpn@hca2begqypeu>
References: <1769047340-113287-1-git-send-email-shawn.lin@rock-chips.com>
 <9e06e69c-d10a-1f21-cbf7-204319549612@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e06e69c-d10a-1f21-cbf7-204319549612@rock-chips.com>

On Wed, Feb 11, 2026 at 09:13:50PM +0800, Shawn Lin wrote:
> 在 2026/01/22 星期四 10:02, Shawn Lin 写道:
> > This patch-set adds new pci controller event and LTSSM tracepoint used by host drivers
> > which provide LTSSM trace functionality. The first user is pcie-dw-rockchip with a 256
> > Bytes FIFO for recording LTSSM transition.
> > 
> 
> Gentle ping...
> 

Merge window is open now, so we can't accept any patches until -rc1. And I'm
also waiting for an Ack from Steven for the tracing part.

- Mani

> > Testing
> > =========
> > 
> > This series was tested on RK3588/RK3588s EVB1 with NVMe SSD connected to PCIe3 and PCIe2
> > root ports.
> > 
> > echo 1 > /sys/kernel/debug/tracing/events/pci_controller/pcie_ltssm_state_transition/enable
> > cat /sys/kernel/debug/tracing/trace_pipe
> > 
> >   # tracer: nop
> >   #
> >   # entries-in-buffer/entries-written: 64/64   #P:8
> >   #
> >   #                                _-----=> irqs-off/BH-disabled
> >   #                               / _----=> need-resched
> >   #                              | / _---=> hardirq/softirq
> >   #                              || / _--=> preempt-depth
> >   #                              ||| / _-=> migrate-disable
> >   #                              |||| /     delay
> >   #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> >   #              | |         |   |||||     |         |
> >        kworker/0:0-9       [000] .....     5.600194: pcie_ltssm_state_transition: dev: a40000000.pcie state: DETECT_ACT rate: Unknown
> >        kworker/0:0-9       [000] .....     5.600198: pcie_ltssm_state_transition: dev: a40000000.pcie state: DETECT_WAIT rate: Unknown
> >        kworker/0:0-9       [000] .....     5.600199: pcie_ltssm_state_transition: dev: a40000000.pcie state: DETECT_ACT rate: Unknown
> >        kworker/0:0-9       [000] .....     5.600201: pcie_ltssm_state_transition: dev: a40000000.pcie state: POLL_ACTIVE rate: Unknown
> >        kworker/0:0-9       [000] .....     5.600202: pcie_ltssm_state_transition: dev: a40000000.pcie state: POLL_CONFIG rate: Unknown
> >        kworker/0:0-9       [000] .....     5.600204: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_LINKWD_START rate: Unknown
> >        kworker/0:0-9       [000] .....     5.600206: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_LINKWD_ACEPT rate: Unknown
> >        kworker/0:0-9       [000] .....     5.600207: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_LANENUM_WAI rate: Unknown
> >        kworker/0:0-9       [000] .....     5.600208: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_LANENUM_ACEPT rate: Unknown
> >        kworker/0:0-9       [000] .....     5.600210: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_COMPLETE rate: Unknown
> >        kworker/0:0-9       [000] .....     5.600212: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_IDLE rate: Unknown
> >        kworker/0:0-9       [000] .....     5.600213: pcie_ltssm_state_transition: dev: a40000000.pcie state: L0 rate: 2.5 GT/s
> >        kworker/0:0-9       [000] .....     5.600214: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: Unknown
> >        kworker/0:0-9       [000] .....     5.600216: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_RCVRCFG rate: Unknown
> >        kworker/0:0-9       [000] .....     5.600217: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_SPEED rate: Unknown
> >        kworker/0:0-9       [000] .....     5.600218: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: Unknown
> >        kworker/0:0-9       [000] .....     5.600220: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_EQ1 rate: Unknown
> >        kworker/0:0-9       [000] .....     5.600221: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_EQ2 rate: 8.0 GT/s
> >        kworker/0:0-9       [000] .....     5.600222: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_EQ3 rate: 8.0 GT/s
> >        kworker/0:0-9       [000] .....     5.600224: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: 8.0 GT/s
> >        kworker/0:0-9       [000] .....     5.600225: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_RCVRCFG rate: 8.0 GT/s
> >        kworker/0:0-9       [000] .....     5.600226: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_IDLE rate: 8.0 GT/s
> >        kworker/0:0-9       [000] .....     5.600227: pcie_ltssm_state_transition: dev: a40000000.pcie state: L0 rate: 8.0 GT/s
> >        kworker/0:0-9       [000] .....     5.600228: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: 8.0 GT/s
> >        kworker/0:0-9       [000] .....     5.600229: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_RCVRCFG rate: 8.0 GT/s
> >        kworker/0:0-9       [000] .....     5.600231: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_IDLE rate: 8.0 GT/s
> >        kworker/0:0-9       [000] .....     5.600232: pcie_ltssm_state_transition: dev: a40000000.pcie state: L0 rate: 8.0 GT/s
> >        kworker/0:0-9       [000] .....     5.600233: pcie_ltssm_state_transition: dev: a40000000.pcie state: L123_SEND_EIDLE rate: 8.0 GT/s
> >        kworker/0:0-9       [000] .....     5.600234: pcie_ltssm_state_transition: dev: a40000000.pcie state: L1_IDLE rate: 8.0 GT/s
> >        kworker/0:0-9       [000] .....     5.600236: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: 8.0 GT/s
> >        kworker/0:0-9       [000] .....     5.600237: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_RCVRCFG rate: 8.0 GT/s
> >        kworker/0:0-9       [000] .....     5.600238: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_IDLE rate: 8.0 GT/s
> >        kworker/0:0-9       [000] .....     5.600239: pcie_ltssm_state_transition: dev: a40000000.pcie state: L0 rate: 8.0 GT/s
> > 
> > 
> > Changes in v4:
> > - use TRACE_EVENT_FN to notify when to start and stop the tracepoint,
> >    and export pci_ltssm_tp_enabled() for host drivers to use
> > - skip trace if pci_ltssm_tp_enabled() is false.(Steven)
> > - wrap into 80 columns(Bjorn)
> > 
> > Changes in v3:
> > - add TRACE_DEFINE_ENUM for all enums(Steven Rostedt)
> > - Add toctree entry in Documentation/trace/index.rst(Bagas Sanjaya)
> > - fix mismatch section underline length(Bagas Sanjaya)
> > - Make example snippets in code block(Bagas Sanjaya)
> > - warp context into 80 columns and fix the file name(Bjorn)
> > - reorder variables(Mani)
> > - rename loop to i; rename en to enable(Mani)
> > - use FIELD_GET(Mani)
> > - add comment about how the FIFO works(Mani)
> > 
> > Changes in v2:
> > - use tracepoint
> > 
> > Shawn Lin (3):
> >    PCI: trace: Add PCI controller LTSSM transition tracepoint
> >    Documentation: tracing: Add PCI controller event documentation
> >    PCI: dw-rockchip: Add pcie_ltssm_state_transition trace support
> > 
> >   Documentation/trace/events-pci-controller.rst |  42 ++++++++++
> >   Documentation/trace/index.rst                 |   1 +
> >   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 111 ++++++++++++++++++++++++++
> >   drivers/pci/trace.c                           |  20 +++++
> >   include/linux/pci.h                           |   4 +
> >   include/trace/events/pci_controller.h         |  57 +++++++++++++
> >   6 files changed, 235 insertions(+)
> >   create mode 100644 Documentation/trace/events-pci-controller.rst
> >   create mode 100644 include/trace/events/pci_controller.h
> > 

-- 
மணிவண்ணன் சதாசிவம்
