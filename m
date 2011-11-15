Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:32958 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932298Ab1KOVJA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2011 16:09:00 -0500
Date: Tue, 15 Nov 2011 16:08:50 -0500 (EST)
From: James Paradis <jparadis@redhat.com>
To: Prarit Bhargava <prarit@redhat.com>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>,
	Matthew Wilcox <matthew@wil.cx>,
	Don Dutile <ddutile@redhat.com>, linux-pci@vger.kernel.org,
	mstowe@redhat.com, jbarnes@virtuousgeek.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci: Workaround Stratus broken PCIE hierarchy
Message-ID: <00c3e8bb-bb13-41e4-a3a9-65d21bc8defa@zmail15.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4EC2AE9A.1030208@redhat.com>
Content-Type: text/plain; charset=utf-8
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> Bjorn,
> 
> > 
> > Is this problem a regression?  If so, what commit caused it?
> > f07852d6442, which introduced only_one_child()?
> 
> That's a tough question to answer.  AFAICT the broken (HARDWARE
> broken) Stratus systems only enumerated properly by chance.  Did
> they work prior to f07852d6?  From what jparadis told me, yes.  Is
> it a regression? ... depends on how you look at it.

Yes, that is the commit that caused the problem.  

> > Does Windows work on this system?
> 
> I don't know.  jparadis?  Any clue?

Windows works just fine on this system, probably because they 
don't optimize the PCIE scan in this way...

> > Is this something that could be fixed by a firmware upgrade?  If
> > so,
> > is there a Stratus/NEC bug report?
> 
> Hmmm, the idea of a FW upgrade somehow fixing this never occurred to
> me.  jparadis?  Is that possible?

I seriously doubt it, but I can ask the hardware folks at Stratus.
I believe that at least some of this topology is baked in...

> > Is there a Red Hat bugzilla URL you could include?
> 
> Only happens upstream.

Well, to be fair, we actually saw this behavior beginning with 
Fedora 14, but never pursued the matter until now.  I suppose
we could have filed a Fedora bug, but we wanted to root-cause the
problem first.

--jim

