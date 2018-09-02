Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:54160 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIBExL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Sep 2018 00:53:11 -0400
Date: Sat, 01 Sep 2018 17:39:25 -0700 (PDT)
Message-Id: <20180901.173925.56106529065602504.davem@davemloft.net>
To: stephen@networkplumber.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        devel@linuxdriverproject.org, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] PCI: hv: support reporting serial number
 as slot information
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180829162452.25805-2-sthemmin@microsoft.com>
References: <20180829162452.25805-1-sthemmin@microsoft.com>
        <20180829162452.25805-2-sthemmin@microsoft.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Stephen Hemminger <stephen@networkplumber.org>
Date: Wed, 29 Aug 2018 09:24:51 -0700

> +	spin_lock_irqsave(&hbus->device_list_lock, flags);
> +	list_for_each_entry(hpdev, &hbus->children, list_entry) {
> +		if (hpdev->pci_slot)
> +			continue;
> +
> +		slot_nr = PCI_SLOT(wslot_to_devfn(hpdev->desc.win_slot.slot));
> +		snprintf(name, SLOT_NAME_SIZE, "%u", hpdev->desc.ser);
> +		hpdev->pci_slot = pci_create_slot(hbus->pci_bus, slot_nr,
> +					  name, NULL);

pci_create_slot() takes a mutex, therefore you can't hold a spinlock or
disable interrupts here.
