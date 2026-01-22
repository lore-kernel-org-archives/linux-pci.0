Received: from mail-m21471.qiye.163.com (mail-m21471.qiye.163.com [117.135.214.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F40934DCD2;
	Thu, 22 Jan 2026 02:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769047360; cv=none; b=ZFUWU4fiI4D8sEAHUrUE2xF9NGc8jtk/QIvDU8fpuEw2ViLGP1Cce+NUV26f87n2GQF5dLUZxrEjlWGsDNylNZoeqVM+5Pa1BQOSeYMl7ZuveGVYR6xf04ewj4n8jviuOHyOX23cpDEQQffxj+kkIZyB0wTKAqVsZuIaHKQunqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769047360; c=relaxed/simple;
	bh=5o50mefmP4dhIMCSwksaSl4lq2225AzQibjucjl8wxA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=B+yTZehBTPLMM+AaXKFbKLJUW6SiDz3ThAj8o+ccvk+KJ+vde9+JG3ce4zjx97NSMy67nqNDjmfaXLe2bqr4oysMNcchXU26qTw7Poiw3f6uJCnL1yebehqQ8+BK5pq9m2Gvpba8AZxmgRK9WwZjfG3N2/4/8a1XLfDuD6QMTMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=NSFrXCrX; arc=none smtp.client-ip=117.135.214.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="NSFrXCrX"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3184faf9d;
	Thu, 22 Jan 2026 10:02:25 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 0/3] PCI Controller event and LTSSM tracepoint support
Date: Thu, 22 Jan 2026 10:02:17 +0800
Message-Id: <1769047340-113287-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9be370485a09cckunm8c44f6d054dab
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhpMTlZKSxoZTRgfS0tOThhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=NSFrXCrXCtgArb9+LVHb2rDVf9ILnfIE6GyBNpiIR+JVC5sXE5cA9u0PnOioLQN7xERlA24EGAk46418gV2LhZjAfuMEE5vvSZ/qKvp1CO30xVbQbB/FGvrSJ/gza+kSzNL/i0xpw6FaZw7QhxP7+yEZYDiMzP0bzi06Eyp3IKo=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=SeHY+qTtsMx3v6OYem5aenBnxJneVxP8BGfjR5qlbOk=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>


This patch-set adds new pci controller event and LTSSM tracepoint used by host drivers
which provide LTSSM trace functionality. The first user is pcie-dw-rockchip with a 256
Bytes FIFO for recording LTSSM transition.

Testing
=========

This series was tested on RK3588/RK3588s EVB1 with NVMe SSD connected to PCIe3 and PCIe2
root ports.

echo 1 > /sys/kernel/debug/tracing/events/pci_controller/pcie_ltssm_state_transition/enable
cat /sys/kernel/debug/tracing/trace_pipe

 # tracer: nop
 #
 # entries-in-buffer/entries-written: 64/64   #P:8
 #
 #                                _-----=> irqs-off/BH-disabled
 #                               / _----=> need-resched
 #                              | / _---=> hardirq/softirq
 #                              || / _--=> preempt-depth
 #                              ||| / _-=> migrate-disable
 #                              |||| /     delay
 #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
 #              | |         |   |||||     |         |
      kworker/0:0-9       [000] .....     5.600194: pcie_ltssm_state_transition: dev: a40000000.pcie state: DETECT_ACT rate: Unknown
      kworker/0:0-9       [000] .....     5.600198: pcie_ltssm_state_transition: dev: a40000000.pcie state: DETECT_WAIT rate: Unknown
      kworker/0:0-9       [000] .....     5.600199: pcie_ltssm_state_transition: dev: a40000000.pcie state: DETECT_ACT rate: Unknown
      kworker/0:0-9       [000] .....     5.600201: pcie_ltssm_state_transition: dev: a40000000.pcie state: POLL_ACTIVE rate: Unknown
      kworker/0:0-9       [000] .....     5.600202: pcie_ltssm_state_transition: dev: a40000000.pcie state: POLL_CONFIG rate: Unknown
      kworker/0:0-9       [000] .....     5.600204: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_LINKWD_START rate: Unknown
      kworker/0:0-9       [000] .....     5.600206: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_LINKWD_ACEPT rate: Unknown
      kworker/0:0-9       [000] .....     5.600207: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_LANENUM_WAI rate: Unknown
      kworker/0:0-9       [000] .....     5.600208: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_LANENUM_ACEPT rate: Unknown
      kworker/0:0-9       [000] .....     5.600210: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_COMPLETE rate: Unknown
      kworker/0:0-9       [000] .....     5.600212: pcie_ltssm_state_transition: dev: a40000000.pcie state: CFG_IDLE rate: Unknown
      kworker/0:0-9       [000] .....     5.600213: pcie_ltssm_state_transition: dev: a40000000.pcie state: L0 rate: 2.5 GT/s
      kworker/0:0-9       [000] .....     5.600214: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: Unknown
      kworker/0:0-9       [000] .....     5.600216: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_RCVRCFG rate: Unknown
      kworker/0:0-9       [000] .....     5.600217: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_SPEED rate: Unknown
      kworker/0:0-9       [000] .....     5.600218: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: Unknown
      kworker/0:0-9       [000] .....     5.600220: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_EQ1 rate: Unknown
      kworker/0:0-9       [000] .....     5.600221: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_EQ2 rate: 8.0 GT/s
      kworker/0:0-9       [000] .....     5.600222: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_EQ3 rate: 8.0 GT/s
      kworker/0:0-9       [000] .....     5.600224: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: 8.0 GT/s
      kworker/0:0-9       [000] .....     5.600225: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_RCVRCFG rate: 8.0 GT/s
      kworker/0:0-9       [000] .....     5.600226: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_IDLE rate: 8.0 GT/s
      kworker/0:0-9       [000] .....     5.600227: pcie_ltssm_state_transition: dev: a40000000.pcie state: L0 rate: 8.0 GT/s
      kworker/0:0-9       [000] .....     5.600228: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: 8.0 GT/s
      kworker/0:0-9       [000] .....     5.600229: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_RCVRCFG rate: 8.0 GT/s
      kworker/0:0-9       [000] .....     5.600231: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_IDLE rate: 8.0 GT/s
      kworker/0:0-9       [000] .....     5.600232: pcie_ltssm_state_transition: dev: a40000000.pcie state: L0 rate: 8.0 GT/s
      kworker/0:0-9       [000] .....     5.600233: pcie_ltssm_state_transition: dev: a40000000.pcie state: L123_SEND_EIDLE rate: 8.0 GT/s
      kworker/0:0-9       [000] .....     5.600234: pcie_ltssm_state_transition: dev: a40000000.pcie state: L1_IDLE rate: 8.0 GT/s
      kworker/0:0-9       [000] .....     5.600236: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_LOCK rate: 8.0 GT/s
      kworker/0:0-9       [000] .....     5.600237: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_RCVRCFG rate: 8.0 GT/s
      kworker/0:0-9       [000] .....     5.600238: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_IDLE rate: 8.0 GT/s
      kworker/0:0-9       [000] .....     5.600239: pcie_ltssm_state_transition: dev: a40000000.pcie state: L0 rate: 8.0 GT/s


Changes in v4:
- use TRACE_EVENT_FN to notify when to start and stop the tracepoint,
  and export pci_ltssm_tp_enabled() for host drivers to use
- skip trace if pci_ltssm_tp_enabled() is false.(Steven)
- wrap into 80 columns(Bjorn)

Changes in v3:
- add TRACE_DEFINE_ENUM for all enums(Steven Rostedt)
- Add toctree entry in Documentation/trace/index.rst(Bagas Sanjaya)
- fix mismatch section underline length(Bagas Sanjaya)
- Make example snippets in code block(Bagas Sanjaya)
- warp context into 80 columns and fix the file name(Bjorn)
- reorder variables(Mani)
- rename loop to i; rename en to enable(Mani)
- use FIELD_GET(Mani)
- add comment about how the FIFO works(Mani)

Changes in v2:
- use tracepoint

Shawn Lin (3):
  PCI: trace: Add PCI controller LTSSM transition tracepoint
  Documentation: tracing: Add PCI controller event documentation
  PCI: dw-rockchip: Add pcie_ltssm_state_transition trace support

 Documentation/trace/events-pci-controller.rst |  42 ++++++++++
 Documentation/trace/index.rst                 |   1 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 111 ++++++++++++++++++++++++++
 drivers/pci/trace.c                           |  20 +++++
 include/linux/pci.h                           |   4 +
 include/trace/events/pci_controller.h         |  57 +++++++++++++
 6 files changed, 235 insertions(+)
 create mode 100644 Documentation/trace/events-pci-controller.rst
 create mode 100644 include/trace/events/pci_controller.h

-- 
2.7.4

