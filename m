Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH 0/6] ACPI / PM: Suspend-to-idle rework to deal with
 spurious ACPI wakeups
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux USB <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mario Limonciello <mario_limonciello@dell.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
References: <8918199.uo13RZ8hZk@aspire.rjw.lan>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <7579a28c-6237-e16a-6eda-9b41cc657ddf@redhat.com>
Date: Thu, 8 Jun 2017 09:24:37 +0200
MIME-Version: 1.0
In-Reply-To: <8918199.uo13RZ8hZk@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 08-06-17 02:00, Rafael J. Wysocki wrote:
> Hi All,
> 
> This series is a replacement for commit eed4d47efe95 (ACPI / sleep: Ignore
> spurious SCI wakeups from suspend-to-idle) which is still there in 4.12-rc4 but
> will be reverted shortly, because it triggered issues on quite a few systems.
> 
> The last patch in the series is a counterpart of the above commit with a few
> modifications, mostly to avoid affecting suspend-to-RAM and to reorder messages
> printed to kernel logs to make them somewhat less confusing.
> 
> The previous patches are pre-requisite changes plus some cleanups.  The major
> ones are [1-2/6] and [4/6] that are really needed for things to work as expected
> after [6/6].
> 
> In addition to that, this patch from Hans: https://patchwork.kernel.org/patch/9762815/
> is needed for USB wakeup on Bay Trail and Cherry Trail systems to work in general.

Small correction, that patch currently only influences Cherry Trail devices, it has:

static const struct x86_cpu_id int0002_cpu_ids[] = {
/*
  * Limit ourselves to Cherry Trail for now, until testing shows we
  * need to handle the INT0002 device on Baytrail too.
  *     ICPU(INTEL_FAM6_ATOM_SILVERMONT1),       * Valleyview, Bay Trail *
  */
        ICPU(INTEL_FAM6_ATOM_AIRMONT),          /* Braswell, Cherry Trail */
        {}
};

If anyone sees any issues where the SCI (typically irq 9) gets a nobody
cared message on Bay Trail try the linked patch with the Bay Trail line
above uncommented.

Regards,

Hans
