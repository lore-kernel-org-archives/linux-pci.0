Return-Path: <SRS0=A4Uv=4X=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1257C10F25
	for <linux-pci@archiver.kernel.org>; Fri,  6 Mar 2020 13:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A62F222C3
	for <linux-pci@archiver.kernel.org>; Fri,  6 Mar 2020 13:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgCFNIx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:08:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53340 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgCFNIw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2020 08:08:52 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jACiV-0003fl-8f; Fri, 06 Mar 2020 14:08:39 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 46E13104085;
        Fri,  6 Mar 2020 14:08:38 +0100 (CET)
Message-Id: <20200306130623.500019114@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 06 Mar 2020 14:03:42 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        stable@vger.kernel.org
Subject: [patch 1/7] genirq/debugfs: Add missing sanity checks to interrupt injection
References: <20200306130341.199467200@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Interrupts cannot be injected when the interrupt is not activated and when
a replay is already in progress.

Fixes: 536e2e34bd00 ("genirq/debugfs: Triggering of interrupts from userspace")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 kernel/irq/debugfs.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -206,8 +206,15 @@ static ssize_t irq_debug_write(struct fi
 		chip_bus_lock(desc);
 		raw_spin_lock_irqsave(&desc->lock, flags);
 
-		if (irq_settings_is_level(desc) || desc->istate & IRQS_NMI) {
-			/* Can't do level nor NMIs, sorry */
+		/*
+		 * Don't allow injection when the interrupt is:
+		 *  - Level or NMI type
+		 *  - not activated
+		 *  - replaying already
+		 */
+		if (irq_settings_is_level(desc) ||
+		    !irqd_is_activated(&desc->irq_data) ||
+		    (desc->istate & (IRQS_NMI | IRQS_REPLAY)) {
 			err = -EINVAL;
 		} else {
 			desc->istate |= IRQS_PENDING;

