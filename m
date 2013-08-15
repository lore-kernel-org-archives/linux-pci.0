Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 14 Aug 2013 21:05:32 -0300
From: Mauro Carvalho Chehab <m.chehab@samsung.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Luck, Tony" <tony.luck@intel.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"rjw@sisk.pl" <rjw@sisk.pl>,
	"lance.ortiz@hp.com" <lance.ortiz@hp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error trace
 event
Message-id: <20130814210532.18fd280b@concha.lan>
In-reply-to: <20130814054322.GA9158@pd.tnic>
References: <20130812083355.47c1bae8@samsung.com>
 <5208D80D.5030206@linux.vnet.ibm.com> <20130812125343.GE18018@pd.tnic>
 <520A16BD.30201@linux.vnet.ibm.com> <20130813124258.GC4077@pd.tnic>
 <520A6D98.9060204@linux.vnet.ibm.com> <20130813175809.GE4077@pd.tnic>
 <3908561D78D1C84285E8C5FCA982C28F31CB8F53@ORSMSX106.amr.corp.intel.com>
 <20130813181004.GF4077@pd.tnic>
 <3908561D78D1C84285E8C5FCA982C28F31CB9150@ORSMSX106.amr.corp.intel.com>
 <20130814054322.GA9158@pd.tnic>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Em Wed, 14 Aug 2013 07:43:22 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Tue, Aug 13, 2013 at 08:13:56PM +0000, Luck, Tony wrote:
> > Generic tracepoints are architected to be able to fire at very high
> > rates and log huge amounts of information. So we'd need something
> > special to say just log these special tracepoints to network/serial.
> >
> > > Which reminds me, pstore could also be a good thing to use, in addition.
> > > Only put error info there as it is limited anyway.
> > 
> > Yes - space is very limited.  I don't know how to assign priority for logging
> > the dmesg data vs. some error logs.
> 
> Didn't we say at some point, "log only the panic messsage which kills
> the machine"?

EDAC core allows those kind of things, and even panic when errors arrive:

$ modinfo edac_core
filename:       /lib/modules/3.10.5-201.fc19.x86_64/kernel/drivers/edac/edac_core.ko
...
parm:           edac_pci_panic_on_pe:Panic on PCI Bus Parity error: 0=off 1=on (int)
parm:           edac_mc_panic_on_ue:Panic on uncorrected error: 0=off 1=on (int)
parm:           edac_mc_log_ue:Log uncorrectable error to console: 0=off 1=on (int)
parm:           edac_mc_log_ce:Log correctable error to console: 0=off 1=on (int)

Those have 644 permission, so they can be changed at runtime.

Of course, there are space for improvements.

> However, we probably could use more the messages before that
> catastrophic event because they could give us hints about what lead to
> the panic but in that case maybe a limited pstore is the wrong logging
> medium.
> 
> Actually, I can imagine the full serial/network logs of "special"
> tracepoints + dmesg to be the optimal thing.
> 
> > If we just "printk()" the most important parts - then that data will
> > automatically flow to the serial console and to pstore.
> 
> Actually, does the pstore act like a circular buffer? Because if it
> contains the last N relevant messages (for an arbitrary definition of
> relevant) before the system dies, then that could more helpful than only
> the error messages.
> 
> And with the advent of UEFI, pretty much every system has a pstore. Too
> bad that we have to limit it to 50% of size so that the boxes don't
> brick. :-P
> 
> > Then we have multiple paths for the critical bits of the error log
> > - and the tracepoints give us more details for the cases where the
> > machine doesn't spontaneously explode.
> 
> Ok, let's sort:
> 
> * First we have the not-so-critical hw error messages. We want to carry
> those out-of-band, i.e. not in dmesg so that people don't have to parse
> and collect dmesg but have a specialized solution which gives them
> structured logs and tools can analyze, collect and ... those errors.
> 
> * When a critical error happens, the above usage is not necessarily
> advantageous anymore in the sense that, in order to debug what caused
> the machine to crash, we don't simply necessarily want only the crash
> message but also the whole system activity that lead to it.
> 
> In which case, we probably actually want to turn off/ignore the error
> logging tracepoints and write *only* to dmesg which goes out over serial
> and to pstore. Right?
> 
> Because in such cases I want to have *all* *relevant* messages that lead
> to the explosion + the explosion message itself.
> 
> Makes sense? Yes, no? Aspects I've missed?

Makes sense to me.

> 
> Thanks.
> 


-- 

Cheers,
Mauro
