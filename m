Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:41310 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755853Ab3EUBvZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 May 2013 21:51:25 -0400
Date: Mon, 20 May 2013 18:51:22 -0700 (PDT)
Message-Id: <20130520.185122.248131229922415805.davem@davemloft.net>
To: bhelgaas@google.com
Cc: benh@kernel.crashing.org, paulus@samba.org,
	sparclinux@vger.kernel.org, rjw@sisk.pl,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] sparc/PCI: Use PCI_UNKNOWN for unknown power state
From: David Miller <davem@davemloft.net>
In-Reply-To: <20130520231916.32416.7318.stgit@bhelgaas-glaptop>
References: <20130520231909.32416.81752.stgit@bhelgaas-glaptop>
	<20130520231916.32416.7318.stgit@bhelgaas-glaptop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 20 May 2013 17:19:16 -0600

> Previously we initialized dev->current_state to 4 (PCI_D3cold), but I think
> we wanted PCI_UNKNOWN (5) here based on the comment and the fact that the
> generic version of this code, pci_setup_device(), uses PCI_UNKNOWN.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: David S. Miller <davem@davemloft.net>
