Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.w2.samsung.com ([211.189.100.11]:39316 "EHLO
	usmailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756770Ab3HMMmZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Aug 2013 08:42:25 -0400
Date: Tue, 13 Aug 2013 09:41:47 -0300
From: Mauro Carvalho Chehab <m.chehab@samsung.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Borislav Petkov <bp@alien8.de>, tony.luck@intel.com,
	bhelgaas@google.com, rostedt@goodmis.org, rjw@sisk.pl,
	lance.ortiz@hp.com, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Aristeu Rozanski Filho <arozansk@redhat.com>
Subject: Re: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error trace
 event
Message-id: <20130813094147.062317f8@concha.lan>
In-reply-to: <520A1B5E.8040105@linux.vnet.ibm.com>
References: <1375986471-27113-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <1375986471-27113-4-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <20130808163822.67e0828a@samsung.com> <20130810180322.GC4155@pd.tnic>
 <20130812083355.47c1bae8@samsung.com> <5208D80D.5030206@linux.vnet.ibm.com>
 <20130812114404.3bd64fa0@samsung.com> <520A1B5E.8040105@linux.vnet.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Em Tue, 13 Aug 2013 17:11:18 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> escreveu:

> On 08/12/2013 08:14 PM, Mauro Carvalho Chehab wrote:
> >> But, this only seems to expose the APEI data as a string
> >> and doesn't look to really make all the fields available to user-space
> >> in a raw manner. Not sure how well this can be utilised by a user-space
> >> tool. Do you have suggestions on how we can do this?
> >
> > There's already an userspace tool that handes it:
> > 	https://git.fedorahosted.org/cgit/rasdaemon.git/
> >
> > What is missing there on the current version is the bits that would allow
> > to translate from APEI way to report an error (memory node, card, module,
> > bank, device) into a DIMM label[1].
> 
> If I'm reading this right, all APEI data seems to be squashed into a 
> string in mc_event.

Yes. We had lots of discussion about how to map memory errors over the
last couple years. Basically, it was decided that the information that
could be decoded into a DIMM to be mapped as integers, and all other
driver-specific data to be added as strings.

On the tests I did, different machines/vendors fill the APEI data on
a different way, with makes harder to associate them to a DIMM.

> Also, the fru id/text don't seem to be passed to user-space.

That's likely because on the systems I tested, those fields were not
filled (or maybe they appeared on a latter ACPI version). We should add
them also the same string as the other fields there at ghes_edac.

Regards,
Mauro
