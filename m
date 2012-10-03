Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58510 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597Ab2JCUuE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Oct 2012 16:50:04 -0400
MIME-Version: 1.0
In-Reply-To: <CAErSpo4gFhiyS8GdZG21Eo0NPjvedr1+rXtY-MP11hDWCZ+LzA@mail.gmail.com>
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
	<1349159588-15029-2-git-send-email-yinghai@kernel.org>
	<20121002133303.GA502@kroah.com>
	<CAE9FiQVCFs8cgFoU2rb=a8MWCzBcfRT6iNh7UchV8q6Bg6XzGQ@mail.gmail.com>
	<20121002174712.GA11843@kroah.com>
	<CAE9FiQXM6Cy64ZbXtjsnQaMFJi0C1QABC7TNYSBZ3FGsjC8D8w@mail.gmail.com>
	<20121002204548.GC28663@kroah.com>
	<CAE9FiQV51R2RBAZBPobDifq6jQUhBCyx_Bo8EHxOX4yrUMSnLg@mail.gmail.com>
	<CAErSpo5EuGVhu_ObioV-4n7930MkJzD9jrtkn6-JdBLikDBmMg@mail.gmail.com>
	<CAE9FiQUXmURaO40sA4ibf7j9sokEHYXK_EaGiEq9b-ob=d1MRw@mail.gmail.com>
	<CAErSpo4gFhiyS8GdZG21Eo0NPjvedr1+rXtY-MP11hDWCZ+LzA@mail.gmail.com>
Date: Wed, 3 Oct 2012 13:50:02 -0700
Message-ID: <CAE9FiQWgvVqnTTeYFvxf1GxLcEEeRyN-uSKPdg3o69oCpm43sQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] device: add drivers_autoprobe in struct device
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 3, 2012 at 12:48 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> You'll have to ask Len (cc'd) what he thinks about the ACPI piece, but
> I don't like the PCI piece.  It's the same idea that Greg already said
> he wouldn't put in the driver core.  Why would it be better to add
> this complexity in the ACPI and PCI cores?

It should be simplify acpi code a little.

I will reorder acpi parts as separate patcheset for review.

> I still think you need to work on the ACPI/PCI binding issue.  Yes,
> it's hard, but I'm not in favor of avoiding that hard work by adding
> kludges everywhere.

acpi pci binding should be solved if len could accept acpi changes.

for pci separate driver attach, that is for registering pci dev to
tree early instead of
waiting till pci_bus_add_devices.
Let me know if you still want us to pursue that.

Otherwise I'd like to move root bus and host bridge registering into
pci_bus_add_devices().

Thanks

Yinghai
