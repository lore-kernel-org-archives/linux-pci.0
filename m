Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F54DC07E85
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 15:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240B820645
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 15:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMn5yjFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240B820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbeLDPwQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:52:16 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35116 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeLDPwQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Dec 2018 10:52:16 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so8421462pfi.2;
        Tue, 04 Dec 2018 07:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OdkkpT2J6isGXQFXROnXRZLRzOG2eTpEzLoXtl4D7vE=;
        b=VMn5yjFLX50xmZ3eRGIo2oStm+weW96F3K87gg01DV7ds+jMlwl7ElOipaltnJWEqs
         0oEvQPtxYg5nVReerTdLn72U1GdLqtRiUrcrmTSHl0JINBDkFSmGKh0n8ms0/gJ6Yfre
         DyfXVpDmcwWpTd2Z4t7hJRdQu3caDLT6OPlRCiaqPpOWsLrj+aFy7xEAIcBWVvY9iiCL
         3p2UsnkOtcQwvasHcLXBIXgoXfIt+9cPk8xdoB5WUQ4ZjtqHHk9mCZ6GSJ9z19/wYTbU
         4TIytrpxB+N9T+hZbv2CBAjwPkULAx9maUQ8iLOEbz3JaYqC3AyL275iikixWOGscJ9O
         2Cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OdkkpT2J6isGXQFXROnXRZLRzOG2eTpEzLoXtl4D7vE=;
        b=okX8XGHkzEt3L82z5VceQFFnvwtO8EP1cGjIRCsSxVstSBoJfRiolnr3h568IfAkBB
         sogSBVIA+x/8/8jGYxaXVr2J5tOzuUPkWDVjujhHZq+LaFY3diYf39Vn4DvVvDdAfAQr
         v2Wz5HZiW0JcKx+3g8I45snvXmYAqAM1e1Q2hrMF58AZsWx/cH3JgH+abQ++MWtDsELv
         YXj2RHwGMBXQ/BznTVnqDZw+ZK2S6C05ybIBX9myuFyTLB5vJR2NtYYJwalHnaAnlXJt
         MiCobHml8HJl7nQTMxyE1TT1jz6cJlnxuMPkCMtNqe8dTOCEqqxDEZsGg3D+fRvaM1+R
         BBkg==
X-Gm-Message-State: AA+aEWZwO0LHIw0pzbcR5av/xE7gUFuwsRU83ygDCQ7ULJEVoDhtCKic
        t+D5bOH5Csa0KGQAYEG2PZpq4mL4AZ4=
X-Google-Smtp-Source: AFSGD/UB1jNRuiQjwaBGiUOur7BBVnkAlp246AZ5aMSW1HedDbdqSe8mo5M2nm4yr2ARz0hJsZ3u2A==
X-Received: by 2002:a63:504d:: with SMTP id q13mr17486239pgl.319.1543938734239;
        Tue, 04 Dec 2018 07:52:14 -0800 (PST)
Received: from localhost.localdomain ([104.238.160.83])
        by smtp.gmail.com with ESMTPSA id u78sm40653444pfi.2.2018.12.04.07.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 07:52:13 -0800 (PST)
From:   Dou Liyang <douliyangs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     tglx@linutronix.de, kashyap.desai@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, sumit.saxena@broadcom.com,
        ming.lei@redhat.com, hch@lst.de, bhelgaas@google.com,
        douliyang1@huawei.com, Dou Liyang <douliyangs@gmail.com>
Subject: [PATCH 2/3] irq/affinity: Add is_managed into struct irq_affinity_desc
Date:   Tue,  4 Dec 2018 23:51:21 +0800
Message-Id: <20181204155122.6327-3-douliyangs@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181204155122.6327-1-douliyangs@gmail.com>
References: <20181204155122.6327-1-douliyangs@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now, Linux uses the irq_affinity_desc to convey information.

As Kashyap and Sumit reported, in MSI/-x subsystem, the pre/post vectors
may be used to some extra reply queues for performance.

  https://marc.info/?l=linux-kernel&m=153543887027997&w=2

Their affinities are not NULL, but, they should be mapped as unmanaged
interrupts. So, only transfering the irq affinity assignments is not enough.

Add a new bit "is_managed" to convey the info in irq_affinity_desc and use
it in alloc_descs().

Reported-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reported-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Dou Liyang <douliyangs@gmail.com>
---
 include/linux/interrupt.h | 1 +
 kernel/irq/affinity.c     | 7 +++++++
 kernel/irq/irqdesc.c      | 9 +++++++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 71be303231e9..a12b3dbbc45e 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -263,6 +263,7 @@ struct irq_affinity {
  */
 struct irq_affinity_desc {
 	struct cpumask	mask;
+	unsigned int	is_managed : 1;
 };
 
 #if defined(CONFIG_SMP)
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 1562a36e7c0f..d122575ba1b4 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -289,6 +289,13 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	for (; curvec < nvecs; curvec++)
 		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
 
+	/*  Setup complementary information */
+	for (i = 0; i < nvecs; i++) {
+		if (i >= affd->pre_vectors && i < nvecs - affd->post_vectors)
+			masks[i].is_managed = 1;
+		else
+			masks[i].is_managed = 0;
+	}
 outnodemsk:
 	free_node_to_cpumask(node_to_cpumask);
 	return masks;
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index f87fa2b9935a..6b0821c144c0 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -455,7 +455,7 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 	const struct irq_affinity_desc *cur_affinity= affinity;
 	const struct cpumask *mask = NULL;
 	struct irq_desc *desc;
-	unsigned int flags;
+	unsigned int flags = 0;
 	int i;
 
 	/* Validate affinity mask(s) */
@@ -468,11 +468,16 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 		}
 	}
 
-	flags = affinity ? IRQD_AFFINITY_MANAGED | IRQD_MANAGED_SHUTDOWN : 0;
 	mask = NULL;
 
 	for (i = 0; i < cnt; i++) {
 		if (affinity) {
+			if (affinity->is_managed) {
+				flags = IRQD_AFFINITY_MANAGED |
+					IRQD_MANAGED_SHUTDOWN;
+			} else {
+				flags = 0;
+			}
 			mask = &affinity->mask;
 			node = cpu_to_node(cpumask_first(mask));
 			affinity++;
-- 
2.17.2

