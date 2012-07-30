Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <50084E8B.3070508@gmx.de>
References: <5002BC55.3050107@gmx.de> <201207152225.49154.rjw@sisk.pl>
 <CAErSpo6Ka6XBakVZH7ge-==XY86FrOHP_dqGoa+zAFNgnnnFTA@mail.gmail.com> <50084E8B.3070508@gmx.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 30 Jul 2012 11:12:48 -0600
Message-ID: <CAErSpo5SCa0NdZUtLpLDma+i6+L7NH7pOFvUzOAD4TougvqMQg@mail.gmail.com>
Subject: [Bug 43238] Re: PCI ACPI/IRQ-routing broken on H77 chipset + Ivy
 Bridge (kernel 3.5-rc7 and earlier)
To: =?ISO-8859-1?Q?Malte_Schr=F6der?= <maltesch@gmx.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Galen Seitz <galens@seitzassoc.com>,
	bugzilla-daemon@bugzilla.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> I was pointed to https://bugzilla.kernel.org/show_bug.cgi?id=43238.
> I tried the modifications to the DSDT that where proposed there and
> voilŕ, the 3c905c started to work :)

I don't know where to go with this.  We do have some _PRT quirks in
drivers/acpi/pci_irq.c, but since Windows 7 works fine without any
quirks, adding a quirk to Linux doesn't seem like the "right" fix.

Lubos, would it be possible for you to collect a Windows system report
using AIDA64?  I think there's a free trial version here:
http://www.aida64.com/

Maybe somebody can compare what Windows does with what Linux does and
figure out the difference.
