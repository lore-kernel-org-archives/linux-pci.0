Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3680DC10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 10:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F133820675
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 10:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wFpr8g0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDLKjW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:39:22 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49250 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfDLKjW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2019 06:39:22 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3CAd2Jx053996;
        Fri, 12 Apr 2019 05:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555065542;
        bh=G5r8PxA0M/wina9XLhWL3BKHZzhc239hT4C13MjT5og=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wFpr8g0RtFh4l92VibzfLTQeaY9InTBmOhB5MNMJd7QXp2ijfZ41+SRqOMJ7eDZGh
         y1seD7SvzuHG5E2hpkJVM7UqZ3o4pK6lj049ugYSqEKIeAZXC9ULjkqmPY7uiemIwg
         PZlaa2OCbX4m9ALXwrePXa/3d9Zx/HoUgPkdXxEI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3CAd2JL051958
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Apr 2019 05:39:02 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 12
 Apr 2019 05:39:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 12 Apr 2019 05:39:01 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3CAcq98008141;
        Fri, 12 Apr 2019 05:38:56 -0500
Subject: Re: [PATCH v3 18/26] PCI: endpoint: Add support to allocate aligned
 buffers to be mapped in BARs
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-kernel@axis.com>, Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>
References: <20190325093947.32633-1-kishon@ti.com>
 <20190325093947.32633-19-kishon@ti.com> <20190411153238.GD6862@red-moon>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7e44bd0d-c450-cb0b-45b0-e96748482477@ti.com>
Date:   Fri, 12 Apr 2019 16:07:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411153238.GD6862@red-moon>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 11/04/19 9:02 PM, Lorenzo Pieralisi wrote:
> On Mon, Mar 25, 2019 at 03:09:39PM +0530, Kishon Vijay Abraham I wrote:
>> Modify pci_epf_alloc_space API to take alignment size as argument in
>> order to argument in order to allocate aligned buffers to be mapped to
>> BARs.
>>
>> Add 'align' parameter to epc_features which can be used by platform
>> drivers to specifiy the BAR allocation alignment requirements and use
>> this while invoking pci_epf_alloc_space.
>>
>> This is mainly required for Synopsys Designware PCIe core which masks
>> the lower bits based on the BAR size (See "I/O and MEM Match Modes"
>> section in DesignWare Cores PCI Express Controller Databook version
>> 4.90a).
> 
> Hi Kishon,
> 
> isn't this a generic PCI BAR requirement rather than a Designware
> specific one ?
> 
> The patch is fine I just would like to understand the statement above.

The address that is allocated using pci_epf_alloc_space would be directly
written to the target address of the Inbound address translation unit.
Designware IP has a configuration parameter (CX_ATU_MIN_REGION_SIZE [1]) which
has 64KB as default value and the lower 16 bits of the Base, Limit and Target
registers of the Inbound ATU are fixed to zero.  So if the programmed memory
address is not aligned to 64 KB boundary there will be memory corruption.

PCI spec has restrictions on the minimum memory address range requested by BAR
as 128 Bytes and the size to be a power of 2, however it doesn't have any
restriction on the local endpoint memory addresses that are mapped to BAR. That
is an endpoint controller restriction.

[1] -> http://www.ti.com/lit/ug/spruid7c/spruid7c.pdf

Thanks
Kishon

> Thanks,
> Lorenzo
> 
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/endpoint/functions/pci-epf-test.c |  5 +++--
>>  drivers/pci/endpoint/pci-epf-core.c           | 10 ++++++++--
>>  include/linux/pci-epc.h                       |  2 ++
>>  include/linux/pci-epf.h                       |  3 ++-
>>  4 files changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>> index d0b91da49bf4..c0786ca74312 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>> @@ -438,7 +438,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>>  	epc_features = epf_test->epc_features;
>>  
>>  	base = pci_epf_alloc_space(epf, sizeof(struct pci_epf_test_reg),
>> -				   test_reg_bar);
>> +				   test_reg_bar, epc_features->align);
>>  	if (!base) {
>>  		dev_err(dev, "Failed to allocated register space\n");
>>  		return -ENOMEM;
>> @@ -453,7 +453,8 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>>  		if (!!(epc_features->reserved_bar & (1 << bar)))
>>  			continue;
>>  
>> -		base = pci_epf_alloc_space(epf, bar_size[bar], bar);
>> +		base = pci_epf_alloc_space(epf, bar_size[bar], bar,
>> +					   epc_features->align);
>>  		if (!base)
>>  			dev_err(dev, "Failed to allocate space for BAR%d\n",
>>  				bar);
>> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
>> index 8bfdcd291196..fb1306de8f40 100644
>> --- a/drivers/pci/endpoint/pci-epf-core.c
>> +++ b/drivers/pci/endpoint/pci-epf-core.c
>> @@ -109,10 +109,12 @@ EXPORT_SYMBOL_GPL(pci_epf_free_space);
>>   * pci_epf_alloc_space() - allocate memory for the PCI EPF register space
>>   * @size: the size of the memory that has to be allocated
>>   * @bar: the BAR number corresponding to the allocated register space
>> + * @align: alignment size for the allocation region
>>   *
>>   * Invoke to allocate memory for the PCI EPF register space.
>>   */
>> -void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
>> +void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>> +			  size_t align)
>>  {
>>  	void *space;
>>  	struct device *dev = epf->epc->dev.parent;
>> @@ -120,7 +122,11 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
>>  
>>  	if (size < 128)
>>  		size = 128;
>> -	size = roundup_pow_of_two(size);
>> +
>> +	if (align)
>> +		size = ALIGN(size, align);
>> +	else
>> +		size = roundup_pow_of_two(size);
>>  
>>  	space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
>>  	if (!space) {
>> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
>> index c3ffa3917f88..f641badc2c61 100644
>> --- a/include/linux/pci-epc.h
>> +++ b/include/linux/pci-epc.h
>> @@ -109,6 +109,7 @@ struct pci_epc {
>>   * @reserved_bar: bitmap to indicate reserved BAR unavailable to function driver
>>   * @bar_fixed_64bit: bitmap to indicate fixed 64bit BARs
>>   * @bar_fixed_size: Array specifying the size supported by each BAR
>> + * @align: alignment size required for BAR buffer allocation
>>   */
>>  struct pci_epc_features {
>>  	unsigned int	linkup_notifier : 1;
>> @@ -117,6 +118,7 @@ struct pci_epc_features {
>>  	u8	reserved_bar;
>>  	u8	bar_fixed_64bit;
>>  	u64	bar_fixed_size[BAR_5 + 1];
>> +	size_t	align;
>>  };
>>  
>>  #define to_pci_epc(device) container_of((device), struct pci_epc, dev)
>> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
>> index ec02f58758c8..2d6f07556682 100644
>> --- a/include/linux/pci-epf.h
>> +++ b/include/linux/pci-epf.h
>> @@ -149,7 +149,8 @@ void pci_epf_destroy(struct pci_epf *epf);
>>  int __pci_epf_register_driver(struct pci_epf_driver *driver,
>>  			      struct module *owner);
>>  void pci_epf_unregister_driver(struct pci_epf_driver *driver);
>> -void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar);
>> +void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>> +			  size_t align);
>>  void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar);
>>  int pci_epf_bind(struct pci_epf *epf);
>>  void pci_epf_unbind(struct pci_epf *epf);
>> -- 
>> 2.17.1
>>
