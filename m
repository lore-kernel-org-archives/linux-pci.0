Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 16 Oct 2017 07:34:52 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
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
Subject: Re: [PATCH 01/12] PM / core: Add NEVER_SKIP and SMART_PREPARE driver
 flags
Message-ID: <20171016053452.GA11822@wunner.de>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
 <1998650.Q52BuGQTI4@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1998650.Q52BuGQTI4@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 16, 2017 at 03:29:02AM +0200, Rafael J. Wysocki wrote:
> +	:c:func:`dev_pm_set_driver_flags` helper function.]  If the first of
> +	tese flags is set, the PM core will not apply the direct-complete
        ^
	these

> +	proceudre described above to the given device and, consequenty, to any
        ^
        procedure

Lukas
