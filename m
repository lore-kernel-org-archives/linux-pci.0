Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:44973 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751106AbbIYHjB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2015 03:39:01 -0400
Date: Fri, 25 Sep 2015 09:38:58 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/6] mvebu PCI fixes and cleanups
Message-ID: <20150925093858.0af99c28@free-electrons.com>
In-Reply-To: <20150923171706.GL21084@n2100.arm.linux.org.uk>
References: <20150923171706.GL21084@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Russell,

On Wed, 23 Sep 2015 18:17:07 +0100, Russell King - ARM Linux wrote:
> This small series contains a number of fixes and cleanups to the
> mvebu PCI host code.

I've tested this series on my Armada XP GP board, with 3 PCIe cards
connected (one Intel e1000e NIC, one generic AHCI SATA card, and one
Marvell SATA card), and I saw no obvious regressions. The PCIe devices
are still properly enumerated, and they seem to work fine. There is no
change in the 'lspci -vv' output.

Moreover, I've reviewed the different patches, and they look alright to
me.

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Bjorn, will you propagate the Tested-by/Reviewed-by to all patches on
the series, or since I believe you're using patchwork, you want us to
post Tested-by/Reviewed-by replies to each patch?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
