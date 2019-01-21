Return-Path: <SRS0=cv1o=P5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFA8C31681
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 17:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84022089F
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 17:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKW0lOV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfAURmn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:42:43 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39542 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfAURmn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jan 2019 12:42:43 -0500
Received: by mail-oi1-f193.google.com with SMTP id i6so15186375oia.6;
        Mon, 21 Jan 2019 09:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vWt9yDzRnpznXrayd/ZIPSRXb5hm/11PQ6c/FyrfH98=;
        b=FKW0lOV0Do6WswE8vjCDt346BCPpgb3OBeSnHaP6gY6mLLKjnWfhiRRF/7Zp/JpgEP
         RMXHZzwK7tU2YAk+h8h9FTUUdDQgvISICE2iJ0WwZgJUi6iQOi2i1eMnQsAlX0hxlvst
         NdU8YObcKK7K7fxOyJ265tuKZL9BiJNw9OK3MzqbK/VLa/ZJlCv9VvZrVJ6lx6FDQto2
         mn+hcVprghxh/SoAR2jataiMbgfAIAI6Kf4y8joPo+3OQw2PalYPrYMXd3h68XVkPQAa
         ZZts30PKLd4aD/DsnCW8ZzuJJfe2reAijbpo0DOqA70pYGWFaKZ9L26zgiw60uHSa1b6
         b+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vWt9yDzRnpznXrayd/ZIPSRXb5hm/11PQ6c/FyrfH98=;
        b=Iz59Fc0SXcF4VzQGfpKpWWiWiCTKsk8vBr7z/G8pI22MQg6P1FWHVx7FH/e7clK+m5
         KEl2+QfsHijRFQtuJWLpznAx7gasdsmgubT86sr9eZsZaEPWwpWR1ZDXL+83BFfyMxkp
         rbG7/VCf0tx1vm8kYARD0b3fbq5AqUTSu6eizazn870Sl7XaAP39ESQperl8uTtUAUis
         Huegern9jMlgetZac3pcFDboPXtRGg8Df06ALC+EIAoqF7ZJiNhaxQdm0uDfbsQ8ocdW
         MOLHXZNAihTtZgcuY+GCOx62l+Os8+NzVdJ5k1hxijrlRiOpfSmk3AuPjLNA6GMT8ffy
         w+eg==
X-Gm-Message-State: AJcUukf7rgKkm+yis68FAjc9itUtEx47Ts5SG7rGxKtafDLHCgrNRmi1
        lLRbWZ5MSBsUPmri75Qn+sI=
X-Google-Smtp-Source: ALg8bN49fkhabll4P0ZBf5LjSIZDTq6Z0d6alU4u9ngw0DS/pnmeIcMyjFgmime1CRdjWfva6SQ95g==
X-Received: by 2002:aca:4506:: with SMTP id s6mr5934777oia.115.1548092560475;
        Mon, 21 Jan 2019 09:42:40 -0800 (PST)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id h25sm6111277otj.27.2019.01.21.09.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 09:42:39 -0800 (PST)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v2] PCI / ACPI: Implementing Type 3 _HPX records
Date:   Mon, 21 Jan 2019 11:42:23 -0600
Message-Id: <20190121174225.15835-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190114200120.GA33971@google.com>
References: <20190114200120.GA33971@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

_HPX Type 3 is intended to be more generic and allow configuration of
settings not possible with Type 2 tables. For example, FW could ensure
that the completion timeout value is set accordingly throughout the PCI
tree.

Type 3 can come in an arbitrary number of ACPI packages. With the older
types we only ever had one descriptor. We could get lazy and store it
on the stack. The current flow is to parse the HPX table
--pci_get_hp_params()-- and then program the PCIe device registers.

In the current flow, we'll need to malloc(). Here's what I tried:
 1) devm_kmalloc() on the pci_dev
  This ended up giving me NULL dereference at boot time.
 2) Add a cleanup function to be called after writing the PCIe registers
  More complicated than it's worth
 3) Intertwine parsing and programming registers

This RFC implements method 3. The HPX3 stuff is still NDA'd, but the
housekeeping parts are in here. This is 3 changes squashed into one.
I've chosen to _ops approach to avoid moving the programming code to
pci-acpi.c. If it is deemed that it's better to move it, I have
nothing against it.
---
 drivers/pci/pci-acpi.c      | 164 +++++++++++++++++++++++++-----------
 drivers/pci/probe.c         |  34 +++++---
 include/linux/pci_hotplug.h |  23 +++--
 3 files changed, 152 insertions(+), 69 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e1949f7efd9c..034676c71916 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -119,7 +119,7 @@ phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
 }
 
 static acpi_status decode_type0_hpx_record(union acpi_object *record,
-					   struct hotplug_params *hpx)
+					   struct hpp_type0 *hpx0)
 {
 	int i;
 	union acpi_object *fields = record->package.elements;
@@ -132,12 +132,11 @@ static acpi_status decode_type0_hpx_record(union acpi_object *record,
 		for (i = 2; i < 6; i++)
 			if (fields[i].type != ACPI_TYPE_INTEGER)
 				return AE_ERROR;
-		hpx->t0 = &hpx->type0_data;
-		hpx->t0->revision        = revision;
-		hpx->t0->cache_line_size = fields[2].integer.value;
-		hpx->t0->latency_timer   = fields[3].integer.value;
-		hpx->t0->enable_serr     = fields[4].integer.value;
-		hpx->t0->enable_perr     = fields[5].integer.value;
+		hpx0->revision        = revision;
+		hpx0->cache_line_size = fields[2].integer.value;
+		hpx0->latency_timer   = fields[3].integer.value;
+		hpx0->enable_serr     = fields[4].integer.value;
+		hpx0->enable_perr     = fields[5].integer.value;
 		break;
 	default:
 		printk(KERN_WARNING
@@ -149,7 +148,7 @@ static acpi_status decode_type0_hpx_record(union acpi_object *record,
 }
 
 static acpi_status decode_type1_hpx_record(union acpi_object *record,
-					   struct hotplug_params *hpx)
+					   struct hpp_type1 *hpx1)
 {
 	int i;
 	union acpi_object *fields = record->package.elements;
@@ -162,11 +161,10 @@ static acpi_status decode_type1_hpx_record(union acpi_object *record,
 		for (i = 2; i < 5; i++)
 			if (fields[i].type != ACPI_TYPE_INTEGER)
 				return AE_ERROR;
-		hpx->t1 = &hpx->type1_data;
-		hpx->t1->revision      = revision;
-		hpx->t1->max_mem_read  = fields[2].integer.value;
-		hpx->t1->avg_max_split = fields[3].integer.value;
-		hpx->t1->tot_max_split = fields[4].integer.value;
+		hpx1->revision      = revision;
+		hpx1->max_mem_read  = fields[2].integer.value;
+		hpx1->avg_max_split = fields[3].integer.value;
+		hpx1->tot_max_split = fields[4].integer.value;
 		break;
 	default:
 		printk(KERN_WARNING
@@ -178,7 +176,7 @@ static acpi_status decode_type1_hpx_record(union acpi_object *record,
 }
 
 static acpi_status decode_type2_hpx_record(union acpi_object *record,
-					   struct hotplug_params *hpx)
+					   struct hpp_type2 *hpx2)
 {
 	int i;
 	union acpi_object *fields = record->package.elements;
@@ -191,24 +189,23 @@ static acpi_status decode_type2_hpx_record(union acpi_object *record,
 		for (i = 2; i < 18; i++)
 			if (fields[i].type != ACPI_TYPE_INTEGER)
 				return AE_ERROR;
-		hpx->t2 = &hpx->type2_data;
-		hpx->t2->revision      = revision;
-		hpx->t2->unc_err_mask_and      = fields[2].integer.value;
-		hpx->t2->unc_err_mask_or       = fields[3].integer.value;
-		hpx->t2->unc_err_sever_and     = fields[4].integer.value;
-		hpx->t2->unc_err_sever_or      = fields[5].integer.value;
-		hpx->t2->cor_err_mask_and      = fields[6].integer.value;
-		hpx->t2->cor_err_mask_or       = fields[7].integer.value;
-		hpx->t2->adv_err_cap_and       = fields[8].integer.value;
-		hpx->t2->adv_err_cap_or        = fields[9].integer.value;
-		hpx->t2->pci_exp_devctl_and    = fields[10].integer.value;
-		hpx->t2->pci_exp_devctl_or     = fields[11].integer.value;
-		hpx->t2->pci_exp_lnkctl_and    = fields[12].integer.value;
-		hpx->t2->pci_exp_lnkctl_or     = fields[13].integer.value;
-		hpx->t2->sec_unc_err_sever_and = fields[14].integer.value;
-		hpx->t2->sec_unc_err_sever_or  = fields[15].integer.value;
-		hpx->t2->sec_unc_err_mask_and  = fields[16].integer.value;
-		hpx->t2->sec_unc_err_mask_or   = fields[17].integer.value;
+		hpx2->revision      = revision;
+		hpx2->unc_err_mask_and      = fields[2].integer.value;
+		hpx2->unc_err_mask_or       = fields[3].integer.value;
+		hpx2->unc_err_sever_and     = fields[4].integer.value;
+		hpx2->unc_err_sever_or      = fields[5].integer.value;
+		hpx2->cor_err_mask_and      = fields[6].integer.value;
+		hpx2->cor_err_mask_or       = fields[7].integer.value;
+		hpx2->adv_err_cap_and       = fields[8].integer.value;
+		hpx2->adv_err_cap_or        = fields[9].integer.value;
+		hpx2->pci_exp_devctl_and    = fields[10].integer.value;
+		hpx2->pci_exp_devctl_or     = fields[11].integer.value;
+		hpx2->pci_exp_lnkctl_and    = fields[12].integer.value;
+		hpx2->pci_exp_lnkctl_or     = fields[13].integer.value;
+		hpx2->sec_unc_err_sever_and = fields[14].integer.value;
+		hpx2->sec_unc_err_sever_or  = fields[15].integer.value;
+		hpx2->sec_unc_err_mask_and  = fields[16].integer.value;
+		hpx2->sec_unc_err_mask_or   = fields[17].integer.value;
 		break;
 	default:
 		printk(KERN_WARNING
@@ -219,17 +216,68 @@ static acpi_status decode_type2_hpx_record(union acpi_object *record,
 	return AE_OK;
 }
 
-static acpi_status acpi_run_hpx(acpi_handle handle, struct hotplug_params *hpx)
+static acpi_status parse_hpx3_register(struct hpp_type3 *hpx3,
+				       union acpi_object *reg_fields)
+{
+	/* Parse fields blurb */
+
+	return AE_OK;
+}
+
+static acpi_status program_type3_hpx_record(struct pci_dev *dev,
+					   union acpi_object *record,
+					   const struct hotplug_program_ops *hp_ops)
+{
+	union acpi_object *fields = record->package.elements;
+	u32 desc_count, expected_length, revision;
+	union acpi_object *reg_fields;
+	struct hpp_type3 hpx3;
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
+		for (i = 0; i < desc_count; i++) {
+			reg_fields = fields + 3 + i * 14;
+			ret = parse_hpx3_register(&hpx3, reg_fields);
+			if (ret != AE_OK)
+				return ret;
+			hp_ops->program_type3(dev, &hpx3);
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
+static acpi_status acpi_run_hpx(struct pci_dev *dev, acpi_handle handle,
+				const struct hotplug_program_ops *hp_ops)
 {
 	acpi_status status;
 	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
 	union acpi_object *package, *record, *fields;
+	struct hpp_type0 hpx0;
+	struct hpp_type1 hpx1;
+	struct hpp_type2 hpx2;
 	u32 type;
 	int i;
 
-	/* Clear the return buffer with zeros */
-	memset(hpx, 0, sizeof(struct hotplug_params));
-
 	status = acpi_evaluate_object(handle, "_HPX", NULL, &buffer);
 	if (ACPI_FAILURE(status))
 		return status;
@@ -257,17 +305,28 @@ static acpi_status acpi_run_hpx(acpi_handle handle, struct hotplug_params *hpx)
 		type = fields[0].integer.value;
 		switch (type) {
 		case 0:
-			status = decode_type0_hpx_record(record, hpx);
+			memset(&hpx0, 0, sizeof(hpx0));
+			status = decode_type0_hpx_record(record, &hpx0);
 			if (ACPI_FAILURE(status))
 				goto exit;
+			hp_ops->program_type0(dev, &hpx0);
 			break;
 		case 1:
-			status = decode_type1_hpx_record(record, hpx);
+			memset(&hpx1, 0, sizeof(hpx1));
+			status = decode_type1_hpx_record(record, &hpx1);
 			if (ACPI_FAILURE(status))
 				goto exit;
+			hp_ops->program_type1(dev, &hpx1);
 			break;
 		case 2:
-			status = decode_type2_hpx_record(record, hpx);
+			memset(&hpx2, 0, sizeof(hpx2));
+			status = decode_type2_hpx_record(record, &hpx2);
+			if (ACPI_FAILURE(status))
+				goto exit;
+			hp_ops->program_type2(dev, &hpx2);
+			break;
+		case 3:
+			status = program_type3_hpx_record(dev, record, hp_ops);
 			if (ACPI_FAILURE(status))
 				goto exit;
 			break;
@@ -283,14 +342,16 @@ static acpi_status acpi_run_hpx(acpi_handle handle, struct hotplug_params *hpx)
 	return status;
 }
 
-static acpi_status acpi_run_hpp(acpi_handle handle, struct hotplug_params *hpp)
+static acpi_status acpi_run_hpp(struct pci_dev *dev, acpi_handle handle,
+				const struct hotplug_program_ops *hp_ops)
 {
 	acpi_status status;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *package, *fields;
+	struct hpp_type0 hpp0;
 	int i;
 
-	memset(hpp, 0, sizeof(struct hotplug_params));
+	memset(&hpp0, 0, sizeof(hpp0));
 
 	status = acpi_evaluate_object(handle, "_HPP", NULL, &buffer);
 	if (ACPI_FAILURE(status))
@@ -311,12 +372,13 @@ static acpi_status acpi_run_hpp(acpi_handle handle, struct hotplug_params *hpp)
 		}
 	}
 
-	hpp->t0 = &hpp->type0_data;
-	hpp->t0->revision        = 1;
-	hpp->t0->cache_line_size = fields[0].integer.value;
-	hpp->t0->latency_timer   = fields[1].integer.value;
-	hpp->t0->enable_serr     = fields[2].integer.value;
-	hpp->t0->enable_perr     = fields[3].integer.value;
+	hpp0.revision        = 1;
+	hpp0.cache_line_size = fields[0].integer.value;
+	hpp0.latency_timer   = fields[1].integer.value;
+	hpp0.enable_serr     = fields[2].integer.value;
+	hpp0.enable_perr     = fields[3].integer.value;
+
+	hp_ops->program_type0(dev, &hpp0);
 
 exit:
 	kfree(buffer.pointer);
@@ -328,7 +390,8 @@ static acpi_status acpi_run_hpp(acpi_handle handle, struct hotplug_params *hpp)
  * @dev - the pci_dev for which we want parameters
  * @hpp - allocated by the caller
  */
-int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp)
+int pci_acpi_program_hp_params(struct pci_dev *dev,
+			       const struct hotplug_program_ops *hp_ops)
 {
 	acpi_status status;
 	acpi_handle handle, phandle;
@@ -351,10 +414,10 @@ int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp)
 	 * this pci dev.
 	 */
 	while (handle) {
-		status = acpi_run_hpx(handle, hpp);
+		status = acpi_run_hpx(dev, handle, hp_ops);
 		if (ACPI_SUCCESS(status))
 			return 0;
-		status = acpi_run_hpp(handle, hpp);
+		status = acpi_run_hpp(dev, handle, hp_ops);
 		if (ACPI_SUCCESS(status))
 			return 0;
 		if (acpi_is_root_bridge(handle))
@@ -366,7 +429,6 @@ int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp)
 	}
 	return -ENODEV;
 }
-EXPORT_SYMBOL_GPL(pci_get_hp_params);
 
 /**
  * pciehp_is_native - Check whether a hotplug port is handled by the OS
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 257b9f6f2ebb..de4394421f70 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1979,6 +1979,23 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
 	 */
 }
 
+static void program_hpp_type3_register(struct pci_dev *dev,
+				       const struct hpp_type3 *hpx3)
+{
+	/* Complicated ACPI-mandated blurb */
+}
+
+static void program_hpp_type3(struct pci_dev *dev, struct hpp_type3 *hpx3)
+{
+	if (!hpx3)
+		return;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	program_hpp_type3_register(dev, hpx3);
+}
+
 int pci_configure_extended_tags(struct pci_dev *dev, void *ign)
 {
 	struct pci_host_bridge *host;
@@ -2131,8 +2148,12 @@ static void pci_configure_eetlp_prefix(struct pci_dev *dev)
 
 static void pci_configure_device(struct pci_dev *dev)
 {
-	struct hotplug_params hpp;
-	int ret;
+	static const struct hotplug_program_ops hp_ops = {
+		.program_type0 = program_hpp_type0,
+		.program_type1 = program_hpp_type1,
+		.program_type2 = program_hpp_type2,
+		.program_type3 = program_hpp_type3,
+	};
 
 	pci_configure_mps(dev);
 	pci_configure_extended_tags(dev, NULL);
@@ -2140,14 +2161,7 @@ static void pci_configure_device(struct pci_dev *dev)
 	pci_configure_ltr(dev);
 	pci_configure_eetlp_prefix(dev);
 
-	memset(&hpp, 0, sizeof(hpp));
-	ret = pci_get_hp_params(dev, &hpp);
-	if (ret)
-		return;
-
-	program_hpp_type2(dev, hpp.t2);
-	program_hpp_type1(dev, hpp.t1);
-	program_hpp_type0(dev, hpp.t0);
+	pci_acpi_program_hp_params(dev, &hp_ops);
 }
 
 static void pci_release_capabilities(struct pci_dev *dev)
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index 7acc9f91e72b..9487abddaa69 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -124,18 +124,25 @@ struct hpp_type2 {
 	u32 sec_unc_err_mask_or;
 };
 
-struct hotplug_params {
-	struct hpp_type0 *t0;		/* Type0: NULL if not available */
-	struct hpp_type1 *t1;		/* Type1: NULL if not available */
-	struct hpp_type2 *t2;		/* Type2: NULL if not available */
-	struct hpp_type0 type0_data;
-	struct hpp_type1 type1_data;
-	struct hpp_type2 type2_data;
+/*
+ * PCI Express Setting Record (Type 3)
+ * The ACPI overlords can never get enough
+ */
+struct hpp_type3 {
+	u32 crap_describing_entry_contents;
+};
+
+struct hotplug_program_ops {
+	void (*program_type0)(struct pci_dev *dev, struct hpp_type0 *hpp);
+	void (*program_type1)(struct pci_dev *dev, struct hpp_type1 *hpp);
+	void (*program_type2)(struct pci_dev *dev, struct hpp_type2 *hpp);
+	void (*program_type3)(struct pci_dev *dev, struct hpp_type3 *hpp);
 };
 
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
-int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp);
+int pci_acpi_program_hp_params(struct pci_dev *dev,
+			       const struct hotplug_program_ops *hp_ops);
 bool pciehp_is_native(struct pci_dev *bridge);
 int acpi_get_hp_hw_control_from_firmware(struct pci_dev *bridge);
 bool shpchp_is_native(struct pci_dev *bridge);
-- 
2.19.2

