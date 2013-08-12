Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.w2.samsung.com ([211.189.100.11]:10388 "EHLO
	usmailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755720Ab3HLOtl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2013 10:49:41 -0400
Date: Mon, 12 Aug 2013 11:49:32 -0300
From: Mauro Carvalho Chehab <m.chehab@samsung.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	tony.luck@intel.com, bhelgaas@google.com, rostedt@goodmis.org,
	rjw@sisk.pl, lance.ortiz@hp.com, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error trace
 event
Message-id: <20130812114932.52bb0314@samsung.com>
In-reply-to: <20130812123813.GD18018@pd.tnic>
References: <1375986471-27113-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <1375986471-27113-4-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <20130808163822.67e0828a@samsung.com> <20130810180322.GC4155@pd.tnic>
 <20130812083355.47c1bae8@samsung.com> <20130812123813.GD18018@pd.tnic>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Em Mon, 12 Aug 2013 14:38:13 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Mon, Aug 12, 2013 at 08:33:55AM -0300, Mauro Carvalho Chehab wrote:
> > APEI is just the mechanism that collects the data, not the mechanism
> > that reports to userspace.
> 
> Both methods add a tracepoint - no difference.
> 
> > I really don't see any sense on adding yet-another-way to report the
> > very same error.
> 
> Well, your suggested way through the layers is this:
> 
> Hardware->APEI->EDAC.
> 
> His is
> 
> Hardware->APEI.
> 
> If I can lose the EDAC layer, then this is a clear win.

Clear win from what PoV? Userspace will need to decode a different type
of tracing, and implement a different logic for APEI. So, it will be
reinventing the wheel, with a different trace format, and will require
userspace to implement another tracing event for the same thing that
EDAC already provides.

Also, if both ghes_edac and this new tracing is enabled, userspace will
receive twice the same event, as two traces will be received for the
same thing.

Worse than that, how userspace is supposed to merge those two events
into one?
> 


-- 

Cheers,
Mauro
