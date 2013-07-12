Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>
Subject: Re: [RFC][PATCH 23/30] ACPI / hotplug / PCI: Do not exectute _PS0 and _PS3 directly
Date: Fri, 12 Jul 2013 23:09:22 +0200
Message-ID: <6400136.2GQyQFPMtH@vostro.rjw.lan>
In-Reply-To: <20130712130508.GK4898@intel.com>
References: <26431283.HJCKsss0rt@vostro.rjw.lan> <1757750.sf0hy8txF5@vostro.rjw.lan> <20130712130508.GK4898@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, July 12, 2013 04:05:08 PM Mika Westerberg wrote:
> On Fri, Jul 12, 2013 at 02:01:30AM +0200, Rafael J. Wysocki wrote:
> > Index: linux-pm/drivers/pci/hotplug/acpiphp.h
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/hotplug/acpiphp.h
> > +++ linux-pm/drivers/pci/hotplug/acpiphp.h
> > @@ -160,7 +160,6 @@ struct acpiphp_attention_info
> >  
> >  /* slot flags */
> >  
> > -#define SLOT_POWEREDON		(0x00000001)
> >  #define SLOT_ENABLED		(0x00000002)
> >  #define SLOT_MULTIFUNCTION	(0x00000004)
> >  
> > @@ -168,11 +167,7 @@ struct acpiphp_attention_info
> >  
> >  #define FUNC_HAS_STA		(0x00000001)
> >  #define FUNC_HAS_EJ0		(0x00000002)
> > -#define FUNC_HAS_PS0		(0x00000010)
> > -#define FUNC_HAS_PS1		(0x00000020)
> > -#define FUNC_HAS_PS2		(0x00000040)
> > -#define FUNC_HAS_PS3		(0x00000080)
> > -#define FUNC_HAS_DCK            (0x00000100)
> > +#define FUNC_HAS_DCK            (0x00000003)
> 
> These are flags not enum so the above wants to be
> 
> 	#define FUNC_HAS_DCK            (0x00000004)

Yeah, obviously.

I guess it goes against the natural tendency to assign numbers to things
sequentially, so I generally prefer the (1U << n) notation. :-)

> otherwise we accidentally match checks like:
> 
> 	/* install notify handler */
> 	if (!(newfunc->flags & FUNC_HAS_DCK)) {
> 		...

Yup.  Thanks for spotting that!

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
