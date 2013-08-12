Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAErSpo6N65EOy6ieZSKN8eO09GoCFe05YOMRNMhx8RLHbqN=yw@mail.gmail.com>
References: <1375965314-24232-1-git-send-email-heikki.krogerus@linux.intel.com>
	<1375965314-24232-2-git-send-email-heikki.krogerus@linux.intel.com>
	<14983102.aCV009CSMA@vostro.rjw.lan>
	<CAErSpo6N65EOy6ieZSKN8eO09GoCFe05YOMRNMhx8RLHbqN=yw@mail.gmail.com>
Date: Mon, 12 Aug 2013 14:32:00 -0700
Message-ID: <CAE9FiQV3ohndZGvWHByA76G=Cb3NEVn4ukpoF==zHsLw8oaopA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI / PCI: don't allow PCI devices without irq to be enabled
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Prarit Bhargava <prarit@redhat.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 12, 2013 at 2:14 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Aug 8, 2013 at 7:57 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> On Thursday, August 08, 2013 03:35:13 PM Heikki Krogerus wrote:
>>> If there is no ACPI entry for the irq, returning error from
>>> acpi_pci_enable_irq() if the irq is 0.
>>>
>>> Prarit Bhargava reported an issue where he noticed that his
>>> Dell PowerEdge 840 has buggy BIOS that does not supply ACPI
>>> entries for irq with some devices. That lead into kernel
>>> generating a warning "genirq: Flags mismatch irq 0...". This
>>> will fix that issue.
>>>
>>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>> Tested-by: Prarit Bhargava <prarit@redhat.com>
>>
>> Hi Bjorn,
>>
>> Any objections to this?
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

some USB3 host controller does not have intx configured, but still
work with MSI?

Yinghai
