Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:46668 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbaFNIpL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 Jun 2014 04:45:11 -0400
Received: by mail-qc0-f181.google.com with SMTP id x13so5286766qcv.40
        for <linux-pci@vger.kernel.org>; Sat, 14 Jun 2014 01:45:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1402669218.4802.3.camel@weser.hi.pengutronix.de>
References: <1401979572-32101-1-git-send-email-l.stach@pengutronix.de>
	<1401979572-32101-2-git-send-email-l.stach@pengutronix.de>
	<CAHM4w1kfsVbcNquK4t1NJqYRc9Qrjg6JYNJuAV=cpZ81Zm-pnw@mail.gmail.com>
	<1402669218.4802.3.camel@weser.hi.pengutronix.de>
Date: Sat, 14 Jun 2014 14:15:10 +0530
Message-ID: <CAHM4w1=rvLeWjRZWQtnN05_dmt=bYOPM-y6oY6PnP4J-Nv7oQw@mail.gmail.com>
Subject: Re: [PATCH 1/4] PCI: allow MSI chip providers to implement their own
 multiple MSI setup
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit Kumar <mohit.kumar@st.com>, kernel@pengutronix.de,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	Richard Zhu <richard.zhu@linaro.org>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Pratyush ANAND <pratyush.anand@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lucas,



On Fri, Jun 13, 2014 at 7:50 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Hi Pratyush,
>
> Am Freitag, den 13.06.2014, 11:12 +0530 schrieb Pratyush Anand:
>>  Hi Lucas,
>>
>>
>> On Thu, Jun 5, 2014 at 8:16 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
>> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>> > ---
>> >  drivers/pci/msi.c   | 3 +++
>> >  include/linux/msi.h | 2 ++
>> >  2 files changed, 5 insertions(+)
>> >
>> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> > index 27a7e67ddfe4..c45399d3061a 100644
>> > --- a/drivers/pci/msi.c
>> > +++ b/drivers/pci/msi.c
>> > @@ -68,9 +68,12 @@ int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
>> >
>> >  int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>> >  {
>> > +       struct msi_chip *chip = dev->bus->msi;
>> >         struct msi_desc *entry;
>> >         int ret;
>> >
>> > +       if (chip && chip->setup_irqs)
>>
>> I think, you should also check here for nvec > 1
>
> No, nvec == 1 is just a special case and is perfectly valid.

So it means that the platform which supports setup_irqs need not
support setup_irq. May be it can be
documented atleast as a comment somewhere and then setup_irq can be
removed from designware driver.

>>
>> > +               return chip->setup_irqs(chip, dev, nvec, type);
>>
>> Before return, shouldn't we set chip_data for all desc->irq?
>
> Setting chip_data is done in the MSI irq domains map callback and is the
> same for single or multiple MSI setup. No need to do anything special
> here.

But I see arch_setup_msi_irq function in this file doing it.

Regards
Pratyush
