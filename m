Received: from mail-m1973184.qiye.163.com (mail-m1973184.qiye.163.com [220.197.31.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2172239E7E;
	Thu, 22 Jan 2026 02:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769048282; cv=none; b=ozYLLmW8IZgR+y9IPgX2XHmZLwKNosFVqPoE9xxsUk/xx2/o2vi+rTZSEZQXlryKwBM7eJ5s51eyelzSWgY5OrnerlA/SQxIGSUnq/6k2khOD2ip0NB7GVCoNadznXkvvU6U2tVmrrd1EiY0XiMoHgMX/owlI1YZvPURqlj+a2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769048282; c=relaxed/simple;
	bh=K7mpVEvFDPhR66u7epruXZEivBOPe+6yIoLoGwZ7A74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SpASmvhiLrL2Fo+gfXfe/FmCPsZqtcy4SZ/vr2UW2hVZJlxChjVQGOQ4EVCrR1DW+fFTS4qDEAN4mRE0T6NtB2t1zv24CwrEkX5HTpCGqRYKRMWBGPCAmTzhUox2Gga7t8QvEokPRGMB8XvGuiLml4AmS6wj528EXNxxE70GDLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=UzUMLcCe; arc=none smtp.client-ip=220.197.31.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="UzUMLcCe"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3184fafb4;
	Thu, 22 Jan 2026 10:02:28 +0800 (GMT+08:00)
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
Subject: [PATCH v4 1/3] PCI: trace: Add PCI controller LTSSM transition tracepoint
Date: Thu, 22 Jan 2026 10:02:18 +0800
Message-Id: <1769047340-113287-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1769047340-113287-1-git-send-email-shawn.lin@rock-chips.com>
References: <1769047340-113287-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9be37055f909cckunm8c44f6d054de9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh1MSFZLH0lCGBgdS0xPGE5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=UzUMLcCeXEQg8M2k3MAlIFoHRJ9IEqTguTIe2KKZmdQxghFCgvcpFm1dsh1tAXl35eMLgFTvKB+67wdbrum2mFKr7Ht/ohwkph1yaieZgvm0hN2uvsDTEPfpxorQWf8bz03fiq7ONwxBiUkcY9xfJaQTLpJAR4aa0tZVcKY/qJI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=kuecErM6mmX6yMkKPN9khMNwgG4xY73sZYSq61VEdC4=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Some platforms may provide LTSSM trace functionality, recording historical
LTSSM state transition information. This is very useful for debugging, such
as when certain devices cannot be recognized or link broken during test.
Implement the pci controller tracepoint for recording LTSSM and rate.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v4:
- use TRACE_EVENT_FN to notify when to start and stop the tracepoint,
  and export pci_ltssm_tp_enabled() for host drivers to use

Changes in v3:
- add TRACE_DEFINE_ENUM for all enums(Steven Rostedt)

Changes in v2: None

 drivers/pci/trace.c                   | 20 ++++++++++++
 include/linux/pci.h                   |  4 +++
 include/trace/events/pci_controller.h | 57 +++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 include/trace/events/pci_controller.h

diff --git a/drivers/pci/trace.c b/drivers/pci/trace.c
index cf11abc..d351a51 100644
--- a/drivers/pci/trace.c
+++ b/drivers/pci/trace.c
@@ -9,3 +9,23 @@
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/pci.h>
+#include <trace/events/pci_controller.h>
+
+static atomic_t pcie_ltssm_tp_enabled = ATOMIC_INIT(0);
+
+bool pci_ltssm_tp_enabled(void)
+{
+	return atomic_read(&pcie_ltssm_tp_enabled) > 0;
+}
+EXPORT_SYMBOL(pci_ltssm_tp_enabled);
+
+int pci_ltssm_tp_reg(void)
+{
+	atomic_inc(&pcie_ltssm_tp_enabled);
+	return 0;
+}
+
+void pci_ltssm_tp_unreg(void)
+{
+	atomic_dec(&pcie_ltssm_tp_enabled);
+}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e7cb527..ac25a3e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2770,6 +2770,10 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
 }
 #endif
 
+#ifdef CONFIG_TRACING
+bool pci_ltssm_tp_enabled(void);
+#endif
+
 void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned nr_devfns);
 bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2);
 int pci_for_each_dma_alias(struct pci_dev *pdev,
diff --git a/include/trace/events/pci_controller.h b/include/trace/events/pci_controller.h
new file mode 100644
index 0000000..db4a960
--- /dev/null
+++ b/include/trace/events/pci_controller.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM pci_controller
+
+#if !defined(_TRACE_HW_EVENT_PCI_CONTROLLER_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_HW_EVENT_PCI_CONTROLLER_H
+
+#include <uapi/linux/pci_regs.h>
+#include <linux/tracepoint.h>
+
+TRACE_DEFINE_ENUM(PCIE_SPEED_2_5GT);
+TRACE_DEFINE_ENUM(PCIE_SPEED_5_0GT);
+TRACE_DEFINE_ENUM(PCIE_SPEED_8_0GT);
+TRACE_DEFINE_ENUM(PCIE_SPEED_16_0GT);
+TRACE_DEFINE_ENUM(PCIE_SPEED_32_0GT);
+TRACE_DEFINE_ENUM(PCIE_SPEED_64_0GT);
+TRACE_DEFINE_ENUM(PCI_SPEED_UNKNOWN);
+
+extern int pci_ltssm_tp_reg(void);
+extern void pci_ltssm_tp_unreg(void);
+
+TRACE_EVENT_FN(pcie_ltssm_state_transition,
+	TP_PROTO(const char *dev_name, const char *state, u32 rate),
+	TP_ARGS(dev_name, state, rate),
+
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name)
+		__string(state, state)
+		__field(u32, rate)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name);
+		__assign_str(state);
+		__entry->rate = rate;
+	),
+
+	TP_printk("dev: %s state: %s rate: %s",
+		__get_str(dev_name), __get_str(state),
+		__print_symbolic(__entry->rate,
+			{ PCIE_SPEED_2_5GT,  "2.5 GT/s" },
+			{ PCIE_SPEED_5_0GT,  "5.0 GT/s" },
+			{ PCIE_SPEED_8_0GT,  "8.0 GT/s" },
+			{ PCIE_SPEED_16_0GT, "16.0 GT/s" },
+			{ PCIE_SPEED_32_0GT, "32.0 GT/s" },
+			{ PCIE_SPEED_64_0GT, "64.0 GT/s" },
+			{ PCI_SPEED_UNKNOWN, "Unknown" }
+		)
+	),
+
+	pci_ltssm_tp_reg, pci_ltssm_tp_unreg
+);
+
+#endif /* _TRACE_HW_EVENT_PCI_CONTROLLER_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.7.4

