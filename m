Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55017 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756984AbcDGQyL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 7 Apr 2016 12:54:11 -0400
Date: Thu, 7 Apr 2016 11:54:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jisheng Zhang <jszhang@marvell.com>
Cc: thomas.petazzoni@free-electrons.com, jason@lakedaemon.net,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: mvebu: trivial cleanup
Message-ID: <20160407165400.GD8780@localhost>
References: <1458122381-2280-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458122381-2280-1-git-send-email-jszhang@marvell.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 16, 2016 at 05:59:39PM +0800, Jisheng Zhang wrote:
> trivial clean ups to pci-mvebu.c
> 
> Jisheng Zhang (2):
>   PCI: mvebu: constify mvebu_pcie_pm_ops structure
>   PCI: mvebu: use SET_NOIRQ_SYSTEM_SLEEP_PM_OPS for mvebu_pcie_pm_ops

Applied with Thomas' ack to pci/host-mvebu for v4.7, thanks!
