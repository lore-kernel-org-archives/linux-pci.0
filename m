Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:31952 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932164AbcFTJJP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Jun 2016 05:09:15 -0400
Date: Mon, 20 Jun 2016 12:03:29 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: Document connection between pci_power_t and
 hardware PM capability
Message-ID: <20160620090329.GZ1739@lahna.fi.intel.com>
References: <20160618180056.7267.67911.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160618180056.7267.67911.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 18, 2016 at 01:00:56PM -0500, Bjorn Helgaas wrote:
> The dev.pme_support field, pci_pm_init(), and pci_pme_capable() depend on
> the fact that the pci_power_t values (PCI_D0, PCI_D1, etc.) match the
> definition of the PME_Support field of the Power Management Capabilities
> register in the Power Management capability (see PCI Bus Power Management
> spec r1.2, sec 3.2.3).
> 
> Add a note to this effect at the pci_power_t typedef.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Good idea,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
