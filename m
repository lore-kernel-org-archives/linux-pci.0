Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36813 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab2GMPnz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jul 2012 11:43:55 -0400
Received: by lbbgm6 with SMTP id gm6so5981120lbb.19
        for <linux-pci@vger.kernel.org>; Fri, 13 Jul 2012 08:43:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1342151381-15255-1-git-send-email-gerg@snapgear.com>
References: <1342151381-15255-1-git-send-email-gerg@snapgear.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 13 Jul 2012 09:43:32 -0600
Message-ID: <CAErSpo56ueJApLdesi+GVBe=pDfFnQfL84FcPcqWC-Az0cfwgg@mail.gmail.com>
Subject: Re: [PATCH] pci: add pci resource code to build for M68K architecture
To: gerg@snapgear.com
Cc: linux-pci@vger.kernel.org, linux-m68k@vger.kernel.org,
	Greg Ungerer <gerg@uclinux.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 12, 2012 at 9:49 PM,  <gerg@snapgear.com> wrote:
> From: Greg Ungerer <gerg@uclinux.org>
>
> The ColdFire M54xx family of CPU cores (supported by the m68k arch code)
> have PCI bus harwdare. We want to be able to use this and will need the
> setup-bus.c and setup-irq.c helper functions. So when CONFIG_M68K is enabled
> add them to the objs build list.
>
> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
> ---
>  drivers/pci/Makefile |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 01c001f..8d688b2 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -49,6 +49,7 @@ obj-$(CONFIG_MN10300) += setup-bus.o
>  obj-$(CONFIG_MICROBLAZE) += setup-bus.o
>  obj-$(CONFIG_TILE) += setup-bus.o setup-irq.o
>  obj-$(CONFIG_SPARC_LEON) += setup-bus.o setup-irq.o
> +obj-$(CONFIG_M68K) += setup-bus.o setup-irq.o
>
>  #
>  # ACPI Related PCI FW Functions

Applied to my "next" branch, thanks!

Bjorn
