Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:53088 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab3FYBxG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jun 2013 21:53:06 -0400
Received: by mail-ob0-f180.google.com with SMTP id eh20so11226136obb.25
        for <linux-pci@vger.kernel.org>; Mon, 24 Jun 2013 18:53:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130620185707.GA8888@mithrandir>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-3-git-send-email-thomas.petazzoni@free-electrons.com> <20130620185707.GA8888@mithrandir>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 24 Jun 2013 19:52:45 -0600
Message-ID: <CAErSpo6Mm6kYZKN_n-fMRD2T1-F0sf9GStmOTA8tT0wVLedCgw@mail.gmail.com>
Subject: Re: [PATCHv3 02/11] pci: use weak functions for MSI arch-specific functions
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 20, 2013 at 12:57 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Wed, Jun 19, 2013 at 06:56:10PM +0200, Thomas Petazzoni wrote:
> [...]
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index 2c10752..4bc0c8f 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -30,19 +30,35 @@ static int pci_msi_enable = 1;
>>
>>  /* Arch hooks */
>>
>> -#ifndef arch_msi_check_device
>> -int arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
>> +int default_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>> +{
>> +     return -EINVAL;
>> +}
>> +
>> +int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>> +{
>> +     return default_setup_msi_irq(dev, desc);
>> +}
>> +
>> +void default_teardown_msi_irq(unsigned int irq)
>> +{
>> +}
>> +
>> +void __weak arch_teardown_msi_irq(unsigned int irq)
>> +{
>> +     return default_teardown_msi_irq(irq);
>> +}
>> +
>> +int default_msi_check_device(struct pci_dev *dev, int nvec, int type)
>>  {
>>       return 0;
>>  }
>> -#endif
>
> I don't think keeping the default_*() for these three is necessary,
> given that they don't do anything and therefore no architecture is
> likely to call them when overriding.

I agree; the whole point of __weak is to provide a "default"
implementation, so I hope you can just remove any empty default_*()
functions and fold the others into the arch_*() functions directly.

If there actually are callbacks from arch-specific strong functions
back to the stuff in the default_*() functions, that suggests that we
should refactor and rename that bit of functionality.

Bjorn
