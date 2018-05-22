Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33130 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753306AbeEVXUP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 19:20:15 -0400
Subject: Re: [PATCH 3/4] PCI: rcar: Add missing irq_dispose_mapping() into
 failpath
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20180521131123.2009-1-marek.vasut+renesas@gmail.com>
 <20180521131123.2009-3-marek.vasut+renesas@gmail.com>
 <CAMuHMdV9_-MRLDP98G5J5v1bojAUmRLvSkyf3Fhmn41t1rpn4g@mail.gmail.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <a95615e8-69f7-886e-f659-6b9880debf28@gmail.com>
Date: Tue, 22 May 2018 23:51:09 +0200
MIME-Version: 1.0
In-Reply-To: <CAMuHMdV9_-MRLDP98G5J5v1bojAUmRLvSkyf3Fhmn41t1rpn4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/22/2018 05:18 PM, Geert Uytterhoeven wrote:
> Hi Marek,

Hi,

> On Mon, May 21, 2018 at 3:11 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> The rcar_pcie_get_resources() is another misnomer with a side effect.
>> The function does not only get resources, but also maps MSI IRQs via
>> irq_of_parse_and_map(). In case anything fails afterward, the IRQ
>> mapping must be disposed through irq_dispose_mapping() which is not
>> done.
>>
>> This patch handles irq_of_parse_and_map() failures in by disposing
>> of the mapping in rcar_pcie_get_resources() as well as in probe.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
>> --- a/drivers/pci/host/pcie-rcar.c
>> +++ b/drivers/pci/host/pcie-rcar.c
>> @@ -923,18 +923,25 @@ static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
>>         i = irq_of_parse_and_map(dev->of_node, 0);
>>         if (!i) {
>>                 dev_err(dev, "cannot get platform resources for msi interrupt\n");
>> -               return -ENOENT;
>> +               err = -ENOENT;
>> +               goto err_irq1;
> 
> You could have kept the return here.

I like the symmetry ;-)

[...]

-- 
Best regards,
Marek Vasut
