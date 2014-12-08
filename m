Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:41940 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405AbaLHVie (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Dec 2014 16:38:34 -0500
Message-ID: <1418074683.13358.1.camel@kernel.crashing.org>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Saifi Khan <saifi.khan@datasynergy.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	Marek =?ISO-8859-1?Q?Kord=EDk?= <kordikmarek@gmail.com>,
	Richard Yang <weiyang@linux.vnet.ibm.com>
Date: Tue, 09 Dec 2014 08:38:03 +1100
In-Reply-To: <CAErSpo69c6jXOp+nw2sTSU4vgqGufUQNUEGK4_2+6p-qpyE0vQ@mail.gmail.com>
References: <CAErSpo6UvY10MNidAOFf4Fptv+wL-NsX6JMaU8OvSP6ywWEebQ@mail.gmail.com>
	 <CAErSpo63uZeo1feoPjjXpdH43nsbcWh63kpBmxCnckPd0t9yrg@mail.gmail.com>
	 <CAE9FiQWV-rKdvSeV-ivME-64QtzCX2Te5DfOVtzr0an=6eOCMA@mail.gmail.com>
	 <20141204173411.GA5949@google.com>
	 <CAE9FiQVyBmo+XwDgO97wwe+6TN4+q_cvnBLCuhTM8Fu_e_V5RQ@mail.gmail.com>
	 <1417777177.4741.69.camel@kernel.crashing.org>
	 <20141208004735.GA15508@shangw>
	 <CAErSpo69c6jXOp+nw2sTSU4vgqGufUQNUEGK4_2+6p-qpyE0vQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2014-12-08 at 14:04 -0700, Bjorn Helgaas wrote:
> 
> However, I think 5b28541552ef is taking the wrong approach.  Consider
> a device that, like this Radeon, has a 32-bit prefetchable BAR.  If
> the upstream bridge has a 32-bit prefetchable window, things work as
> expected -- we put the prefetchable BAR in the prefetchable window.
> But if the bridge has a 64-bit prefetchable window, we put that same
> BAR in a 32-bit non-prefetchable window.

Well, that's expected, unless the 64-bit prefetchable window happens to
be fully enclosed in 32-bit space ... So maybe the approach is to check
that this is the case and "downgrade" such 64-bit prefetchable BARs to
32-bit ...

Cheers,
Ben.


> So we upgraded the system with a better bridge, i.e., it supports a
> full 64-bit window instead of just a 32-bit window, and the system
> performs WORSE.  That's what I think is fundamentally broken.
> 
> > Looking at bug#85491 and the logs from Marek, BIOS didn't configure
> windows
> > and BARs for PCI bridge and adapters properly, which forces the
> kernel to
> > reassign those BARs/windows failing to be claimed previously. If I'm
> correct,
> > we need a way to reassign the bridge's non-prefetchable window and
> with it,
> > find_free_bus_resource() needn't check on "!r->parent".
> 
> It's true that the BIOS didn't configure things correctly.  But we
> can't use that as an excuse; the kernel should be able to configure
> things correctly itself because there are plenty of machines where the
> BIOS never configures things.


