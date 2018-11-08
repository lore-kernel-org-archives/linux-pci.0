Return-Path: <SRS0=XjPq=NT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C12ECDE4C
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 17:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FA320989
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 17:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MF+Ux7k2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FA320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeKICrv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:47:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45317 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeKICrv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Nov 2018 21:47:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so8675536pgc.12
        for <linux-pci@vger.kernel.org>; Thu, 08 Nov 2018 09:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/7QJD6QyN4a7tCGv0UAwEV35V+U7OQLpTdnOlwe/UIk=;
        b=MF+Ux7k2StOreuROdRCMWZIJI9kOkmgExm0GoIPapVQY/fph+Kh8mjLOGEGKFBvYzu
         qC7+HVHvZR8Ai990c/tL22zlIHNPRxh2R0uPBaOMv0fIQlbpuh8IZ1os9od/6MtAriiq
         rEM0b+/4pLKXIPSJv5wPjmz/U39XEIoRAV99U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/7QJD6QyN4a7tCGv0UAwEV35V+U7OQLpTdnOlwe/UIk=;
        b=s/L+5ROp+XP0OAPYUFPmi3gC3Hi9UCPg9tGGJfDh3x3VGkSlDqDIObvjsBh7BIOYgu
         cb3AytP2RmQwFxVvXoiKrZdXPvRDcLfAfRDW8fDUFO2BH8QavibCV9fCFV4l+oVNY902
         LB4uNa1ZeauinoGi+1N3WTIOSO3ysSIzb3E28KdF95Otbi7cPOAicFbqRf97CYyItN3T
         iakiPDfYAMDNTh7+VYbce/HmlD385zXC66Ic2jfJ607WLbIQPWR83YEigUm7qgvp5154
         zNpJpvmpqp5hTTu6Gui+GY3OlO9cBrhiTC9FFfEqwz8OpFBhnHTwcG/7W+QWXmVO99wq
         Rvbg==
X-Gm-Message-State: AGRZ1gJRHoQLnaDlddyF9cDvBFs3HjfFrnAaDHWDlC9BLO37vNaaf+lG
        EPa5a+82lAHVaHF53E0s+O9stg==
X-Google-Smtp-Source: AJdET5e+x/8kNitiv3lRCTXGBPMnZK9QLKHxzYzCswFeEQ+WdxERpnNjuhl045XAP2dRK9qIRWx43w==
X-Received: by 2002:a65:664e:: with SMTP id z14-v6mr4250026pgv.347.1541697083998;
        Thu, 08 Nov 2018 09:11:23 -0800 (PST)
Received: from zsm-linux.mtv.corp.google.com ([2620:15c:202:201:1b7c:8280:c835:b226])
        by smtp.googlemail.com with ESMTPSA id s86-v6sm9586941pfa.137.2018.11.08.09.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 09:11:23 -0800 (PST)
From:   Zubin Mithra <zsm@chromium.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        hch@infradead.org, bhelgaas@google.com
Cc:     groeck@chromium.org, keescook@chromium.org, zsm@chromium.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [RFC] x86/pci: Mark pci_root_ops as const
Date:   Thu,  8 Nov 2018 09:11:15 -0800
Message-Id: <20181108171115.216060-1-zsm@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_root_ops is only written to from within intel_mid_pci_init. This
is linked in only when CONFIG_X86_INTEL_MID is set. If not for this,
pci_root_ops could be marked as const.

Fix this by replacing pci_root_ops usage with pci_root_ops_ptr. If
CONFIG_X86_INTEL_MID is set, pci_root_ops_ptr will be set to
intel_mid_pci_ops inside intel_mid_pci_init.

Introduce pci_acpi_set_ops for intel_mid_pci_init to set
acpi_pci_root_ops.pci_ops.

This also means that intel_mid_pci_ops cannot be freed after init, hence
remove __initconst.

Signed-off-by: Zubin Mithra <zsm@chromium.org>
---
 arch/x86/include/asm/pci_x86.h |  4 +++-
 arch/x86/pci/acpi.c            |  5 +++++
 arch/x86/pci/common.c          |  5 +++--
 arch/x86/pci/intel_mid_pci.c   |  5 +++--
 drivers/pci/access.c           |  4 ++--
 drivers/pci/probe.c            |  4 ++--
 include/linux/pci-acpi.h       |  2 +-
 include/linux/pci.h            | 11 ++++++-----
 8 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 959d618dbb17..1e82ddaeb52f 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -58,7 +58,8 @@ void pcibios_set_cache_line_size(void);
 /* pci-pc.c */
 
 extern int pcibios_last_bus;
-extern struct pci_ops pci_root_ops;
+extern const struct pci_ops pci_root_ops;
+extern const struct pci_ops *pci_root_ops_ptr;
 
 void pcibios_scan_specific_bus(int busn);
 
@@ -122,6 +123,7 @@ extern void __init dmi_check_skip_isa_align(void);
 
 /* some common used subsys_initcalls */
 extern int __init pci_acpi_init(void);
+extern void __init pci_acpi_set_ops(const struct pci_ops *ops);
 extern void __init pcibios_irq_init(void);
 extern int __init pcibios_init(void);
 extern int pci_legacy_init(void);
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 948656069cdd..63ebac5fa212 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -397,6 +397,11 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 	return 0;
 }
 
+void __init pci_acpi_set_ops(const struct pci_ops *ops)
+{
+	acpi_pci_root_ops.pci_ops = ops;
+}
+
 int __init pci_acpi_init(void)
 {
 	struct pci_dev *dev = NULL;
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index d4ec117c1142..747a8e9fd430 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -67,10 +67,11 @@ static int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int siz
 				  devfn, where, size, value);
 }
 
-struct pci_ops pci_root_ops = {
+const struct pci_ops pci_root_ops = {
 	.read = pci_read,
 	.write = pci_write,
 };
+const struct pci_ops *pci_root_ops_ptr = &pci_root_ops;
 
 /*
  * This interrupt-safe spinlock protects all accesses to PCI configuration
@@ -467,7 +468,7 @@ void pcibios_scan_root(int busnum)
 	sd->node = x86_pci_root_bus_node(busnum);
 	x86_pci_root_bus_resources(busnum, &resources);
 	printk(KERN_DEBUG "PCI: Probing PCI hardware (bus %02x)\n", busnum);
-	bus = pci_scan_root_bus(NULL, busnum, &pci_root_ops, sd, &resources);
+	bus = pci_scan_root_bus(NULL, busnum, pci_root_ops_ptr, sd, &resources);
 	if (!bus) {
 		pci_free_resource_list(&resources);
 		kfree(sd);
diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 43867bc85368..b79c469afd57 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -280,7 +280,7 @@ static void intel_mid_pci_irq_disable(struct pci_dev *dev)
 	}
 }
 
-static const struct pci_ops intel_mid_pci_ops __initconst = {
+static const struct pci_ops intel_mid_pci_ops = {
 	.read = pci_read,
 	.write = pci_write,
 };
@@ -297,7 +297,8 @@ int __init intel_mid_pci_init(void)
 	pci_mmcfg_late_init();
 	pcibios_enable_irq = intel_mid_pci_irq_enable;
 	pcibios_disable_irq = intel_mid_pci_irq_disable;
-	pci_root_ops = intel_mid_pci_ops;
+	pci_root_ops_ptr = &intel_mid_pci_ops;
+	pci_acpi_set_ops(&intel_mid_pci_ops);
 	pci_soc_mode = 1;
 	/* Continue with standard init */
 	acpi_noirq_set();
diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 544922f097c0..ca9d3cbc5541 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -180,9 +180,9 @@ EXPORT_SYMBOL_GPL(pci_generic_config_write32);
  *
  * Return previous raw operations
  */
-struct pci_ops *pci_bus_set_ops(struct pci_bus *bus, struct pci_ops *ops)
+const struct pci_ops *pci_bus_set_ops(struct pci_bus *bus, const struct pci_ops *ops)
 {
-	struct pci_ops *old_ops;
+	const struct pci_ops *old_ops;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&pci_lock, flags);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b1c05b5054a0..c66c84ef070a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2915,7 +2915,7 @@ void __weak pcibios_remove_bus(struct pci_bus *bus)
 }
 
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+		const struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
 	int error;
 	struct pci_host_bridge *bridge;
@@ -3079,7 +3079,7 @@ int pci_scan_root_bus_bridge(struct pci_host_bridge *bridge)
 EXPORT_SYMBOL(pci_scan_root_bus_bridge);
 
 struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+		const struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
 	struct resource_entry *window;
 	bool found = false;
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 8082b612f561..e2c80f2edbe8 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -69,7 +69,7 @@ struct acpi_pci_root_info {
 };
 
 struct acpi_pci_root_ops {
-	struct pci_ops *pci_ops;
+	const struct pci_ops *pci_ops;
 	int (*init_info)(struct acpi_pci_root_info *info);
 	void (*release_info)(struct acpi_pci_root_info *info);
 	int (*prepare_resources)(struct acpi_pci_root_info *info);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 11c71c4ecf75..994a4418a3c4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -474,7 +474,7 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
 struct pci_host_bridge {
 	struct device	dev;
 	struct pci_bus	*bus;		/* Root bus */
-	struct pci_ops	*ops;
+	const struct pci_ops	*ops;
 	void		*sysdata;
 	int		busnr;
 	struct list_head windows;	/* resource_entry */
@@ -558,7 +558,7 @@ struct pci_bus {
 	struct list_head resources;	/* Address space routed to this bus */
 	struct resource busn_res;	/* Bus numbers routed to this bus */
 
-	struct pci_ops	*ops;		/* Configuration access functions */
+	const struct pci_ops	*ops;	/* Configuration access functions */
 	struct msi_controller *msi;	/* MSI controller */
 	void		*sysdata;	/* Hook for sys-specific extension */
 	struct proc_dir_entry *procdir;	/* Directory entry in /proc/bus/pci */
@@ -913,14 +913,14 @@ struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(const struct pci_bus *bus);
 struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
-				    struct pci_ops *ops, void *sysdata,
+				    const struct pci_ops *ops, void *sysdata,
 				    struct list_head *resources);
 int pci_host_probe(struct pci_host_bridge *bridge);
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
 void pci_bus_release_busn_res(struct pci_bus *b);
 struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
-				  struct pci_ops *ops, void *sysdata,
+				  const struct pci_ops *ops, void *sysdata,
 				  struct list_head *resources);
 int pci_scan_root_bus_bridge(struct pci_host_bridge *bridge);
 struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
@@ -1010,7 +1010,8 @@ int pci_generic_config_read32(struct pci_bus *bus, unsigned int devfn,
 int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
 			       int where, int size, u32 val);
 
-struct pci_ops *pci_bus_set_ops(struct pci_bus *bus, struct pci_ops *ops);
+const struct pci_ops *pci_bus_set_ops(struct pci_bus *bus,
+				      const struct pci_ops *ops);
 
 int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val);
 int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val);
-- 
2.19.1.930.g4563a0d9d0-goog

