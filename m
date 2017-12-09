Return-Path: <SRS0=gZr4=DF=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=gZr4=DF=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20171208202556.GD12367@bhelgaas-glaptop.roam.corp.google.com>
References: <3600031.yTsliOITBg@aspire.rjw.lan> <20171208202556.GD12367@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 9 Dec 2017 15:13:49 +0100
Message-ID: <CAJZ5v0gNgOEmKE_Sf1Hfwmw=PDQ4QGe4UvWhr0=wNUrS6fnS2g@mail.gmail.com>
Subject: Re: [PATCH] PM / sleep: Avoid excess pm_runtime_enable() calls in device_resume()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 8, 2017 at 9:25 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Dec 07, 2017 at 03:26:14AM +0100, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Middle-layer code doing suspend-time optimizations for devices with
>> the DPM_FLAG_SMART_SUSPEND flag set (currently, the PCI bus type and
>> the ACPI PM domain) needs to make the core skip ->thaw_early and
>> ->thaw callbacks for those devices in some cases and it sets the
>> power.direct_complete flag for them for this purpose.
>>
>> However, it turns out that setting power.direct_complete outside of
>> the PM core is a bad idea as it triggers an excessive invocation of
>> pm_runtime_enable() in device_resume().
>>
>> For this reason, provide a helper to clear power.is_late_suspended
>> and power.is_suspended to be invoked by the middle-layer code in
>> question instead of setting power.direct_complete and make that code
>> call the new helper.
>>
>> Fixes: c4b65157aeef (PCI / PM: Take SMART_SUSPEND driver flag into account)
>> Fixes: 05087360fd7a (ACPI / PM: Take SMART_SUSPEND driver flag into account)
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> I don't pretend to understand this (and I don't need to, so don't
> waste your time explaining), but I trust you :)

Thank you! :-)
