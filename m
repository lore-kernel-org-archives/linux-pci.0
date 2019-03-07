Return-Path: <SRS0=a/OH=RK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF39C10F03
	for <linux-pci@archiver.kernel.org>; Thu,  7 Mar 2019 21:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1421F20684
	for <linux-pci@archiver.kernel.org>; Thu,  7 Mar 2019 21:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeuFTN5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfCGVi5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:38:57 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45002 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfCGViz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Mar 2019 16:38:55 -0500
Received: by mail-ot1-f66.google.com with SMTP id g1so15526675otj.11;
        Thu, 07 Mar 2019 13:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/5DeYC4CA85Y6dPuWkR/Hrkgj1mEyphOasJagul6/eI=;
        b=eeuFTN5LB92UeDap2eHX22GNeVx8WFnkP08qVP9D+lx/LXEEByfOkjHHf2n+MezYc5
         1zT7AFibRLACvGl/7Tz+Z3KPO7c1NnuC5kAzBl5XmxSKLOA6x1N9PQSqRQOy65huomlg
         /vldnuDL0EWzHuVMSw4SCMFqzJLuvwtZF98+PyfHN6W+aI5xHmumyfTitcOEjcAvFi63
         +fFiirYtbx87etM7hjpBrtz+vJ5/e0LgXGnrqeXlLSb1QR716kQ+OT2L1Y/TFwHOeBUp
         srS2FkLDSb+cqMg5XW2x/S7fcSy7Ulily0+g8upKjqn64NCc5fjBOLwnLuiATi0cy5JV
         ij6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/5DeYC4CA85Y6dPuWkR/Hrkgj1mEyphOasJagul6/eI=;
        b=j3mLsNVMpJGzE/m3Ht3Gct5Gb1t0Qgn96P1871CFFXrQtD3xjJcC/7Q4/9eJusDMK9
         BY8LEIHpiP1j91jd++2leL0JtJUycJYu8Ic/2BZOFCErU7nU6HqTJQ+CKfd6AH65wxXj
         yBOJCvzqO7bkWpylG5yRIeifo47CICO6EnAEsEJBhCj9lKnnvO1zxv4BlPo+eoHb+p6E
         RSBIHmrb0Gfwcb2th8I8pcwLLPSiQAti67k7/FxzUP7NbRbV72iulRkI3TArp59AdW8h
         5w9rRPZ9GCTVohUT5sTDhL/VKm55XGx/yCh4IZLv5/YN0BAKXbCHb01ETli3XsU/+j44
         95Fg==
X-Gm-Message-State: APjAAAX1SbaOdKrTZapxQB+diHEMSkUb/7DjIlHSnd0j4NrjUTO5lnE7
        gWAd+AQ8p/TTMQ4W9QC7UyM=
X-Google-Smtp-Source: APXvYqzOqNCOzTwUu5Emit1IR4ODOuBjKofv7bpbf2X1HKxzoslfKXGhLBfvTfHB+s1A86fW+6gOXA==
X-Received: by 2002:a9d:6acc:: with SMTP id m12mr9066187otq.243.1551994733689;
        Thu, 07 Mar 2019 13:38:53 -0800 (PST)
Received: from nuclearis2-1.lan ([2601:2c1:8501:182d::cdd])
        by smtp.gmail.com with ESMTPSA id p188sm2352205oia.58.2019.03.07.13.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 13:38:53 -0800 (PST)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v1 2/3] PCI / ACPI: Remove the need for 'struct hotplug_params'
Date:   Thu,  7 Mar 2019 15:38:26 -0600
Message-Id: <20190307213834.5914-3-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190307213834.5914-1-mr.nuke.me@gmail.com>
References: <20190307213834.5914-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We used to first parse all the _HPP and _HPX tables before using the
information to program registers of PCIe devices. Up until HPX type 2,
there was only one structure of each type, so we could cheat and store
it on the stack.

With HPX type 3 we get an arbitrary number of entries, so the above
model doesn't scale that well. Instead of parsing all tables at once,
parse and program each entry separately. For _HPP and _HPX 0 thru 2,
this is functionally equivalent. The change enables the upcoming _HPX3
to integrate more easily.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pci-acpi.c      | 108 +++++++++++++++++++-----------------
 drivers/pci/probe.c         |  16 ++----
 include/linux/pci_hotplug.h |  18 +++---
 3 files changed, 72 insertions(+), 70 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index b25e5fa9d1c9..95f4f86d2f34 100644
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
@@ -219,17 +216,18 @@ static acpi_status decode_type2_hpx_record(union acpi_object *record,
 	return AE_OK;
 }
 
-static acpi_status acpi_run_hpx(acpi_handle handle, struct hotplug_params *hpx)
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
@@ -257,19 +255,25 @@ static acpi_status acpi_run_hpx(acpi_handle handle, struct hotplug_params *hpx)
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
 			if (ACPI_FAILURE(status))
 				goto exit;
+			hp_ops->program_type2(dev, &hpx2);
 			break;
 		default:
 			printk(KERN_ERR "%s: Type %d record not supported\n",
@@ -283,14 +287,16 @@ static acpi_status acpi_run_hpx(acpi_handle handle, struct hotplug_params *hpx)
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
@@ -311,12 +317,13 @@ static acpi_status acpi_run_hpp(acpi_handle handle, struct hotplug_params *hpp)
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
@@ -328,7 +335,8 @@ static acpi_status acpi_run_hpp(acpi_handle handle, struct hotplug_params *hpp)
  * @dev - the pci_dev for which we want parameters
  * @hpp - allocated by the caller
  */
-int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp)
+int pci_acpi_program_hp_params(struct pci_dev *dev,
+			       const struct hotplug_program_ops *hp_ops)
 {
 	acpi_status status;
 	acpi_handle handle, phandle;
@@ -351,10 +359,10 @@ int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp)
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
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 257b9f6f2ebb..527c209f0c94 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2131,8 +2131,11 @@ static void pci_configure_eetlp_prefix(struct pci_dev *dev)
 
 static void pci_configure_device(struct pci_dev *dev)
 {
-	struct hotplug_params hpp;
-	int ret;
+	static const struct hotplug_program_ops hp_ops = {
+		.program_type0 = program_hpp_type0,
+		.program_type1 = program_hpp_type1,
+		.program_type2 = program_hpp_type2,
+	};
 
 	pci_configure_mps(dev);
 	pci_configure_extended_tags(dev, NULL);
@@ -2140,14 +2143,7 @@ static void pci_configure_device(struct pci_dev *dev)
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
index 7acc9f91e72b..c85378edf235 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -124,26 +124,24 @@ struct hpp_type2 {
 	u32 sec_unc_err_mask_or;
 };
 
-struct hotplug_params {
-	struct hpp_type0 *t0;		/* Type0: NULL if not available */
-	struct hpp_type1 *t1;		/* Type1: NULL if not available */
-	struct hpp_type2 *t2;		/* Type2: NULL if not available */
-	struct hpp_type0 type0_data;
-	struct hpp_type1 type1_data;
-	struct hpp_type2 type2_data;
+struct hotplug_program_ops {
+	void (*program_type0)(struct pci_dev *dev, struct hpp_type0 *hpp);
+	void (*program_type1)(struct pci_dev *dev, struct hpp_type1 *hpp);
+	void (*program_type2)(struct pci_dev *dev, struct hpp_type2 *hpp);
 };
 
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
-int pci_get_hp_params(struct pci_dev *dev, struct hotplug_params *hpp);
+int pci_acpi_program_hp_params(struct pci_dev *dev,
+			       const struct hotplug_program_ops *hp_ops);
 bool pciehp_is_native(struct pci_dev *bridge);
 int acpi_get_hp_hw_control_from_firmware(struct pci_dev *bridge);
 bool shpchp_is_native(struct pci_dev *bridge);
 int acpi_pci_check_ejectable(struct pci_bus *pbus, acpi_handle handle);
 int acpi_pci_detect_ejectable(acpi_handle handle);
 #else
-static inline int pci_get_hp_params(struct pci_dev *dev,
-				    struct hotplug_params *hpp)
+int pci_acpi_program_hp_params(struct pci_dev *dev,
+			       const struct hotplug_program_ops *hp_ops);
 {
 	return -ENODEV;
 }
-- 
2.19.2

