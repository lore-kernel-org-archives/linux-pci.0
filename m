Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:22460 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757045AbdLXD3u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Dec 2017 22:29:50 -0500
Subject: Re: PROBLEM: 4.15.0-rc3 APIC causes lockups on Core 2 Duo laptop
To: Thomas Gleixner <tglx@linutronix.de>,
        Dexuan Cui <decui@microsoft.com>
CC: Alexandru Chirvasitu <achirvasub@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
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
References: <20171218101131.GA5338@amd>
 <20171219083421.GB24638@arch-chirva.localdomain>
 <alpine.DEB.2.20.1712200124440.2282@nanos>
 <ec3a298b-27a3-f3fe-ea8d-a777669104ba@cn.fujitsu.com>
 <20171220131929.GC24638@arch-chirva.localdomain>
 <20171220194506.GD24638@arch-chirva.localdomain>
 <20171221022356.GE24638@arch-chirva.localdomain>
 <1bd74ca3-afca-9d61-6911-61250f459891@cn.fujitsu.com>
 <20171222142053.3cbhi2nhh24w7yoo@D-69-91-141-110.dhcp4.washington.edu>
 <KL1P15301MB000676F3F8C9A5AC8C489E75BF020@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20171222222917.GA1138@arch-chirva.localdomain>
 <KL1P15301MB00064E9E767F9395744F42A3BF030@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <alpine.DEB.2.20.1712231432210.1853@nanos>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <5de54d9c-236a-eed8-f0c3-618269442c07@cn.fujitsu.com>
Date: Sun, 24 Dec 2017 11:29:45 +0800
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1712231432210.1853@nanos>
Content-Type: text/plain; charset="gbk"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Thomas,

At 12/23/2017 09:32 PM, Thomas Gleixner wrote:
[...]
>>
>> The BUG_ON panic happens at line 147:
>>                     BUG_ON(!test_and_clear_bit(bit, cm->alloc_map));
>>
>> I'm sure Thomas and Dou know it better than me.
> 
> I'll have a look after the holidays.
> 

Merry Christmas!  :-)

I am trying to look into it.

Thanks,
	dou
