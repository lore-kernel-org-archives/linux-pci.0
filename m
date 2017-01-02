Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 2 Jan 2017 12:53:22 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-mmc@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] ACPI / scan: Prefer devices without _HID/_CID for _ADR
 matching
Message-ID: <20170102105322.GG1460@lahna.fi.intel.com>
References: <20161225102148.7706-1-hdegoede@redhat.com>
 <CAJZ5v0gjcaYtskSMueAz+GjHcLZv=4A8Qz_Lf6Bn7S0CLSkgPg@mail.gmail.com>
 <20161229084135.GC1460@lahna.fi.intel.com>
 <2022116.4lq1KAmrJA@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2022116.4lq1KAmrJA@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 30, 2016 at 02:27:31AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The way acpi_find_child_device() works currently is that, if there
> are two (or more) devices with the same _ADR value in the same
> namespace scope (which is not specifically allowed by the spec and
> the OS behavior in that case is not defined), the first one of them
> found to be present (with the help of _STA) will be returned.
> 
> This covers the majority of cases, but is not sufficient if some of
> the devices in question have a _HID (or _CID) returning some valid
> ACPI/PNP device IDs (which is disallowed by the spec) and the
> ASL writers' expectation appears to be that the OS will match
> devices without a valid ACPI/PNP device ID against a given bus
> address first.
> 
> To cover this special case as well, modify find_child_checks()
> to prefer devices without ACPI/PNP device IDs over devices that
> have them.
> 
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks for taking care of this Rafael :)
