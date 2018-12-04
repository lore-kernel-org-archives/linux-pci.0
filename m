Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAC2C04EBF
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 15:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A8220645
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 15:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaIss0ji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A8220645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeLDPwZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:52:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45049 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeLDPwY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Dec 2018 10:52:24 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so7537115pgr.11;
        Tue, 04 Dec 2018 07:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T5+rm2G+CG4RcqJPn9oni1Nfoo3IO96rRBFqIoeXuRI=;
        b=SaIss0jiT7fv8RECTR0Ooa+5NmTZBhwA/6/uZwuhKF2dvklF0GUA3/S3QJsCGPn9tQ
         RyYV4q3Sc1TqfEn9/Y12XuZSyy4aEeqVXiuhYcMauETgrH+ChpCTpEQyrT0NT+mqLuZv
         JO0EVxDGxTKGNLaQZv7glSIUmYLf2DK6AvR5Ni8W4v3RnKnWDAswJFwoAjIL1F/iwRUS
         PnnCvv8W+bLtHFHcZyf/L3gX8bPDifalNZE8vwoz8wtQw5Kb4zCVffois0Ke/MqF5DXf
         gESc5LVmevhohhL9RWw+8dr8EzyqJG+OZ1aJ+phwfXqmg4z7ktlXxJRyNRw+i8v06OIZ
         QqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T5+rm2G+CG4RcqJPn9oni1Nfoo3IO96rRBFqIoeXuRI=;
        b=AmKk0BAOa1FY3yKbpZeovQM3jqTcpC9sO4/Aduv43As14RpfoNBNMz31ysDH5hJObt
         qww1aneqyJBUzIqBo+NmWk3Vt9HNVQOZ1J08GdECHkAB4vqMDKG0WSbF5/uUSseArvyO
         rlq1kXgEWO1hTlIcA3n7tFY7+6qBwQ+VVqcytICz90FetDMGeJFPbFXa7fYBxkxmuEvX
         aUCT9iKNeFmSQzSBiplbhLxgVwAIxhzaYp6trcMiMwo9algY9sKb0zmRMaJMOdLTmluj
         s9UfbeAvhwEkGjWudEaD/nIcALAKjAELwc26bnS8ggQlLPD+XJOong/s6z7XIboVB/dk
         cebQ==
X-Gm-Message-State: AA+aEWYJSIEGN531TkWKg59CnM7qVQGlWLap8ckFmQ6+qs3KyMDkXNWu
        K9NzPgQIPgBnOYkZ+HrwL6WDj5U7X3A=
X-Google-Smtp-Source: AFSGD/UlhGhR2KgdWc6y1cFJc6QsYSDcJSSfx0QU+nf0iACA6VOSoXAphdwShOw0Q1ZUwG5f98RmLg==
X-Received: by 2002:a62:f247:: with SMTP id y7mr20584770pfl.25.1543938743845;
        Tue, 04 Dec 2018 07:52:23 -0800 (PST)
Received: from localhost.localdomain ([104.238.160.83])
        by smtp.gmail.com with ESMTPSA id u78sm40653444pfi.2.2018.12.04.07.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 07:52:23 -0800 (PST)
From:   Dou Liyang <douliyangs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     tglx@linutronix.de, kashyap.desai@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, sumit.saxena@broadcom.com,
        ming.lei@redhat.com, hch@lst.de, bhelgaas@google.com,
        douliyang1@huawei.com, Dou Liyang <douliyangs@gmail.com>
Subject: [PATCH 3/3] irq/affinity: Fix a possible breakage
Date:   Tue,  4 Dec 2018 23:51:22 +0800
Message-Id: <20181204155122.6327-4-douliyangs@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181204155122.6327-1-douliyangs@gmail.com>
References: <20181204155122.6327-1-douliyangs@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In case of irq_default_affinity != cpu_possible_mask, setting the affinity
for the pre/post vectors to irq_default_affinity is a breakage.

Just set the pre/post vectors to cpu_possible_mask and be done with it.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dou Liyang <douliyangs@gmail.com>
---
 kernel/irq/affinity.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index d122575ba1b4..aaa1dd82c3df 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -257,7 +257,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 
 	/* Fill out vectors at the beginning that don't need affinity */
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
-		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
+		cpumask_copy(&masks[curvec].mask, cpu_possible_mask);
 	/*
 	 * Spread on present CPUs starting from affd->pre_vectors. If we
 	 * have multiple sets, build each sets affinity mask separately.
@@ -282,12 +282,15 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	}
 
 	/* Fill out vectors at the end that don't need affinity */
-	if (usedvecs >= affvecs)
+	if (usedvecs >= affvecs) {
 		curvec = affd->pre_vectors + affvecs;
-	else
+	} else {
 		curvec = affd->pre_vectors + usedvecs;
+		for (; curvec < affd->pre_vectors + affvecs; curvec++)
+			cpumask_copy(&masks[curvec].mask, irq_default_affinity);
+	}
 	for (; curvec < nvecs; curvec++)
-		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
+		cpumask_copy(&masks[curvec].mask, cpu_possible_mask);
 
 	/*  Setup complementary information */
 	for (i = 0; i < nvecs; i++) {
-- 
2.17.2

