Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 15 Aug 2013 10:34:21 -0300
From: Mauro Carvalho Chehab <m.chehab@samsung.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"rjw@sisk.pl" <rjw@sisk.pl>,
	"lance.ortiz@hp.com" <lance.ortiz@hp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Aristeu Rozanski Filho <arozansk@redhat.com>
Subject: Re: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error trace
 event
Message-id: <20130815103421.178a5224@samsung.com>
In-reply-to: <20130815100132.GC27616@pd.tnic>
References: <20130810180322.GC4155@pd.tnic>
 <20130812083355.47c1bae8@samsung.com> <5208D80D.5030206@linux.vnet.ibm.com>
 <20130812114404.3bd64fa0@samsung.com> <520A1B5E.8040105@linux.vnet.ibm.com>
 <20130813094147.062317f8@concha.lan> <520A6A30.1030406@linux.vnet.ibm.com>
 <3908561D78D1C84285E8C5FCA982C28F31CB8DB5@ORSMSX106.amr.corp.intel.com>
 <520B603E.3040002@linux.vnet.ibm.com> <20130814211504.393cf138@concha.lan>
 <20130815100132.GC27616@pd.tnic>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Em Thu, 15 Aug 2013 12:01:32 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Wed, Aug 14, 2013 at 09:15:04PM -0300, Mauro Carvalho Chehab wrote:
> > > - Two, if ghes_edac is enabled, it prevents other edac drivers
> > > from being loaded. It looks like the assumption here is that if
> > > ghes/firmware first is enabled, then *all* memory errors are
> > > reported through ghes which is not true. We could have (a subset
> > > of) corrected errors reported through ghes, some through CMCI
> > > and uncorrected errors through MCE. So, if I'm not mistaken, if
> > > ghes_edac is enabled, we will only receive ghes error events through
> > > mc_event and not the others. Mauro, is this accurate?
> > 
> > Yes, that's the current assumption. It prevents to have both BIOS and a
> > direct-hardware-access-EDAC-driver to race, as this is known to have
> > serious issues.
> 
> Ok, this is getting confusing so let's shed some more light.
> 
> * First of all, Naveen is asking whether other *edac* drivers can
> be loaded. And no, they cannot once the ghes thing is loaded which
> potentially is a problem.
> 
> For example, if the chipset-specific driver has additional functionality
> from ghes_edac, then that functionality is gone when ghes_edac loads
> first. This might be a problem in some cases, we probably need to think
> about this more in depth.

Yes, but the thing is that it is not safe to use the hardware driver if
the BIOS is also reading the hardware error registers directly, as, on
several hardware, a read cause the error data to be cleaned on such 
register.

So, either APEI should be extended to allow some fine-grained that would
provide ways to check/control what resources would be reserved for BIOS 
only, or the user needs to tell BIOS/Kernel if they want BIOS
or OS to access the hardware.

Regards,
Mauro
