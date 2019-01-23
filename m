Return-Path: <SRS0=s0ql=P7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863FCC282C0
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 21:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E54021855
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 21:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFfj5hJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfAWVCP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:02:15 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36621 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfAWVCP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jan 2019 16:02:15 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so1271167itj.1;
        Wed, 23 Jan 2019 13:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0p1yTpV5Tht/6aKQSHmDd5AdsxL/XMoMMRLNnSBXjfI=;
        b=oFfj5hJbr5a4IsaR2weKrt1pWmXii31pW2Ov4R1+lYWIsX+3194iI9N3nYLHC2T8SE
         fqWJ6mGb8X57S7FCj01m2Z5h8LeZacJP7ztQ9PIwj3r598s9w8adTg3+nY/ymcNpyPJx
         FiM+ZoUNXlrqAFT+ymIDmUWysle6Y6ww74xmcMVcKJDnVhhmTgtjKIQa6FufSdmxziss
         fmDXTFPoYkP0drEjfEBVHENlCSrigB/Gi5IATwPVduSsbz85YuAllChg+tWCyj+r5nK8
         QAjFYd7uxVN0ymRX3VyumW9W5qA0ahsFNfXMmb/9Ky20wPfO43uvISYjP81RK4jmzLqi
         KabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0p1yTpV5Tht/6aKQSHmDd5AdsxL/XMoMMRLNnSBXjfI=;
        b=OwUJqpebi0IJbaU3EdbHOvnf3yl1sNa0HL7XKANHoch/La/tlkzou1HBqnjFuJoXjY
         YM2+5nYP8L9hxjra/q7d78AfmBUagkeKWeOCBG+x077tYvQwYtq/3U2W++m61wVJvRX2
         iRvkuefh6sD2N5+qiPytIX1BvQLJjTSG4JysJKD0Lm7YNF3Ur3gis4yZmp2QCixQD5lm
         aBCjcwa6uRbiciDM1sgk0EcISDG0Ksg2gN1LA2DcSspTMWZdfzEmMe7wy23tfAWkf1n1
         vPUD43W5AKCvPMbKoEFRI8sAFKuZhqlIiT3vhIA71zTKWYlMKOSdpa0YthK8BPM98PU4
         NZmw==
X-Gm-Message-State: AJcUukfZipAv3Iojgk8GWsy4Rd9GphrY/6r3Ns1r7CJdsoc++EBVP6Lj
        txqbF7nd7JPxcTM1aUrCoiE=
X-Google-Smtp-Source: AHgI3IYdJTrQTMAaeg1D3iwVy5qtLnKuCZa6JU4YDHZ41ksLTPrljIlGLQEncmR8d5MlikMD+FWCrQ==
X-Received: by 2002:a24:eec7:: with SMTP id b190mr2409712iti.18.1548277334537;
        Wed, 23 Jan 2019 13:02:14 -0800 (PST)
Received: from m-hyperV (50-47-89-76.evrt.wa.frontiernet.net. [50.47.89.76])
        by smtp.gmail.com with ESMTPSA id r139sm8643976ior.53.2019.01.23.13.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 13:02:13 -0800 (PST)
Date:   Wed, 23 Jan 2019 13:02:12 -0800
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, haiyangz@microsoft.com,
        vkuznets@redhat.com, marcelo.cerri@canonical.com
Subject: [PATCH 2/2] PCI: hv: Refactor hv_irq_unmask() to use
 cpumask_to_vpset()
Message-ID: <885d207cd90a558364d611e4ebd64a87aa8962d7.1548232616.git.m.maya.nakamura@gmail.com>
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

Remove the duplicate implementation of cpumask_to_vpset() and use the
shared implementation. Export hv_max_vp_index, which is required by
cpumask_to_vpset().

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
---
 arch/x86/hyperv/hv_init.c           |  1 +
 drivers/pci/controller/pci-hyperv.c | 39 +++++++++++++----------------
 2 files changed, 19 insertions(+), 21 deletions(-)

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
index da8b58d8630d..d879458d441f 100644
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
+	int cpu, nr_bank = 0;
 	u64 res;
 
 	dest = irq_data_get_effective_affinity_mask(data);
@@ -953,29 +951,28 @@ static void hv_irq_unmask(struct irq_data *data)
 		 */
 		params->int_target.flags |=
 			HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
-		params->int_target.vp_set.valid_bank_mask =
-			(1ull << HV_VP_SET_BANK_COUNT_MAX) - 1;
+
+		if (!alloc_cpumask_var(&tmp, GFP_KERNEL)) {
+			dev_err(&hbus->hdev->device, "out of memory");
+			return;
+		}
+
+		cpumask_and(tmp, dest, cpu_online_mask);
+		nr_bank = cpumask_to_vpset(&params->int_target.vp_set, tmp);
+		free_cpumask_var(tmp);
+
+		if (!nr_bank) {
+			dev_err(&hbus->hdev->device, "too high CPU");
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

