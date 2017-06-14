Return-Path: <SRS0=8Wua=5T=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=8Wua=5T=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20170614180943.GA20778@bhelgaas-glaptop.roam.corp.google.com>
References: <8918199.uo13RZ8hZk@aspire.rjw.lan> <1615075.mBkoKApGGc@aspire.rjw.lan>
 <5652844.yCt16F1gBo@aspire.rjw.lan> <20170614180943.GA20778@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Jun 2017 00:22:25 +0200
Message-ID: <CAJZ5v0gtGfpwHM-n+-e=Vc_+PwSMC3YxM1XESTgxL5Z1R-XsNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] ACPI / PM: Run wakeup notify handlers synchronously
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux USB <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>, Felipe Balbi <balbi@kernel.org>,
	Mario Limonciello <mario_limonciello@dell.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>, Hans De Goede <hdegoede@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 14, 2017 at 8:09 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Jun 12, 2017 at 10:48:41PM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> The work functions provided by the users of acpi_add_pm_notifier()
>> should be run synchronously before re-enabling the wakeup GPE in
>> case they are used to clear the status and/or disable the wakeup
>> signaling at the source.  Otherwise, which is the case currently in
>> the PCI bus type code, the same wakeup event may be signaled for
>> multiple times while the execution of the work function in response
>> to it has already been queued up.
>>
>> Fortunately, acpi_add_pm_notifier() is only used by PCI and by
>> ACPI device PM code internally, so the change is relatively
>> straightforward to make.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!
