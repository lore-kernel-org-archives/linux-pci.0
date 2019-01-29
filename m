Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD5FC169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 07:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AB42147A
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 07:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfG3GZck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbfA2HSU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:18:20 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40431 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfA2HSU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2019 02:18:20 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so2573638ita.5;
        Mon, 28 Jan 2019 23:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GyNtLBHh0xeZa5yZWxYrqzD/jwUpFtb/xcRYJ2hiRz0=;
        b=rfG3GZck2Hu4OouisCpWtNqsn0DtP2/TB45pjQXLboseYtPUTYOhUpJMariGpu7eKW
         9IQoLwXg2ghZd6m4TC17kwZt1BhyfjWphMbI4XHQScVuNNDv05/Lvc6IcGMqTlvumxZj
         8cg6xqKon/HjLcTShxlrcNJc06dTq6GZsc8gkyM7MlccsuGCFv2B0yOwgR30lswHN0dx
         IIvy8lH5CpRanpCX625PD2lxAr0pwsvs/S6NdnsVlVWmFnN2GQjpWfbWmycJw2wJWatb
         gK0OEVVrWMhzFWuNhBdGrO/eUOZR+pqwy4ywv5nrTBeMxcUTH6nU1dbwFNX0no4woFyk
         spFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GyNtLBHh0xeZa5yZWxYrqzD/jwUpFtb/xcRYJ2hiRz0=;
        b=ueYzg4k+pvJjaO23fA0Fo5inbqL00HqFs7k2uSnQKP6838+z1PeW+mBgHi5n72ODN4
         JIm/pfYrjA1kiE8DRr00JO70NmQTtRZmKj7x0V/1egTM6TSBzjLK3QWE7kFGYSbqfSDN
         433fb26WVDuGKGY1/WElan/TiGsvgUVfH0AzU5KR5ZcF0JBbJdt+wcf60SWICdx0GziY
         IwKqe4do3t6GW0kez4Ko7K7T7C1ikgqozoq7mjJhUncQb7h5lpBGQHRjZk/iPqWuscKL
         NL6xI0JUBCs65deORl+6Wd75aefT0fQFXCXEM/ikxQeb5FphyZ2p7LyyfbNEAaVZsj4e
         pkJg==
X-Gm-Message-State: AJcUukfS2UPwkvIVKZic+EZfIVgi2tW1o63w1Vxxj3xF5AhgnRC2qbNM
        Ki3pIVB9zXEIzMNlC3fmrvs=
X-Google-Smtp-Source: ALg8bN5Qza+K60uTvFzqGMoAWhm1bWtx+nXYJ8dDx3wO/5hFYkLC5hyuosIN82JkkE5BDovcVoJjiA==
X-Received: by 2002:a24:1fc7:: with SMTP id d190mr11400794itd.126.1548746299105;
        Mon, 28 Jan 2019 23:18:19 -0800 (PST)
Received: from m-hyperV (50-47-88-57.evrt.wa.frontiernet.net. [50.47.88.57])
        by smtp.gmail.com with ESMTPSA id f13sm14513210iol.82.2019.01.28.23.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 23:18:18 -0800 (PST)
Date:   Mon, 28 Jan 2019 23:18:17 -0800
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, haiyangz@microsoft.com,
        vkuznets@redhat.com, marcelo.cerri@canonical.com
Subject: [PATCH v3 1/2] PCI: hv: Replace hv_vp_set with hv_vpset
Message-ID: <19aea785b78cf14c71f58bf278df17dc3adf8368.1548745212.git.m.maya.nakamura@gmail.com>
References: <cover.1548745212.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548745212.git.m.maya.nakamura@gmail.com>
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
Change in v3:
- Correct the v2 change log.

Change in v2:
- Update the commit message.

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

