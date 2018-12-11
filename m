Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9073C5CFFE
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 17:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2CB20851
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 17:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2CB20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wwwdotorg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeLKRXc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:23:32 -0500
Received: from avon.wwwdotorg.org ([104.237.132.123]:44118 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeLKRXc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Dec 2018 12:23:32 -0500
Received: from [10.20.204.51] (unknown [216.228.112.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id EFB081C01A0;
        Tue, 11 Dec 2018 10:23:30 -0700 (MST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at avon.wwwdotorg.org
Subject: Re: [PATCH V2] PCI: dwc ep: cache config until DBI regs available
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Vidya Sagar <vidyas@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Stephen Warren <swarren@nvidia.com>
References: <20181126230958.8175-1-swarren@wwwdotorg.org>
 <340ed2c5-cb11-0aea-5430-5da5b509d805@ti.com>
From:   Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <b4a19329-3fd0-6242-5e31-8270d2c0a3e4@wwwdotorg.org>
Date:   Tue, 11 Dec 2018 10:23:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <340ed2c5-cb11-0aea-5430-5da5b509d805@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/10/18 9:36 PM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On 27/11/18 4:39 AM, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Some implementations of the DWC PCIe endpoint controller do not allow
>> access to DBI registers until the attached host has started REFCLK,
>> released PERST, and the endpoint driver has initialized clocking of the
>> DBI registers based on that. One such system is NVIDIA's T194 SoC. The
>> PCIe endpoint subsystem and DWC driver currently don't work on such
>> hardware, since they assume that all endpoint configuration can happen
>> at any arbitrary time.
>>
>> Enhance the DWC endpoint driver to support such systems by caching all
>> endpoint configuration in software, and only writing the configuration
>> to hardware once it's been initialized. This is implemented by splitting
>> all endpoint controller ops into two functions; the first which simply
>> records/caches the desired configuration whenever called by the
>> associated function driver and optionally calls the second, and the
>> second which actually programs the configuration into hardware, which
>> may be called either by the first function, or later when it's known
>> that the DBI registers are available.

>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c

>> +void dw_pcie_set_regs_available(struct dw_pcie *pci)
>> +{
> 
> When will this function be invoked? Does the wrapper get an interrupt when
> refclk is enabled where this function will be invoked?

Yes, there's an IRQ from the HW that indicates when PEXRST is released. 
I don't recall right now if this IRQ is something that exists for all 
DWC instantiations, or is Tegra-specific.

>> +	struct dw_pcie_ep *ep = &(pci->ep);
>> +	int i;
>> +
>> +	ep->hw_regs_not_available = false;
> 
> This can race with epc_ops.
> 
>> +
>> +	dw_pcie_ep_write_header_regs(ep);
>> +	for_each_set_bit(i, ep->ib_window_map, ep->num_ib_windows) {
>> +		dw_pcie_prog_inbound_atu(pci, i,
>> +			ep->cached_inbound_atus[i].bar,
>> +			ep->cached_inbound_atus[i].cpu_addr,
>> +			ep->cached_inbound_atus[i].as_type);
> 
> Depending on the context in which this function is invoked, programming
> inbound/outbound ATU can also race with EPC ops.
 >
>> +		dw_pcie_ep_set_bar_regs(ep, 0, ep->cached_inbound_atus[i].bar);
>> +	}
>> +	for_each_set_bit(i, ep->ob_window_map, ep->num_ob_windows)
>> +		dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
>> +			ep->cached_outbound_atus[i].addr,
>> +			ep->cached_outbound_atus[i].pci_addr,
>> +			ep->cached_outbound_atus[i].size);
>> +	dw_pcie_dbi_ro_wr_en(pci);
>> +	dw_pcie_writew_dbi(pci, PCI_MSI_FLAGS, ep->cached_msi_flags);
>> +	dw_pcie_writew_dbi(pci, PCI_MSIX_FLAGS, ep->cached_msix_flags);
>> +	dw_pcie_dbi_ro_wr_dis(pci);
> 
> IMHO we should add a new epc ops ->epc_init() which indicates if the EPC is
> ready to be initialized or not. Only if the epc_init indicates it's ready to be
> initialized, the endpoint function driver should go ahead with further
> initialization. Or else it should wait for a notification from EPC to indicate
> when it's ready to be initialized.

(Did you mean epf op or epc op?)

I'm not sure how exactly how that would work; do you want the DWC core 
driver or the endpoint subsystem to poll that epc op to find out when 
the HW is ready to be initialized? Or do you envisage the controller 
driver still calling dw_pcie_set_regs_available() (possibly renamed), 
which in turn calls ->epc_init() calls for some reason?

If you don't want to cache the endpoint configuration, perhaps you want:

a) Endpoint function doesn't pro-actively call the endpoint controller 
functions to configure the endpoint.

b) When endpoint HW is ready, the relevant driver calls pci_epc_ready() 
(or whatever name), which lets the core know the HW can be configured. 
Perhaps this schedules a work queue item to implement locking to avoid 
the races you mentioned.

c) Endpoint core calls pci_epf_init() which calls epf op ->init().

One gotcha with this approach, which the caching approach helps avoid:

Once PEXRST is released, the system must respond to PCIe enumeration 
requests within 50ms. Thus, SW must very quickly respond to the IRQ 
indicating PEXRST release and program the endpoint configuration into 
HW. By caching the configuration in the DWC driver and 
immediately/synchronously applying it in the PEXRST IRQ handler, we 
reduce the number of steps and amount of code taken to program the HW, 
so it should get done pretty quickly. If instead we call back into the 
endpoint function driver's ->init() op, we run the risk of that op doing 
other stuff besides just calling the endpoint HW configuration APIs 
(e.g. perhaps the function driver defers memory buffer allocation or 
IOVA programming to that ->init function) which in turns makes it much 
less likely the 50ms requirement will be hit. Perhaps we can solve this 
by naming the op well and providing lots of comments, but my guess is 
that endpoint function authors won't notice that...
