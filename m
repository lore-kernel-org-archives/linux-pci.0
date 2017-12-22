Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pu1apc01on0139.outbound.protection.outlook.com ([104.47.126.139]:22880
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755934AbdLVVby (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Dec 2017 16:31:54 -0500
From: Dexuan Cui <decui@microsoft.com>
To: Alexandru Chirvasitu <achirvasub@gmail.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>,
        "kernel list" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        "Mihai Costache (Cloudbase Solutions SRL)" <v-micos@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Simon Xiao" <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "Jork Loeser" <Jork.Loeser@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: PROBLEM: 4.15.0-rc3 APIC causes lockups on Core 2 Duo laptop
Date: Fri, 22 Dec 2017 21:31:28 +0000
Message-ID: <KL1P15301MB000676F3F8C9A5AC8C489E75BF020@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <20171218082011.GA24638@arch-chirva.localdomain>
 <20171218101131.GA5338@amd> <20171219083421.GB24638@arch-chirva.localdomain>
 <alpine.DEB.2.20.1712200124440.2282@nanos>
 <ec3a298b-27a3-f3fe-ea8d-a777669104ba@cn.fujitsu.com>
 <20171220131929.GC24638@arch-chirva.localdomain>
 <20171220194506.GD24638@arch-chirva.localdomain>
 <20171221022356.GE24638@arch-chirva.localdomain>
 <1bd74ca3-afca-9d61-6911-61250f459891@cn.fujitsu.com>
 <20171222142053.3cbhi2nhh24w7yoo@D-69-91-141-110.dhcp4.washington.edu>
In-Reply-To: <20171222142053.3cbhi2nhh24w7yoo@D-69-91-141-110.dhcp4.washington.edu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Alexandru Chirvasitu [mailto:achirvasub@gmail.com]
> Sent: Friday, December 22, 2017 06:21
>=20
> In the absence of logs, the best I can do at the moment is attach a
> picture of the screen I am presented with on the apic=3Ddebug boot
> attempt.
> Alex

The panic happens in irq_matrix_assign_system+0x4e/0xd0 in your picture.
IMO we should find which line of code causes the panic. I suppose
"objdump -D kernel/irq/matrix.o" can help to do that.

Thanks,
-- Dexuan
