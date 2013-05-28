Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:42584 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934848Ab3E1RFv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2013 13:05:51 -0400
Received: by mail-ob0-f178.google.com with SMTP id fb19so2109125obc.9
        for <linux-pci@vger.kernel.org>; Tue, 28 May 2013 10:05:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKXJSOEeeOemeFk4EHZmoVB2q1FLd_RO+EoTzyn_qR4fND1OMA@mail.gmail.com>
References: <CAKXJSOEeeOemeFk4EHZmoVB2q1FLd_RO+EoTzyn_qR4fND1OMA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 28 May 2013 11:05:30 -0600
Message-ID: <CAErSpo54ChPNoiNiWngLh-RkCASYN16CQXEa7_qMAYMhb4sPhg@mail.gmail.com>
Subject: Re: [PATCH] PCI: fix a typo in the comment for pci.c/pci_swizzle_interrupt_pin
To: Wang Sheng-Hui <shhuiw@gmail.com>
Cc: Martin Mares <mj@ucw.cz>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 27, 2013 at 9:17 PM, Wang Sheng-Hui <shhuiw@gmail.com> wrote:
> The INTx pin should be INIT[ABCD]. Fix the type "3=INTC".
>
> Signed-off-by: Wang Sheng-Hui <shhuiw@gmail.com>

Applied to my pci/misc branch for v3.11, thanks!

> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a899d8b..e5f4e55 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2421,7 +2421,7 @@ bool pci_acs_path_enabled(struct pci_dev *start,
>  /**
>   * pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
>   * @dev: the PCI device
> - * @pin: the INTx pin (1=INTA, 2=INTB, 3=INTD, 4=INTD)
> + * @pin: the INTx pin (1=INTA, 2=INTB, 3=INTC, 4=INTD)
>   *
>   * Perform INTx swizzling for a device behind one level of bridge.  This is
>   * required by section 9.1 of the PCI-to-PCI bridge specification for devices
> --
> 1.7.12.4
