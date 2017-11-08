Return-Path: <SRS0=IMkZ=CG=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=IMkZ=CG=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20171108203833.GA21597@bhelgaas-glaptop.roam.corp.google.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <16592954.7Zo1mAdIIH@aspire.rjw.lan>
 <6330680.LdxjlP4uri@aspire.rjw.lan> <125862518.pYVN4SKj76@aspire.rjw.lan> <20171108203833.GA21597@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 8 Nov 2017 22:09:14 +0100
Message-ID: <CAJZ5v0jFxv0E0FMmZkeQscvBUR3ORbPQXpZhEn2zYDktri8XMQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] PCI / PM: Support for LEAVE_SUSPENDED driver flag
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 8, 2017 at 9:38 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, Nov 08, 2017 at 02:28:18PM +0100, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Add support for DPM_FLAG_LEAVE_SUSPENDED to the PCI bus type by
>> making it (a) set the power.may_skip_resume status bit for devices
>> that, from its perspective, may be left in suspend after system
>> wakeup from sleep and (b) return early from pci_pm_resume_noirq()
>> for devices whose remaining resume callbacks during the transition
>> under way are going to be skipped by the PM core.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!
