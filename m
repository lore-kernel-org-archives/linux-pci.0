Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:42517 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab3GIQe2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jul 2013 12:34:28 -0400
Received: by mail-ob0-f170.google.com with SMTP id ef5so7316542obb.29
        for <linux-pci@vger.kernel.org>; Tue, 09 Jul 2013 09:34:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130708165149.55499b8e@skate>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo4aodspFnC0uR87yYAgswQQdmU48uoX5NA43UZjbCpOuw@mail.gmail.com> <20130708165149.55499b8e@skate>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 9 Jul 2013 10:34:08 -0600
Message-ID: <CAErSpo6rDAdN4UVReYx7EAXuOtFutyPK-gT2Vd4j2OGEUCzNsQ@mail.gmail.com>
Subject: Re: [PATCHv4 04/11] PCI: Introduce new MSI chip infrastructure
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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
	Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 8, 2013 at 8:51 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Bjorn Helgaas,
>
> On Fri, 5 Jul 2013 15:51:10 -0600, Bjorn Helgaas wrote:
>
>> >  int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>> >  {
>> > +       struct msi_chip *chip = dev->bus->msi;
>> > +
>> > +       if (chip && chip->setup_irq) {
>> > +               int err;
>> > +
>> > +               err = chip->setup_irq(chip, dev, desc);
>> > +               if (err < 0)
>> > +                       return err;
>> > +
>> > +               irq_set_chip_data(desc->irq, chip);
>> > +               return err;
>> > +       }
>> > +
>> >         return -EINVAL;
>>
>> It's sub-optimal to indent the whole body of a function like this.  I
>> think this is a bit more readable:
>>
>>     if (!chip || !chip->setup_irq)
>>         return -EINVAL
>>
>>     err = chip->setup_irq(...);
>>     ...
>>     return err;
>>
>> The return value of ->setup_irq() (and hence of arch_setup_msi_irq())
>> is a bit unclear.  Apparently it can return negative values (errors)
>> or positive values (not sure what they mean), or zero (again, not
>> sure).  A comment would clear this up.
>
> I've changed ->setup_irq() to simply return 0 on success, and a
> negative error code on failure.

Perfect.

> Apparently, according to the default implementation
> of arch_msi_setup_irqs(), the arch_msi_setup_irq() hook is supposed to
> return:
>  * A negative value on error, the value being an error code that is
>    propagated to the caller.
>  * A positive value on some other errors, in which case the -ENOSPC
>    error value is returned. To me, it doesn't make a lot of sense, as
>    arch_msi_setup_irq() could just as well return -ENOSPC directly.
>  * A 0 value on success.
>
>> It might even be worth introducing a no-op chip with pointers to no-op
>> functions so we don't have to do these checks ("if (chip &&
>> chip->xxx)" everywhere.  I'm not sure if there's a Linux consensus on
>> that -- certainly there are many examples of code that *does* make
>> these checks everywhere -- so I'll ack it either way.
>
> The problem with this is that I'm not sure where in the PCI code this
> association to the default implementation should be done. And there are
> also two levels to take into account here:
>
>  * The PCI driver may not specify any msi_chip structure for a
>    particular pci_bus. This would have to be detected by the PCI core
>    when the bus is registered, and bus->msi would be set to the special
>    no-op msi_chip.
>
>  * The PCI driver may specify an msi_chip structure, but without
>    necessarily implementation all the methods. This could be solved by
>    offering a pci_msi_chip_assign(struct pci_bus *, struct msi_chip *)
>    function to be used by PCI drivers to assign their msi_chip to a
>    given pci_bus, and this function would fill in the missing msi_chip
>    operations with the default implementation.
>
> I am not sure it is really worth doing at this point, but I'm open to
> suggestions on this.

Sounds like it's not worth doing.  Thanks for checking into it.

>> >  int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
>> >  {
>> > +       struct msi_chip *chip = dev->bus->msi;
>> > +
>> > +       if (chip && chip->check_device)
>> > +               return chip->check_device(chip, dev, nvec, type);
>> > +
>>
>> These functions are poorly named.  They give no clue what
>> "check_device" means.  Are we checking that it exists, that it
>> supports some property, that it's enabled, ... ?
>
> Well the naming clearly doesn't come from this commit. The
> arch_msi_check_device() hook was around before this commit, and the
> reason the operation is named ->check_device() is just because it used
> the same terminology as the existing arch_msi_check_device() call.
>
> This hook is only used in one place, the PowerPC architecture, in
> arch/powerpc/kernel/msi.c, to actually check whether the given device
> supports MSI.
>
> I can rename if to arch_msi_device_supports_msi() and
> ->device_supports_msi(), or arch_msi_device_has_msi() and
> ->device_has_msi(), but that a change that relatively unrelated to this
> commit, I'd say.
>
> Here as well, I'm open to suggestions,

You're right, you didn't make that mess, so I guess it's OK if you
don't clean it up here.  I spent a fair amount of time yesterday
analyzing the return values, and lost interest before all became
clear.  So I stand by my assertion that it is hard to read, but I'm OK
with leaving it as-is for now.

Bjorn
