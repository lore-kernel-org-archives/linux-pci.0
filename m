Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 14 Mar 2018 14:05:47 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI/DPC: Disable interrupt generation during suspend
Message-ID: <20180314120547.GB2703@lahna.fi.intel.com>
References: <20180314114125.71132-1-mika.westerberg@linux.intel.com>
 <CAJZ5v0gOrQhXzLHDnABEYHxGbHVY89Nij9uQzqx-oyYmFwzuSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0gOrQhXzLHDnABEYHxGbHVY89Nij9uQzqx-oyYmFwzuSg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 14, 2018 at 12:48:49PM +0100, Rafael J. Wysocki wrote:
> Have you considered putting these things into the ->suspend_late and
> ->resume_early callbacks, respectively?
> 
> That might be slightly better as runtime resume is still enabled when
> the ->suspend and ->resume callbacks run.

There is no ->suspend_late or ->resume_early callbacks in struct
pcie_port_service_driver so I followed what drivers/pci/pcie/pme.c is
doing. I guess we could add those callbacks as well if you think they
are better suited here.
