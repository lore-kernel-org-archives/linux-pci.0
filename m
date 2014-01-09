Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:63497 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbaAIUxS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jan 2014 15:53:18 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl1so17175743igb.5
        for <linux-pci@vger.kernel.org>; Thu, 09 Jan 2014 12:53:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <loom.20140109T201208-15@post.gmane.org>
References: <CA+sq2CfthYc3Eda3GRa-Q-TA9gq+ygBTLrPjvzhRquikm220GA@mail.gmail.com>
 <CAErSpo6rigeEY7RbpcRrm2N7gKxA+rAwEX7_iD7r706hvM0_MA@mail.gmail.com> <loom.20140109T201208-15@post.gmane.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 9 Jan 2014 13:52:57 -0700
Message-ID: <CAErSpo5PRS4KYZgYmPKcBCCS9QoHtpzBc8pkjh-+V=fq6OA=FQ@mail.gmail.com>
Subject: Re: Query regarding ARI configuration of a on-board PCIe device.
To: Scott Lurndal <kdb@lurndal.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 9, 2014 at 12:16 PM, Scott Lurndal <kdb@lurndal.org> wrote:
> Bjorn Helgaas <bhelgaas <at> google.com> writes:
>
>>
>> On Thu, Jan 9, 2014 at 3:51 AM, Sunil Kovvuri <sunil.kovvuri <at>
> gmail.com> wrote:
>> > Hi,
>> >
>> > I have a platform which has a on-board PCIe device attached to PCIe port.
>> > This device is an ethernet device with SRIOV capability having morethan
>> > 8 virtual functions.
>> >
>> > I am going through Linux's ARI configuration code and saw that it is
> checking
>> > if upstream bridge supports ARI or not. In our case its a on-board
> device and
>> > no bridge is involved.
>> >
>> > Need some help or ideas on how i can configure ARI on the device so that
>> > all VFs gets added.
>> >
>> > Do i need to change the ARI configuration code or is there a way to fake a
>> > PCI bridge for this purpose ?
>>
>> I assume you're referring to pci_configure_ari().  A PCIe endpoint
>> such as your ethernet device always has an upstream bridge.  In your
>> case, the device is on-board and there's no PCIe switch involved, but
>> the root port is the upstream device, and it is handled as a bridge.
>>
>> It looks like pci_configure_ari() should enable ARI by default when it
>> is supported.  But apparently it isn't being enabled on your system?
>> Can you collect the "lspci -vv" output for the root port and the NIC?
>>
>> Bjorn
>>
>
>
> Hi Bjorn,
>
>    For the sake of discussion, let's assume that the device in question,
> which is intended to appear to software as a pci-express SR-IOV device
> with more than 8 functions (i.e. ARI), has a PCI-Express configuration
> space which is slotted into an ECAM region for discovery and
> configuration.  The device itself is directly attached to the host-bridge
> and doesn't have an associated root port.
>
>    In this case, the check for bridge in pci_configure_ari() is
> problematic because there is no root port (the host bridge is
> transparent to software).

I don't think the topology you describe is legal.  A directly-attached
device that is not part of the hierarchy below a Root Port would have
to be a Root Complex Integrated Endpoint.  The device would indicate
its support for ARI with an ARI extended capability, but the spec (sec
7.23) says an Integrated Endpoint can't have an ARI capability.

If I understand ARI correctly, an endpoint has to indicate support for
it with the ARI capability, but you actually enable support for it in
the downstream port leading to the endpoint (assuming *it* also
supports ARI).

I guess if you posit an integrated endpoint with an ARI capability, I
could imagine an ARI-enable switch in the host bridge, but that's not
architected, so there would have to be host bridge driver code to
enable it.

Bjorn
