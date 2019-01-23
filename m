Return-Path: <SRS0=s0ql=P7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795C4C282C0
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 21:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4353E21855
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 21:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zru6X8xf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfAWVAc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:00:32 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40464 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfAWVAc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jan 2019 16:00:32 -0500
Received: by mail-io1-f68.google.com with SMTP id k2so2813143iog.7;
        Wed, 23 Jan 2019 13:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CuB8fXN6idRJoV6oBvYHvLfSlspkhZGP9SAAMiIC9Xs=;
        b=Zru6X8xf2f+ni2ZjJHx0PjvysbWq/TH9jZ4TxsFtlIFFD07Svq7qGPCsFazYZ9DecX
         IzifO+d9wJW50FwBk4TnvcwHkWSEiGimYG5KUh6SMxRMC43o9mf56RUp6EuqU6rEgwcf
         cyhZ43rNsJOFCRlRCv/n8YPhLu2vUFiB0rtV8A4MwtaGeXQp0gscRatII19wqiBIZlkT
         RN1vdsdObQLdfEn6EP0YYKHOAnW38qi8DHCT6paGqplrM1aQ34lrOV60CMek17cKVrhq
         jtG9ltulbzng/52atpkDBGdOqW8+B0gfxC8I6r3rACvdz+qyD23/slqnbBeaf46RnYXS
         Khjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CuB8fXN6idRJoV6oBvYHvLfSlspkhZGP9SAAMiIC9Xs=;
        b=q7NJcck6BoTVtzpoAuzUz2iH+LO9CNyl4ec15B9+uTDAu0lLsovc6q4RxlJCcapXZt
         siqIv9U2BiZX46goIqTu1P1w6CWV0lfIQEnc65Ski9y3t9vzdipCfLJYV5XS/mSSFoSi
         0cvK5kRuPhq0g2cxNGY1J2MQ2UGcsMWYUVGSWTJKKE7cV0u0jQgXBz05+P6rcOtVAqZg
         YEZ8lpcpQS83NuzOE499sdgEJyPUmgB9JHWmAJG2dmiHwPLu+QU1Tsp1jk+s8IzHHRB5
         igGpzdOEmwfIwNDrViFtk2MWqyywcr6u6ue82R8tVXC+oezsCMxXqXekhT7/c8oJGyhD
         Wtjw==
X-Gm-Message-State: AJcUukfVNWF26pSrs/ruEfEwIMKlPqdCs0GrAoWKsN/+RvIdAVQzRtSp
        qfPixPy4OewX46MUEKfywMk=
X-Google-Smtp-Source: AHgI3IbQTlHtTkhjQh2APotS8qCYeWjK1JyFUIK6B1Icg3Q1pcVkLa/6CQxObD3pTt23Mqx6G6gNwQ==
X-Received: by 2002:a6b:b7ce:: with SMTP id h197mr2140009iof.274.1548277231528;
        Wed, 23 Jan 2019 13:00:31 -0800 (PST)
Received: from m-hyperV (50-47-89-76.evrt.wa.frontiernet.net. [50.47.89.76])
        by smtp.gmail.com with ESMTPSA id e22sm7905308iod.47.2019.01.23.13.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 13:00:30 -0800 (PST)
Date:   Wed, 23 Jan 2019 13:00:29 -0800
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, haiyangz@microsoft.com,
        vkuznets@redhat.com, marcelo.cerri@canonical.com
Subject: [PATCH 1/2] PCI: hv: Replace hv_vp_set with hv_vpset
Message-ID: <87ffdc2eb0642301516378feb1416cf7450bf6c1.1548232616.git.m.maya.nakamura@gmail.com>
References: <cover.1548232616.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548232616.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove a duplicate definition of VP set (hv_vp_set) and use the common
definition (hv_vpset) that is used in other places.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
---
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

