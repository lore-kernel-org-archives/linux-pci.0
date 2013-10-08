Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:42300 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753442Ab3JHRZN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 13:25:13 -0400
Date: Tue, 8 Oct 2013 13:25:10 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-pci@vger.kernel.org,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>
Subject: Re: [PATCH v3] PCI: mvebu: add I/O access wrappers
Message-ID: <20131008172510.GQ5402@titan.lakedaemon.net>
References: <001e01cea3e5$410cf6d0$c326e470$%jun@samsung.com>
 <20130828141417.139ad2b0@skate>
 <002101cec0e8$3ec9c7c0$bc5d5740$%jun@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <002101cec0e8$3ec9c7c0$bc5d5740$%jun@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 04, 2013 at 06:58:15PM +0900, Seungwon Jeon wrote:
> This change adds wrapper functions for MMIO access to PCIe IP block.
> And some 8/16-bit access are replaced by 32-bit.
> 
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> Changes in v3:
>  - Just rebased
>  - Modified commit message
> 
> Changes in v2:
>  - Only 32-bit accessors are kept(from Thomas Petazzoni)
> 
>  drivers/pci/host/pci-mvebu.c |   97 ++++++++++++++++++++++++------------------
>  1 files changed, 55 insertions(+), 42 deletions(-)

Applied to mvebu/drivers

thx,

Jason.
