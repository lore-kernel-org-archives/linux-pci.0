Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34731 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658Ab3IMX4C (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Sep 2013 19:56:02 -0400
Received: by mail-ie0-f175.google.com with SMTP id e14so3799982iej.6
        for <linux-pci@vger.kernel.org>; Fri, 13 Sep 2013 16:56:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2086253.mJBe8Nv4qL@vostro.rjw.lan>
References: <1375965314-24232-1-git-send-email-heikki.krogerus@linux.intel.com>
 <52330A82.7050607@redhat.com> <2086253.mJBe8Nv4qL@vostro.rjw.lan>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 13 Sep 2013 17:55:40 -0600
Message-ID: <CAErSpo4r=oQ+J0=cM9gp3-i5-+5JYpYZQfzi3HFa6spxOO9OJg@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPI: return error in acpi_pci_irq_enable when there
 is no irq
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Prarit Bhargava <prarit@redhat.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yinghai]

On Fri, Sep 13, 2013 at 5:43 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, September 13, 2013 08:52:18 AM Prarit Bhargava wrote:
>>
>> On 08/08/2013 08:35 AM, Heikki Krogerus wrote:
>> > Hi,
>> >
>> > This is the fix for the Dell PowerEdge 840 issue where nothing
>> > allocated an irq for it's PCH if I understood correctly. The issue was
>> > reported by Prarit Bhargava.
>> >
>> > The second patch is just a minor cleanup.
>> >
>> > Thanks,
>> >
>> >
>> > Heikki Krogerus (2):
>> >   ACPI / PCI: don't allow PCI devices without irq to be enabled
>> >   ACPI / PCI: remove an extra check from acpi_pci_irq_enable()
>> >
>>
>> Rafael, is this in your queue?
>
> No, it is not, because Bjorn wanted to debug this issue deeper as far as I
> could understand.
>
> Bjorn?

Yes.  Yinghai pointed out a possible issue ("some USB3 host controller
does not have intx configured, but still work with MSI?").  I can't
explain to you right now what that means, but I did look at it enough
to think that there indeed might be a problem there.

So I asked [1] for a bugzilla with more info (dmesg, acpidump) so
somebody could look at it.  Actually, I was hoping Heikki or Prarit
would look into it and address Yinghai's concern.  Maybe there's no
problem there, but we should at least look and explain *why* it's not
a problem.  And I would really like a kernel.org bugzilla with the
info, in case this change turns out to have unintended consequences
and we have to debug it again later.

Bjorn

[1] http://lkml.kernel.org/r/CAErSpo7KDY87QPLNwbufeUAFGBtvyGteDmk6AxqFXBOX0RaObw@mail.gmail.com
