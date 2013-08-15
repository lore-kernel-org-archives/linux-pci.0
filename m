Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 15 Aug 2013 10:26:07 -0300
From: Mauro Carvalho Chehab <m.chehab@samsung.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	tony.luck@intel.com, bhelgaas@google.com, rostedt@goodmis.org,
	rjw@sisk.pl, lance.ortiz@hp.com, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error trace
 event
Message-id: <20130815102607.7168a930@samsung.com>
In-reply-to: <20130815093831.GA27616@pd.tnic>
References: <20130810180322.GC4155@pd.tnic>
 <20130812083355.47c1bae8@samsung.com> <5208D80D.5030206@linux.vnet.ibm.com>
 <20130812125343.GE18018@pd.tnic> <520A16BD.30201@linux.vnet.ibm.com>
 <20130813124258.GC4077@pd.tnic> <520A6D98.9060204@linux.vnet.ibm.com>
 <20130813175809.GE4077@pd.tnic> <520B6282.6030906@linux.vnet.ibm.com>
 <20130814212211.544ee6a4@concha.lan> <20130815093831.GA27616@pd.tnic>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Em Thu, 15 Aug 2013 11:38:31 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Wed, Aug 14, 2013 at 09:22:11PM -0300, Mauro Carvalho Chehab wrote:
> > 	1) EDAC core needs to know that it should reject "hardware first"
> > drivers.
> 
> -ENOPARSE. What do you mean?

I mean that the edac core needs to know that, on a given system, the
BIOS is accessing the hardware registers and sending the data via ghes_edac.

On such case, it should reject the driver that reads such data directly
from the hardware, as having both active cause inconsistent error reports
(I got a few BZ reports about that).

> >  3) If BIOS vendors add later some solution to enumerate the DIMMS
> > per memory controller, channel, socket with APEI, the addition to the
> > existing driver would be trivial.
> 
> Actually, with BIOS vendors wanting to do firmware-first strategy with
> DRAM errors, they must have a pretty good and intimate picture of the
> memory topology at hand. So it is only a logical consequence for them,
> when reporting a memory error to the OS to tell us the silkscreen label
> too, while at it.
> 
> And if they do that, we don't need the additional layer - just a
> tracepoint from APEI and a userspace script.

No. As we want that fatal errors to also be properly reported, the
kernel will still need to know the memory layout.

Ok, such information can come via userspace, just like we do with the
other EDAC drivers, but we'll need to allow to dynamically create the
memory layout via sysfs (or to use some other interface for loading that
data).

> It's a whole another question if they don't do that.

-- 

Cheers,
Mauro
