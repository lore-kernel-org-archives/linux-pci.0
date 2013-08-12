Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.w2.samsung.com ([211.189.100.14]:43308 "EHLO
	usmailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755582Ab3HLOoN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2013 10:44:13 -0400
Date: Mon, 12 Aug 2013 11:44:04 -0300
From: Mauro Carvalho Chehab <m.chehab@samsung.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Borislav Petkov <bp@alien8.de>, tony.luck@intel.com,
	bhelgaas@google.com, rostedt@goodmis.org, rjw@sisk.pl,
	lance.ortiz@hp.com, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Aristeu Rozanski Filho <arozansk@redhat.com>
Subject: Re: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error trace
 event
Message-id: <20130812114404.3bd64fa0@samsung.com>
In-reply-to: <5208D80D.5030206@linux.vnet.ibm.com>
References: <1375986471-27113-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <1375986471-27113-4-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <20130808163822.67e0828a@samsung.com> <20130810180322.GC4155@pd.tnic>
 <20130812083355.47c1bae8@samsung.com> <5208D80D.5030206@linux.vnet.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Em Mon, 12 Aug 2013 18:11:49 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> escreveu:

> On 08/12/2013 05:03 PM, Mauro Carvalho Chehab wrote:
> > Em Sat, 10 Aug 2013 20:03:22 +0200
> > Borislav Petkov <bp@alien8.de> escreveu:
> >
> >> On Thu, Aug 08, 2013 at 04:38:22PM -0300, Mauro Carvalho Chehab wrote:
> >>> Em Thu, 08 Aug 2013 23:57:51 +0530
> >>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> escreveu:
> >>>
> >>>> Enable memory error trace event in cper.c
> >>>
> >>> Why do we need to do that? Memory error events are already handled
> >>> via edac_ghes module,
> >>
> >> If APEI gives me all the required information in order to deal with the
> >> hardware error - and it looks like it does - then the additional layer
> >> of ghes_edac is not needed.
> >
> > APEI is just the mechanism that collects the data, not the mechanism
> > that reports to userspace.
> 
> I think what Boris is saying is that ghes_edac isn't adding anything 
> more here given what we get from APEI structures. So, there doesn't seem 
> to be a need to add dependency on edac for this purpose.
> 
> Further, ghes_edac seems to require EDAC_MM_EDAC to be compiled into the 
> kernel (not a module). So, more dependencies.
> 
> >
> > The current implementation is that APEI already reports those errors
> > via ghes_edac driver. It also reports the very same error via MCE
> > (although the APEI interface to MCE is currently broken for everything
> > that it is not Nehalem-EX - as it basically emulates the MCE log for
> > that specific architecture).
> 
> So, I looked at ghes_edac and it basically seems to boil down to 
> trace_mc_event. 

Yes. It also provides the sysfs nodes that describe the memory.

> But, this only seems to expose the APEI data as a string 
> and doesn't look to really make all the fields available to user-space 
> in a raw manner. Not sure how well this can be utilised by a user-space 
> tool. Do you have suggestions on how we can do this?

There's already an userspace tool that handes it:
	https://git.fedorahosted.org/cgit/rasdaemon.git/

What is missing there on the current version is the bits that would allow
to translate from APEI way to report an error (memory node, card, module,
bank, device) into a DIMM label[1]. 

At the end, what really matters is to be able to point to the DIMM(s)
in a way that the user can replace them (e. g. using the silk screen
labels on the system motherboard).

[1] It does such translation for the other EDAC drivers, via a
configuration file that does such per-system mapping. Extending it to
also handle APEI errors shouldn't be hard.

> 
> Thanks,
> Naveen
> 


-- 

Cheers,
Mauro
