Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34013 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754370AbbEPPZl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 May 2015 11:25:41 -0400
Received: by ieczm2 with SMTP id zm2so70895430iec.1
        for <linux-pci@vger.kernel.org>; Sat, 16 May 2015 08:25:40 -0700 (PDT)
Date: Sat, 16 May 2015 10:25:37 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
	linux-pci@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI/sparc: Fix booting with T5-8
Message-ID: <20150516152537.GJ31666@google.com>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 31, 2015 at 07:57:46PM -0700, Yinghai Lu wrote:
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

Ping, any updates on this?  AFAICT, we should add a new pci_bus_addr_t
distinct from dma_addr_t, but Ben raised an issue that needs to be
resolved first.

Bjorn
