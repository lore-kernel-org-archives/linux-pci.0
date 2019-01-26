Return-Path: <SRS0=pA/b=QC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E9FC282C5
	for <linux-pci@archiver.kernel.org>; Sat, 26 Jan 2019 08:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5AF218F0
	for <linux-pci@archiver.kernel.org>; Sat, 26 Jan 2019 08:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JalG4qrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfAZIwa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 26 Jan 2019 03:52:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34681 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfAZIwa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Jan 2019 03:52:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so5835007pfg.1;
        Sat, 26 Jan 2019 00:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GMa9ParM+bD6Sxu5NaqN2juAjxA5hsNmjLgl/k+rpkI=;
        b=JalG4qrGqvUPH9+5lhETDQdhHZ3NFc0C4ThxIbIQx6HZ+eNnfI3YkAljjuuVco5ng3
         Dg0k5au2lenCtawzQpL3YcpV85yAN6KKHiF09M2jcUDg6Pi0xJU3IKPLjTZvgblg/GfI
         5X8Y+ZEeKaBALJ1L6F8mMm0YnD0GNKVqTFNLs9IaMO4ftsdfr7Pd4h8xMQQ2mi1HUSQO
         YlxGG4VmaBo9c8JGhDL6N+jlaplAtZBDAU5KkqAYHuSSEu7Ei6wvJtIi/MjxAKnvvyP9
         ZW9kkbVxhf8fFAzr4Ai48OA+ARkPkY4s6JOxt4vs0UnjtM3YnpgewzClt36+Qw740atw
         E5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GMa9ParM+bD6Sxu5NaqN2juAjxA5hsNmjLgl/k+rpkI=;
        b=E+X/ifhtC7QBkTmuztT/j7VwO0Kn1u2E/GECzVLgx6LhEGLqA6BS9mwvXxJZndMaxj
         GANGrqtIc/B+3XFjSxC/qzfN81O13D84Q8RNBKQLZiuah5dL704/JpBYfKWT9MAipsN9
         RN3mVSskdjjv3TjjXYOsiEbIUWo4FMzsbGZgKFx4faMKzmb2gNU9RAODv428Au6/5UZ4
         xO9XEHdxnyPfxz1haRLZrL9jgAz+dbykrbDzPVyCtgDWDplqSfyXDpHqEp/7Pkou9WFI
         tmolpM2rZpHQvxATUK4jCc9/hZ1+IFwlV/iQydGm+ZTm0f/hCNGONDGZJpoAVfzt7pAC
         zY4w==
X-Gm-Message-State: AJcUukf3vPcvKIe/4W+lk7gGsRlIHC5kBUvFhCtC/FNcU6N0s76c/gBK
        oeBBcxuOwpHKS26MFRsHDY8=
X-Google-Smtp-Source: ALg8bN7yi+1mhhReb8ToOkB5X9mUSTTJeouzvwv2Z9SMDInMLwrR9Fn567r/mMEi6SQIAsf820zjgw==
X-Received: by 2002:a63:235f:: with SMTP id u31mr12813956pgm.122.1548492749638;
        Sat, 26 Jan 2019 00:52:29 -0800 (PST)
Received: from m-hyperV (50-47-89-76.evrt.wa.frontiernet.net. [50.47.89.76])
        by smtp.gmail.com with ESMTPSA id 78sm41732320pft.184.2019.01.26.00.52.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 00:52:28 -0800 (PST)
Date:   Sat, 26 Jan 2019 00:52:28 -0800
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, haiyangz@microsoft.com,
        vkuznets@redhat.com, marcelo.cerri@canonical.com
Subject: [PATCH v2 1/2] PCI: hv: Replace hv_vp_set with hv_vpset
Message-ID: <2fa660dc51189316590021c4ee8aeaac79b8270f.1548489092.git.m.maya.nakamura@gmail.com>
References: <cover.1548489092.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548489092.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove a duplicate definition of VP set (hv_vp_set) and use the common
definition (hv_vpset) that is used in other places.

Change the order of the members in struct hv_pcibus_device so that the
declaration of retarget_msi_interrupt_params is the last member. Struct
hv_vpset, which contains a flexible array, is nested two levels deep in
struct hv_pcibus_device via retarget_msi_interrupt_params.

Add a comment that retarget_msi_interrupt_params should be the last member
of struct hv_pcibus_device.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
---
Change in v2:
- None

 drivers/pci/controller/pci-hyperv.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 9ba4d12c179c..da8b58d8630d 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -393,12 +393,6 @@ struct hv_interrupt_entry {
 
 #define HV_VP_SET_BANK_COUNT_MAX	5 /* current implementation limit */
 
-struct hv_vp_set {
-	u64	format;			/* 0 (HvGenericSetSparse4k) */
-	u64	valid_banks;
-	u64	masks[HV_VP_SET_BANK_COUNT_MAX];
-};
-
 /*
  * flags for hv_device_interrupt_target.flags
  */
@@ -410,7 +404,7 @@ struct hv_device_interrupt_target {
 	u32	flags;
 	union {
 		u64		 vp_mask;
-		struct hv_vp_set vp_set;
+		struct hv_vpset vp_set;
 	};
 };
 
@@ -460,12 +454,16 @@ struct hv_pcibus_device {
 	struct msi_controller msi_chip;
 	struct irq_domain *irq_domain;
 
-	/* hypercall arg, must not cross page boundary */
-	struct retarget_msi_interrupt retarget_msi_interrupt_params;
-
 	spinlock_t retarget_msi_interrupt_lock;
 
 	struct workqueue_struct *wq;
+
+	/* hypercall arg, must not cross page boundary */
+	struct retarget_msi_interrupt retarget_msi_interrupt_params;
+
+	/*
+	 * Don't put anything here: retarget_msi_interrupt_params must be last
+	 */
 };
 
 /*
@@ -955,12 +953,13 @@ static void hv_irq_unmask(struct irq_data *data)
 		 */
 		params->int_target.flags |=
 			HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
-		params->int_target.vp_set.valid_banks =
+		params->int_target.vp_set.valid_bank_mask =
 			(1ull << HV_VP_SET_BANK_COUNT_MAX) - 1;
 
 		/*
 		 * var-sized hypercall, var-size starts after vp_mask (thus
-		 * vp_set.format does not count, but vp_set.valid_banks does).
+		 * vp_set.format does not count, but vp_set.valid_bank_mask
+		 * does).
 		 */
 		var_size = 1 + HV_VP_SET_BANK_COUNT_MAX;
 
@@ -974,7 +973,7 @@ static void hv_irq_unmask(struct irq_data *data)
 				goto exit_unlock;
 			}
 
-			params->int_target.vp_set.masks[cpu_vmbus / 64] |=
+			params->int_target.vp_set.bank_contents[cpu_vmbus / 64]	|=
 				(1ULL << (cpu_vmbus & 63));
 		}
 	} else {
-- 
2.17.1

