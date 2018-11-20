Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1F7C46463
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 20:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F74214E0
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 20:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F74214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wwwdotorg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbeKUGwM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:52:12 -0500
Received: from avon.wwwdotorg.org ([104.237.132.123]:42518 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeKUGwM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Nov 2018 01:52:12 -0500
Received: from [10.20.204.51] (unknown [216.228.112.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id D6EFB1C00E7;
        Tue, 20 Nov 2018 13:21:15 -0700 (MST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at avon.wwwdotorg.org
Subject: Re: [PATCH] PCI: dwc ep: cache config until DBI regs available
To:     Trent Piepho <tpiepho@impinj.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "vidyas@nvidia.com" <vidyas@nvidia.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "swarren@nvidia.com" <swarren@nvidia.com>
References: <20181119222602.28001-1-swarren@wwwdotorg.org>
 <BN6PR12MB11714E3FED1EF50D7F3CA3C9B8D90@BN6PR12MB1171.namprd12.prod.outlook.com>
 <921c50a5-35b7-33e7-398b-3c4cacef8529@wwwdotorg.org>
 <1542744746.30311.618.camel@impinj.com>
From:   Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <34383596-8732-52af-e12e-d7d3007f6975@wwwdotorg.org>
Date:   Tue, 20 Nov 2018 13:21:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542744746.30311.618.camel@impinj.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/20/18 1:12 PM, Trent Piepho wrote:
> On Tue, 2018-11-20 at 10:41 -0700, Stephen Warren wrote:
>> On 11/20/18 10:30 AM, Vidya Sagar wrote:
>>>>
>>>> Some implementations of the DWC PCIe endpoint controller do not allow access
>>>> to DBI registers until the attached host has started REFCLK, released PERST, and
>>>> the endpoint driver has initialized clocking of the DBI registers based on that.
>>>>
> 
>> a) Update every existing DWC EP driver to set ep->hw_regs_available
>> during probe/initialization.
> 
> I believe on IMX7d, it is also the case that access to DWC PCIe
> controller without PCI REFCLK causes a system hang.
> 
> We had a design with a mistake that didn't provide a REFCLK, and a hang
>   starting the dwc controller is what happened.  It was fixed with an
> external PCIe clock chip to provide the REFCLK input (as imx7d is
> designed to expect), which, for the clock chip we used and the rest of
> the external clock tree, means the REFCLK is there before Linux boots.
> 
> But there's no reason that must be the case.  Maybe the external clock
> chip is I2C controlled and needs to be enabled?  And maybe I only want
> to do that if PCI-e is to be used?
> 
> So I don't think if this is a specific problem for nvidia.

Good to hear that this could be more generally useful.

> But I wonder, why can't you add REFCLK to the Linux clock tree and the
> dwc bindings, and have the dwc driver EPROBE_DEFER if it can't
> clk_prepare_enable() the refclk?

In our systems, we expect REFCLK to be provided by the system that 
contains the PCIe root port. There is no communication channel between 
the endpoint system and the root port system besides PCIe, so there's no 
way we could implement such clock control. The endpoint system must boot 
first, so that when the root port system boots, it is ready to be 
enumerated on the PCIe bus. To make this work, the Tegra endpoint driver 
calls dw_pcie_ep_set_regs_available() when it sees PERST release, and 
hopes to complete the DWC programming before the root port system begins 
PCIe enumeration.
