Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sg2apc01on0123.outbound.protection.outlook.com ([104.47.125.123]:57189
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751229AbdL1TBk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Dec 2017 14:01:40 -0500
From: Dexuan Cui <decui@microsoft.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Alexandru Chirvasitu <achirvasub@gmail.com>
CC: Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        "Mihai Costache (Cloudbase Solutions SRL)" <v-micos@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: PROBLEM: 4.15.0-rc3 APIC causes lockups on Core 2 Duo laptop
Date: Thu, 28 Dec 2017 19:01:02 +0000
Message-ID: <KL1P15301MB00063D165782C59828A0C2F1BF040@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <20171218082011.GA24638@arch-chirva.localdomain>
 <20171218101131.GA5338@amd> <20171219083421.GB24638@arch-chirva.localdomain>
 <alpine.DEB.2.20.1712200124440.2282@nanos>
 <ec3a298b-27a3-f3fe-ea8d-a777669104ba@cn.fujitsu.com>
 <20171220131929.GC24638@arch-chirva.localdomain>
 <alpine.DEB.2.20.1712281201210.1688@nanos>
In-Reply-To: <alpine.DEB.2.20.1712281201210.1688@nanos>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Thomas Gleixner [mailto:tglx@linutronix.de]
> Sent: Thursday, December 28, 2017 03:03
> > > On Wed, Dec 20, 2017 at 02:12:05AM +0000, Dexuan Cui wrote:
>=20
> > > For Linux VM running on Hyper-V, we did get "spurious APIC interrupt
> > > through vector " and a patchset, which included the patch you identif=
ed
> > > ("genirq: Add config option for reservation mode"), was made to fix t=
he
> > > issue. But since you're using a physical machine rathter than a VM, I
> > > suspect it should be a different issue.
>=20
> Aaargh! Why was this never reported and where is that magic patchset?
> 	tglx

Hi Thomas,
The Hyper-V specific issue was reported and you made a patchset to fix it:
https://patchwork.kernel.org/patch/10006171/
https://lkml.org/lkml/2017/10/17/120


Thanks,
-- Dexuan
