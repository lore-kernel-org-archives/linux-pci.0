Return-Path: <SRS0=R787=H5=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=R787=H5=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180510130343.GA173327@bhelgaas-glaptop.roam.corp.google.com>
References: <56a8953c-d833-837c-57d5-fe758d4db02a@canonical.com>
 <1823373.ea0yBGqyI6@aspire.rjw.lan> <20180510130343.GA173327@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 May 2018 16:49:38 +0200
Message-ID: <CAJZ5v0hdkyQnpRseSYi2gJWrFPu+svUA64sZvmV0dg2g=KOuiw@mail.gmail.com>
Subject: Re: [PATCH] PCI / PM: Check device_may_wakeup() in pci_enable_wake()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Joseph Salisbury <joseph.salisbury@canonical.com>,
	Bjorn Helgaas <bhelgaas@google.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 1745646@bugs.launchpad.net,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 10, 2018 at 3:03 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, May 09, 2018 at 12:18:32AM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Commit 0847684cfc5f0 (PCI / PM: Simplify device wakeup settings code)
>> went too far and dropped the device_may_wakeup() check from
>> pci_enable_wake() which causes wakeup to be enabled during system
>> suspend, hibernation or shutdown for some PCI devices that are not
>> allowed by user space to wake up the system from sleep (or power off).
>>
>> As a result of this excessive power is drawn by some of the affected
>> systems while in sleep states or off.
>>
>> Restore the device_may_wakeup() check in pci_enable_wake(), but make
>> sure that the PCI bus type's runtime suspend callback will not call
>> device_may_wakeup() which is about system wakeup from sleep and not
>> about device wakeup from runtime suspend.
>>
>> Fixes: 0847684cfc5f0 (PCI / PM: Simplify device wakeup settings code)
>> Reported-by: Joseph Salisbury <joseph.salisbury@canonical.com>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> 0847684cfc5f0 appeared in v4.13, which raises the question of whether
> this problem is important enough for a stable backport.  Up to you :)

Yes, it is IMO, thank you!
