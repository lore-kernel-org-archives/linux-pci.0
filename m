Return-Path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520412364-2680-1-git-send-email-wei.guo.simon@gmail.com>
To: wei.guo.simon@gmail.com, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Simon Guo <wei.guo.simon@gmail.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: PCI/hotplug: ppc: correct a php_slot usage after free
Message-Id: <401RHS1y6kz9sRX@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:43 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2018-03-07 at 08:46:04 UTC, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> In pnv_php_unregister_one(), pnv_php_put_slot() might kfree
> php_slot structure. But there is pci_hp_deregister() after
> that with php_slot reference.
> 
> This patch moves pnv_php_put_slot() to the end of function.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/97c6f25d5828b497e3e802b1f7c701

cheers
