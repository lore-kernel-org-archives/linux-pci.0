Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:35715 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101AbaADBsa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jan 2014 20:48:30 -0500
Date: Fri, 03 Jan 2014 20:48:26 -0500 (EST)
Message-Id: <20140103.204826.924684292174040714.davem@davemloft.net>
To: jeffrey.t.kirsher@intel.com
Cc: bhelgaas@google.com, jesse.brandeburg@gmail.com,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	gospo@redhat.com, sassmann@redhat.com,
	linux-kernel@vger.kernel.org, bjorn.helgaas@hp.com
Subject: Re: [net-next] pci_regs.h: Add PCI bus link speed and width defines
From: David Miller <davem@davemloft.net>
In-Reply-To: <1388798859.2275.5.camel@jtkirshe-mobl>
References: <CAErSpo7TJXTCxpFKWXLTaHmqXXnYQdnpNeWt+cehSaES2Jh30w@mail.gmail.com>
	<20140103.193008.684316024702680161.davem@davemloft.net>
	<1388798859.2275.5.camel@jtkirshe-mobl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 03 Jan 2014 17:27:39 -0800

> What do you want to do with the current series of patches
> (mainly the ixgbe LER patches) on my tree?  I know that there is a
> thread going on between Joe Perches and Mark, but it sounded like Mark
> is working on a follow-on patch to address Joe's concerns.

I want the LER config option removed.
