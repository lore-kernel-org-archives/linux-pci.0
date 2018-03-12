Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932332AbeCLODS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Mar 2018 10:03:18 -0400
Date: Mon, 12 Mar 2018 09:03:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>,
        Frederick Lawler <fred@fredlawl.com>
Subject: Re: [PATCH v2 08/13] PCI/portdrv: Simplify PCIe feature permission
 checking
Message-ID: <20180312140316.GB194000@bhelgaas-glaptop.roam.corp.google.com>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152062203293.77693.8159909590216160503.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180312080402.GE10358@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180312080402.GE10358@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 12, 2018 at 01:04:02AM -0700, Christoph Hellwig wrote:
> > +	 * We assume we can manage these PCIe features.  Some systems may
> > +	 * reserve these for use by the platform itself, e.g., an ACPI BIOS
> > +	 * may implement its own AER handling and use _OSC to prevent the
> > +	 * OS from interfering.
> > +	 */
> > +	bridge->use_aer = 1;
> > +	bridge->use_hotplug = 1;
> > +	bridge->use_pme = 1;
> 
> If we start out with enabled maybe these should be disable_foo flags
> instead?

I went back and forth on that.  "disable_foo" is nice because the
default value is correct (zero means enabled).  But then you end up
with things like:

  if (pcie_ports_native || !host->disable_hotplug)

where the "!host->disable_hotplug" is a double negative, and I have a
really hard time reading that.

> Also please use bool (or a bitfield bool) for true/false values.

I'm a little ambivalent about bool in structs because of things like
this:

  https://lkml.kernel.org/r/CA+55aFxnePDimkVKVtv3gNmRGcwc8KQ5mHYvUxY8sAQg6yvVYg@mail.gmail.com

Bjorn
