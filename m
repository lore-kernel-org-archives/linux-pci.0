Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:56336 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752015AbdL1KXv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Dec 2017 05:23:51 -0500
Subject: Re: PROBLEM: 4.15.0-rc3 APIC causes lockups on Core 2 Duo laptop
To: Alexandru Chirvasitu <achirvasub@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Dexuan Cui <decui@microsoft.com>, Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        "Mihai Costache (Cloudbase Solutions SRL)" <v-micos@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        KY Srinivasan <kys@microsoft.com>
References: <1bd74ca3-afca-9d61-6911-61250f459891@cn.fujitsu.com>
 <20171222142053.3cbhi2nhh24w7yoo@D-69-91-141-110.dhcp4.washington.edu>
 <KL1P15301MB000676F3F8C9A5AC8C489E75BF020@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20171222222917.GA1138@arch-chirva.localdomain>
 <KL1P15301MB00064E9E767F9395744F42A3BF030@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <alpine.DEB.2.20.1712231432210.1853@nanos>
 <20171223200112.GC1138@arch-chirva.localdomain>
 <548c814c-7e24-00c0-3436-26f2704cb427@cn.fujitsu.com>
 <20171227161801.GE1410@arch-chirva.localdomain>
 <308183d9-d8d6-0100-159b-8c8be8636b31@cn.fujitsu.com>
 <20171228025114.wdydzgppfikuo65z@D-69-91-141-110.dhcp4.washington.edu>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <0b98e96f-e176-9288-b54c-8ea908954c01@cn.fujitsu.com>
Date: Thu, 28 Dec 2017 18:23:39 +0800
MIME-Version: 1.0
In-Reply-To: <20171228025114.wdydzgppfikuo65z@D-69-91-141-110.dhcp4.washington.edu>
Content-Type: multipart/mixed;
        boundary="------------BFAF4E4E7F82FA873D423A56"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--------------BFAF4E4E7F82FA873D423A56
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexandru,

At 12/28/2017 10:51 AM, Alexandru Chirvasitu wrote:
> Ah, of course. Attached is the output of `journalctl --boot=-1` after
> booting, getting locked up, and then rebooting a good kernel.
> 
For the Hard lockups on both CPUs after login:

Please try the patch in the attachment by

git am ./0001-x86-vector-Replace-the-raw_spin_lock-with-raw_spin_l.patch

or

patch -p1 < 
./0001-x86-vector-Replace-the-raw_spin_lock-with-raw_spin_l.patch

> Slightly different version of 4.15-rc5; this one has both patches
> applied, yours and Linus' for kexec, but the latter shouldn't make a
> difference.
> 
> ---
> 
> You'll see another trace in there that's been bugging me, about W=X
> checking. I'm not qualified to judge how related they are, but during
> these past few days I've compiled and tested many kernels, and many of
> them have exhibited the W+X thing but*not*  the lockups.
> 

Yes, I found it, but I am not familiar with it and have no idea.

Thanks,
	dou.

---------------------8<--------------------------------------------



--------------BFAF4E4E7F82FA873D423A56
Content-Type: text/x-patch;
	name="0001-x86-vector-Replace-the-raw_spin_lock-with-raw_spin_l.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-x86-vector-Replace-the-raw_spin_lock-with-raw_spin_l.pa";
	filename*1="tch"

>From 57d8543ea4dcf2a53b1c37757da12866a52aaf57 Mon Sep 17 00:00:00 2001
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Thu, 28 Dec 2017 16:20:48 +0800
Subject: [PATCH] x86/vector: Replace the raw_spin_lock() with
 raw_spin_lock_irqsave()

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 arch/x86/kernel/apic/vector.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 750449152b04..a43ca26d5dfd 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -726,6 +726,7 @@ static int apic_set_affinity(struct irq_data *irqd,
 			     const struct cpumask *dest, bool force)
 {
 	struct apic_chip_data *apicd = apic_chip_data(irqd);
+	unsigned long flags;
 	int err;
 
 	/*
@@ -740,13 +741,13 @@ static int apic_set_affinity(struct irq_data *irqd,
 	    (apicd->is_managed || apicd->can_reserve))
 		return IRQ_SET_MASK_OK;
 
-	raw_spin_lock(&vector_lock);
+	raw_spin_lock_irqsave(&vector_lock, flags);
 	cpumask_and(vector_searchmask, dest, cpu_online_mask);
 	if (irqd_affinity_is_managed(irqd))
 		err = assign_managed_vector(irqd, vector_searchmask);
 	else
 		err = assign_vector_locked(irqd, vector_searchmask);
-	raw_spin_unlock(&vector_lock);
+	raw_spin_unlock_irqrestore(&vector_lock, flags);
 	return err ? err : IRQ_SET_MASK_OK;
 }
 
-- 
2.14.3


--------------BFAF4E4E7F82FA873D423A56--
