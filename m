Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38993 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389Ab3EVUoG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 May 2013 16:44:06 -0400
Message-ID: <1369255424.3870.18.camel@pasglop>
Subject: Re: Resource assignment oddities
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Thu, 23 May 2013 06:43:44 +1000
In-Reply-To: <CAE9FiQWsZXfkSSVFzee4-J4bUDP8DdG=y9-k2du+ek90StDvNA@mail.gmail.com>
References: <1367712653.11982.19.camel@pasglop>
	 <1367712932.11982.20.camel@pasglop>
	 <CAE9FiQX=h4H1gcbW=EfQo_ZtAgHGOZ2GxVxLG59C1iMH+qgH2g@mail.gmail.com>
	 <1367732090.11982.38.camel@pasglop>
	 <CAE9FiQUN3qqVmdw_EdOC-JZGc219M3tu=roOX98xns+77LJhMw@mail.gmail.com>
	 <1367740336.11982.41.camel@pasglop>
	 <51871088.4594420a.0ccc.7300SMTPIN_ADDED_BROKEN@mx.google.com>
	 <CAE9FiQXGUOM_h_X5tdGbkiuZGZkiFigSLbbftx3YXybFBg6trg@mail.gmail.com>
	 <518786a7.64bbec0a.58a0.1f6bSMTPIN_ADDED_BROKEN@mx.google.com>
	 <CAErSpo5MJCoaof=heFM4vLxuWz8pFqsyXAC356jZ7rbRvSOt9g@mail.gmail.com>
	 <CAE9FiQWsZXfkSSVFzee4-J4bUDP8DdG=y9-k2du+ek90StDvNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2013-05-22 at 09:59 -0700, Yinghai Lu wrote:
> On Wed, May 22, 2013 at 7:54 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > What exactly is the problem here?  Is it just that you don't want to
> > see the "can't assign" messages?  Or is there a device with a BAR that
> > *should* be assigned, but isn't?  If so, which device is it?
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

The simpler thing to do would have been to do the entire thing in two
separate passes, one for MMIO and one for IO, and skip the second one
entirely if there's no IO at the host bridge level :-)

Cheers,
Ben.


