Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:42369 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934448AbcCPKH1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2016 06:07:27 -0400
Date: Wed, 16 Mar 2016 11:07:24 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jisheng Zhang <jszhang@marvell.com>
Cc: <jason@lakedaemon.net>, <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: mvebu: constify mvebu_pcie_pm_ops structure
Message-ID: <20160316110724.239fd419@free-electrons.com>
In-Reply-To: <1458122381-2280-2-git-send-email-jszhang@marvell.com>
References: <1458122381-2280-1-git-send-email-jszhang@marvell.com>
	<1458122381-2280-2-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jisheng Zhang,

On Wed, 16 Mar 2016 17:59:40 +0800, Jisheng Zhang wrote:
> The mvebu_pcie_pm_ops structure is never modified, so declare it as
> const.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/pci/host/pci-mvebu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
