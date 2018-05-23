Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46350 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932071AbeEWLOZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2018 07:14:25 -0400
Subject: Re: [PATCH 4/4] PCI: rcar: Teardown MSI setup if rcar_pcie_enable()
 fails
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20180521131123.2009-1-marek.vasut+renesas@gmail.com>
 <20180521131123.2009-4-marek.vasut+renesas@gmail.com>
 <CAMuHMdVhrb_dR7TP3PU=rsbne+9BZu=BHA9XAK=L1so98HogtA@mail.gmail.com>
 <f4622ab5-3c94-bb99-cfc3-1929dd88092e@gmail.com>
 <CAMuHMdVOEe_PFcCpk_yYRZaBicSToEBZjhJ1Z+88Ct8a1HbXZA@mail.gmail.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <b492dc3d-a2e6-e538-5a4f-05e636fe214e@gmail.com>
Date: Wed, 23 May 2018 12:38:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVOEe_PFcCpk_yYRZaBicSToEBZjhJ1Z+88Ct8a1HbXZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/23/2018 08:18 AM, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Tue, May 22, 2018 at 11:53 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> On 05/22/2018 08:36 PM, Geert Uytterhoeven wrote:
>>> On Mon, May 21, 2018 at 3:11 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>>> --- a/drivers/pci/host/pcie-rcar.c
>>>> +++ b/drivers/pci/host/pcie-rcar.c
>>>> @@ -900,6 +900,28 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
>>>>         return err;
>>>>  }
>>>>
>>>> +static void rcar_pcie_teardown_msi(struct rcar_pcie *pcie)
>>>> +{
>>>> +       struct rcar_msi *msi = &pcie->msi;
>>>> +       int irq, i;
>>>> +
>>>> +       /* Disable all MSI interrupts */
>>>> +       rcar_pci_write_reg(pcie, 0, PCIEMSIIER);
>>>> +
>>>> +       /* Disable address decoding of the MSI interrupt, MSIFE */
>>>> +       rcar_pci_write_reg(pcie, 0, PCIEMSIALR);
>>>> +
>>>> +       free_pages(msi->pages, 0);
>>>> +
>>>> +       for (i = 0; i < INT_PCI_MSI_NR; i++) {
>>>> +               irq = irq_find_mapping(msi->domain, i);
>>>> +               if (irq > 0)
>>>> +                       irq_dispose_mapping(irq);
>>>> +       }
>>>
>>> Note that similar calls to irq_dispose_mapping() should be added to the
>>> failure path of rcar_pcie_enable_msi(), too.
>>
>> There are no failures happening in rcar_pcie_enable_msi() after the
>> mapping is created, just memory writes, so no. Did I miss something there ?
> 
> In my copy, there are two calls to devm_request_irq(). If they fail, the
> IRQ domain is removed, but the mappings are never disposed of.

Ah, true, I'll pull out a bit of the rcar_pcie_teardown_msi and call it
in the failpath to remove the mapping. Thanks

-- 
Best regards,
Marek Vasut
