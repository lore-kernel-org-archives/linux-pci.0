Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:39010 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755651Ab3EVUpY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 May 2013 16:45:24 -0400
Message-ID: <1369255489.3870.19.camel@pasglop>
Subject: Re: Resource assignment oddities
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Thu, 23 May 2013 06:44:49 +1000
In-Reply-To: <CAErSpo45wXjnDiXiZ1qs+Z7fsEoVmAxbjhGVvtZGEUkbd4bNKg@mail.gmail.com>
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
	 <CAErSpo45wXjnDiXiZ1qs+Z7fsEoVmAxbjhGVvtZGEUkbd4bNKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2013-05-22 at 11:21 -0600, Bjorn Helgaas wrote:
> > looks like right fix for v3.9 should be as attached patch.
> > it will keep must+optional for mmio, if only ioport fails....
> 
> I read all that before, but it didn't answer my questions.  I assume
> we're trying to fix a device that doesn't work.  Which device is it?

We have MMIO assignment failures due to the "retry" but so far it hasn't
prevented the devices I have tested from working. It does make me very
nervous however.

Gavin, do you have more details about what actually happens ?

Cheers,
Ben.


