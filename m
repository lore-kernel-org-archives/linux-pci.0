Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14D9C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 09:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB22920833
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 09:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="XBOGwLwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfAaJIO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:08:14 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:54508 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfAaJIO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2019 04:08:14 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 657B05C017F;
        Thu, 31 Jan 2019 10:08:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1548925691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2gMcYLQvmtqqAnUFCyazvkTeryFQH+1faRdY9BvOSck=;
        b=XBOGwLwJyr7cIB2BENOvmkogJDn6WnIhLbIXNGVLLYnLvuEzg40WAJDiLksJbCm/e0ptC7
        Bp/+7UpTye8G3+iSg6PH559eRq6zOsAAmNiONv/q35BhLtjgqbmV1o2R3JWWY0f6pzyA+U
        76pnPC9pztPN9hS80Cl0+Bg56WlnM1Q=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 31 Jan 2019 10:08:11 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        l.stach@pengutronix.de, tpiepho@impinj.com,
        leonard.crestez@nxp.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] PCI: dwc: allow to limit registers set length
In-Reply-To: <20190130175415.GA7715@e107981-ln.cambridge.arm.com>
References: <20181204165528.15534-1-stefan@agner.ch>
 <20190130175415.GA7715@e107981-ln.cambridge.arm.com>
Message-ID: <f4f731d928293406e093ae9b23583510@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30.01.2019 18:54, Lorenzo Pieralisi wrote:
> On Tue, Dec 04, 2018 at 05:55:26PM +0100, Stefan Agner wrote:
>> Add length to the struct dw_pcie and check that the accessors
>> dw_pcie_(rd|wr)_conf() do not read/write beyond that point.
>>
>> Suggested-by: Trent Piepho <tpiepho@impinj.com>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> Changes in v4:
>> - Move length check to dw_pcie_rd_conf
>>
>>  .../pci/controller/dwc/pcie-designware-host.c    | 16 ++++++++++++++--
>>  drivers/pci/controller/dwc/pcie-designware.h     |  1 +
>>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> Hi Stefan,
> 
> I wanted to ask you if this series should be considered for v5.1
> inclusion, it is in the PCI backlog. If it is, let me have a look
> and if it is OK to go I will likely ask you to rebase it.

Yes please. With this last change I did not see any regression anymore
so far.

Andrey Smirnov picked up the second patch: "PCI: imx6: introduce
drvdata". Not sure what the plan is with his patchset, if it gets merged
into v5.1 too then I probably better drop this patch and rebase ontop of
his series.

--
Stefan

> 
> Thanks,
> Lorenzo
> 
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 692dd1b264fb..9fc0f7bd99f0 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -606,14 +606,20 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>>  			   int size, u32 *val)
>>  {
>>  	struct pcie_port *pp = bus->sysdata;
>> +	struct dw_pcie *pci;
>>
>>  	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn))) {
>>  		*val = 0xffffffff;
>>  		return PCIBIOS_DEVICE_NOT_FOUND;
>>  	}
>>
>> -	if (bus->number == pp->root_bus_nr)
>> +	if (bus->number == pp->root_bus_nr) {
>> +		pci = to_dw_pcie_from_pp(pp);
>> +		if (pci->dbi_length && where + size > pci->dbi_length)
>> +			return PCIBIOS_BAD_REGISTER_NUMBER;
>> +
>>  		return dw_pcie_rd_own_conf(pp, where, size, val);
>> +	}
>>
>>  	return dw_pcie_rd_other_conf(pp, bus, devfn, where, size, val);
>>  }
>> @@ -622,12 +628,18 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>>  			   int where, int size, u32 val)
>>  {
>>  	struct pcie_port *pp = bus->sysdata;
>> +	struct dw_pcie *pci;
>>
>>  	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn)))
>>  		return PCIBIOS_DEVICE_NOT_FOUND;
>>
>> -	if (bus->number == pp->root_bus_nr)
>> +	if (bus->number == pp->root_bus_nr) {
>> +		pci = to_dw_pcie_from_pp(pp);
>> +		if (pci->dbi_length && where + size > pci->dbi_length)
>> +			return PCIBIOS_BAD_REGISTER_NUMBER;
>> +
>>  		return dw_pcie_wr_own_conf(pp, where, size, val);
>> +	}
>>
>>  	return dw_pcie_wr_other_conf(pp, bus, devfn, where, size, val);
>>  }
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 9943d8c68335..9cd7bdc94200 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -229,6 +229,7 @@ struct dw_pcie {
>>  	void __iomem		*dbi_base2;
>>  	/* Used when iatu_unroll_enabled is true */
>>  	void __iomem		*atu_base;
>> +	int			dbi_length;
>>  	u32			num_viewport;
>>  	u8			iatu_unroll_enabled;
>>  	struct pcie_port	pp;
>> --
>> 2.19.1
>>
