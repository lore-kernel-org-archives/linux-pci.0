Return-Path: <SRS0=pA/b=QC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0383EC282C5
	for <linux-pci@archiver.kernel.org>; Sat, 26 Jan 2019 08:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF21C21902
	for <linux-pci@archiver.kernel.org>; Sat, 26 Jan 2019 08:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXeFT4bP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfAZIzX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 26 Jan 2019 03:55:23 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44232 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfAZIzW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Jan 2019 03:55:22 -0500
Received: by mail-pl1-f195.google.com with SMTP id e11so5618984plt.11;
        Sat, 26 Jan 2019 00:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=niyt0UR2PXpRbHY6CfjN400AvM7m2HvuWdGn/Q6y7OQ=;
        b=DXeFT4bPWrJseLNgE9q3yDqgzIiVBisJxnhl+U+cX7QAdv6sW/aVIQ7hiqWBpie+Jj
         T7twUmrdN0QX7IgnA1lgCNwJ9UjssH5H+Vrm+0QDa0oIEXjCx5YmCpZ+u9Z3BkOgD8ky
         7iFz0YinvNEzblwGMo8a6EeI1BihkztCUGVepun4pW7YsUW1l70xzTMlrymOFo6i4SIw
         A5+2fXUbCe2RmhmWpiP2LkJz6TR9IH2mjuSXVVuX4mQdSMFUUIYINw8X8Jhhjxx4i/K6
         HIkfRmgTXZCE/6XZhk8pcMm6rHqe52/BUdA22l7vx3Zj9Sm0wJYdsRs2iYXsqfNoQlSF
         RoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=niyt0UR2PXpRbHY6CfjN400AvM7m2HvuWdGn/Q6y7OQ=;
        b=rqCXkmabYtJ+RY/1vCvv9AfV1NlYuhdzyMWGWDmab7+fsZPOlktIlRrkx2YQLjFvc6
         Ya/wRYBuZL4U8u2ESepy2BtSAVi4PasEXrQ0uft8bT+joqsTR76Lx2Vp4Y8HKQui+6Vy
         vt4AOatJ95nIZzZxCBSlaBkP6Y1oKY6R61oJNyo4NpPNm+1TLlEUNV6wxUuBUHyt5km4
         wcTMOsge2gk+fIvvBx3Z0DZxqNOjPrPKaERq9B2fKy1dc1lkqlNwiQ2P6NuW9OsAC2Xw
         Qj0/rNQN9PC9Oskl1WyM30b2VptL+LcLAHQ+8sp/JqcxXMU3mv3YaQmO8iq6J57ad0Lm
         QbVA==
X-Gm-Message-State: AJcUukdXehLzU9ttwPve+GnS8gH0a1BXaeO3Xbt/7+jJ3F8njpGF5+qF
        lIkQuB59EaZ90KeGZlzLJvI=
X-Google-Smtp-Source: ALg8bN51LTVslHUHRdKx5V1WTvK2/K5IEEGpxS6kq5GDqzPKkR+gz8tzgAeGzuBqcUh0r6VW4tUGuA==
X-Received: by 2002:a17:902:583:: with SMTP id f3mr14767693plf.202.1548492922191;
        Sat, 26 Jan 2019 00:55:22 -0800 (PST)
Received: from m-hyperV (50-47-89-76.evrt.wa.frontiernet.net. [50.47.89.76])
        by smtp.gmail.com with ESMTPSA id l3sm39750274pga.92.2019.01.26.00.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 00:55:21 -0800 (PST)
Date:   Sat, 26 Jan 2019 00:55:20 -0800
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, haiyangz@microsoft.com,
        vkuznets@redhat.com, marcelo.cerri@canonical.com
Subject: [PATCH v2 2/2] PCI: hv: Refactor hv_irq_unmask() to use
 cpumask_to_vpset()
Message-ID: <4b94f3bb88f56e4c5ca05c1c6ee73f9c6c6a88e7.1548489092.git.m.maya.nakamura@gmail.com>
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

Remove the duplicate implementation of cpumask_to_vpset() and use the
shared implementation. Export hv_max_vp_index, which is required by
cpumask_to_vpset().

Apply changes to hv_irq_unmask() based on feedback.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
---
Changes in v2:
 - Remove unnecessary nr_bank initialization.
 - Delete two unnecessary dev_err()'s.
 - Unlock before returning.

 arch/x86/hyperv/hv_init.c           |  1 +
 drivers/pci/controller/pci-hyperv.c | 38 +++++++++++++----------------
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 7abb09e2eeb8..7f2eed1fc81b 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -96,6 +96,7 @@ void  __percpu **hyperv_pcpu_input_arg;
 EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
 
 u32 hv_max_vp_index;
+EXPORT_SYMBOL_GPL(hv_max_vp_index);
 
 static int hv_cpu_init(unsigned int cpu)
 {
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index da8b58d8630d..d74c0f111fd0 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -391,8 +391,6 @@ struct hv_interrupt_entry {
 	u32	data;
 };
 
-#define HV_VP_SET_BANK_COUNT_MAX	5 /* current implementation limit */
-
 /*
  * flags for hv_device_interrupt_target.flags
  */
@@ -908,12 +906,12 @@ static void hv_irq_unmask(struct irq_data *data)
 	struct retarget_msi_interrupt *params;
 	struct hv_pcibus_device *hbus;
 	struct cpumask *dest;
+	cpumask_var_t tmp;
 	struct pci_bus *pbus;
 	struct pci_dev *pdev;
 	unsigned long flags;
 	u32 var_size = 0;
-	int cpu_vmbus;
-	int cpu;
+	int cpu, nr_bank;
 	u64 res;
 
 	dest = irq_data_get_effective_affinity_mask(data);
@@ -953,29 +951,27 @@ static void hv_irq_unmask(struct irq_data *data)
 		 */
 		params->int_target.flags |=
 			HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
-		params->int_target.vp_set.valid_bank_mask =
-			(1ull << HV_VP_SET_BANK_COUNT_MAX) - 1;
+
+		if (!alloc_cpumask_var(&tmp, GFP_KERNEL)) {
+			res = 1;
+			goto exit_unlock;
+		}
+
+		cpumask_and(tmp, dest, cpu_online_mask);
+		nr_bank = cpumask_to_vpset(&params->int_target.vp_set, tmp);
+		free_cpumask_var(tmp);
+
+		if (!nr_bank) {
+			res = 1;
+			goto exit_unlock;
+		}
 
 		/*
 		 * var-sized hypercall, var-size starts after vp_mask (thus
 		 * vp_set.format does not count, but vp_set.valid_bank_mask
 		 * does).
 		 */
-		var_size = 1 + HV_VP_SET_BANK_COUNT_MAX;
-
-		for_each_cpu_and(cpu, dest, cpu_online_mask) {
-			cpu_vmbus = hv_cpu_number_to_vp_number(cpu);
-
-			if (cpu_vmbus >= HV_VP_SET_BANK_COUNT_MAX * 64) {
-				dev_err(&hbus->hdev->device,
-					"too high CPU %d", cpu_vmbus);
-				res = 1;
-				goto exit_unlock;
-			}
-
-			params->int_target.vp_set.bank_contents[cpu_vmbus / 64]	|=
-				(1ULL << (cpu_vmbus & 63));
-		}
+		var_size = 1 + nr_bank;
 	} else {
 		for_each_cpu_and(cpu, dest, cpu_online_mask) {
 			params->int_target.vp_mask |=
-- 
2.17.1

