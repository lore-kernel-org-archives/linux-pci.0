Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:59034 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab1LSVNx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2011 16:13:53 -0500
Date: Mon, 19 Dec 2011 16:13:49 -0500 (EST)
Message-Id: <20111219.161349.1101987855765407439.davem@davemloft.net>
To: bhelgaas@google.com
Cc: jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 4/6] sunhme/PCI: use list_for_each_entry() for
 bus->devices traversal
From: David Miller <davem@davemloft.net>
In-Reply-To: <20111216223149.5963.61942.stgit@bhelgaas.mtv.corp.google.com>
References: <20111216223043.5963.87534.stgit@bhelgaas.mtv.corp.google.com>
	<20111216223149.5963.61942.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 16 Dec 2011 15:31:49 -0700

> Replace open-coded list traversal with list_for_each_entry().
> 
> CC: David S. Miller <davem@davemloft.net>
> CC: netdev@vger.kernel.org
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied.
