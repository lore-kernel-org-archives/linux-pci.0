Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753950AbeAQStp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jan 2018 13:49:45 -0500
Date: Wed, 17 Jan 2018 11:49:44 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        "Jan H . =?UTF-8?B?U2Now7ZuaGVycg==?=" <jschoenh@amazon.de>
Subject: Re: [PATCH] pci: Do not read INTx PIN and LINE registers for
 virtual functions
Message-ID: <20180117114944.4835c296@w520.home>
In-Reply-To: <1516213829-14844-1-git-send-email-karahmed@amazon.de>
References: <1516213829-14844-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 17 Jan 2018 19:30:29 +0100
KarimAllah Ahmed <karahmed@amazon.de> wrote:

> ... since INTx is not supported by-spec for virtual functions.

But the spec also states that VFs must implement the interrupt pin
register as read-only zero, so either this is redundant or it's a
workaround for VFs that aren't quite compliant?  Thanks,

Alex

> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
> ---
>  drivers/pci/probe.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 65099d0..61002fb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1232,6 +1232,13 @@ static void pci_read_irq(struct pci_dev *dev)
>  {
>  	unsigned char irq;
>  
> +	/* Virtual functions do not have INTx support */
> +	if (dev->is_virtfn) {
> +		dev->pin = 0;
> +		dev->irq = 0;
> +		return;
> +	}
> +
>  	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &irq);
>  	dev->pin = irq;
>  	if (irq)
