Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729097AbeGZMMk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Jul 2018 08:12:40 -0400
Date: Thu, 26 Jul 2018 11:56:17 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: mobiveil: integer overflow in IB_WIN_SIZE
Message-ID: <20180726105617.GA6181@red-moon>
References: <20180705094539.xkmtfffbzl3kooum@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180705094539.xkmtfffbzl3kooum@kili.mountain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 05, 2018 at 12:45:39PM +0300, Dan Carpenter wrote:
> IB_WIN_SIZE is larger than INT_MAX so we need to cast it to u64.
> 
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Untested...  Possibly the problem is that there are too many multiplies
> by * 1024.
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c

Applied to pci/mobiveil for v4.19 (it is still not fixing anything
given that the driver lacks a Kconfig and Makefile entries - that
must be fixed with urgency), thanks.

Lorenzo

> index 4d6c20e47bed..cf0aa7cee5b0 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -107,7 +107,7 @@
>  #define CFG_WINDOW_TYPE	0
>  #define IO_WINDOW_TYPE		1
>  #define MEM_WINDOW_TYPE	2
> -#define IB_WIN_SIZE		(256 * 1024 * 1024 * 1024)
> +#define IB_WIN_SIZE		((u64)256 * 1024 * 1024 * 1024)
>  #define MAX_PIO_WINDOWS	8
>  
>  /* Parameters for the waiting for link up routine */
