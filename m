Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646DFC04EB8
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 22:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AE02082B
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 22:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22AE02082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbeLDWN0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:13:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47463 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeLDWN0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Dec 2018 17:13:26 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB4MDAUV1031962
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 4 Dec 2018 14:13:10 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB4MDAZG1031959;
        Tue, 4 Dec 2018 14:13:10 -0800
Date:   Tue, 4 Dec 2018 14:13:10 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Lance Roy <tipbot@zytor.com>
Message-ID: <tip-868f7a09a4f385e5167fc0ff9ec4c3f817897f3a@git.kernel.org>
Cc:     paulmck@linux.ibm.com, x86@kernel.org, bp@alien8.de,
        mingo@redhat.com, linux-pci@vger.kernel.org, ldr709@gmail.com,
        mingo@kernel.org, bhelgaas@google.com, tglx@linutronix.de,
        hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
          mingo@redhat.com, bp@alien8.de, x86@kernel.org,
          paulmck@linux.ibm.com, tglx@linutronix.de, hpa@zytor.com,
          mingo@kernel.org, bhelgaas@google.com, ldr709@gmail.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/rcu] x86/PCI: Replace spin_is_locked() with lockdep
Git-Commit-ID: 868f7a09a4f385e5167fc0ff9ec4c3f817897f3a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit-ID:  868f7a09a4f385e5167fc0ff9ec4c3f817897f3a
Gitweb:     https://git.kernel.org/tip/868f7a09a4f385e5167fc0ff9ec4c3f817897f3a
Author:     Lance Roy <ldr709@gmail.com>
AuthorDate: Thu, 4 Oct 2018 23:45:38 -0700
Committer:  Paul E. McKenney <paulmck@linux.ibm.com>
CommitDate: Thu, 8 Nov 2018 21:53:35 -0800

x86/PCI: Replace spin_is_locked() with lockdep

lockdep_assert_held() is better suited to checking locking requirements,
since it only checks if the current thread holds the lock regardless of
whether someone else does. This is also a step towards possibly removing
spin_is_locked().

Signed-off-by: Lance Roy <ldr709@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Cc: <linux-pci@vger.kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 arch/x86/pci/i386.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index 8cd66152cdb0..9df652d3d927 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -59,7 +59,7 @@ static struct pcibios_fwaddrmap *pcibios_fwaddrmap_lookup(struct pci_dev *dev)
 {
 	struct pcibios_fwaddrmap *map;
 
-	WARN_ON_SMP(!spin_is_locked(&pcibios_fwaddrmap_lock));
+	lockdep_assert_held(&pcibios_fwaddrmap_lock);
 
 	list_for_each_entry(map, &pcibios_fwaddrmappings, list)
 		if (map->dev == dev)
