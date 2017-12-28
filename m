Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:55814 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752693AbdL1CGk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Dec 2017 21:06:40 -0500
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
References: <20171220194506.GD24638@arch-chirva.localdomain>
 <20171221022356.GE24638@arch-chirva.localdomain>
 <1bd74ca3-afca-9d61-6911-61250f459891@cn.fujitsu.com>
 <20171222142053.3cbhi2nhh24w7yoo@D-69-91-141-110.dhcp4.washington.edu>
 <KL1P15301MB000676F3F8C9A5AC8C489E75BF020@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20171222222917.GA1138@arch-chirva.localdomain>
 <KL1P15301MB00064E9E767F9395744F42A3BF030@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <alpine.DEB.2.20.1712231432210.1853@nanos>
 <20171223200112.GC1138@arch-chirva.localdomain>
 <548c814c-7e24-00c0-3436-26f2704cb427@cn.fujitsu.com>
 <20171227161801.GE1410@arch-chirva.localdomain>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <308183d9-d8d6-0100-159b-8c8be8636b31@cn.fujitsu.com>
Date: Thu, 28 Dec 2017 10:06:25 +0800
MIME-Version: 1.0
In-Reply-To: <20171227161801.GE1410@arch-chirva.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alexandru,

Thanks for testing !
At 12/28/2017 12:18 AM, Alexandru Chirvasitu wrote:
> As per instructions, I did the following:
> 
> (1)
> 
> Checked out
> 
> 464e1d5 Linux 4.15-rc5
> 
> (after getting my copy up to date, fetching, pulling ,etc.) and
> compiled it as-is. Config attached (the one labeled 'np' for 'no
> patch').
> 
> Result:
> 
> Boot with no extraparameters locks up after login, as before;
> 
> apic=debug does not panic, but locks up after login, as before;
> 
I also hope to see the log with "apic=debug" by "journalctl" command,
though the logs don't have the lockup trace.

Thanks,
	dou.
> 
