Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1377036123.10300.475.camel@misato.fc.hp.com>
Subject: Re: [PATCH] ACPI / PM: Hold acpi_scan_lock over system PM
 transitions
From: Toshi Kani <toshi.kani@hp.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Date: Tue, 20 Aug 2013 16:02:03 -0600
In-Reply-To: <2852781.TfChGuuEkJ@vostro.rjw.lan>
References: <2852781.TfChGuuEkJ@vostro.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2013-08-20 at 01:47 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Bad things happen if ACPI hotplug events are handled during system
> PM transitions, especially if devices are removed as a result.
> To prevent those bad things from happening, acquire acpi_scan_lock
> when a transition is started and release it when that transition
> is complete or has been aborted.
> 
> This fixes resume lockup on my test-bed Acer Aspire S5 that happens
> when Thunderbolt devices are disconnected from the machine while
> suspended.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The change looks good to me.

Acked-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
-Toshi


