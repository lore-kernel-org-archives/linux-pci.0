Received: from mail-m1973183.qiye.163.com (mail-m1973183.qiye.163.com [220.197.31.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A56A279DC3;
	Wed, 25 Mar 2026 01:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774403936; cv=none; b=reMKvj5z597uhx/Sk6NXfFDwTxoISKy9CCjNT9TyquuBnumm1ogktxbw5yy1zwm1sB06Q2IuJx0sIIRDfI5pE1dyMptv+ETATr8fy7Vwu0qyVamflGd4ttoWPoBkcuGdU+WJVX3LLM2Jr+N1fIwlj61pLfgeYLvAbWM4UR7pDow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774403936; c=relaxed/simple;
	bh=NAOObBjWYkTwBB2oaO+yEQHCURdt5DpiaopucuaD/eo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JRa6m1DycjmQQMxZFcnvAIqMC02AnL6ySh40by4SnZHYESTW1Z5Qi3xoAksCCgPue60dtkCuQHdI5UR5GleFigbQiTwiMnx/cioeAuKMjXR3vZ2RAweTV9CzBPHEku4GIMQ+X+XzduyRpz3ZLA/p+E9hiem6YZcCRI1b2cCPppw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=T25oK540; arc=none smtp.client-ip=220.197.31.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="T25oK540"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 382e78d81;
	Wed, 25 Mar 2026 09:58:43 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 2/3] Documentation: tracing: Add PCI controller event documentation
Date: Wed, 25 Mar 2026 09:58:31 +0800
Message-Id: <1774403912-210670-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1774403912-210670-1-git-send-email-shawn.lin@rock-chips.com>
References: <1774403912-210670-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9d22b72f9a09cckunm61c156f0a55897
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU5LGlYZTkIeHU4aThkfSUxWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=T25oK54011WllIvrtGUBvYeaP2ibH5Eum1pnPUYo8ntQlhBjIeHDZ3YzhuKtttuvYpPJJJyEZ9ISdLzoVI97zwD1F5esX+AaX8gA5X0Tuxgu8Wf4zhn3CLRC+ePN/JX9gfXPRuEWgm9bhQkfhr1WevV1jgB3P/qJkBgukU9nAF0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=GDNTzFg7mWA3WGCmaG5bEv/LuzxprcU2vL1BmwDw0fg=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The available tracepoint, pcie_ltssm_state_transition, monitors the LTSSM
state transition for debugging purpose. Add description about it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v5: None
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
index 036db96..5d9bf469 100644
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

