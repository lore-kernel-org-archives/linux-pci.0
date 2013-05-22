Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:51110 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756925Ab3EVVN1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 May 2013 17:13:27 -0400
Message-ID: <1369257193.3870.23.camel@pasglop>
Subject: Re: Resource assignment oddities
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Thu, 23 May 2013 07:13:13 +1000
In-Reply-To: <CAE9FiQU48-t5HP8w29gL7JY0eqa=fS=jhCU7bRU2hvMt0iRy6A@mail.gmail.com>
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
	 <1369255424.3870.18.camel@pasglop>
	 <CAE9FiQU48-t5HP8w29gL7JY0eqa=fS=jhCU7bRU2hvMt0iRy6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2013-05-22 at 14:00 -0700, Yinghai Lu wrote:
> > The simpler thing to do would have been to do the entire thing in two
> > separate passes, one for MMIO and one for IO, and skip the second one
> > entirely if there's no IO at the host bridge level :-)
> 
> that will need more changes.
> 
> also how about hostbridge only has mmio pref 64bit?

MMIO pref and non-pref are somewhat linked, I'm not saying you should
separate them or change your design, but IO should have absolutely no
impact.

Anyway, that's how it should have been... probably too late to change.

Ben.


