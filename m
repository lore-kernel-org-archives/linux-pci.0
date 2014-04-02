Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:58099 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756780AbaDBC35 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 1 Apr 2014 22:29:57 -0400
Date: Tue, 01 Apr 2014 22:29:55 -0400 (EDT)
Message-Id: <20140401.222955.1322740724254746495.davem@davemloft.net>
To: weiyang@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, yevgenyp@mellanox.com,
	ogerlitz@mellanox.com, amirv@mellanox.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] net/mlx4_core: match pci_device_id including dynids
From: David Miller <davem@davemloft.net>
In-Reply-To: <1396326961-20395-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1396326961-20395-1-git-send-email-weiyang@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yang <weiyang@linux.vnet.ibm.com>
Date: Tue,  1 Apr 2014 12:36:01 +0800

> Fix issue introduced by commit: 97a5221 "net/mlx4_core: pass
> pci_device_id.driver_data to __mlx4_init_one during reset".
> 
> pci_match_id() just match the static pci_device_id, which may return NULL if
> someone binds the driver to a device manually using
> /sys/bus/pci/drivers/.../new_id.
> 
> This patch match pci_device_id with pci_match_device() to cover both dynids
> and static id_table.
> 
> Thanks to Bjorn finding this issue.
> 
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Amir Vadai <amirv@mellanox.com>
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Acked-by: Amir Vadai <amirv@mellanox.com>

And ACK from the PCI folks would be greatly appreciated.

Thanks.
