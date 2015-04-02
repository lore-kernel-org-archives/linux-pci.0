Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:41304 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbbDBUhR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Apr 2015 16:37:17 -0400
Date: Thu, 02 Apr 2015 16:37:15 -0400 (EDT)
Message-Id: <20150402.163715.643586069492103151.davem@davemloft.net>
To: yinghai@kernel.org
Cc: bhelgaas@google.com, david.ahern@oracle.com,
	linux-pci@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI/sparc: Fix booting with T5-8
From: David Miller <davem@davemloft.net>
In-Reply-To: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yinghai Lu <yinghai@kernel.org>
Date: Tue, 31 Mar 2015 19:57:46 -0700

> Fix regression by commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows to
> fit in upstream windows").
> 
> That cause bridge bar get clipped wrongly.
> 
> The sparc64 dma_addr_t is 32-bit, we can not use it to check if we can
> use 64bit bar, introduce pci_bus_addr_t.
> 
> sparc ofpci does not parse 64bit mem for root bus, add code to
> make sure that we get correct resource for root.
> 
> Also there are device 64-bit res does not have pref bit flag, but bridges
> do have pref bit set, that cause extra "no compatible window".
> Set pref bit for them according to the errata.

Just to be clear, who is going to merge this? :-)

