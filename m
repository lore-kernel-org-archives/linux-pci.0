Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 12 Aug 2013 14:25:57 -0300
From: Mauro Carvalho Chehab <m.chehab@samsung.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	tony.luck@intel.com, bhelgaas@google.com, rostedt@goodmis.org,
	rjw@sisk.pl, lance.ortiz@hp.com, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error trace
 event
Message-id: <20130812142557.2a43f155@samsung.com>
In-reply-to: <20130812150424.GH18018@pd.tnic>
References: <1375986471-27113-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <1375986471-27113-4-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <20130808163822.67e0828a@samsung.com> <20130810180322.GC4155@pd.tnic>
 <20130812083355.47c1bae8@samsung.com> <20130812123813.GD18018@pd.tnic>
 <20130812114932.52bb0314@samsung.com> <20130812150424.GH18018@pd.tnic>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Em Mon, 12 Aug 2013 17:04:24 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Mon, Aug 12, 2013 at 11:49:32AM -0300, Mauro Carvalho Chehab wrote:
> > Clear win from what PoV? Userspace will need to decode a different type
> > of tracing, and implement a different logic for APEI.
> 
> There's no different type of tracing - it is the same info as in both
> cases it comes from APEI.

Well, patch 2/3 is defining a different type of tracing for memory errors,
instead of re-using the existing one.

> And if it can be done in the APEI layer, then
> we don't need the next layer.

Userspace still needs the EDAC sysfs, in order to identify how the memory
is organized, and do the proper memory labels association.

What edac_ghes does is to fill those sysfs nodes, and to call the
existing tracing to report errors.

> > Also, if both ghes_edac and this new tracing is enabled, userspace
> > will receive twice the same event, as two traces will be received for
> > the same thing.
> 
> We are, of course, going to have only one tracepoint which reports
> memory errors, not two.

Yes, that's my point.

Regards,
Mauro
