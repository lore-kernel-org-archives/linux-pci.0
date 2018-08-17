Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33313 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeHQLzQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2018 07:55:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id x5-v6so4132392edr.0
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2018 01:52:42 -0700 (PDT)
Date: Fri, 17 Aug 2018 11:52:37 +0300
In-Reply-To: <MWHPR07MB3502630540660CC0E120DC09D83D0@MWHPR07MB3502.namprd07.prod.outlook.com>
References: <1534340781-19194-1-git-send-email-adouglas@cadence.com> <615023FB-D8BA-4F12-BC2B-EDDBBDA39148@gmail.com> <MWHPR07MB3502DD2C6CAADBA52D56166CD83E0@MWHPR07MB3502.namprd07.prod.outlook.com> <CA+Kvs9m=jECCcy6RCrtKvJOAwt5Fr8XFFkkijMy3MFe9trav5g@mail.gmail.com> <CA+Kvs9=YMSNCC-vAREQNDAQaUBVs+eewXAEyWwVpqCbjo4LS3g@mail.gmail.com> <MWHPR07MB3502630540660CC0E120DC09D83D0@MWHPR07MB3502.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: RE: [PATCH v2 0/5] Add MSI-X support for cadence EP driver
To: Alan Douglas <adouglas@cadence.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "cyrille.pitchen@bootlin.com" <cyrille.pitchen@bootlin.com>,
        Scott Telford <stelford@cadence.com>
From: Ramon Fried <ramon.fried@gmail.com>
Message-ID: <159FE708-1849-4FD4-8F35-2F7ACD8C5D34@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On August 17, 2018 11:32:03 AM GMT+03:00, Alan Douglas <adouglas@cadence=2E=
com> wrote:
>Hi Ramon,
>
>On 17 August 2018 05:09, Ramon Fried wrote:
>> On Fri, Aug 17, 2018 at 7:05 AM Ramon Fried <ramon=2Efried@gmail=2Ecom>
>wrote:
>> > On Thu, Aug 16, 2018 at 5:28 PM Alan Douglas <adouglas@cadence=2Ecom>
>wrote:
>> >> On 15 August 2018 17:56, Ramon Fried wrote:
>> >> > On August 15, 2018 4:46:21 PM GMT+03:00, Alan Douglas
><adouglas@cadence=2Ecom> wrote:
>> >> > >The patch implements MSI-X support in the cadence endpoint
>driver=2E
>> >> > >
>> >> > >This patch depends on on Gustavo Pimentel's patch series adding
>MSI-X
>> >> > >support for EP ("Add MSI-X support on pcitest tool")
>> >> > >
>> >> > >It also adds fixes for MSI issues discovered during testing of
>MSI-X
>> >> > >  - Use AXI region 0 for interrupt signalling
>> >> > >  - Write MSI and MSI-X with 32bit value rather than 16bit
>> >> > >  - Check for masking before sending MSI or MSI-X
>> >> > >  - Check link is up before sending IRQ
>> >> > >
>> >> > Hi=2E
>> >> > AFAIK the BIOS allocates physical memory for the bars=2E Assuming
>that the MSIx bar is only mapped after kernel boots on the
>> endpoint,
>> >> > could it be too late?
>> >> >
>> >> > Do we need to trigger re-enumeration of the PCI bus from host
>side when working with this as an endpoint?
>> >> It depends on how you are using it=2E  PF0 is always enabled in the
>cadence HW, so will be enumerated at boot,
>> >> as long as the EP HW is out of reset and PHY is enabled=2E
>> >> The PCIe EP hardware can be initialized so that BARs are enabled
>by default, before the kernel boots on the
>> >> endpoint, and so they will be found and mapped during the initial
>enumeration and you don't need to
>> >> re-enumerate=2E  The MSI-X vectors can't be written to the BAR until
>the EP kernel has booted and the EP driver
>> >> has mapped the BAR to local EP memory though (unless  you also
>configure this in the PCIe EP hardware, or in
>> >> EP pre-boot, but in that case you are probably not using the EP
>driver framework=2E)
>> >>
>> >> The EP driver framework does, in my understanding, generally
>expect re-enumeration after the
>> >> EP kernel has booted and the driver has been initialized, since it
>allows configuration of device ID, BAR
>> >> sizes etc=2E, and if you change any of these from the HW defaults at
>boot you will need to re-enumerate=2E
>> >>
>> This basically means that this driver is for hobbyist / enthusiast,
>> you can't base a real product expecting
>> re-enumeration of the bus=2E right ?
>It depends what you mean by a real product, but yes it's not intended
>for use in a typical PCIe device=2E
>There are a wide variety of use cases for the EP driver framework, not
>necessarily hobbyist/enthusiast=2E
>The documentation here:
>https://www=2Ekernel=2Eorg/doc/Documentation/PCI/endpoint/pci-endpoint=2E=
txt
>mentions testing or validation, co-processor accelerator, etc=2E as
>possible use cases=2E
>
Thanks Alan=2E=20
>Regards,
>Alan


--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
