Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50211 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752249Ab3KGJLV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Nov 2013 04:11:21 -0500
Date: Thu, 7 Nov 2013 10:11:18 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jisheng Zhang <jszhang@marvell.com>
Cc: <bhelgaas@google.com>, <jason@lakedaemon.net>,
	<ezequiel.garcia@free-electrons.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: mvebu: staticize mvebu_pcie_align_resource
Message-ID: <20131107101118.72f2c0e3@skate>
In-Reply-To: <1383815155-5318-1-git-send-email-jszhang@marvell.com>
References: <1383815155-5318-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jisheng Zhang,

On Thu, 7 Nov 2013 17:05:55 +0800, Jisheng Zhang wrote:
> This patch fixes the following sparse warning:
> drivers/pci/host/pci-mvebu.c:676:17: warning: symbol
> 'mvebu_pcie_align_resource' was not declared. Should it be static?
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Thanks, but a similar patch was already merged:

https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/drivers/pci/host/pci-mvebu.c?id=f5072dfbac053200c8865c4fb15e4f020b7b5d1d

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
