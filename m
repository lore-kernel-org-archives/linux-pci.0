Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:40474 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab2F0Iev (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jun 2012 04:34:51 -0400
Date: Wed, 27 Jun 2012 01:34:50 -0700 (PDT)
Message-Id: <20120627.013450.1958267122682964980.davem@davemloft.net>
To: bhelgaas@google.com
Cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] sparc/PCI: remove unused pcibios_assign_resource()
 definition
From: David Miller <davem@davemloft.net>
In-Reply-To: <20120618181709.6135.2703.stgit@bhelgaas.mtv.corp.google.com>
References: <20120618181709.6135.2703.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 18 Jun 2012 12:17:10 -0600

> pcibios_assign_resource() isn't used anywhere; remove it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied.
