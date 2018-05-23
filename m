Return-Path: <SRS0=L5Uk=IK=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=L5Uk=IK=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180522220149.GB22385@bhelgaas-glaptop.roam.corp.google.com>
References: <11415287.ki0m5Bqgns@aspire.rjw.lan> <20180522220149.GB22385@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 23 May 2018 10:11:38 +0200
Message-ID: <CAJZ5v0hE+_PUqngC3JcRDd7SW3ioP6hT3Vpmz98obqgXi1vuEA@mail.gmail.com>
Subject: Re: [PATCH] PCI / PM: Do not clear state_saved for devices that
 remain suspended
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PCI <linux-pci@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 23, 2018 at 12:01 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, May 18, 2018 at 10:17:42AM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> The state_saved flag should not be cleared in pci_pm_suspend() if the
>> given device is going to remain suspended, or the device's config
>> space will not be restored properly during the subsequent resume.
>>
>> Namely, if the device is going to stay in suspend, both the late
>> and noirq callbacks return early for it, so if its state_saved flag
>> is cleared in pci_pm_suspend(), it will remain unset throughout the
>> remaining part of suspend and resume and pci_restore_state() called
>> for the device going forward will return without doing anything.
>>
>> For this reason, change pci_pm_suspend() to only clear state_saved
>> if the given device is not going to remain suspended.  [This is
>> analogous to what commit ae860a19f37c (PCI / PM: Do not clear
>> state_saved in pci_pm_freeze() when smart suspend is set) did for
>> hibernation.]
>>
>> Fixes: c4b65157aeef (PCI / PM: Take SMART_SUSPEND driver flag into account)
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> I assume you'll take this one, too.

Yes, I will, thank you!
