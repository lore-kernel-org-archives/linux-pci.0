Return-Path: <SRS0=KO2k=Z4=ti.com=kishon@kernel.org>
Return-Path: <SRS0=KO2k=Z4=ti.com=kishon@kernel.org>
Subject: Re: [PATCH 00/37] PCI: Support for configurable PCI endpoint
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <5891D53E.5050409@ti.com>
 <20170214235501.GD19040@bhelgaas-glaptop.roam.corp.google.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <58A457F9.7050702@ti.com>
Date: Wed, 15 Feb 2017 19:00:33 +0530
MIME-Version: 1.0
In-Reply-To: <20170214235501.GD19040@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Wednesday 15 February 2017 05:25 AM, Bjorn Helgaas wrote:
> On Wed, Feb 01, 2017 at 06:01:58PM +0530, Kishon Vijay Abraham I wrote:
>> - list
>>
>> Hi Bjorn,
>>
>> How do you want to handle this series? I'll send one more version of the series
>> including the directory restructuring in the same series. Should it be based on
>> your -next?
> 
> I think if you base it on my pci/host-designware branch, it should
> work pretty well.  I haven't merged that into -next yet, but I will
> soon.
> 
> I'm not sure there was consensus on all the patches yet, but if you
> can group the easy ones at the beginning, I should be able to at least
> get quite a few out of the way.

I've split this series and sent only the designware host driver rework part
[1]. I created those patches after cherrypicking "PCI: designware: Check for
iATU unroll only on platforms that use ATU" since it's not present in
pci/host-designware branch.

The endpoint support has some minor comments which I'll fix and send in the
next couple of days.

I'll send the endpoint series next (which will include endpoint framework,
endpoint support in designware driver and endpoint support in dra7xx driver).
Will that be fine? Also which branch should it be based on? pci -next?

Thanks
Kishon

[1] -> https://lkml.org/lkml/2017/2/15/273
> 
> Bjorn
> 
