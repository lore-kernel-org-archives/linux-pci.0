Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:52287 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeC1NA5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Mar 2018 09:00:57 -0400
Subject: Re: [PATCH 6/8] PCI: dwc: Replace lower into upper case characters
To: Fabio Estevam <festevam@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
References: <cover.1522235224.git.gustavo.pimentel@synopsys.com>
 <e3c679c8bd516602d1f7cf5182cf718414e74089.1522235224.git.gustavo.pimentel@synopsys.com>
 <CAOMZO5AyzTqpVofx6wf4oHsWjwaC=94o8dgbJSs0rhnc8OwPkA@mail.gmail.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <f3b1d6f1-708e-b467-91a6-304a204a3655@synopsys.com>
Date: Wed, 28 Mar 2018 14:00:10 +0100
MIME-Version: 1.0
In-Reply-To: <CAOMZO5AyzTqpVofx6wf4oHsWjwaC=94o8dgbJSs0rhnc8OwPkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Fabio,

On 28/03/2018 13:05, Fabio Estevam wrote:
> Hi Gustavo,
> 
> On Wed, Mar 28, 2018 at 8:38 AM, Gustavo Pimentel
> <gustavo.pimentel@synopsys.com> wrote:
> 
>> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
>> index 550fdbb..03e9b82 100644
>> --- a/drivers/pci/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/dwc/pcie-designware-host.c
>> @@ -248,8 +248,10 @@ static void dw_pcie_irq_domain_free(struct irq_domain *domain,
>>         unsigned long flags;
>>
>>         raw_spin_lock_irqsave(&pp->lock, flags);
>> +
>>         bitmap_release_region(pp->msi_irq_in_use, data->hwirq,
>>                               order_base_2(nr_irqs));
>> +
>>         raw_spin_unlock_irqrestore(&pp->lock, flags);
>>  }
> 
> This looks like an unrelated change.

Yes, it's not a replace character from lower to upper case. It's just a code
formatting style to be coherent with the rest of the driver code. I guess I can
added on the patch description a note about it.
It works for you?
Thanks.

> 
Regards,
Gustavo
