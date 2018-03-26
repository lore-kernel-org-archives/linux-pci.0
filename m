Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:49962 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbeCZKBs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Mar 2018 06:01:48 -0400
Date: Mon, 26 Mar 2018 13:01:35 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 0/5] PCI: Fixes for native PCIe and ACPI hotplug
Message-ID: <20180326100135.GA2703@lahna.fi.intel.com>
References: <20180226132112.81447-1-mika.westerberg@linux.intel.com>
 <20180315060005.GO2703@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180315060005.GO2703@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 15, 2018 at 08:00:05AM +0200, Mika Westerberg wrote:
> Do you have any comments on the series? It would be nice to get it
> merged for v4.17 if no objections.

Hi Bjorn,

Sorry for pressing you but this series is pretty much needed for any
systems having Thunderbolt in native PCIe enumeration mode. This mode is
already used in some existing systems so it effectively means that
Thunderbolt hotplug does not work on them properly.

I would really appeciate if you could consider merging this for
v4.17-rc1.

Thanks!
