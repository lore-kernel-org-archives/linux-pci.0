Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3812 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751759AbdKMOaS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Nov 2017 09:30:18 -0500
Date: Mon, 13 Nov 2017 16:30:13 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] powerpc/pci: Unroll two pass loop when scanning
 bridges
Message-ID: <20171113143013.GF18997@lahna.fi.intel.com>
References: <20171110175230.82522-1-andriy.shevchenko@linux.intel.com>
 <20171110175230.82522-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171110175230.82522-2-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 10, 2017 at 07:52:30PM +0200, Andy Shevchenko wrote:
> The current scanning code is really hard to understand because it calls
> the same function in a loop where pass value is changed without any
> comments explaining it:
> 
>   for (pass = 0; pass < 2; pass++)
>     for_each_pci_bridge(dev, bus)
>       max = pci_scan_bridge(bus, dev, max, pass);
> 
> Unfamiliar reader cannot tell easily what is the purpose of this loop
> without looking at internals of pci_scan_bridge().
> 
> In order to make this bit easier to understand, open-code the loop in
> pci_scan_child_bus() and pci_hp_add_bridge() with added comments.
> 
> No functional changes intended.
> 
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
