Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:60828 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752905AbdL1LA6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Dec 2017 06:00:58 -0500
Date: Thu, 28 Dec 2017 12:00:47 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Alexandru Chirvasitu <achirvasub@gmail.com>
cc: Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        Mihai Costache <v-micos@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devel@linuxdriverproject.org, KY Srinivasan <kys@microsoft.com>
Subject: Re: PROBLEM: 4.15.0-rc3 APIC causes lockups on Core 2 Duo laptop
In-Reply-To: <20171220131929.GC24638@arch-chirva.localdomain>
Message-ID: <alpine.DEB.2.20.1712281145510.1688@nanos>
References: <20171218082011.GA24638@arch-chirva.localdomain> <20171218101131.GA5338@amd> <20171219083421.GB24638@arch-chirva.localdomain> <alpine.DEB.2.20.1712200124440.2282@nanos> <ec3a298b-27a3-f3fe-ea8d-a777669104ba@cn.fujitsu.com>
 <20171220131929.GC24638@arch-chirva.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 20 Dec 2017, Alexandru Chirvasitu wrote:
> On Wed, Dec 20, 2017 at 11:58:57AM +0800, Dou Liyang wrote:
> > At 12/20/2017 08:31 AM, Thomas Gleixner wrote:
> > > > I had never heard of 'bisect' before this casual mention (you might tell
> > > > I am a bit out of my depth). I've since applied it to Linus' tree between
> > > 
> > > > bebc608 Linux 4.14 (good)
> > > > 
> > > > and
> > > > 
> > > > 4fbd8d1 Linux 4.15-rc1 (bad)
> > > 
> > > Is Linus current head 4.15-rc4 bad as well?
> > > 
> > [...]
> 
> Yes. Exactly the same symptoms on
> 
> 1291a0d5 Linux 4.15-rc4
> 
> compiled just now from Linus' tree. 

Ok, lets take a step back. The bisect/kexec attempts led us away from the
initial problem which is the machine locking up after login, right?

Could you try the patch below on top of Linus tree (rc5+)?

Thanks,

	tglx

8<---------------
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -151,7 +151,7 @@ static struct apic apic_flat __ro_after_
 	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= flat_apic_id_registered,
 
-	.irq_delivery_mode		= dest_LowestPrio,
+	.irq_delivery_mode		= dest_Fixed,
 	.irq_dest_mode			= 1, /* logical */
 
 	.disable_esr			= 0,
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -105,7 +105,7 @@ static struct apic apic_default __ro_aft
 	.apic_id_valid			= default_apic_id_valid,
 	.apic_id_registered		= default_apic_id_registered,
 
-	.irq_delivery_mode		= dest_LowestPrio,
+	.irq_delivery_mode		= dest_Fixed,
 	/* logical delivery broadcast to all CPUs: */
 	.irq_dest_mode			= 1,
 
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -184,7 +184,7 @@ static struct apic apic_x2apic_cluster _
 	.apic_id_valid			= x2apic_apic_id_valid,
 	.apic_id_registered		= x2apic_apic_id_registered,
 
-	.irq_delivery_mode		= dest_LowestPrio,
+	.irq_delivery_mode		= dest_Fixed,
 	.irq_dest_mode			= 1, /* logical */
 
 	.disable_esr			= 0,
