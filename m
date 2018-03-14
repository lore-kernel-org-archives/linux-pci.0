Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:35468 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbeCNRl3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Mar 2018 13:41:29 -0400
MIME-Version: 1.0
In-Reply-To: <20180314163455.15854-2-desnesn@linux.vnet.ibm.com>
References: <20180314163455.15854-1-desnesn@linux.vnet.ibm.com> <20180314163455.15854-2-desnesn@linux.vnet.ibm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Mar 2018 19:41:27 +0200
Message-ID: <CAHp75VdOaE-efzbQV=Mtf+a1-6L5JxF10Uc+uZ+LYz3S757biw@mail.gmail.com>
Subject: Re: [PATCH 1/2, pci] pci: Addition of PCI_DEV_FLAGS_QUIET_PCI_REALIGN
 attribute to the PCI subsystem
To: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
        <linuxppc-dev@lists.ozlabs.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ruscur@russell.cc,
        aik@ozlabs.ru, david@gibson.dropbear.id.au,
        fbarrat@linux.vnet.ibm.com, brking@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 14, 2018 at 6:34 PM, Desnes A. Nunes do Rosario
<desnesn@linux.vnet.ibm.com> wrote:
> Add PCI_DEV_FLAGS_QUIET_PCI_REALIGN to pci_dev_flags and use it to
> silent PCI realignment messages if the flag is turned on by a driver.

It doesn't explain "Why?"
Why the driver needs that?

Another approach is to increase level of the message. Would it be
accepted by you (in case Bjorn agrees)?

> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -205,6 +205,8 @@ enum pci_dev_flags {
>         PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
>         /* Don't use Relaxed Ordering for TLPs directed at this device */
>         PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
> +       /* Silent PCI resource realignment messages */
> +       PCI_DEV_FLAGS_QUIET_PCI_REALIGN = (__force pci_dev_flags_t) (1 << 12),

I would rather name it _NO_PCI_REALIGN_MSG

>  };

-- 
With Best Regards,
Andy Shevchenko
