Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83353C282DA
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 13:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539D321773
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 13:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uxQtU8on"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbfDQNId (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:08:33 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59154 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfDQNId (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Apr 2019 09:08:33 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3HD8Dip100392;
        Wed, 17 Apr 2019 08:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555506493;
        bh=r5kq205iU1iqPvi87w82BmwDqtQo9PeTN3yj5l/qvnE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uxQtU8on9l0t3MZwvxgE2v1h3I3s7JVm3jz/3NkCJk7PIP5Fbgv8hxA2ScdICLR5Q
         /LDzUw7wLru42GNoT37BP7wmZ//tCTYpRInzKUa01SJg+3oVcHYbbxnS/FWCxkkEOv
         0BrMrCQ/j5yAGDXx8uVeqhFt+yDvgW9qt81K7umQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3HD8D4M021215
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Apr 2019 08:08:13 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 17
 Apr 2019 08:08:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 17 Apr 2019 08:08:12 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3HD85C0075254;
        Wed, 17 Apr 2019 08:08:07 -0500
Subject: Re: [PATCH v3 14/26] PCI: keystone: Add support for PCIe RC in AM654x
 Platforms
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
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
 <20190325093947.32633-15-kishon@ti.com> <20190413152633.GF126710@google.com>
 <20190416141525.GD14705@red-moon>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <fd5c114b-5a67-cca9-d9fb-750557f14970@ti.com>
Date:   Wed, 17 Apr 2019 18:36:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416141525.GD14705@red-moon>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 16/04/19 7:45 PM, Lorenzo Pieralisi wrote:
> On Sat, Apr 13, 2019 at 10:26:33AM -0500, Bjorn Helgaas wrote:
>> On Mon, Mar 25, 2019 at 03:09:35PM +0530, Kishon Vijay Abraham I wrote:
>>> Add PCIe RC support for AM654x Platforms in pci-keystone.c
>>
>>> +static int ks_pcie_am654_msi_host_init(struct pcie_port *pp)
>>> +{
>>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>> +	struct device *dev = pci->dev;
>>> +
>>> +	dev_vdbg(dev, "dummy function so that DW core doesn't configure MSI\n");
>>
>> Drive-by nit: this is the first occurrence of dev_vdbg() in
>> drivers/pci, and while dev_vdbg() might be useful somewhere, I'm not
>> sure this is the place.
>>
>> It took me 10 minutes of archaeology to figure out what it is and how
>> to use it.  Apparently it does nothing at all unless you define
>> VERBOSE_DEBUG, which can be set via Kconfig in a few cases:
>>
>>   drivers/dma/Makefile:subdir-ccflags-$(CONFIG_DMADEVICES_VDEBUG) += -DVERBOSE_DEBUG
>>   drivers/usb/dwc2/Makefile:ccflags-$(CONFIG_USB_DWC2_VERBOSE)    += -DVERBOSE_DEBUG
>>   drivers/usb/gadget/Makefile:subdir-ccflags-$(CONFIG_USB_GADGET_VERBOSE) += -DVERBOSE_DEBUG
>>
>> but is more commonly set by adding "#define VERBOSE_DEBUG" manually
>> in a source file.  Neither one applies here, so I don't think this
>> actually does anything.
>>
>> Anyway, I suspect this particular message would make a lot of sense as
>> a *comment*, but maybe not as a mysterious dev_vdbg() that never
>> actually does anything.
> 
> I agree. Kishon ? I would do what Bjorn suggests here, please let me
> know.

Sure.

Thanks
Kishon
