Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:54164 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab2FZFr6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jun 2012 01:47:58 -0400
Received: by weyu7 with SMTP id u7so3309934wey.19
        for <linux-pci@vger.kernel.org>; Mon, 25 Jun 2012 22:47:57 -0700 (PDT)
Message-ID: <4FE94D08.7040603@monstr.eu>
Date: Tue, 26 Jun 2012 07:47:52 +0200
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
MIME-Version: 1.0
To: Myron Stowe <myron.stowe@redhat.com>
CC: bhelgaas@google.com, linux-pci@vger.kernel.org, rth@twiddle.net,
	ink@jurassic.park.msu.ru, mattst88@gmail.com,
	linux@arm.linux.org.uk, starvik@axis.com, jesper.nilsson@axis.com,
	tony.luck@intel.com, fenghua.yu@intel.com, ralf@linux-mips.org,
	yasutake.koichi@jp.panasonic.com, jejb@parisc-linux.org,
	deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org,
	lethal@linux-sh.org, davem@davemloft.net, cmetcalf@tilera.com,
	gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, chris@zankel.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/16] microblaze/PCI: Factor 'pcibios_setup()' out of
 microblaze
References: <20120626033045.16434.17412.stgit@amt.stowe> <20120626033123.16434.47270.stgit@amt.stowe>
In-Reply-To: <20120626033123.16434.47270.stgit@amt.stowe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/26/2012 05:31 AM, Myron Stowe wrote:
> The PCI core provides a generic (__weak) 'pcibios_setup()' routine that
> can be used by all architectures as a default.  Drop microblaze's
> architecture specific version in favor of that as it does not need to be
> over-ridden.
>
> Signed-off-by: Myron Stowe<myron.stowe@redhat.com>
> ---
>
>   arch/microblaze/pci/pci-common.c |    5 -----
>   1 files changed, 0 insertions(+), 5 deletions(-)
>
> diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
> index ed22bfc..7b510ae 100644
> --- a/arch/microblaze/pci/pci-common.c
> +++ b/arch/microblaze/pci/pci-common.c
> @@ -192,11 +192,6 @@ void pcibios_set_master(struct pci_dev *dev)
>   	/* No special bus mastering setup handling */
>   }
>
> -char __devinit *pcibios_setup(char *str)
> -{
> -	return str;
> -}
> -
>   /*
>    * Reads the interrupt pin to determine if interrupt is use by card.
>    * If the interrupt is used, then gets the interrupt line from the
>

Acked-by: Michal Simek <monstr@monstr.eu>

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
