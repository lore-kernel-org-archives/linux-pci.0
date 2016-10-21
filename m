Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:60847 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934191AbcJUPgo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Oct 2016 11:36:44 -0400
Date: Fri, 21 Oct 2016 17:37:14 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>, Wei Zhang <wzhang@fb.com>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCHv3 2/5] pci: Add is_removed state
Message-ID: <20161021153714.GA4221@wunner.de>
References: <1475007815-28354-1-git-send-email-keith.busch@intel.com>
 <1475007815-28354-3-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475007815-28354-3-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 27, 2016 at 04:23:32PM -0400, Keith Busch wrote:
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -109,6 +109,8 @@ int pciehp_unconfigure_device(struct slot *p_slot)
>  				break;
>  			}
>  		}
> +		if (!presence)
> +			dev->is_removed = 1;
>  		pci_stop_and_remove_bus_device(dev);
>  		/*
>  		 * Ensure that no new Requests will be generated from

Sorry for the delay Keith, I finally got around to test v3 of your
series with hot-removed Thunderbolt devices on Apple Macs.

I've found that the above isn't sufficient, it's necessary to also
set the is_removed bit on any child devices.  E.g. on my system
when an Apple Gigabit Ethernet adapter is plugged in, the topology
looks like this:

0000:06:04.0 --- 0000:09:00.0 --- 0000:0a:00.0 --- 0000:0b:00.0

Hotplug port     Upstream bridge  Downstream br.   Broadcom 57762
of TB host       of TB switch in
                 Ethernet adapter

With your patch above, the is_removed bit is only set on 0000:09:00.0
but not on its children.  Consequently the "tg3" driver tries to
access the hot-removed Broadcom 57762 Ethernet chip as before,
causing a soft lockup.

The diff below fixes this for me, could you fold that into your patch?
The same change might also be necessary in pcie-dpc.c. Feel free to
rename "set_is_removed_cb()" if you don't like it.

Thanks,

Lukas

-- >8 --
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 299ea5e..ec26eb7 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -73,6 +73,12 @@ int pciehp_configure_device(struct slot *p_slot)
 	return ret;
 }
 
+static int set_is_removed_cb(struct pci_dev *pdev, void *unused)
+{
+	pdev->is_removed = 1;
+	return 0;
+}
+
 int pciehp_unconfigure_device(struct slot *p_slot)
 {
 	int rc = 0;
@@ -109,8 +115,11 @@ int pciehp_unconfigure_device(struct slot *p_slot)
 				break;
 			}
 		}
-		if (!presence)
+		if (!presence) {
 			dev->is_removed = 1;
+			if (pci_has_subordinate(dev))
+				pci_walk_bus(dev->subordinate, set_is_removed_cb, NULL);
+		}
 		pci_stop_and_remove_bus_device(dev);
 		/*
 		 * Ensure that no new Requests will be generated from
