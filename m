Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:63726 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760722AbbA3WPZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jan 2015 17:15:25 -0500
Received: by mail-qc0-f175.google.com with SMTP id c9so22837934qcz.6
        for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2015 14:15:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1666566.z9ZP4KJ7VA@wuerfel>
References: <1666566.z9ZP4KJ7VA@wuerfel>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 30 Jan 2015 16:15:04 -0600
Message-ID: <CAErSpo7iqe07HQBpbGfr8=FwK3wF0dkCFvjAJRBvd7HusMjjvg@mail.gmail.com>
Subject: Re: [PATCH] ARM: integrator: remove unused variable
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>,
	Rob Herring <robh@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 30, 2015 at 3:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The patch to add the new generic config space accessors removed
> a useless spinlock, but left the flags variable in place, which
> now causes a build warning:
>
> arch/arm/mach-integrator/pci_v3.c: In function 'pci_v3_preinit':
> arch/arm/mach-integrator/pci_v3.c:614:16: warning: unused variable 'flags' [-Wunused-variable]
>
> This removes it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 1ba525109219 ("ARM: integrator: Convert PCI to use generic config accessors")

Folded in, thanks!

>
> diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
> index dc7782f26cbb..2565f0e7b5cf 100644
> --- a/arch/arm/mach-integrator/pci_v3.c
> +++ b/arch/arm/mach-integrator/pci_v3.c
> @@ -611,7 +611,6 @@ static int __init pci_v3_setup(int nr, struct pci_sys_data *sys)
>   */
>  static void __init pci_v3_preinit(void)
>  {
> -       unsigned long flags;
>         unsigned int temp;
>         phys_addr_t io_address = pci_pio_to_address(io_mem.start);
>
>
