Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.w2.samsung.com ([211.189.100.11]:50398 "EHLO
	usmailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab3HOAWU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Aug 2013 20:22:20 -0400
Date: Wed, 14 Aug 2013 21:22:11 -0300
From: Mauro Carvalho Chehab <m.chehab@samsung.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Borislav Petkov <bp@alien8.de>, tony.luck@intel.com,
	bhelgaas@google.com, rostedt@goodmis.org, rjw@sisk.pl,
	lance.ortiz@hp.com, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error trace
 event
Message-id: <20130814212211.544ee6a4@concha.lan>
In-reply-to: <520B6282.6030906@linux.vnet.ibm.com>
References: <1375986471-27113-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <1375986471-27113-4-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <20130808163822.67e0828a@samsung.com> <20130810180322.GC4155@pd.tnic>
 <20130812083355.47c1bae8@samsung.com> <5208D80D.5030206@linux.vnet.ibm.com>
 <20130812125343.GE18018@pd.tnic> <520A16BD.30201@linux.vnet.ibm.com>
 <20130813124258.GC4077@pd.tnic> <520A6D98.9060204@linux.vnet.ibm.com>
 <20130813175809.GE4077@pd.tnic> <520B6282.6030906@linux.vnet.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Em Wed, 14 Aug 2013 16:27:06 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> escreveu:

> On 08/13/2013 11:28 PM, Borislav Petkov wrote:
> > On Tue, Aug 13, 2013 at 11:02:08PM +0530, Naveen N. Rao wrote:
> >> If I'm not mistaken, even for systems that have EDAC drivers, it looks
> >> to me like EDAC can't really decode to the DIMM given what is provided
> >> by the bios in the APEI report currently. If and when ghes_edac gains
> >> this capability, users will have a choice between raw APEI reports vs.
> >> edac processed ones.
> >
> > Which kinda makes that APEI tracepoint not really useful and we can call
> > the one we have already - trace_mc_event - from APEI...
> 
> This looks like a nice option. Mauro, what do you think?

I considered calling trace_mc_event directly in APEI, before writing ghes_edac.

I decided to implement it as a separate driver due to some reasons:

	1) EDAC core needs to know that it should reject "hardware first"
drivers. So, any solution would need to talk to EDAC core anyway (or we 
would need to write some other kind of resource allocation somewhere);

	2) EDAC userspace would need to detect the type of memory. Even
being crappy, the current way the memory is reported as a single contiguous
block at sysfs. So, EDAC userspace is aware that it can't decode the DIMM;

	3) If BIOS vendors add later some solution to enumerate the DIMMS
per memory controller, channel, socket with APEI, the addition to the
existing driver would be trivial.

So, while it would work to just call the tracing at APEI, on the current way,
I believe that having this part on a separate code is better.

Cheers,
Mauro
