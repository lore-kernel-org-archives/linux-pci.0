Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:10110 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753716Ab3L0Red (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Dec 2013 12:34:33 -0500
Date: Fri, 27 Dec 2013 12:34:30 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] PCI: mvebu: Use max_t() instead of
 max(resource_size_t,)
Message-ID: <20131227173430.GT19878@titan.lakedaemon.net>
References: <000601cf029b$6bb27e40$43177ac0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000601cf029b$6bb27e40$43177ac0$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 27, 2013 at 09:34:36AM +0900, Jingoo Han wrote:
> Use max_t() instead of max(resource_size_t,) in order to fix
> the following checkpatch warning.
> 
>   WARNING: max() should probably be max_t(resource_size_t, SZ_64K, size)
>   WARNING: max() should probably be max_t(resource_size_t, SZ_1M, size)
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/pci/host/pci-mvebu.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
