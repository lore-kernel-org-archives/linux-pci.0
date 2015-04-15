Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI / hotplug: Propagate the "ignore hotplug" setting to parent
Date: Wed, 15 Apr 2015 03:03:19 +0200
Message-ID: <2638174.Fqeb1nNFUX@vostro.rjw.lan>
In-Reply-To: <1429025292.3383705.253616133.4A1DF301@webmail.messagingengine.com>
References: <2001450.KHHLaZsp3O@vostro.rjw.lan> <1429025292.3383705.253616133.4A1DF301@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, April 14, 2015 12:28:12 PM Henrique de Moraes Holschuh wrote:
> On Mon, Apr 13, 2015, at 11:23, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Refine the mechanism introduced by commit f244d8b623da (ACPIPHP / radeon
> > / nouveau: Fix VGA switcheroo problem related to hotplug) to propagate
> > the ignore_hotplug setting of the device to its parent bridge in case
> > hotplug notifications related to the graphics adapter switching are
> > given for the bridge rather than for the device itself (the need to
> > be ignored in both cases).
> 
> I do apologise if this is a stupid question, but is there any chance the
> bridge will be connected to other devices that do require hotplug handling,
> and not just to the GPU?

The bridge is actually a downstream PCIe port holding the GPU, so no. :-)

Rafael

