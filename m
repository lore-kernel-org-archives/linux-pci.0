Return-Path: <SRS0=YnKd=PK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2889C43387
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 16:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B128C218DE
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 16:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbfABQe4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:34:56 -0500
Received: from avon.wwwdotorg.org ([104.237.132.123]:42052 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729256AbfABQez (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jan 2019 11:34:55 -0500
Received: from [10.20.204.51] (unknown [216.228.112.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id 4A6301C015A;
        Wed,  2 Jan 2019 09:34:53 -0700 (MST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at avon.wwwdotorg.org
Subject: Re: [PATCH V2] PCI: dwc ep: cache config until DBI regs available
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Vidya Sagar <vidyas@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Stephen Warren <swarren@nvidia.com>
References: <20181126230958.8175-1-swarren@wwwdotorg.org>
 <340ed2c5-cb11-0aea-5430-5da5b509d805@ti.com>
 <b4a19329-3fd0-6242-5e31-8270d2c0a3e4@wwwdotorg.org>
 <27179f56-c7be-a55e-46ef-8ebc144e8547@wwwdotorg.org>
 <f86f4b8e-6b62-e921-eee2-1cf7ff0266ff@ti.com>
From:   Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <8982f057-881d-ffe7-6c26-e6a9844cbc0a@wwwdotorg.org>
Date:   Wed, 2 Jan 2019 09:34:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f86f4b8e-6b62-e921-eee2-1cf7ff0266ff@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/19/18 7:37 AM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On 14/12/18 10:31 PM, Stephen Warren wrote:
>> On 12/11/18 10:23 AM, Stephen Warren wrote:
>>> On 12/10/18 9:36 PM, Kishon Vijay Abraham I wrote:
>>>> Hi,
>>>>
>>>> On 27/11/18 4:39 AM, Stephen Warren wrote:
>>>>> From: Stephen Warren <swarren@nvidia.com>
>>>>>
>>>>> Some implementations of the DWC PCIe endpoint controller do not allow
>>>>> access to DBI registers until the attached host has started REFCLK,
>>>>> released PERST, and the endpoint driver has initialized clocking of the
>>>>> DBI registers based on that. One such system is NVIDIA's T194 SoC. The
>>>>> PCIe endpoint subsystem and DWC driver currently don't work on such
>>>>> hardware, since they assume that all endpoint configuration can happen
>>>>> at any arbitrary time.
>>>>>
>>>>> Enhance the DWC endpoint driver to support such systems by caching all
>>>>> endpoint configuration in software, and only writing the configuration
>>>>> to hardware once it's been initialized. This is implemented by splitting
>>>>> all endpoint controller ops into two functions; the first which simply
>>>>> records/caches the desired configuration whenever called by the
>>>>> associated function driver and optionally calls the second, and the
>>>>> second which actually programs the configuration into hardware, which
>>>>> may be called either by the first function, or later when it's known
>>>>> that the DBI registers are available.
>>>
>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>>> b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>
>>>>> +void dw_pcie_set_regs_available(struct dw_pcie *pci)
>>>>> +{
>>>>
>>>> When will this function be invoked? Does the wrapper get an interrupt when
>>>> refclk is enabled where this function will be invoked?
>>>
>>> Yes, there's an IRQ from the HW that indicates when PEXRST is released. I
>>> don't recall right now if this IRQ is something that exists for all DWC
>>> instantiations, or is Tegra-specific.
>>>
>>>>> +    struct dw_pcie_ep *ep = &(pci->ep);
>>>>> +    int i;
>>>>> +
>>>>> +    ep->hw_regs_not_available = false;
>>>>
>>>> This can race with epc_ops.
>>>>
>>>>> +
>>>>> +    dw_pcie_ep_write_header_regs(ep);
>>>>> +    for_each_set_bit(i, ep->ib_window_map, ep->num_ib_windows) {
>>>>> +        dw_pcie_prog_inbound_atu(pci, i,
>>>>> +            ep->cached_inbound_atus[i].bar,
>>>>> +            ep->cached_inbound_atus[i].cpu_addr,
>>>>> +            ep->cached_inbound_atus[i].as_type);
>>>>
>>>> Depending on the context in which this function is invoked, programming
>>>> inbound/outbound ATU can also race with EPC ops.
>>>   >
>>>>> +        dw_pcie_ep_set_bar_regs(ep, 0, ep->cached_inbound_atus[i].bar);
>>>>> +    }
>>>>> +    for_each_set_bit(i, ep->ob_window_map, ep->num_ob_windows)
>>>>> +        dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
>>>>> +            ep->cached_outbound_atus[i].addr,
>>>>> +            ep->cached_outbound_atus[i].pci_addr,
>>>>> +            ep->cached_outbound_atus[i].size);
>>>>> +    dw_pcie_dbi_ro_wr_en(pci);
>>>>> +    dw_pcie_writew_dbi(pci, PCI_MSI_FLAGS, ep->cached_msi_flags);
>>>>> +    dw_pcie_writew_dbi(pci, PCI_MSIX_FLAGS, ep->cached_msix_flags);
>>>>> +    dw_pcie_dbi_ro_wr_dis(pci);
>>>>
>>>> IMHO we should add a new epc ops ->epc_init() which indicates if the EPC is
>>>> ready to be initialized or not. Only if the epc_init indicates it's ready to be
>>>> initialized, the endpoint function driver should go ahead with further
>>>> initialization. Or else it should wait for a notification from EPC to indicate
>>>> when it's ready to be initialized.
>>>
>>> (Did you mean epf op or epc op?)
>>>
>>> I'm not sure how exactly how that would work; do you want the DWC core driver
>>> or the endpoint subsystem to poll that epc op to find out when the HW is
>>> ready to be initialized? Or do you envisage the controller driver still
>>> calling dw_pcie_set_regs_available() (possibly renamed), which in turn calls
>>> ->epc_init() calls for some reason?
>>>
>>> If you don't want to cache the endpoint configuration, perhaps you want:
>>>
>>> a) Endpoint function doesn't pro-actively call the endpoint controller
>>> functions to configure the endpoint.
>>>
>>> b) When endpoint HW is ready, the relevant driver calls pci_epc_ready() (or
>>> whatever name), which lets the core know the HW can be configured. Perhaps
>>> this schedules a work queue item to implement locking to avoid the races you
>>> mentioned.
>>>
>>> c) Endpoint core calls pci_epf_init() which calls epf op ->init().
>>>
>>> One gotcha with this approach, which the caching approach helps avoid:
>>>
>>> Once PEXRST is released, the system must respond to PCIe enumeration requests
>>> within 50ms. Thus, SW must very quickly respond to the IRQ indicating PEXRST
>>> release and program the endpoint configuration into HW. By caching the
>>> configuration in the DWC driver and immediately/synchronously applying it in
>>> the PEXRST IRQ handler, we reduce the number of steps and amount of code
>>> taken to program the HW, so it should get done pretty quickly. If instead we
>>> call back into the endpoint function driver's ->init() op, we run the risk of
>>> that op doing other stuff besides just calling the endpoint HW configuration
>>> APIs (e.g. perhaps the function driver defers memory buffer allocation or
>>> IOVA programming to that ->init function) which in turns makes it much less
>>> likely the 50ms requirement will be hit. Perhaps we can solve this by naming
>>> the op well and providing lots of comments, but my guess is that endpoint
>>> function authors won't notice that...
>>
>> Kishon,
>>
>> Do you have any further details exactly how you'd prefer this to work? Does the
>> approach I describe in points a/b/c above sound like what you want? Thanks.
> 
> Agree with your PERST comment.
> 
> What I have in mind is we add a new epc_init() ops. I feel there are more uses
> for it (For e.g I have an internal patch which uses epc_init to initialize DMA.
> Hopefully I'll post it soon).
> If you look at pci_epf_test, pci_epf_test_bind() is where the function actually
> starts to write to HW (i.e using pci_epc_*).
> So before the endpoint function invokes pci_epc_write_header(), it should
> invoke epc_init(). Only if that succeeds, it should go ahead with other
> initialization.
> If epc_init_* fails, we can have a particular error value to indicate the
> controller is waiting for clock from host (so that we don't return error from
> ->bind()). Once the controller receives the clock, it can send an atomic
> notification to the endpoint function driver to indicate it is ready to be
> initialized. (Atomic notification makes it easy to handle for multi function
> endpoint devices.)
> The endpoint function can then initialize the controller.
> I think except for pci_epf_test_alloc_space() all other functions are
> configuring the HW (in pci_epf_test_bind). pci_epf_test_alloc_space() could be
> moved to pci_epf_test_probe() so there are no expensive operations to be done
> once the controller is ready to be initialized.
> I have epc_init() and the atomic notification part already implemented and I'm
> planning to post it before next week. Once that is merged, we might have to
> reorder function in pci_epf_test driver and you have to return the correct
> error value for epc_init() if the clock is not there.

Kishon, did you manage to post the patches that implement epc_init()? If 
so, a link would be appreciated. Thanks.
