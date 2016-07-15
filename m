Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:44169 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932187AbcGOKx2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Jul 2016 06:53:28 -0400
In-Reply-To: <1468444634-1866-14-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>,
	Michael Neuling <mikey@neuling.org>,
	Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Ian Munsie <imunsie@au1.ibm.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [13/15] PCI/hotplug: pnv_php: export symbols and move struct types needed by cxl
Message-Id: <3rrTvC2V9yz9ssM@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:27 +1000 (AEST)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2016-13-07 at 21:17:12 UTC, Ian Munsie wrote:
> From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> 
> The cxl driver will use infrastructure from pnv_php to handle device tree
> updates when switching bi-modal CAPI cards into CAPI mode.
> 
> To enable this, export pnv_php_find_slot() and
> pnv_php_set_slot_power_state(), and add corresponding declarations, as well
> as the definition of struct pnv_php_slot, to asm/pnv-pci.h.
> 
> Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Cc: linux-pci@vger.kernel.org
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/89379f165a1be13aa9b4731a90

cheers
