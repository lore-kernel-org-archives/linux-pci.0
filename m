Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50139 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757138Ab1KOS0f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Nov 2011 13:26:35 -0500
Message-ID: <4EC2AE9A.1030208@redhat.com>
Date: Tue, 15 Nov 2011 13:25:30 -0500
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Rolf Eike Beer <eike-kernel@sf-tec.de>,
	Matthew Wilcox <matthew@wil.cx>,
	Don Dutile <ddutile@redhat.com>,
	James Paradis <jparadis@redhat.com>, linux-pci@vger.kernel.org,
	mstowe@redhat.com, jbarnes@virtuousgeek.org
Subject: Re: [PATCH] pci: Workaround Stratus broken PCIE hierarchy
References: <bd3514f0-1a80-45ac-a08e-b327a367b276@zmail15.collab.prod.int.phx2.redhat.com> <4EBD73C8.8070407@redhat.com> <CAErSpo5eZ=4yqnMFpFjTOqGvK6p4mOmsppJbodeGe+vkjfKdbw@mail.gmail.com> <4EBD8714.30401@redhat.com> <4EC12962.2040105@redhat.com> <20111114181418.GE4387@parisc-linux.org> <4EC28B93.1060101@redhat.com> <af06626e34e32043e3c4974290270ec1.squirrel@webmail.sf-mail.de> <CAErSpo5=YFNMcDt59JU2HQJV2EZpy1khLLCxyPAf49w8m4=kOA@mail.gmail.com>
In-Reply-To: <CAErSpo5=YFNMcDt59JU2HQJV2EZpy1khLLCxyPAf49w8m4=kOA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

> 
> Is this problem a regression?  If so, what commit caused it?
> f07852d6442, which introduced only_one_child()?

That's a tough question to answer.  AFAICT the broken (HARDWARE broken) Stratus systems only enumerated properly by chance.  Did they work prior to f07852d6?  From what jparadis told me, yes.  Is it a regression? ... depends on how you look at it.

> 
> Does Windows work on this system?

I don't know.  jparadis?  Any clue?

> 
> Is this something that could be fixed by a firmware upgrade?  If so,
> is there a Stratus/NEC bug report?

Hmmm, the idea of a FW upgrade somehow fixing this never occurred to me.  jparadis?  Is that possible?

> 
> Is there a Red Hat bugzilla URL you could include?

Only happens upstream.

> 
> What bad things would happen if we just turned on this
> Stratus-specific behavior all the time on all systems?  It looks like
> f07852d6442 is basically an optimization that makes pci_scan_slot()
> faster, so I assume one effect would be to slow down PCI enumeration
> for everybody.  By how much?

Not a huge amount -- estimated lt 0.5 seconds on this Stratus system.  As for other systems, it obviously depends on how complicated the PCIE hierarchy is.

P.
