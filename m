Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:34636 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932187AbcGOKxa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Jul 2016 06:53:30 -0400
In-Reply-To: <1468444634-1866-15-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>,
	Michael Neuling <mikey@neuling.org>,
	Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Ian Munsie <imunsie@au1.ibm.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [14/15] PCI/hotplug: pnv_php: handle OPAL_PCI_SLOT_OFFLINE power state
Message-Id: <3rrTvD2DB5z9sBg@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:28 +1000 (AEST)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2016-13-07 at 21:17:13 UTC, Ian Munsie wrote:
> From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> 
> When calling pnv_php_set_slot_power_state() with state ==
> OPAL_PCI_SLOT_OFFLINE, remove devices from the device tree as if we're
> dealing with OPAL_PCI_SLOT_POWER_OFF.
> 
> Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Cc: linux-pci@vger.kernel.org
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5473a6bf635d35d5c1d12d0e13

cheers
