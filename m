Received: from mail-m15590.qiye.163.com (mail-m15590.qiye.163.com [101.71.155.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0A33C1FD4;
	Thu, 22 Jan 2026 03:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769051903; cv=none; b=Fu0VP8tkI2bzLH88KqGHi21M0mZ6vyQ1idjj7s0G9lLnDOL9EHFrl2AXAgSMoCjWQ2BAD6JR2xGBDeXYSP/3HppW3K9+scb+U+6cZdAvdJTTJJeyrJj7yRVg8QrAgaTQlV6Db4bppVvxVe8qfGmHJGdPlT/oO2znmHV/C3s6GQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769051903; c=relaxed/simple;
	bh=pj5Gf7liDdqIKaP/BfzzjluqZt5UziHOPCEWulZVRZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=M0eJ2CclVIG1ORd9Manz4JDJbLstPF+S6uqDTjZaVL5L/iOsJ6mM9VA6Un9ELEDeXriZMg66Ov5plWiueh+kHViUhXVH7gq++4aVT2R9yBZnwnyUrlLOWe03siCYFxoADwqsmGvZCPisE4n+pgrrNTulOjh2SYikxg/eUZt4jTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=j06J+bG9; arc=none smtp.client-ip=101.71.155.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="j06J+bG9"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3184fafd1;
	Thu, 22 Jan 2026 10:02:32 +0800 (GMT+08:00)
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
Subject: [PATCH v4 2/3] Documentation: tracing: Add PCI controller event documentation
Date: Thu, 22 Jan 2026 10:02:19 +0800
Message-Id: <1769047340-113287-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1769047340-113287-1-git-send-email-shawn.lin@rock-chips.com>
References: <1769047340-113287-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9be37065ba09cckunm8c44f6d054e35
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkwYGVZNHUIYGB0aGBlMH0tWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=j06J+bG9m8u26Dh+mvv9HQIUZWD/watbt7COLqzsjr56ppyCf2KwQYO2Gl/k+QHFVM/1BQBbEOvE+biT0lu0vrdG4zS2VjhjhjJYOuES6tpXXMxh03WHxE4LvO8RgCQIfx1q37SNaGrMIawOU2wAD6dbExrSLlcCoZdv9D4Iz0g=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=1EORHdYl0hQQuji7whDcNAsRcycC/y/m3V41T1wuTxI=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The available tracepoint, pcie_ltssm_state_transition, monitors the LTSSM state
transition for debugging purpose. Add description about it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v4: None
Changes in v3:
- Add toctree entry in Documentation/trace/index.rst(Bagas Sanjaya)
- fix mismatch section underline length(Bagas Sanjaya)
- Make example snippets in code block(Bagas Sanjaya)
- warp context into 80 columns and fix the file name(Bjorn)

Changes in v2: None

 Documentation/trace/events-pci-controller.rst | 42 +++++++++++++++++++++++++++
 Documentation/trace/index.rst                 |  1 +
 2 files changed, 43 insertions(+)
 create mode 100644 Documentation/trace/events-pci-controller.rst

diff --git a/Documentation/trace/events-pci-controller.rst b/Documentation/trace/events-pci-controller.rst
new file mode 100644
index 0000000..cb9f715
--- /dev/null
+++ b/Documentation/trace/events-pci-controller.rst
@@ -0,0 +1,42 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================
+Subsystem Trace Points: PCI Controller
+======================================
+
+Overview
+========
+The PCI controller tracing system provides tracepoints to monitor controller
+level information for debugging purpose. The events normally show up here:
+
+	/sys/kernel/tracing/events/pci_controller
+
+Cf. include/trace/events/pci_controller.h for the events definitions.
+
+Available Tracepoints
+=====================
+
+pcie_ltssm_state_transition
+---------------------------
+
+Monitors PCIe LTSSM state transition including state and rate information
+::
+
+    pcie_ltssm_state_transition  "dev: %s state: %s rate: %s\n"
+
+**Parameters**:
+
+* ``dev`` - PCIe controller instance
+* ``state`` - PCIe LTSSM state
+* ``rate`` - PCIe date rate
+
+**Example Usage**:
+
+.. code-block:: shell
+
+    # Enable the tracepoint
+    echo 1 > /sys/kernel/debug/tracing/events/pci_controller/pcie_ltssm_state_transition/enable
+
+    # Monitor events (the following output is generated when a device is linking)
+    cat /sys/kernel/debug/tracing/trace_pipe
+       kworker/0:0-9       [000] .....     5.600221: pcie_ltssm_state_transition: dev: a40000000.pcie state: RCVRY_EQ2 rate: 8.0 GT/s
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 0a40bfa..6101317 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -55,6 +55,7 @@ applications.
    events-nmi
    events-msr
    events-pci
+   events-pci-controller
    boottime-trace
    histogram
    histogram-design
-- 
2.7.4

