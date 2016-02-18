Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:53462 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1424150AbcBROb2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Feb 2016 09:31:28 -0500
Date: Thu, 18 Feb 2016 15:29:03 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH] PCI: mvebu: Restrict build to 32-bit ARM
Message-ID: <20160218152903.7a659ca8@free-electrons.com>
In-Reply-To: <1455802330-17565-1-git-send-email-thierry.reding@gmail.com>
References: <1455802330-17565-1-git-send-email-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Thu, 18 Feb 2016 14:32:10 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This driver uses PCI glue that is only available on 32-bit ARM. This
> used to work fine as long as ARCH_MVEBU and ARCH_DOVE were exclusively
> 32-bit, but that's changed now, with ARCH_MVEBU also being available
> on 64-bit ARM.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/pci/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
