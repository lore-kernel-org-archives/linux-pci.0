Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:49706 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbbDGAfh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Apr 2015 20:35:37 -0400
Date: Mon, 06 Apr 2015 20:35:33 -0400 (EDT)
Message-Id: <20150406.203533.1356187749826485194.davem@davemloft.net>
To: bhelgaas@google.com
Cc: yinghai@kernel.org, david.ahern@oracle.com,
	linux-pci@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: Set pref for mem64 resource of pcie device
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150406220638.GH10892@google.com>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
	<1427857069-6789-4-git-send-email-yinghai@kernel.org>
	<20150406220638.GH10892@google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 6 Apr 2015 17:06:38 -0500

> But this is a general change that affects all platforms, and it's late in
> the cycle for something as invasive as this.  I'd rather include your patch
> in the v4.1 merge window, and revert d63e2e1f3df9 ("sparc/PCI: Clip bridge
> windows to fit in upstream windows") for v4.0.

I would kindly ask that we not proceed this way and use the change
which implements the fix properly.
