Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <524E04C1.7010605@redhat.com>
Date: Thu, 03 Oct 2013 19:58:57 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Yinghai Lu <yinghai@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 1/2] ACPI / PCI: don't allow PCI devices without irq to
 be enabled
References: <1375965314-24232-1-git-send-email-heikki.krogerus@linux.intel.com> <1375965314-24232-2-git-send-email-heikki.krogerus@linux.intel.com> <14983102.aCV009CSMA@vostro.rjw.lan> <CAErSpo6N65EOy6ieZSKN8eO09GoCFe05YOMRNMhx8RLHbqN=yw@mail.gmail.com> <CAE9FiQV3ohndZGvWHByA76G=Cb3NEVn4ukpoF==zHsLw8oaopA@mail.gmail.com> <CAErSpo6dmSwcM5ensq1fKL=-mbLNyi9G+U+LPA1P=pP8j9=EoA@mail.gmail.com>
In-Reply-To: <CAErSpo6dmSwcM5ensq1fKL=-mbLNyi9G+U+LPA1P=pP8j9=EoA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 08/12/2013 06:32 PM, Bjorn Helgaas wrote:
> On Mon, Aug 12, 2013 at 3:32 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Mon, Aug 12, 2013 at 2:14 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> On Thu, Aug 8, 2013 at 7:57 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>>> On Thursday, August 08, 2013 03:35:13 PM Heikki Krogerus wrote:
>>>>> If there is no ACPI entry for the irq, returning error from
>>>>> acpi_pci_enable_irq() if the irq is 0.
>>>>>
>>>>> Prarit Bhargava reported an issue where he noticed that his
>>>>> Dell PowerEdge 840 has buggy BIOS that does not supply ACPI
>>>>> entries for irq with some devices. That lead into kernel
>>>>> generating a warning "genirq: Flags mismatch irq 0...". This
>>>>> will fix that issue.
>>>>>
>>>>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>>>> Tested-by: Prarit Bhargava <prarit@redhat.com>
>>>>
>>>> Hi Bjorn,
>>>>
>>>> Any objections to this?
>>>
>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>> some USB3 host controller does not have intx configured, but still
>> work with MSI?
> 
> Huh, OK, I take back my ack, at least while we investigate this.
> 

Bjorn, as suggested I've opened up a BZ here:

https://bugzilla.kernel.org/show_bug.cgi?id=62521

I've only cc'd yourself and Rafael.  Heikki -- I didn't find an account under
your intel.com address ...

P.
