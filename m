Return-Path: <SRS0=Qt75=YT=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=Qt75=YT=linux.intel.com=mika.westerberg@kernel.org>
Date: Thu, 5 Jan 2017 12:49:40 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Wu <peter@lekensteyn.nl>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Kilian Singer <kilian.singer@quantumtechnology.info>,
	linux-pci <linux-pci@vger.kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Dave Airlie <airlied@redhat.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170105104940.GA3353@lahna.fi.intel.com>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <20170104081639.GA21076@wunner.de>
 <20170104210954.GA11946@al>
 <59349185.1aqio7kYFn@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <59349185.1aqio7kYFn@aspire.rjw.lan>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 04, 2017 at 10:58:10PM +0100, Rafael J. Wysocki wrote:
> I would rather add a quirk to the ACPI core to prevent the power resources in
> question from being enumerated.  Or even to prevent ACPI PM from being
> used for the port in question.

If we are going to add a quirk, I agree that it should be put to the
ACPI core.

However, Windows seems to be able to use _PR3 just fine. So there is
something that we are missing or do not implement properly which causes
all the troubles. IMHO we should try to find out what that difference is
and fix that if possible.
