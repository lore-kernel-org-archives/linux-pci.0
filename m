Return-Path: <SRS0=9OyC=PS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEC1C43387
	for <linux-pci@archiver.kernel.org>; Thu, 10 Jan 2019 23:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A64208E3
	for <linux-pci@archiver.kernel.org>; Thu, 10 Jan 2019 23:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nq1lh+cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfAJXLt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:11:49 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43221 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfAJXLt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jan 2019 18:11:49 -0500
Received: by mail-oi1-f194.google.com with SMTP id u18so10722595oie.10;
        Thu, 10 Jan 2019 15:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kxp3nAsjyhe1ZXgou3xjj+oYDaWg6XYj9eFlDogGyts=;
        b=Nq1lh+cscYB6VfvbOK+3GwQV1Bpkh94ES6P/EMVIXVdndGXT7MrDBUjwsHFf6F9/eM
         A5sR6xtGBv/fnDJID1/IjYHNgf/5gz51ozuFWx2ZEv/VUYZDRdTQJZK954MPJeTDoMlh
         6Q7vt3IPP4fP6cu6q2vT4CgKBUhxkbo5xNuaQjIsNjxe5MwwLvUxeTzFLYKDFZd/tESc
         Vfqb28LHr3vLdbINmUnrKuOTrXB4bM9HbUxUtqkmSVwoGrCZss5mHDIkQOi/CEZXy4E8
         Vb8aPRYqb+AE12hyCaSDfxalyydekKBt8z6GZ0MYkESYCHNWWa9JuWcfvgJ6rNwZkYMO
         dLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kxp3nAsjyhe1ZXgou3xjj+oYDaWg6XYj9eFlDogGyts=;
        b=IOqjwkg1uTaeIZwP/yZ5XU/xtSvfHooOLNGFwalC/0kE8BsykHuzDe4qntzxXWhy/Q
         GZ/79hKyhJDNgNIS57+tYBpRxCGdS453NZH7dRZ4ASrAY326T2KQ8AmpVFDsbgpkInhj
         0iJS8dMOeX1yUJIAQ2c/lY7GubOQk3jIw/X+iGk1+eubunEq7VfBwjl6G1OmNYxgzSJf
         v8tL0xZ55rApGytcocYB8BGE6Ps7m+YJf8mzpYVwoPJwZtYEHD1nslwARZN5dojN5i8N
         humpHagDJAfvg7tVglNraiPqodN/vxuyucR3lWNvCe5z69QnDj0W1Wyth/FGhjRxx035
         2NOQ==
X-Gm-Message-State: AJcUukeANXZxQ/Kn98fT3a65SRCLLybLn5B9tvQSKpTlg2CYDR9nJHof
        LXU75zHIRRrYoKQAXuEueJmr6wG0ik0=
X-Google-Smtp-Source: ALg8bN6gwaZSFTR3MqkLnZKLgc2axibXNsT1Z+0JzJxEb/XKkxRoTaUBxvIukMkqa9Vuo48tTeNQkA==
X-Received: by 2002:aca:2403:: with SMTP id n3mr7813937oic.328.1547161907350;
        Thu, 10 Jan 2019 15:11:47 -0800 (PST)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id m133sm37152654oib.52.2019.01.10.15.11.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 15:11:46 -0800 (PST)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] PCI / ACPI: Implementing Type 3 _HPX records
Date:   Thu, 10 Jan 2019 17:11:27 -0600
Message-Id: <20190110231136.31163-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

_HPX Type 3 is intended to be more generic and allow configuration of
settings not possible with Type 2 tables. For example, FW could ensure
that the completion timeout value is set accordingly throughout the PCI
tree; some switches require very special handling.

Type 3 can come in an arbitrary number of ACPI packages. With the older
types we only ever had one descriptor. We could get lazy and store it
on the stack. The current flow is to parse the HPX table
--pci_get_hp_params()-- and then program the PCIe device registers.

In the current flow, we'll need to malloc(). Here's what I tried:
 1) devm_kmalloc() on the pci_dev
  This ended up giving me NULL dereference at boot time.
 2) Add a cleanup function to be called after writing the PCIe registers

This RFC implements method 2. The HPX3 stuff is still NDA'd, but the
housekeeping parts are in here. Is this a good way to do things? I'm not
too sure about the need to call cleanup() on a stack variable. But if
not that, then what else?

Alex

---
 drivers/pci/pci-acpi.c      | 88 +++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c         | 29 ++++++++++++
 include/linux/pci_hotplug.h | 17 +++++++
 3 files changed, 134 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e1949f7efd9c..2ce1b68ce688 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -219,6 +219,65 @@ static acpi_status decode_type2_hpx_record(union acpi_object *record,
 	return AE_OK;
 }
 
+static acpi_status parse_hpx3_register(struct hpp_type3 *hpx3,
+				       union acpi_object *reg_fields)
+{
+	struct hpp_type3_register *hpx3_reg;
+
+	hpx3_reg = kzalloc(sizeof(*hpx3_reg), GFP_KERNEL);
+	if (!hpx3_reg)
+		return AE_NO_MEMORY;
+
+	/* Parse fields blurb */
+
+	list_add_tail(&hpx3_reg->list, &hpx3->regs);
+	return AE_OK;
+}
+
+static acpi_status decode_type3_hpx_record(union acpi_object *record,
+					   struct hotplug_params *hpx)
+{
+	union acpi_object *fields = record->package.elements;
+	u32 desc_count, expected_length, revision;
+	union acpi_object *reg_fields;
+	acpi_status ret;
+	int i;
+
+	revision = fields[1].integer.value;
+	switch (revision) {
+	case 1:
+		desc_count = fields[2].integer.value;
+		expected_length = 3 + desc_count * 14;
+
+		if (record->package.count != expected_length)
+			return AE_ERROR;
+
+		for (i = 2; i < expected_length; i++)
+			if (fields[i].type != ACPI_TYPE_INTEGER)
+				return AE_ERROR;
+
+		if (!hpx->t3) {
+			INIT_LIST_HEAD(&hpx->type3_data.regs);
+			hpx->t3 = &hpx->type3_data;
+		}
+
+		for (i = 0; i < desc_count; i++) {
+			reg_fields = fields + 3 + i * 14;
+			ret = parse_hpx3_register(hpx->t3, reg_fields);
+			if (ret != AE_OK)
+				return ret;
+		}
+
+		break;
+	default:
+		printk(KERN_WARNING
+			"%s: Type 3 Revision %d record not supported\n",
+			__func__, revision);
+		return AE_ERROR;
+	}
+	return AE_OK;
+}
+
 static acpi_status acpi_run_hpx(acpi_handle handle, struct hotplug_params *hpx)
 {
 	acpi_status status;
@@ -271,6 +330,11 @@ static acpi_status acpi_run_hpx(acpi_handle handle, struct hotplug_params *hpx)
 			if (ACPI_FAILURE(status))
 				goto exit;
 			break;
+		case 3:
+			status = decode_type3_hpx_record(record, hpx);
+			if (ACPI_FAILURE(status))
+				goto exit;
+			break;
 		default:
 			printk(KERN_ERR "%s: Type %d record not supported\n",
 			       __func__, type);
@@ -368,6 +432,30 @@ int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp)
 }
 EXPORT_SYMBOL_GPL(pci_get_hp_params);
 
+static int cleantup_type3_hpx_record(struct hpp_type3 *hpx3)
+{
+	struct hpp_type3_register *reg;
+	struct list_head *entry, *temp;
+
+	list_for_each_safe(entry, temp, &hpp->t3->regs){
+		reg = list_entry(entry, typeof(*reg), list);
+		list_del(entry);
+		kfree(reg);
+	}
+}
+
+/* pci_cleanup_hp_params
+ *
+ * @hpp - allocated by the caller
+ */
+void pci_cleanup_hp_params(struct hotplug_params *hpp)
+{
+
+	if (hpp->t3)
+		cleanup_type3_hpx_record(hpp->t3);
+}
+EXPORT_SYMBOL_GPL(pci_cleanup_hp_params);
+
 /**
  * pciehp_is_native - Check whether a hotplug port is handled by the OS
  * @bridge: Hotplug port to check
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 257b9f6f2ebb..35ef7d1f4f3b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1979,6 +1979,32 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
 	 */
 }
 
+static void program_hpp_type3_register(struct pci_dev *dev,
+				       const struct hpp_type3_register *reg)
+{
+	/* Complicated ACPI-mandated blurb */
+}
+
+static void program_hpp_type3(struct pci_dev *dev, struct hpp_type3 *hpp)
+{
+	struct hpp_type3_register *reg;
+
+	if (!hpp)
+		return;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	if (hpp->revision > 1) {
+		pci_warn(dev, "PCIe settings rev %d not supported\n",
+			 hpp->revision);
+		return;
+	}
+
+	list_for_each_entry(reg, &hpp->regs, list)
+		program_hpp_type3_register(dev, reg);
+}
+
 int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
 {
 	struct pci_host_bridge *host;
@@ -2145,9 +2171,12 @@ static void pci_configure_device(struct pci_dev *dev)
 	if (ret)
 		return;
 
+	program_hpp_type3(dev, hpp.t3);
 	program_hpp_type2(dev, hpp.t2);
 	program_hpp_type1(dev, hpp.t1);
 	program_hpp_type0(dev, hpp.t0);
+
+	pci_cleanup_hp_params(&hpp);
 }
 
 static void pci_release_capabilities(struct pci_dev *dev)
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index 7acc9f91e72b..479da87a3774 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -124,18 +124,35 @@ struct hpp_type2 {
 	u32 sec_unc_err_mask_or;
 };
 
+/*
+ * PCI Express Setting Record (Type 3)
+ * The ACPI overlords can never get enough
+ */
+struct hpp_type3_register {
+	u32 crap_describing_entry_contents;
+	struct list_head list;
+};
+
+struct hpp_type3 {
+	u32 revision;
+	struct list_head regs;
+};
+
 struct hotplug_params {
 	struct hpp_type0 *t0;		/* Type0: NULL if not available */
 	struct hpp_type1 *t1;		/* Type1: NULL if not available */
 	struct hpp_type2 *t2;		/* Type2: NULL if not available */
+	struct hpp_type3 *t3;		/* Type3: NULL if not available */
 	struct hpp_type0 type0_data;
 	struct hpp_type1 type1_data;
 	struct hpp_type2 type2_data;
+	struct hpp_type3 type3_data;
 };
 
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
 int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp);
+void pci_cleanup_hp_params(struct hotplug_params *hpp);
 bool pciehp_is_native(struct pci_dev *bridge);
 int acpi_get_hp_hw_control_from_firmware(struct pci_dev *bridge);
 bool shpchp_is_native(struct pci_dev *bridge);
-- 
2.19.2

