Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 14 Feb 2018 11:47:32 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/5] PCI: Make sure all bridges reserve at least one bus
 number
Message-ID: <20180214094732.GJ27191@lahna.fi.intel.com>
References: <20180213163200.8787-1-mika.westerberg@linux.intel.com>
 <20180213163200.8787-2-mika.westerberg@linux.intel.com>
 <CAJZ5v0h7okRkBsNmSkLQ9AOZ_zPk5G0vbu=hKxwm2vjEthvxOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0h7okRkBsNmSkLQ9AOZ_zPk5G0vbu=hKxwm2vjEthvxOA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 13, 2018 at 06:43:00PM +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 13, 2018 at 5:31 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > When distributing extra buses between hotplug bridges we need to make
> > sure each bridge reserve at least one bus number, even if there is
> > currently nothing connected to it. For instance ACPI hotplug may bring
> > in additional devices to non-hotplug bridges later on. To make sure we
> > don't run out of bus numbers for non-hotplug bridges reserve one bus
> > number for them upfront before distributing buses for hotplug bridges.
> >
> > Fixes: 1c02ea810065 ("PCI: Distribute available buses to hotplug-capable bridges")
> > Reported-by: Mario Limonciello <mario.limonciello@dell.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: stable@vger.kernel.org
> 
> Just a few notation-related nits below.

Thanks for the comments! I'll update the patch accordingly.
