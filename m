Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36005 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab3LWR6H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Dec 2013 12:58:07 -0500
Received: by mail-ie0-f174.google.com with SMTP id at1so6182388iec.19
        for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2013 09:58:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201312231512.rBNFC6mo008974@cosmhbs0.lsi.com>
References: <201312231512.rBNFC6mo008974@cosmhbs0.lsi.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 23 Dec 2013 10:57:46 -0700
Message-ID: <CAErSpo7X4khuPOp5s4MdunOmwww0V4JZipJa3iEOA=Y5nnCwqA@mail.gmail.com>
Subject: Re: [PATCH] megaraid_sas: Quirk mmio hook for 1078 MR controller
To: "Desai, Kashyap" <Kashyap.Desai@lsi.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"James E.J. Bottomley" <jbottomley@parallels.com>,
	sumit.saxena@lsi.com, Adam Radford <aradford@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 23, 2013 at 8:13 AM,  <Kashyap.Desai@lsi.com> wrote:
> This patch has fix for LSI Gen-1 MR controller issue which only pop-up on
> few systems and it is not generic.
>
> On few system, MR 1078 MR controller is not working if mmio decoding is off.
> This patch proposed early quirck entry for Device id 0x1000/0x0411 to enable mmio.
>
> Signed-off-by: Kashyap Desai <kashyap.desai@lsi.com>
> ---
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f6c31fa..a20fe41 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -43,6 +43,10 @@ static void quirk_mmio_always_on(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_ANY_ID, PCI_ANY_ID,
>                                 PCI_CLASS_BRIDGE_HOST, 8, quirk_mmio_always_on);
> +/* LSI controller device id 0x0411 has some issues if mmio_always_on is not set.
> + * It pop-up only on few specific system, where decoding disable is not working.
> + */
> +DECLARE_PCI_FIXUP_EARLY(0x1000, 0x0411, quirk_mmio_always_on);

What is the actual problem that happens without this quirk?  Is there
some hardware defect in the MR 1078 that makes it fail when we disable
decoding?

Disabling decoding is important because it prevents conflicts with
other devices while sizing and updating BARs, so I don't want to use
this quirk unless it's really necessary.

Bjorn
