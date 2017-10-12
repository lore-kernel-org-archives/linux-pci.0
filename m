Return-Path: <SRS0=7RJ+=BL=ACULAB.COM=David.Laight@kernel.org>
Return-Path: <SRS0=7RJ+=BL=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Bjorn Helgaas' <helgaas@kernel.org>, Mika Westerberg
	<mika.westerberg@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Ashok Raj <ashok.raj@intel.com>,
	Keith Busch <keith.busch@intel.com>, "Rafael J . Wysocki"
	<rafael.j.wysocki@intel.com>, Lukas Wunner <lukas@wunner.de>, Michael Jamet
	<michael.jamet@intel.com>, Yehezkel Bernat <yehezkel.bernat@intel.com>,
	"Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/7] PCI: Distribute available buses to hotplug capable
 PCIe downstream ports
Date: Thu, 12 Oct 2017 09:50:31 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0092407@AcuExch.aculab.com>
References: <20170926141720.25067-1-mika.westerberg@linux.intel.com>
 <20170926141720.25067-4-mika.westerberg@linux.intel.com>
 <20171011233243.GX25517@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171011233243.GX25517@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas
> Sent: 12 October 2017 00:33
> Why do you limit it to PCIe?  Isn't it conceivable that one could
> hot-add a conventional PCI card that contained a bridge leading to
> another hotplug slot?  E.g., a PCI card with PCMCIA slot or something
> on it?

There are (maybe were!) cardbus cards that contained PCI bridges to
connect to expansion chassis.
Bus enumeration was always a problem unless they were connected
at boot time.

	David
