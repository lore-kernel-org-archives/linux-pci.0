Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:44655 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753629AbcLGTFJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Dec 2016 14:05:09 -0500
Date: Wed, 7 Dec 2016 14:15:04 -0500
From: Keith Busch <keith.busch@intel.com>
To: Jon Mason <jon.mason@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI: Change default MPS behavior
Message-ID: <20161207191504.GA22478@localhost.localdomain>
References: <1481070027-9096-1-git-send-email-jon.mason@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481070027-9096-1-git-send-email-jon.mason@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 06, 2016 at 07:20:27PM -0500, Jon Mason wrote:
> Not all systems have a BIOS or firmware to preconfigure the PCIE MPS
> prior to Linux booting.  Without any firmware to pre-setup the MPS, the
> PCIE_BUS_DEFAULT will simply set everything to 0 (128b).  This behavior
> causes these systems to have non-optimal MPS values.  To get around this
> issue, change the default value of pcie_bus_config to be PCIE_BUS_SAFE.
> This configures all systems to use better values for the MPS, at the
> expense of any potential HW errata that might not like being changed.

Wouldn't it be better to provide the kernel parameter to override the
default on such platforms? The PCIE_BUS_SAFE sets the MPS to the lowest
common denominator below the root port, which may be less optimal than
the default behavior for hot plug.
