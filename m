Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E67C43387
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 17:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609722173C
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 17:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfAGRQe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:16:34 -0500
Received: from avon.wwwdotorg.org ([104.237.132.123]:53856 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfAGRQe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jan 2019 12:16:34 -0500
Received: from [10.20.204.51] (unknown [216.228.112.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id 029CE1C00E7;
        Mon,  7 Jan 2019 10:16:30 -0700 (MST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at avon.wwwdotorg.org
Subject: Re: [PATCH] PCI: dwc: fix MSI IRQ handler ordering
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Stephen Warren <swarren@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, Faiz Abbas <faiz_abbas@ti.com>,
        Harro Haan <hrhaan@gmail.com>,
        Jingoo Han <jg1.han@samsung.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Juergen Beisert <jbe@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Matthias Mann <m.mann@arkona-technologies.de>,
        Mohit Kumar <mohit.kumar@st.com>,
        Pratyush Anand <pratyush.anand@st.com>,
        Richard Zhu <hong-xing.zhu@freescale.com>,
        Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
        Siva Reddy Kallam <siva.kallam@samsung.com>,
        Srikanth T Shivanand <ts.srikanth@samsung.com>,
        Tim Harvey <tharvey@gateworks.com>
References: <20190104214509.16891-1-swarren@wwwdotorg.org>
 <520c9d1b-8b1f-46ac-687a-fdb703328567@synopsys.com>
From:   Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <567e726d-e3c5-c48d-ec99-af1c1576180f@wwwdotorg.org>
Date:   Mon, 7 Jan 2019 10:16:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <520c9d1b-8b1f-46ac-687a-fdb703328567@synopsys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/7/19 2:36 AM, Gustavo Pimentel wrote:
> Hi Stephen,
> 
> On 04/01/2019 21:45, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> The current code does this when handling MSI IRQs:
>>
>> a) Process the irq.
>> b) Clear the latched IRQ status.
>>
>> If a new IRQ occurs any time after (a) has read the IRQ status for the
>> last time and before (b), it will be lost. For example, this occurs in
>> practice when using a Marvell 9171 AHCI controller with NCQ enabled;
>> many command timeouts occur with certain disk access patterns.
>>
>> Fix the code to do the following instead, so that if any new IRQs are
>> raised during the processing of the IRQ, the IRQ status is not cleared,
>> so that the IRQ is not lost.
>>
>> a) Clear the latched IRQ status.
>> b) Process the IRQ.
>>
>> This change reverts commit 8c934095fa2f ("PCI: dwc: Clear MSI interrupt
>> status after it is handled, not before")
>>
>> This change re-applies commit ca1658921b63 ("PCI: designware: Fix
>> missing MSI IRQs")
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Faiz Abbas <faiz_abbas@ti.com>
>> Cc: Harro Haan <hrhaan@gmail.com>
>> Cc: Jingoo Han <jg1.han@samsung.com>
>> Cc: Joao Pinto <jpinto@synopsys.com>
>> Cc: Juergen Beisert <jbe@pengutronix.de>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: Matthias Mann <m.mann@arkona-technologies.de>
>> Cc: Mohit Kumar <mohit.kumar@st.com>
>> Cc: Pratyush Anand <pratyush.anand@st.com>
>> Cc: Richard Zhu <hong-xing.zhu@freescale.com>
>> Cc: Sean Cross <xobs@kosagi.com>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
>> Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
>> Cc: Tim Harvey <tharvey@gateworks.com>
>> ---
>> Note: This issue was found in downstream NVIDIA 4.9 and 4.14 kernels.
>> However, the exact same code structure is present in mainline and I have
>> no reason to believe the problem would not reproduce there. I have
>> compile tested but not runtime tested it in mainline, since my board is
>> not yet supported in mainline.
>> ---
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 692dd1b264fb..7fd6c56a6f35 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -98,10 +98,10 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>>   			irq = irq_find_mapping(pp->irq_domain,
>>   					       (i * MAX_MSI_IRQS_PER_CTRL) +
>>   					       pos);
>> -			generic_handle_irq(irq);
>>   			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS +
>>   						(i * MSI_REG_CTRL_BLOCK_SIZE),
>>   					    4, 1 << pos);
>> +			generic_handle_irq(irq);
>>   			pos++;
>>   		}
>>   	}
> 
> This fix was already suggested by Trent Piepho, however, after review by Marc
> Zyngier and some information obtained from Synopsys IP development team, the
> following set of patches was generated to correct the problem.
> 
> 830920e065e9 ("PCI: dwc: Use interrupt masking instead of disabling")
> fce5423e4f43 ("PCI: dwc: Take lock when ACKing an interrupt")
> 3f7bb2ec20ce ("PCI: dwc: Move interrupt acking into the proper callback")

OK. I assume that dw_pci_bottom_ack() gets called before 
dw_handle_msi_irq() for each IRQ? In which case, the last of those 3 
changes is essentially identical to the patch I proposed, it's just that 
the acking is handled in a separate function rather than earlier in the 
same function.
