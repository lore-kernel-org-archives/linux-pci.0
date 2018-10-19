Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12394ECDE3D
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 11:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73522145D
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 11:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Aj3E+xfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73522145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeJSTTg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 15:19:36 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:44080 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeJSTTf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Oct 2018 15:19:35 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id A29B15C0058;
        Fri, 19 Oct 2018 13:13:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1539947635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=9ilOd1/Kb0rsVQFv+/y4d07M5qEsZLZaakfPIEGYRAc=;
        b=Aj3E+xfpGaciNiDUQhN890/dXnT5N8afSks1im0rOwA+ofN4hE06P3UAJh+xkLXTnkREfA
        u39WLxXYcaYcOL4WSXYKgvqWnFXy1g6uSnI6Zr18KUyR2dUL50un77Cw4I4u18DAagQn9b
        baF1hfYCMh3jqjgdEz42qJn1KH1JcWQ=
From:   Stefan Agner <stefan@agner.ch>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        l.stach@pengutronix.de
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] PCI: dwc: Limit config space size for i.MX6
Date:   Fri, 19 Oct 2018 13:13:50 +0200
Message-Id: <20181019111350.6170-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reading the full 4k config space through sysfs leads to an
external abort. Testing on a platform showed that the upper
limit is 512. Limit config space to 512.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
I observed this on a Apalis iMX6 which uses the i.MX 6Quad without any
PCIe device connected. It is especially annoying since it breaks by
simply reading a file as root in sysfs (e.g. grepping through sysfs)...

I am not very familiar with PCIe, so there might be better/more generic
ways to fix this?

# cat /sys/devices/soc0/soc/1ffc000.pcie/pci0000\:00/0000\:00\:00.0/config
[  100.015997] pci_read_config, size 4096
[  100.021433] Unhandled fault: imprecise external abort (0x1406) at 0xb6ea7000
[  100.028985] pgd = 1a90ef4f
[  100.031780] [b6ea7000] *pgd=4a039831
[  100.035475] Internal error: : 1406 [#1] SMP ARM
[  100.040094] Modules linked in:
[  100.043230] CPU: 1 PID: 605 Comm: cat Not tainted 4.19.0-rc8+ #366
[  100.049626] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  100.056423] PC is at dw_pcie_read+0x50/0x84
[  100.060790] LR is at dw_pcie_rd_own_conf+0x44/0x48
[  100.065779] pc : [<c05bd600>]    lr : [<c05be248>]    psr: 60080093
[  100.072274] sp : c3f77d40  ip : c3f77d50  fp : c3f77d4c
[  100.077693] r10: 00000000  r9 : 00000004  r8 : c1708908
[  100.083122] r7 : c3f77dc8  r6 : 00000200  r5 : 00000004  r4 : 00000000
[  100.089895] r3 : 00000000  r2 : c3f77dc8  r1 : 00000000  r0 : f09b4200
[  100.096657] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  100.104152] Control: 10c5387d  Table: 13fb404a  DAC: 00000051
[  100.110114] Process cat (pid: 605, stack limit = 0xcd2180c8)
[  100.115994] Stack: (0xc3f77d40 to 0xc3f78000)
[  100.120533] 7d40: c3f77d6c c3f77d50 c05be248 c05bd5bc eceede28 ecef7800 00000000 00000200
[  100.129025] 7d60: c3f77dbc c3f77d70 c05be2c4 c05be210 c05956dc 00000200 c3f77e08 c1708908
[  100.137504] 7d80: c17665c4 c05956dc c3f77dbc 00000000 c0d27974 c05be24c c1708908 00000200
[  100.145980] 7da0: c3f77e08 c1708908 ec276000 ec276200 c3f77dec c3f77dc0 c059570c c05be258
[  100.160586] 7dc0: c3f77dc8 00000000 ffffffff e5e423ab ec5c1800 ec277000 00001000 13d8a000
[  100.175434] 7de0: c3f77e3c c3f77df0 c05a4a5c c05956a8 c019b890 000003ff 00000001 00000000
[  100.190328] 7e00: 00000000 00000000 00000000 e5e423ab ffffe000 c05a4944 00000000 00000000
[  100.205490] 7e20: 00000000 00000000 00000000 c38f5790 c3f77e6c c3f77e40 c038022c c05a4950
[  100.220890] 7e40: 00000000 00000000 00001000 c3f77e58 c38f5780 00001000 c3f77f58 b6ea8000
[  100.236386] 7e60: c3f77eac c3f77e70 c037fae0 c03801d8 00000000 00000000 c3f77e9c ec276000
[  100.252114] 7e80: c0194a18 c1708908 c037fa28 c3fb83c0 c3f77f58 00000000 b6ea8000 00020000
[  100.268039] 7ea0: c3f77f24 c3f77eb0 c02efcc4 c037fa34 00000022 00000000 00000000 00000000
[  100.284170] 7ec0: 00000800 00000000 b6ea7000 c170eec8 00000817 c1708908 c0119574 b6ea7000
[  100.300390] 7ee0: c3f77fb0 00000000 c3f77fac c3f77ef8 c0119ac8 c0119580 c3f77f5c e5e423ab
[  100.316721] 7f00: 00020000 c3fb83c0 b6ea8000 c3f77f58 00000000 b6ea8000 c3f77f54 c3f77f28
[  100.333196] 7f20: c02efe74 c02efc94 c010e5c4 c010cc7c c3fb83c0 c3fb83c0 00000000 00000000
[  100.349704] 7f40: c1708908 b6ea8000 c3f77f94 c3f77f58 c02f0388 c02efdf4 00000000 00000000
[  100.366197] 7f60: c16eedd8 e5e423ab c1708d64 0000006c 7ff00000 00000000 00000003 c01011e4
[  100.382693] 7f80: c3f76000 00000003 c3f77fa4 c3f77f98 c02f03fc c02f0344 00000000 c3f77fa8
[  100.399206] 7fa0: c0101000 c02f03f8 0000006c 7ff00000 00000003 b6ea8000 00020000 00000000
[  100.415718] 7fc0: 0000006c 7ff00000 00000000 00000003 00000003 00000000 00020000 00000000
[  100.432222] 7fe0: 00000003 bef56ab8 b6f53d57 b6ee06c6 80080030 00000003 00000000 00000000
[  100.448703] Backtrace:
[  100.455228] [<c05bd5b0>] (dw_pcie_read) from [<c05be248>] (dw_pcie_rd_own_conf+0x44/0x48)
[  100.471541] [<c05be204>] (dw_pcie_rd_own_conf) from [<c05be2c4>] (dw_pcie_rd_conf+0x78/0x1c8)
[  100.488164]  r7:00000200 r6:00000000 r5:ecef7800 r4:eceede28
[  100.497930] [<c05be24c>] (dw_pcie_rd_conf) from [<c059570c>] (pci_user_read_config_dword+0x70/0xec)
[  100.515006]  r10:ec276200 r9:ec276000 r8:c1708908 r7:c3f77e08 r6:00000200 r5:c1708908
[  100.530829]  r4:c05be24c
[  100.537271] [<c059569c>] (pci_user_read_config_dword) from [<c05a4a5c>] (pci_read_config+0x118/0x2cc)
[  100.554299]  r7:13d8a000 r6:00001000 r5:ec277000 r4:ec5c1800
[  100.563911] [<c05a4944>] (pci_read_config) from [<c038022c>] (sysfs_kf_bin_read+0x60/0xac)
[  100.579880]  r10:c38f5790 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:00000000
[  100.595383]  r4:c05a4944
[  100.601650] [<c03801cc>] (sysfs_kf_bin_read) from [<c037fae0>] (kernfs_fop_read+0xb8/0x200)
[  100.617481]  r7:b6ea8000 r6:c3f77f58 r5:00001000 r4:c38f5780
[  100.626926] [<c037fa28>] (kernfs_fop_read) from [<c02efcc4>] (__vfs_read+0x3c/0x160)
[  100.642031]  r10:00020000 r9:b6ea8000 r8:00000000 r7:c3f77f58 r6:c3fb83c0 r5:c037fa28
[  100.657201]  r4:c1708908
[  100.663320] [<c02efc88>] (__vfs_read) from [<c02efe74>] (vfs_read+0x8c/0x114)
[  100.674165]  r9:b6ea8000 r8:00000000 r7:c3f77f58 r6:b6ea8000 r5:c3fb83c0 r4:00020000
[  100.689131] [<c02efde8>] (vfs_read) from [<c02f0388>] (ksys_read+0x50/0xb4)
[  100.699876]  r9:b6ea8000 r8:c1708908 r7:00000000 r6:00000000 r5:c3fb83c0 r4:c3fb83c0
[  100.714919] [<c02f0338>] (ksys_read) from [<c02f03fc>] (sys_read+0x10/0x14)
[  100.725650]  r10:00000003 r9:c3f76000 r8:c01011e4 r7:00000003 r6:00000000 r5:7ff00000
[  100.740784]  r4:0000006c
[  100.746897] [<c02f03ec>] (sys_read) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
[  100.761495] Exception stack(0xc3f77fa8 to 0xc3f77ff0)
[  100.770224] 7fa0:                   0000006c 7ff00000 00000003 b6ea8000 00020000 00000000
[  100.785624] 7fc0: 0000006c 7ff00000 00000000 00000003 00000003 00000000 00020000 00000000
[  100.801074] 7fe0: 00000003 bef56ab8 b6f53d57 b6ee06c6
[  100.809800] Code: e5821000 e89da800 e5901000 ee073f9a (e5821000)
[  100.819571] ---[ end trace 1be350dbae42cdaf ]---

--
Stefan

 drivers/pci/quirks.c    | 10 ++++++++++
 include/linux/pci_ids.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6bc27b7fd452..24d8d1d614e5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -471,6 +471,16 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NETRONOME,	PCI_DEVICE_ID_NETRONOME_NFP600
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NETRONOME,	PCI_DEVICE_ID_NETRONOME_NFP5000,	quirk_nfp6000);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NETRONOME,	PCI_DEVICE_ID_NETRONOME_NFP6000_VF,	quirk_nfp6000);
 
+/*
+ * This PCIe controller causes external abort if config addresses above 0x200
+ * are read.
+ */
+static void quirk_dw_imx6(struct pci_dev *dev)
+{
+	dev->cfg_size = 0x200;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS,	PCI_DEVICE_ID_SYNOPSYS_IMX6,	quirk_dw_imx6);
+
 /*  On IBM Crocodile ipr SAS adapters, expand BAR to system page size */
 static void quirk_extend_bar_to_page(struct pci_dev *dev)
 {
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d157983b84cf..cfd43468f983 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2354,6 +2354,7 @@
 #define PCI_DEVICE_ID_CENATEK_IDE	0x0001
 
 #define PCI_VENDOR_ID_SYNOPSYS		0x16c3
+#define PCI_DEVICE_ID_SYNOPSYS_IMX6	0xabcd
 
 #define PCI_VENDOR_ID_VITESSE		0x1725
 #define PCI_DEVICE_ID_VITESSE_VSC7174	0x7174
-- 
2.19.1

