Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36235 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967511AbeEYSSt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 May 2018 14:18:49 -0400
Subject: Re: [PATCH v4 0/6] PCI: rcar: Failpath fixes
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20180524143624.26718-1-marek.vasut+renesas@gmail.com>
 <20180525164313.GA13284@e107981-ln.cambridge.arm.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <340da935-4769-2de6-0774-4e4c1b8c059b@gmail.com>
Date: Fri, 25 May 2018 19:10:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180525164313.GA13284@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/25/2018 06:43 PM, Lorenzo Pieralisi wrote:
> On Thu, May 24, 2018 at 04:36:18PM +0200, Marek Vasut wrote:
>> Multiple minor failpath fixes for the R-Car PCIe driver.
>>
>> V4: Sync up the version numbers
>>     Rebase on top of Lorenzo's tree
>>     Add new patch fixing bug in the PHY code
>>
>> Marek Vasut (6):
>>   PCI: rcar: Pull bus clock enable/disable from
>>     rcar_pcie_get_resources()
>>   PCI: rcar: Add missing irq_dispose_mapping() into failpath
>>   PCI: rcar: Teardown MSI setup if rcar_pcie_enable() fails
>>   PCI: rcar: Poll more often in rcar_pcie_wait_for_dl()
>>   PCI: rcar: Remove IRQ mappings in rcar_pcie_enable_msi failpath
>>   PCI: rcar: Shut the PHY down in failpath
>>
>>  drivers/pci/host/pcie-rcar.c | 82 +++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 66 insertions(+), 16 deletions(-)
> 
> Marek,
> 
> I have applied patches [1-5] to pci/rcar for v4.18, I could not
> apply patch 6 since it is missing Simon's ACK (please have a look
> at what I queued to check it is OK).
> 
> Bjorn will be merging the branch into -next shortly, I do not know if
> there is room for adding additional patches on top of it, as I mentioned
> on linux-pci I will be offline for two weeks so it is possible that
> what's in pci/rcar at present will be what gets into v4.18, apologies,
> that's all I can do.

Fine. Yes, there's another patch coming for the PHY stuff from Sergej.

-- 
Best regards,
Marek Vasut
