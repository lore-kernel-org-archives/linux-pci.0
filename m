Return-Path: <SRS0=ORhH=6P=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=ORhH=6P=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20170712195729.GH14614@bhelgaas-glaptop.roam.corp.google.com>
References: <4782965.eeHMKbM6vL@aspire.rjw.lan> <20170712195729.GH14614@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Jul 2017 22:30:12 +0200
Message-ID: <CAJZ5v0gAjB4w_jHk2=hgAypV5pF5GZxnxPoq7RrWTiJ7XPjGCQ@mail.gmail.com>
Subject: Re: [PATCH] PCI / PM: Restore PME Enable after config space restoration
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PCI <linux-pci@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 12, 2017 at 9:57 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, Jul 12, 2017 at 03:05:39AM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Commit dc15e71eefc7 (PCI / PM: Restore PME Enable if skipping wakeup
>> setup) introduced a mechanism by which the PME Enable bit can be
>> restored by pci_enable_wake() if dev->wakeup_prepared is set in
>> case it has been overwritten by PCI config space restoration.
>>
>> However, that commit overlooked the fact that on some systems (Dell
>> XPS13 9360 in particular) the AML handling wakeup events checks PME
>> Status and PME Enable and it won't trigger a Notify() for devices
>> where those bits are not set while it is running.
>>
>> That happens during resume from suspend-to-idle when pci_restore_state()
>> invoked by pci_pm_default_resume_early() clears PME Enable before the
>> wakeup events are processed by AML, effectively causing those wakeup
>> events to be ignored.
>>
>> Fix this issue by restoring the PME Enable configuration right after
>> pci_restore_state() has been called instead of doing that in
>> pci_enable_wake().
>>
>> Fixes: dc15e71eefc7 (PCI / PM: Restore PME Enable if skipping wakeup setup)
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Since you merged dc15e71eefc7, do you want to merge the fix as well?
> Let me know if you'd rather have me take it.

I will take this one.

Thanks!
