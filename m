Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:62601 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118Ab3EVRWH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 May 2013 13:22:07 -0400
Received: by mail-ob0-f175.google.com with SMTP id wo10so2662607obc.6
        for <linux-pci@vger.kernel.org>; Wed, 22 May 2013 10:22:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWsZXfkSSVFzee4-J4bUDP8DdG=y9-k2du+ek90StDvNA@mail.gmail.com>
References: <1367712653.11982.19.camel@pasglop> <1367712932.11982.20.camel@pasglop>
 <CAE9FiQX=h4H1gcbW=EfQo_ZtAgHGOZ2GxVxLG59C1iMH+qgH2g@mail.gmail.com>
 <1367732090.11982.38.camel@pasglop> <CAE9FiQUN3qqVmdw_EdOC-JZGc219M3tu=roOX98xns+77LJhMw@mail.gmail.com>
 <1367740336.11982.41.camel@pasglop> <51871088.4594420a.0ccc.7300SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAE9FiQXGUOM_h_X5tdGbkiuZGZkiFigSLbbftx3YXybFBg6trg@mail.gmail.com>
 <518786a7.64bbec0a.58a0.1f6bSMTPIN_ADDED_BROKEN@mx.google.com>
 <CAErSpo5MJCoaof=heFM4vLxuWz8pFqsyXAC356jZ7rbRvSOt9g@mail.gmail.com> <CAE9FiQWsZXfkSSVFzee4-J4bUDP8DdG=y9-k2du+ek90StDvNA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 22 May 2013 11:21:45 -0600
Message-ID: <CAErSpo45wXjnDiXiZ1qs+Z7fsEoVmAxbjhGVvtZGEUkbd4bNKg@mail.gmail.com>
Subject: Re: Resource assignment oddities
To: Yinghai Lu <yinghai@kernel.org>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 22, 2013 at 10:59 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, May 22, 2013 at 7:54 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> What exactly is the problem here?  Is it just that you don't want to
>> see the "can't assign" messages?  Or is there a device with a BAR that
>> *should* be assigned, but isn't?  If so, which device is it?
>
> We try must+optional as first, then if there is any ioport or mmio fail
> we will stick to must only then extend must to meet optional.
> but mmio range and mmio-pref could be connected each other,
> so extend will fail...
>
> problem here, some root bus will not have ioport range, so it will always have
> ioport allocation fail.
>
> looks like right fix for v3.9 should be as attached patch.
> it will keep must+optional for mmio, if only ioport fails....

I read all that before, but it didn't answer my questions.  I assume
we're trying to fix a device that doesn't work.  Which device is it?

Bjorn
