Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:49632 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbbKWLjT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Nov 2015 06:39:19 -0500
Date: Mon, 23 Nov 2015 11:39:02 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: keystone: fix crash with deferred probe
Message-ID: <20151123113902.GM8644@n2100.arm.linux.org.uk>
References: <866b2f1544f9d55fa932aa9f9cb5e7d523a23d05.1448017883.git.nsekhar@ti.com>
 <20151123192209.38e2c101@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151123192209.38e2c101@xhacker>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 23, 2015 at 07:22:09PM +0800, Jisheng Zhang wrote:
> when trying to add berlin pcie support and came up one patch
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/384575.html
> 
> when build testing, I also realized this issue, but keystone relies on
> hook_fault_code() which is will be freed after boot, so your patch isn't
> completed.

hook_fault_code() is intentionally not callable after boot.  It's unsafe
to try to change the fault handling for a running system.  It's even more
unsafe to try to remove a fault handler which is located in module code.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
