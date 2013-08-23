Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:41624 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab3HWRAc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Aug 2013 13:00:32 -0400
Received: by mail-ie0-f177.google.com with SMTP id e14so1144694iej.8
        for <linux-pci@vger.kernel.org>; Fri, 23 Aug 2013 10:00:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6dmSwcM5ensq1fKL=-mbLNyi9G+U+LPA1P=pP8j9=EoA@mail.gmail.com>
References: <1375965314-24232-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1375965314-24232-2-git-send-email-heikki.krogerus@linux.intel.com>
 <14983102.aCV009CSMA@vostro.rjw.lan> <CAErSpo6N65EOy6ieZSKN8eO09GoCFe05YOMRNMhx8RLHbqN=yw@mail.gmail.com>
 <CAE9FiQV3ohndZGvWHByA76G=Cb3NEVn4ukpoF==zHsLw8oaopA@mail.gmail.com> <CAErSpo6dmSwcM5ensq1fKL=-mbLNyi9G+U+LPA1P=pP8j9=EoA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 23 Aug 2013 11:00:11 -0600
Message-ID: <CAErSpo7KDY87QPLNwbufeUAFGBtvyGteDmk6AxqFXBOX0RaObw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI / PCI: don't allow PCI devices without irq to be enabled
To: Yinghai Lu <yinghai@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Prarit Bhargava <prarit@redhat.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 12, 2013 at 4:32 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
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

Is anybody looking into this?  I'm afraid I gave the impression that
*I* would investigate this.  But I don't really have enough
information, and it would be better if the patch author and the
reporter could investigate it first.

It would help if there were a bugzilla with complete dmesg log, acpidump, etc.

Bjorn
