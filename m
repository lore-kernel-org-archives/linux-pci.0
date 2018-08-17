Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41407 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbeHQHLG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2018 03:11:06 -0400
Received: by mail-ed1-f65.google.com with SMTP id s24-v6so3807377edr.8
        for <linux-pci@vger.kernel.org>; Thu, 16 Aug 2018 21:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <1534340781-19194-1-git-send-email-adouglas@cadence.com>
 <615023FB-D8BA-4F12-BC2B-EDDBBDA39148@gmail.com> <MWHPR07MB3502DD2C6CAADBA52D56166CD83E0@MWHPR07MB3502.namprd07.prod.outlook.com>
 <CA+Kvs9m=jECCcy6RCrtKvJOAwt5Fr8XFFkkijMy3MFe9trav5g@mail.gmail.com>
In-Reply-To: <CA+Kvs9m=jECCcy6RCrtKvJOAwt5Fr8XFFkkijMy3MFe9trav5g@mail.gmail.com>
From: Ramon Fried <ramon.fried@gmail.com>
Date: Fri, 17 Aug 2018 07:09:05 +0300
Message-ID: <CA+Kvs9=YMSNCC-vAREQNDAQaUBVs+eewXAEyWwVpqCbjo4LS3g@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add MSI-X support for cadence EP driver
To: Alan Douglas <adouglas@cadence.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, kishon@ti.com,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        gustavo.pimentel@synopsys.com, cyrille.pitchen@bootlin.com,
        stelford@cadence.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 17, 2018 at 7:05 AM Ramon Fried <ramon.fried@gmail.com> wrote:
>
>
>
> On Thu, Aug 16, 2018 at 5:28 PM Alan Douglas <adouglas@cadence.com> wrote:
>>
>> Hi Ramon,
>>
>> On 15 August 2018 17:56, Ramon Fried wrote:
>> > On August 15, 2018 4:46:21 PM GMT+03:00, Alan Douglas <adouglas@cadence.com> wrote:
>> > >The patch implements MSI-X support in the cadence endpoint driver.
>> > >
>> > >This patch depends on on Gustavo Pimentel's patch series adding MSI-X
>> > >support for EP ("Add MSI-X support on pcitest tool")
>> > >
>> > >It also adds fixes for MSI issues discovered during testing of MSI-X
>> > >  - Use AXI region 0 for interrupt signalling
>> > >  - Write MSI and MSI-X with 32bit value rather than 16bit
>> > >  - Check for masking before sending MSI or MSI-X
>> > >  - Check link is up before sending IRQ
>> > >
>> > Hi.
>> > AFAIK the BIOS allocates physical memory for the bars. Assuming that the MSIx bar is only mapped after kernel boots on the endpoint,
>> > could it be too late?
>> >
>> > Do we need to trigger re-enumeration of the PCI bus from host side when working with this as an endpoint?
>> It depends on how you are using it.  PF0 is always enabled in the cadence HW, so will be enumerated at boot,
>> as long as the EP HW is out of reset and PHY is enabled.
>> The PCIe EP hardware can be initialized so that BARs are enabled by default, before the kernel boots on the
>> endpoint, and so they will be found and mapped during the initial enumeration and you don't need to
>> re-enumerate.  The MSI-X vectors can't be written to the BAR until the EP kernel has booted and the EP driver
>> has mapped the BAR to local EP memory though (unless  you also configure this in the PCIe EP hardware, or in
>> EP pre-boot, but in that case you are probably not using the EP driver framework.)
>>
>> The EP driver framework does, in my understanding, generally expect re-enumeration after the
>> EP kernel has booted and the driver has been initialized, since it allows configuration of device ID, BAR
>> sizes etc., and if you change any of these from the HW defaults at boot you will need to re-enumerate.
>>
This basically means that this driver is for hobbyist / enthusiast,
you can't base a real product expecting
re-enumeration of the bus. right ?
>
>> All tests I have done for the EP driver have been without BIOS enumeration, and triggering re-enumeration
>> after initializing the BAR sizes etc. via the EP driver
>>
>> Regards,
>> Alan
>>
