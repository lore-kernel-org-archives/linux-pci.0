Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38453382374;
	Thu, 21 May 2026 03:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779334723; cv=none; b=fFjn55YDa3wziEKpi0eT3YKXTWCNxr4cBtILrCMlWpHkMJobmF5v1aNBQpiKLWMw+XOaUegSdvP+WxaaWe+F44kGyTtELR/g2bCQfvH+s7/dQ27AzV8y+EuYAjKh4U+hEf/m7sk8WOiOPnOI38vbM22XSG3ht7CX+ibZNjdrNTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779334723; c=relaxed/simple;
	bh=2/6sEwIrPju1EdAdRMY8mrY5aPqXwzvY1nJmWaSvUbs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FItEOUG97bg3YzysQ2am0FdKVzkMyTkrgjR1mK1lTSpSes5MQjzLE9oz97eBROCj3usJvv1ZmrbjHK8oLYiIJOtJNegwv05e/s32pyo6zuhwc0/PVEfvRca3j5lGeg+qU8FbhKSUZcQne8mrREaOFDInGaSgstjG+UM5R7E2iCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=uybjizmL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="uybjizmL"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64L3cVe75932799, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1779334712;
	bh=Y/fxuK6jZP6LXobLmMopm5khI5ztCQCzwaRZHfFZIDI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=uybjizmLdX0zUxydGtEiOQwQDDTU88cOPcUZVWYJ73GbFT6CkgXjlkN+9whnkdsGY
	 k+CN2nnnjtEiuAIz83z7kHA0Gd1Xq7soGscvm8C1MO437GnlvNzXSnmxOAqs0D/NK0
	 gRFv5COoG09/T1KCh6meX8ZXVGem7KX+keoZ5jeIML7+ekmRRKmXOuYxLdFf4xsPfH
	 o8qp7XyiGpb5mNgTpQ2xL91d+K9qtJWRg8D0Ephl/R7WbtvfVu/3zNY6S9iOcowVii
	 kcbLQPh7k8zcgl+xElgi8Txh3Z1SYZXxPssrSIdK+z9hhMKj3rV4mizChY48J4zVzV
	 L6bYz7VKZYDUg==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64L3cVe75932799
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 May 2026 11:38:32 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 May 2026 11:38:32 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 21 May 2026 11:38:32 +0800
From: javen <javen_xu@realsil.com.cn>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [RFC Patch] pci: add power management for rtl8116af
Date: Thu, 21 May 2026 11:38:27 +0800
Message-ID: <20260521033827.502-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

RTL8116af is a multi function card. But due to the hardware design, only
function 0 and function 1(nic) are exposed to pci system. If the system
want to enter s0idle or cpu need to enter c10 when suspend, function 2
to 7 must be set to d3 and enable aspm. Function 5 and 6 are reserved,
so we skip them.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Hi,
Just as the comments above, function 2 to 7 are hidden to pci system. So
we have to set d3 and aspm through our private register, which is CSI. I
have a discussion with netdev maintainer, and he thought this might be a
question to pci system.
I wonder whether this patch can be accepted here. Any feedback would be
highly appreciated!

Thanks,
BRs,
Javen
---
 drivers/pci/quirks.c | 119 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index caaed1a01dc0..e6538edcdff4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -35,6 +35,7 @@
 #include <linux/sizes.h>
 #include <linux/suspend.h>
 #include <linux/switchtec.h>
+#include <linux/iopoll.h>
 #include "pci.h"
 
 static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta)
@@ -6381,3 +6382,121 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
 #endif
+
+#define RTL_TX_CONFIG			0x40
+#define RTL_CSIDR			0x64
+#define RTL_CSIAR			0x68
+#define RTL_ERIDR			0x70
+#define RTL_ERIAR			0x74
+#define RTL_OCPDR			0xb0
+
+#define CSIAR_FLAG			0x80000000
+#define CSIAR_WRITE_CMD			0x80000000
+#define CSIAR_BYTE_ENABLE		0x0000f000
+#define CSIAR_ADDR_MASK			0x00000fff
+
+#define ERIAR_READ_CMD			0x80000000
+#define ERIAR_MASK_1111			0x0f000000
+#define ERIAR_EXGMAC			0
+#define ERIAR_FLAG			0x80000000
+
+static u32 quirk_rtl_csi_read(void __iomem *base, u8 multi_fun_sel_bit, int addr)
+{
+	u32 cmd = (addr & CSIAR_ADDR_MASK) | (multi_fun_sel_bit << 16) | CSIAR_BYTE_ENABLE;
+	u32 val;
+
+	writel(cmd, base + RTL_CSIAR);
+	if (readl_poll_timeout(base + RTL_CSIAR, val, val & CSIAR_FLAG, 10, 1000))
+		return ~0;
+	return readl(base + RTL_CSIDR);
+}
+
+static void quirk_rtl_csi_write(void __iomem *base, u8 multi_fun_sel_bit, int addr, int value)
+{
+	u32 cmd = CSIAR_WRITE_CMD | (addr & CSIAR_ADDR_MASK) |
+		  CSIAR_BYTE_ENABLE | (multi_fun_sel_bit << 16);
+	u32 val;
+
+	writel(value, base + RTL_CSIDR);
+	writel(cmd, base + RTL_CSIAR);
+	readl_poll_timeout(base + RTL_CSIAR, val, !(val & CSIAR_FLAG), 10, 1000);
+}
+
+static u16 quirk_r8168_mac_ocp_read(void __iomem *base, u32 reg)
+{
+	writel(reg << 15, base + RTL_OCPDR);
+	return (u16)readl(base + RTL_OCPDR);
+}
+
+static void quirk_rtl8168_clear_and_set_csi(void __iomem *base, u8 multi_fun_sel_bit,
+					    u32 addr, u32 clearmask, u32 setmask)
+{
+	u32 val = quirk_rtl_csi_read(base, multi_fun_sel_bit, addr);
+
+	if (val != ~0) {
+		val &= ~clearmask;
+		val |= setmask;
+		quirk_rtl_csi_write(base, multi_fun_sel_bit, addr, val);
+	}
+}
+
+static void quirk_rtl8168_other_fun_pci_setting(void __iomem *base, u32 addr,
+						u32 clearmask, u32 setmask)
+{
+	for (int i = 2; i < 8; i++) {
+		if (i == 5 || i == 6)
+			continue;
+		quirk_rtl8168_clear_and_set_csi(base, i, addr, clearmask, setmask);
+	}
+}
+
+static void quirk_rtl8168_set_aspm_clkreq(struct pci_dev *pdev)
+{
+	void __iomem *base;
+	u16 pci_command;
+	int mmio_bar;
+	u32 txconfig, xid;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+	if (!(pci_command & PCI_COMMAND_MEMORY))
+		return;
+
+	mmio_bar = pci_select_bars(pdev, IORESOURCE_MEM);
+	if (!mmio_bar)
+		return;
+
+	mmio_bar = ffs(mmio_bar) - 1;
+	base = pci_iomap(pdev, mmio_bar, 0);
+	if (!base)
+		return;
+
+	txconfig = readl(base + RTL_TX_CONFIG);
+	if (txconfig == ~0U) {
+		pci_iounmap(pdev, base);
+		return;
+	}
+
+	xid = (txconfig >> 20) & 0xfcf;
+	if ((xid & 0x7cf) != 0x54b && (xid & 0x7cf) != 0x54a) {
+		pci_iounmap(pdev, base);
+		return;
+	}
+
+	if ((quirk_r8168_mac_ocp_read(base, 0xdc00) & 0x0078) != 0x0030 ||
+	    (quirk_r8168_mac_ocp_read(base, 0xd006) & 0x00ff) != 0x0000) {
+		pci_iounmap(pdev, base);
+		return;
+	}
+
+	quirk_rtl8168_other_fun_pci_setting(base, 0x80,
+					    BIT(0) | BIT(1) | BIT(8),
+					    BIT(0) | BIT(1) | BIT(8));
+
+	quirk_rtl8168_other_fun_pci_setting(base, 0x44,
+					    0,
+					    BIT(0) | BIT(1));
+
+	pci_iounmap(pdev, base);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, 0x8168, quirk_rtl8168_set_aspm_clkreq);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_REALTEK, 0x8168, quirk_rtl8168_set_aspm_clkreq);
-- 
2.43.0

