Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36789 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753027AbeDIPpT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Apr 2018 11:45:19 -0400
Received: by mail-lf0-f66.google.com with SMTP id d20-v6so1405901lfe.3
        for <linux-pci@vger.kernel.org>; Mon, 09 Apr 2018 08:45:18 -0700 (PDT)
Subject: Re: [PATCH 1/4] pcie-rcar: poll PHYRDY in rcar_pcie_hw_init()
To: Simon Horman <horms@verge.net.au>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <23335d95-63ca-b107-e43d-f4c2621adc2c@cogentembedded.com>
 <35e8fb4a-4b43-dac9-7a6f-cc7083c06453@cogentembedded.com>
 <20180409105415.h4rstrzzan4k6neq@verge.net.au>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <410d8ca9-8efa-8c41-a8ac-cad77e7bd2da@cogentembedded.com>
Date: Mon, 9 Apr 2018 18:45:15 +0300
MIME-Version: 1.0
In-Reply-To: <20180409105415.h4rstrzzan4k6neq@verge.net.au>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/09/2018 01:54 PM, Simon Horman wrote:

>> In  all the R-Car gen1/2/3 manuals, we are instructed to poll PCIEPHYSR
>> for PHYRDY=1  at  an early stage of the PCIEC initialization -- while
>> the driver only does this on R-Car H1 (polling a PHY specific register).
> 
> Is the R-Car H1 specific code still needed with this patch in place?

   No, it's removed in the next patch.

[...]
>> Add the PHYRDY polling to rcar_pcie_hw_init(). Note that without the
>> special PHY driver on the R-Car V3H the PCIEC initialization just freezes
>> the kernel --  adding the PHYRDY polling allows the init code to exit
>> gracefully on timeout (PHY starts powered down after reset on this SoC).
> 
> How widely has this been exercised? I assume it affects Rcar Gen 1, 2 and 3.

   Tested on R8A7791/Porter (unfortunately, I have no spare PCIe card) and
R8A77980/Condor (tried couple PCIe cards).

>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>>  drivers/pci/host/pcie-rcar.c |   20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> Index: pci/drivers/pci/host/pcie-rcar.c
>> ===================================================================
>> --- pci.orig/drivers/pci/host/pcie-rcar.c
>> +++ pci/drivers/pci/host/pcie-rcar.c
>> @@ -36,6 +36,8 @@
>>  #define PCIECDR			0x000020
>>  #define PCIEMSR			0x000028
>>  #define PCIEINTXR		0x000400
>> +#define PCIEPHYSR		0x0007f0
>> +#define  PHYRDY			1
> 
> Can we start using the BIT() macro in this driver?

   Done by Marek for the other regs... not sure whose patch would hit the kernel
first tho...

[...]

MBR, Sergei
