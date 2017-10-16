Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 01/12] PM / core: Add NEVER_SKIP and SMART_PREPARE driver flags
Date: Tue, 17 Oct 2017 00:03:30 +0200
Message-ID: <2810125.2d3aXhnV41@aspire.rjw.lan>
In-Reply-To: <20171016053452.GA11822@wunner.de>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <1998650.Q52BuGQTI4@aspire.rjw.lan> <20171016053452.GA11822@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, October 16, 2017 7:34:52 AM CEST Lukas Wunner wrote:
> On Mon, Oct 16, 2017 at 03:29:02AM +0200, Rafael J. Wysocki wrote:
> > +	:c:func:`dev_pm_set_driver_flags` helper function.]  If the first of
> > +	tese flags is set, the PM core will not apply the direct-complete
>         ^
> 	these
> 
> > +	proceudre described above to the given device and, consequenty, to any
>         ^
>         procedure
> 

Thanks!

