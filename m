Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38715 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756810Ab3J1Qxo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2013 12:53:44 -0400
From: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
To: Andrew Murray <amurray@embedded-bits.co.uk>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: AER driver on ARM platform
Date: Mon, 28 Oct 2013 16:53:42 +0000
Message-ID: <3E54258959B69E4282D79E01AB1F32B704626477@DFLE11.ent.ti.com>
References: <3E54258959B69E4282D79E01AB1F32B704625941@DFLE11.ent.ti.com>
	<CAPcvp5Epf+6tOp+0=ZbBLusCzq4dF98aS+Ou0D7Nyko_VwM8KA@mail.gmail.com>
	<3E54258959B69E4282D79E01AB1F32B704625B1A@DFLE11.ent.ti.com>
 <CAPcvp5EwTb7qm_aMzqJzLX0ScrD3A0VFog1qga76dqTT5cBW3g@mail.gmail.com>
In-Reply-To: <CAPcvp5EwTb7qm_aMzqJzLX0ScrD3A0VFog1qga76dqTT5cBW3g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> -----Original Message-----
>> From: Andrew Murray [mailto:amurray@embedded-bits.co.uk]
>> Sent: Friday, October 25, 2013 3:01 PM
>> To: Karicheri, Muralidharan
>> Cc: linux-pci@vger.kernel.org
>> Subject: Re: AER driver on ARM platform
>> 
>> On 25 October 2013 19:18, Karicheri, Muralidharan <m-karicheri2@ti.com> wrote:
>> >
>> > >> -----Original Message-----
>> > >> From: Andrew Murray [mailto:amurray@embedded-bits.co.uk]
>> > >> Sent: Friday, October 25, 2013 12:27 PM
>> > >> To: Karicheri, Muralidharan
>> > >> Cc: linux-pci@vger.kernel.org
>> > >> Subject: Re: AER driver on ARM platform
>> > >>
>> > >> On 25 October 2013 16:56, Karicheri, Muralidharan <m-karicheri2@ti.com> wrote:
>> > >> > Did anyone successfully tested PCIe AER driver on an ARM
>> > >> > platform? I saw this enabled in
>> > >> a tegra platform. Could someone from nVidia respond?
>> > >>
>> > >> I've previously used this on a custom ARM platform - it works.
>> > >>
>> > >> You need to ensure that PCIe port services are enabled, I believe
>> > >> at one point this required 'pcie_ports=native' to be set on the kernel command line.
>> > >>
>> > >> Andrew Murray
>> > >>
>> >
>> > Yes. That was it. It probes the driver now. Did you try error inject feature?
>> 
>> I did have a look at that, but it really depends on what exactly you want to test. There are
>> many things this won't help you with, you ought to examine the aer inject driver to see
>> what it does. For example if you are bringing up a new device and want to see it raise an
>> AER interrupt then aer inject won't help. In this case you'll need to find a way to trigger real
>> errors.
>> 

I am basically trying to test if an error in a PCIe device gets reported to AER driver. As I understand, there is a error_handle in the PCI device driver that gets called when an error is received by the AER driver so that device can handle it. At this point, I am trying to test the AER driver with any error that can be injected to check if the error handle is being called.  I will dig more into the inject feature to get an answer, but if you know this is possible or not, please reply.

Thanks.

Murali

>> Andrew Murray
