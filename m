Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:47172 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbaDPRQD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Apr 2014 13:16:03 -0400
Received: by mail-ig0-f171.google.com with SMTP id c1so1284789igq.16
        for <linux-pci@vger.kernel.org>; Wed, 16 Apr 2014 10:16:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1397629987.32730.9.camel@pasglop>
References: <CAE9FiQXzRQ9S0mwwb58R2icBTtHHJ6NMVFMaxEgtVNP9mZVjZw@mail.gmail.com>
 <1394222924-28886-1-git-send-email-yinghai@kernel.org> <CAErSpo6r16va7oBpaDcTXw0Y0igc=NbXy9G7c27X+P0UM7fh8g@mail.gmail.com>
 <20140408025738.GA3198@yanx> <CAErSpo4JSrjSn4dXC9Pzfz2Aho+W4Gq9uKc+kAFbqTERcRAJ+w@mail.gmail.com>
 <20140409075215.GA3173@yanx> <CAErSpo4aGU_rmNSiv=HS-pDVsfKk798zLQW8Kx5huHe8jwdghw@mail.gmail.com>
 <20140415115450.GA7792@yanx> <CAErSpo63LKffb4DH+cSfBnvtAoPy06u22e7CUhRuKr-PHNWZMw@mail.gmail.com>
 <1397629816.32730.8.camel@pasglop> <1397629987.32730.9.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 16 Apr 2014 11:15:42 -0600
Message-ID: <CAErSpo676pcHWyEtjJaPjfARB3iJd2qBPPqAzP45+z8RxD3VGA@mail.gmail.com>
Subject: Re: [PATCH v7] PCI: Try best to allocate pref mmio 64bit above 4g
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Guo Chao <yan@linux.vnet.ibm.com>, Yinghai Lu <yinghai@kernel.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Amir Vadai <amirv@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Eugenia Emantayev <eugenia@mellanox.com>, talal@mellanox.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 16, 2014 at 12:33 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2014-04-16 at 16:30 +1000, Benjamin Herrenschmidt wrote:
>> On Tue, 2014-04-15 at 18:09 -0600, Bjorn Helgaas wrote:
>> >
>> > Thanks for the example.  Please open a bug report at
>> > http://bugzilla.kernel.org and attach the complete dmesg logs before
>> > and after Yinghai's patch.
>> >
>> > Having the complete logs helps me answer questions myself without
>> > having to bother you, and it also helps me figure out whether we can
>> > improve our logging to make it easier to diagnose problems like this.
>>
>> Unfortunately, for a *little while* longer (hint !) we can't publish
>> a complete log from a Power8 machine, but we should be able to include
>> everything remotely related to PCI.
>
> Hrm, actually, I'm not sure we can disclose the device details just yet,
> so let's just hide the vendor/device ID to make the lawyers happy and
> you can print all the rest.

Sure, no problem (and it looks like Guo has done just that with
https://bugzilla.kernel.org/show_bug.cgi?id=74151).

I'm pretty sure this problem is not specific to your secret hardware;
it should be reproducible on any hardware with similar apertures and
similar BARs.  I am a little concerned about the PE implications, but
I'm ignoring that for now until we sort out the first-order problem of
getting the allocation scheme to work.
