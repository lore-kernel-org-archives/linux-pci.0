Return-Path: <SRS0=vzn2=YV=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=vzn2=YV=wunner.de=lukas@kernel.org>
Date: Sat, 7 Jan 2017 13:16:15 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Hans de Goede <hdegoede@redhat.com>
Cc: David Airlie <airlied@redhat.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Peter Wu <peter@lekensteyn.nl>, Bjorn Helgaas <helgaas@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Kilian Singer <kilian.singer@quantumtechnology.info>,
	linux-pci <linux-pci@vger.kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Peter Jones <pjones@redhat.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170107121615.GA22429@wunner.de>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <20170104081639.GA21076@wunner.de>
 <20170104210954.GA11946@al>
 <59349185.1aqio7kYFn@aspire.rjw.lan>
 <1456065516.8360056.1483572074197.JavaMail.zimbra@redhat.com>
 <20170105150646.GB21446@wunner.de>
 <2562d75e-a770-3b9d-da3b-57c12896cd11@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2562d75e-a770-3b9d-da3b-57c12896cd11@redhat.com>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 07, 2017 at 12:45:35PM +0100, Hans de Goede wrote:
> I've a W541 sitting in my home office at well. I will take it through
> some gpu runtime suspend/resume testing. Which kernel introduces the
> problem I'm looking for ?

v4.8, it adds runtime PM for PCIe ports.  Or anything newer.


> I believe mine has the old BIOS / EFI which is less troublesome so I
> will first see if I can reproduce the problem with that and then upgrade
> to see if that introduces the problem.

Please be sure to make an acpidump before upgrading the BIOS
so that we can compare what they've changed.

Thanks!

Lukas
