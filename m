Received: from mail-m49248.qiye.163.com (mail-m49248.qiye.163.com [45.254.49.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39BF279DC3;
	Wed, 25 Mar 2026 01:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774403933; cv=none; b=WZh/oP8QXYbumUeXpbrds+oI9CCKYLxt5yEOxsOTUk1Mh5KjTM++xUAa+rn5w+zFJK2BIBXtZS1jX/9N+78zUpioL6gXQzE4g2Eqe0+1O1d5RY+UL2oPVR9+I6v5x3UnqVdX8mVgsmPD/aDa5gD5eAXkUW+GD+o2tnSC2ec2NZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774403933; c=relaxed/simple;
	bh=QalUjP7AkMbAsghFE2vnYPKXnA1KvR2kiGM3lY0+zu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=iIbRohg/71JnCoNRJnjPdiMK++4NCoMp9kQxhUsGukDiCZqhw2PJve3x8pfBJzpYpB3+JOc7nfTxXqtkFePb984qFiehkec/98wM+6ToTvGsbIFoK/cr3m6cU/KAjv6/EnXahNa6Rkmd+/PHIXz6X/WnWSiz4cdIBDLDFiOe6jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=h7RxCBke; arc=none smtp.client-ip=45.254.49.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="h7RxCBke"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 382e59d5b;
	Wed, 25 Mar 2026 09:58:41 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 1/3] PCI: trace: Add PCI controller LTSSM transition tracepoint
Date: Wed, 25 Mar 2026 09:58:30 +0800
Message-Id: <1774403912-210670-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1774403912-210670-1-git-send-email-shawn.lin@rock-chips.com>
References: <1774403912-210670-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9d22b7256909cckunm61c156f0a5586c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh4eS1ZOTEtLSkNDTR5OSEpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
	pVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=h7RxCBkeNdV3RdS1lL07SH+zn9re32xt2UAL9i4tKl7hfxKg5oUcvxmx8t2UQDmVajPAA+NirUI6MCkqOkCa3nC+Rk4Ps9m8F9/uHdW3sO0o7/xCuBgBaC1yJDNXptRVndtg2ZWutSEVeppWEiAlUg5IVsmzxoPU8UcAgNIxRSc=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=QSGJAYrwVyaJSE6SdOF9MFVaSP3OU7Hp4gce1A1jKiI=;
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

Changes in v5:
- use EM/EMe instead
- remove reg/unreg function and back to use TRACE_EVENT

Changes in v4:
- use TRACE_EVENT_FN to notify when to start and stop the tracepoint,
  and export pci_ltssm_tp_enabled() for host drivers to use

Changes in v3:
- add TRACE_DEFINE_ENUM for all enums(Steven Rostedt)

Changes in v2: None

 drivers/pci/trace.c                   |  1 +
 include/trace/events/pci_controller.h | 58 +++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 include/trace/events/pci_controller.h

diff --git a/drivers/pci/trace.c b/drivers/pci/trace.c
index cf11abc..c1da9d3 100644
--- a/drivers/pci/trace.c
+++ b/drivers/pci/trace.c
@@ -9,3 +9,4 @@
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/pci.h>
+#include <trace/events/pci_controller.h>
diff --git a/include/trace/events/pci_controller.h b/include/trace/events/pci_controller.h
new file mode 100644
index 0000000..a4b387c
--- /dev/null
+++ b/include/trace/events/pci_controller.h
@@ -0,0 +1,58 @@
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
+#define RATE					\
+	EM(PCIE_SPEED_2_5GT,  "2.5 GT/s")	\
+	EM(PCIE_SPEED_5_0GT,  "5.0 GT/s")	\
+	EM(PCIE_SPEED_8_0GT,  "8.0 GT/s")	\
+	EM(PCIE_SPEED_16_0GT, "16.0 GT/s")	\
+	EM(PCIE_SPEED_32_0GT, "32.0 GT/s")	\
+	EM(PCIE_SPEED_64_0GT, "64.0 GT/s")	\
+	EMe(PCI_SPEED_UNKNOWN, "Unknown")
+
+
+#undef EM
+#undef EMe
+#define EM(a, b)	TRACE_DEFINE_ENUM(a);
+#define EMe(a, b)	TRACE_DEFINE_ENUM(a);
+
+RATE
+
+#undef EM
+#undef EMe
+#define EM(a, b)	{a, b},
+#define EMe(a, b)	{a, b}
+
+TRACE_EVENT(pcie_ltssm_state_transition,
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
+		__print_symbolic(__entry->rate, RATE)
+	)
+);
+
+#endif /* _TRACE_HW_EVENT_PCI_CONTROLLER_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.7.4

