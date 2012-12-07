Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:56937 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095Ab2LGRvN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Dec 2012 12:51:13 -0500
Date: Fri, 07 Dec 2012 12:51:11 -0500 (EST)
Message-Id: <20121207.125111.884049913645755574.davem@davemloft.net>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, netdev@vger.kernel.org, divy@chelsio.com
Subject: Re: [PATCH 06/12] cxgb3: Use standard #defines for PCIe Capability
 ASPM fields
From: David Miller <davem@davemloft.net>
In-Reply-To: <20121205205750.13851.10893.stgit@bhelgaas.mtv.corp.google.com>
References: <20121205205724.13851.50508.stgit@bhelgaas.mtv.corp.google.com>
	<20121205205750.13851.10893.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 05 Dec 2012 13:57:50 -0700

> Use the standard #defines rather than bare numbers for PCIe Capability
> ASPM fields.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

This seems to depend upon another patch which presumably adds the
define of this new macro to a PCI header file.  So I can't apply
this to my tree.

Just merge it wherever the dependency is:

Acked-by: David S. Miller <davem@davemloft.net>
