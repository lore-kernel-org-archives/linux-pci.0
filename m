Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180301180220.11333-1-andriy.shevchenko@linux.intel.com>
References: <20180301180220.11333-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Mar 2018 12:10:59 +0100
Message-ID: <CAJZ5v0jY-psSy51ZvrgHKidGg5CK_4hK1UGbhnzXD_QQxyCvZg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] x86, dmi: introduce and use dmi_get_bios_year()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Jean Delvare <jdelvare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 1, 2018 at 7:02 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Introduce a new helper to extract a year from DMI BIOS date since there
> are most existing users do and newcomers would utilize as well.
>
> Ingo, this is respin of the patches in x86/platform. I think, if it's
> possible to rebase, would be easier just to replace existing ones.
>
> Otherwise I would reorganize them as a series of fixups.
>
> Bjorn, Jean, Rafael, thank you for your reviews!
>
> Since v1:
> - move the helper to be regular function (Bjorn, Rafael)
> - fix a potential regression introduced in pci_acpi_crs_quirks() (Jean)
> - adjust subject lines and commit message bodies (Bjorn)
> - add tags (Bjorn, Jean)
>
> Andy Shevchenko (4):
>   firmware: dmi_scan: Introduce the dmi_get_bios_year() helper
>   x86/PCI: Simplify code by using the new dmi_get_bios_year() helper
>   ACPI / sleep: Simplify code by using the new dmi_get_bios_year()
>     helper
>   PCI: Simplify code by using the new dmi_get_bios_year() helper

I can apply this or if you want to route it differently, please feel free to add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to all of the patches in the series.

Thanks!
