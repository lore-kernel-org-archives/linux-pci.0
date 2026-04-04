Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6001A682A;
	Sat,  4 Apr 2026 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775321624; cv=none; b=DDDROPISPnTpjbrTR3i1WhWtih/B3Itl4ztMMI3Qx4S556HT3hPGXGVM8CbzMK9HLLXYBJP9AJMmnSrAUnRyj4fqA1ErOYva8WFkkfRaq9PFwO1Q6Jsp7rTA/UojOSerXuWnU60t4exs1n0tbU6DR7lQ1+KVidhz7YDA/Uyww8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775321624; c=relaxed/simple;
	bh=4ljFbXNE5GaVpD1qooXO+bZe5p57hd2HpLdsSi36i98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaASr+fRuK5zDWNgOXg1FaBpe9s01VoMLW3vmG/SwzR+NJ9VuXmSOdyizaOvhbzXjJH6AhS08Vrd2u7MG8wxP3x23kelFI//uvqLgOm8r8gr8ulncVtpeuguqziWFr1An8bIzq4//LdQsTU6SwA8bratSqo0mIs9IeFqz+IAo+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoLLbiIx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoLLbiIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAFCC19421;
	Sat,  4 Apr 2026 16:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775321624;
	bh=4ljFbXNE5GaVpD1qooXO+bZe5p57hd2HpLdsSi36i98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uoLLbiIxFbBGZ/vxLYnikvtUkFkVKpK+0+eS4Voj+KIm5HA/M3qyTg3zJr+w+/gsa
	 mdc7NOsJGiGu5M6W/VfPOHq0EHo0WoThpRYCQ5/2oVF2oh3tgiYy8Tg3LNrLh+L4Mu
	 uHBZ++P6y2er+rTRp3yfoTo7bKJHU4Url3YYN9yjLOY++ThUbe297jAGjbSy+FF9RI
	 IKhX2S4k3adTLbqFyVmgH7E+VllDg6fIf6g6zOQIRH/R8AKRKsl0clumvpP8LIeyzU
	 U5+YLC/LgJludkLgapI6ZyBO6VqWZkDdVHDcGxwtZeLV1WVdrbru/6P1V06EVBmn75
	 hjx/TgvCHesdQ==
Date: Sat, 4 Apr 2026 22:23:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 0/3] PCI Controller event and LTSSM tracepoint support
Message-ID: <u2dh2os5qyuuv636uwzttvohfyics7tvqiobheftjzdnuegq33@n77svn2nlqu2>
References: <1774403912-210670-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1774403912-210670-1-git-send-email-shawn.lin@rock-chips.com>

On Wed, Mar 25, 2026 at 09:58:29AM +0800, Shawn Lin wrote:
> 
> This patch-set adds new pci controller event and LTSSM tracepoint used by host drivers
> which provide LTSSM trace functionality. The first user is pcie-dw-rockchip with a 256
> Bytes FIFO for recording LTSSM transition.
> 

Steve, could you please take a look at the tracing part?

- Mani

> Testing
> =========
> 
> This series was tested on RK3588/RK3588s EVB1 with NVMe SSD connected to PCIe3 and PCIe2
> root ports.
> 
> echo 1 > /sys/kernel/debug/tracing/events/pci_controller/pcie_ltssm_state_transition/enable
> cat /sys/kernel/debug/tracing/trace_pipe
> 
>  # tracer: nop
>  #
>  # entries-in-buffer/entries-written: 64/64   #P:8
>  #
>  #                                _-----=> irqs-off/BH-disabled
>  #                               / _----=> need-resched
>  #                              | / _---=> hardirq/softirq
>  #                              || / _--=> preempt-depth
>  #                              ||| / _-=> migrate-disable
>  #                              |||| /     delay
>  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>  #              | |         |   |||||     |         |
>       kworker/0:0-9       [000] .....     5.600194: pcie_ltssm_state_transition: dev: a40000000.pcie state: DETECT_ACT rate: Unknown
>       kworker/0:0-9       [000] .....     5.600198: pcie_ltssm_state_transition: dev: a40000000.pcie state: DETECT_WAIT rate: Unknown
>       kworker/0:0-9       [000] .....     5.600199: pcie_ltssm_state_transition: dev: a40000000.pcie state: DETECT_ACT rate: Unknown
>       kworker/0:0-9       [000] .....     5.600201: pcie_ltssm_state_transition: dev: a40000000.pcie state: POLL_ACTIVE rate: Unknown
>       kworker/0:0-9       [000] .....     5.600202: pcie_ltssm_state_transition: dev: a40000000.pcie state: POLL_CONFIG rate: Unknown
>       kworker/0:0-9       [000] .....     5.600204: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_LINKWD_START rate: Unknown
>       kworker/0:0-9       [000] .....     5.600206: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_LINKWD_ACEPT rate: Unknown
>       kworker/0:0-9       [000] .....     5.600207: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_LANENUM_WAI rate: Unknown
>       kworker/0:0-9       [000] .....     5.600208: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_LANENUM_ACEPT rate: Unknown
>       kworker/0:0-9       [000] .....     5.600210: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_COMPLETE rate: Unknown
>       kworker/0:0-9       [000] .....     5.600212: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_IDLE rate: Unknown
>       kworker/0:0-9       [000] .....     5.600213: pcie_ltssm_state_transition: dev: a40000000.pcie state: L0 rate: 2.5 GT/s
>       kworker/0:0-9       [000] .....     5.600214: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: Unknown
>       kworker/0:0-9       [000] .....     5.600216: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_RCVRCFG rate: Unknown
>       kworker/0:0-9       [000] .....     5.600217: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_SPEED rate: Unknown
>       kworker/0:0-9       [000] .....     5.600218: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: Unknown
>       kworker/0:0-9       [000] .....     5.600220: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_EQ1 rate: Unknown
>       kworker/0:0-9       [000] .....     5.600221: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_EQ2 rate: 8.0 GT/s
>       kworker/0:0-9       [000] .....     5.600222: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_EQ3 rate: 8.0 GT/s
>       kworker/0:0-9       [000] .....     5.600224: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: 8.0 GT/s
>       kworker/0:0-9       [000] .....     5.600225: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_RCVRCFG rate: 8.0 GT/s
>       kworker/0:0-9       [000] .....     5.600226: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_IDLE rate: 8.0 GT/s
>       kworker/0:0-9       [000] .....     5.600227: pcie_ltssm_state_transition: dev: a40000000.pcie state: L0 rate: 8.0 GT/s
>       kworker/0:0-9       [000] .....     5.600228: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: 8.0 GT/s
>       kworker/0:0-9       [000] .....     5.600229: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_RCVRCFG rate: 8.0 GT/s
>       kworker/0:0-9       [000] .....     5.600231: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_IDLE rate: 8.0 GT/s
>       kworker/0:0-9       [000] .....     5.600232: pcie_ltssm_state_transition: dev: a40000000.pcie state: L0 rate: 8.0 GT/s
>       kworker/0:0-9       [000] .....     5.600233: pcie_ltssm_state_transition: dev: a40000000.pcie state: L123_SEND_EIDLE rate: 8.0 GT/s
>       kworker/0:0-9       [000] .....     5.600234: pcie_ltssm_state_transition: dev: a40000000.pcie state: L1_IDLE rate: 8.0 GT/s
>       kworker/0:0-9       [000] .....     5.600236: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: 8.0 GT/s
>       kworker/0:0-9       [000] .....     5.600237: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_RCVRCFG rate: 8.0 GT/s
>       kworker/0:0-9       [000] .....     5.600238: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_IDLE rate: 8.0 GT/s
>       kworker/0:0-9       [000] .....     5.600239: pcie_ltssm_state_transition: dev: a40000000.pcie state: L0 rate: 8.0 GT/s
> 
> 
> Changes in v5:
> - rebase
> - use EM/EMe instead
> - remove reg/unreg function and back to use TRACE_EVENT
> - use trace_pcie_ltssm_state_transition_enabled()
> 
> Changes in v4:
> - use TRACE_EVENT_FN to notify when to start and stop the tracepoint,
>   and export pci_ltssm_tp_enabled() for host drivers to use
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
>   PCI: trace: Add PCI controller LTSSM transition tracepoint
>   Documentation: tracing: Add PCI controller event documentation
>   PCI: dw-rockchip: Add pcie_ltssm_state_transition trace support
> 
>  Documentation/trace/events-pci-controller.rst |  42 ++++++++++
>  Documentation/trace/index.rst                 |   1 +
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 111 ++++++++++++++++++++++++++
>  drivers/pci/trace.c                           |   1 +
>  include/trace/events/pci_controller.h         |  58 ++++++++++++++
>  5 files changed, 213 insertions(+)
>  create mode 100644 Documentation/trace/events-pci-controller.rst
>  create mode 100644 include/trace/events/pci_controller.h
> 
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
