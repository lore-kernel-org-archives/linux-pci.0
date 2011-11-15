Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57636 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753897Ab1KOVw5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Nov 2011 16:52:57 -0500
Subject: Re: [PATCH] pci: Workaround Stratus broken PCIE hierarchy
From: Myron Stowe <mstowe@redhat.com>
To: James Paradis <jparadis@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>,
	Rolf Eike Beer <eike-kernel@sf-tec.de>,
	Matthew Wilcox <matthew@wil.cx>,
	Don Dutile <ddutile@redhat.com>, linux-pci@vger.kernel.org,
	jbarnes@virtuousgeek.org, Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <00c3e8bb-bb13-41e4-a3a9-65d21bc8defa@zmail15.collab.prod.int.phx2.redhat.com>
References: <00c3e8bb-bb13-41e4-a3a9-65d21bc8defa@zmail15.collab.prod.int.phx2.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 15 Nov 2011 14:52:28 -0700
Message-ID: <1321393949.2417.181.camel@zim.stowe>
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2011-11-15 at 16:08 -0500, James Paradis wrote:
> > Bjorn,
> > 
> > > 
> > > Is this problem a regression?  If so, what commit caused it?
> > > f07852d6442, which introduced only_one_child()?
> > 
> > That's a tough question to answer.  AFAICT the broken (HARDWARE
> > broken) Stratus systems only enumerated properly by chance.  Did
> > they work prior to f07852d6?  From what jparadis told me, yes.  Is
> > it a regression? ... depends on how you look at it.
> 
> Yes, that is the commit that caused the problem.  
> 
> > > Does Windows work on this system?
> > 
> > I don't know.  jparadis?  Any clue?
> 
> Windows works just fine on this system, probably because they 
> don't optimize the PCIE scan in this way...
> 
> > > Is this something that could be fixed by a firmware upgrade?  If
> > > so,
> > > is there a Stratus/NEC bug report?
> > 
> > Hmmm, the idea of a FW upgrade somehow fixing this never occurred to
> > me.  jparadis?  Is that possible?
> 
> I seriously doubt it, but I can ask the hardware folks at Stratus.
> I believe that at least some of this topology is baked in...

James,

I think a lot of people are wondering why this is only now coming up as
the patch in question has been upstream for a couple of years.

While the system has been in the field for awhile - has the I/O
subsystem that exhibits this issue been there since the introduction of
this type of system -or- is there a new, PCI Express based, I/O
subsystem now being introduced that can be used with the original
platform and this is why we are just now seeing the issue?

Myron
> 
> > > Is there a Red Hat bugzilla URL you could include?
> > 
> > Only happens upstream.
> 
> Well, to be fair, we actually saw this behavior beginning with 
> Fedora 14, but never pursued the matter until now.  I suppose
> we could have filed a Fedora bug, but we wanted to root-cause the
> problem first.
> 
> --jim
> 


