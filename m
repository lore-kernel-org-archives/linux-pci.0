Return-Path: <SRS0=slvM=EL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0EDC55178
	for <linux-pci@archiver.kernel.org>; Thu,  5 Nov 2020 20:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A80B020756
	for <linux-pci@archiver.kernel.org>; Thu,  5 Nov 2020 20:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgKEUmI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 5 Nov 2020 15:42:08 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:56052 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726214AbgKEUmH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 15:42:07 -0500
Received: from cpc79921-stkp12-2-0-cust288.10-2.cable.virginm.net ([86.16.139.33] helo=[192.168.1.4])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1kam56-0006I9-Pu; Thu, 05 Nov 2020 20:42:04 +0000
Subject: Re: [PATCH v1 1/2] PCI: Disable MSI for Pericom PCIe-USB adapter
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        johan@kernel.org, linux-usb@vger.kernel.org
Cc:     alberto.vignani@fastwebnet.it
References: <20201105180644.42862-1-andriy.shevchenko@linux.intel.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <0c48dd87-82a2-3dfa-6b00-57ccf9d5dd0b@codethink.co.uk>
Date:   Thu, 5 Nov 2020 20:42:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201105180644.42862-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05/11/2020 18:06, Andy Shevchenko wrote:
> Pericom PCIe-USB adapter ambiguously advertises MSI, but documentation says
> "The MSI Function is not implemented on this device." in the chapters 7.3.27,
> 7.3.29-7.3.31.
> 
> Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
> Datasheet: https://www.diodes.com/assets/Datasheets/PI7C9X440SL.pdf
> Reported-by: alberto.vignani@fastwebnet.it
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/pci/quirks.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f70692ac79c5..7df7ae50618c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5567,17 +5567,25 @@ static void pci_fixup_no_d0_pme(struct pci_dev *dev)
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x2142, pci_fixup_no_d0_pme);
>   
>   /*
> - * Device [12d8:0x400e] and [12d8:0x400f]
> + * Device 12d8:0x400e [OHCI] and 12d8:0x400f [EHCI]
> + *
>    * These devices advertise PME# support in all power states but don't
>    * reliably assert it.
> + *
> + * These devices ambiguously advertise MSI, but documentation (PI7C9X440SL.pdf)
> + * says "The MSI Function is not implemented on this device." in the chapters
> + * 7.3.27, 7.3.29-7.3.31.
>    */
> -static void pci_fixup_no_pme(struct pci_dev *dev)
> +static void pci_fixup_no_msi_no_pme(struct pci_dev *dev)
>   {
> +	pci_info(dev, "The MSI Function is not implemented on this device, disabling it\n");
> +	dev->no_msi = 1;
> +
>   	pci_info(dev, "PME# is unreliable, disabling it\n");
>   	dev->pme_support = 0;
>   }


idea: one pci_info() print of:

pci_info(dev, "PME# is unreliable, MSI not implemented, disabling both\n");

> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400e, pci_fixup_no_pme);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400f, pci_fixup_no_pme);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400e, pci_fixup_no_msi_no_pme);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400f, pci_fixup_no_msi_no_pme);
>   
>   static void apex_pci_fixup_class(struct pci_dev *pdev)
>   {
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
