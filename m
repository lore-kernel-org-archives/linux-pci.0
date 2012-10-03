Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUXmURaO40sA4ibf7j9sokEHYXK_EaGiEq9b-ob=d1MRw@mail.gmail.com>
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
Date: Tue, 2 Oct 2012 19:07:28 -0700
Message-ID: <CAE9FiQVpLtMMAvWF-ehKCpNXW=uxwQWhpcHmgRJFDP22AKY1Mw@mail.gmail.com>
Subject: Re: [PATCH 01/10] device: add drivers_autoprobe in struct device
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 2, 2012 at 5:00 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Oct 2, 2012 at 3:38 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>> I don't know what the right answer is, but I do think it's better to
>> resolve it inside PCI and ACPI rather than playing games with driver
>> binding times in the driver core.
>
> is that ok to save that drivers_autoprobe bit in device.archdata for
> ia64 and x86 that using acpi?

updated patch to put the bit in pci_dev and acpi_device instead.

please check attached patches.

Yinghai
