Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 14 Sep 2018 11:16:33 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 01/10] PCI: Do not skip power managed bridges in
 pci_enable_wake()
Message-ID: <20180914081633.GU14465@lahna.fi.intel.com>
References: <20180913143322.77953-1-mika.westerberg@linux.intel.com>
 <20180913143322.77953-2-mika.westerberg@linux.intel.com>
 <153688100.j3IOAyprJL@aspire.rjw.lan>
 <20180914080621.GT14465@lahna.fi.intel.com>
 <CAJZ5v0gzacxkV+6gbY+paq6=h71KWpRM4pG5ko-Fu3ROdJ2AXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0gzacxkV+6gbY+paq6=h71KWpRM4pG5ko-Fu3ROdJ2AXQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 14, 2018 at 10:11:25AM +0200, Rafael J. Wysocki wrote:
> You may need to resend for Patchwork to pick it up, though.  Depends
> on Bjorn I suppose.

OK, I'll resend it just in case :)
