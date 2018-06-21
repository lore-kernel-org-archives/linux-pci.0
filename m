Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:29680 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753906AbeFULOA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jun 2018 07:14:00 -0400
Date: Thu, 21 Jun 2018 14:13:54 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH 32/32] PCI: Whitelist Thunderbolt ports for runtime D3
Message-ID: <20180621111354.GW2558@lahna.fi.intel.com>
References: <cover.1529173804.git.lukas@wunner.de>
 <10206fe7f3967aa73ade5b24dc729de0e94c3b7f.1529173804.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <10206fe7f3967aa73ade5b24dc729de0e94c3b7f.1529173804.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 16, 2018 at 09:25:00PM +0200, Lukas Wunner wrote:
> +		/* Even the oldest 2010 Thunderbolt controller supports D3. */
> +		if (bridge->is_thunderbolt)
> +			return true;

I have a small concern here. In PC world native PCIe hotplug used with
Thunderbolt comes in two flavors:

  - Native PCI hotplug without runtime PM
  - Native PCI hotplug with runtime PM

The former works so that even if it uses native PCIe hotplug, the power
management is done so that the Thunderbolt host router is hot-removed
when there is nothing connected (and that brings the power savings).
With the above change we start putting all Thunderbolt PCIe hotplug
ports to D3 runtime. While this probably works (and I tested it on the
same Dell) I don't think Windows does it and it may lead to a path that
has not been tested very thoroughly by OEMs.

So I wonder if it makes sense to restrict this particular check to Apple
hardware at this point?
