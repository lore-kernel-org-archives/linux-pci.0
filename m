Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D06C04EB8
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 10:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567A320834
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 10:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BX7sy0mU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567A320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbeLDKkg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:40:36 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:47112 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeLDKkg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Dec 2018 05:40:36 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 274F910C0C13;
        Tue,  4 Dec 2018 02:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543920036; bh=QFptKFuEEOboXwvfSm4BVTKR8HyhhdyharqkxaMepII=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=BX7sy0mUrcoIoY0w4fzbECk0NEL0M4jHo8H7v8Wef5Oy2UeZ/WFSMY/p4InIv9fV4
         R3OEiUUc+qIlJgbefxRr0DAgzG8DPlu4S4r64tMg2nt00eVHGYYoHI6fjEE6wziSFP
         qwemo/PBUmqvrwJoffIlxO42FQPU8yBW+W0/6+cb+Z/wvVy30wlHrwR7ACHjOL92RH
         wi3IvSmr0uf7wqTGYIjRR1iHdEqgnb2N5sid+/B9+LK721Gof45XSTkOVxoZK6Mnew
         R6ybxSAnJmW+fjgZdNpI2+BTPW3NBeHcj0d06pDaoDRQLN6jiCIy8BmvWmapbde7/4
         N9yiDI/tVmaHw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id D5E83304B;
        Tue,  4 Dec 2018 02:40:35 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 02:40:35 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 11:40:33 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 11:40:33 +0100
Subject: Re: [PATCH] PCI: dwc: Print debug error message when MSI-X entry
 control mask bit is set
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "joao.pinto@synopsys.com" <joao.pinto@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <113052d54c1f3fa01f8ea1aa6e5a49e2620b5c64.1542910855.git.gustavo.pimentel@synopsys.com>
 <20181130103834.GA17598@e107981-ln.cambridge.arm.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <5dc240eb-624b-1f24-7382-a860cf9ded17@synopsys.com>
Date:   Tue, 4 Dec 2018 10:36:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181130103834.GA17598@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/11/2018 10:38, Lorenzo Pieralisi wrote:
> On Thu, Nov 22, 2018 at 07:20:55PM +0100, Gustavo Pimentel wrote:
>> Add debug error message when MSI-X entry control mask bit is set, to help
>> depur which reason why a MSI-X interrupt is not being trigger.
> 
> s/depur which/debug the
> 
> s/trigger/triggered

Ok, I'll fix it.

> 
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-designware-ep.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> index 1e7b022..b52b986 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> @@ -466,8 +466,10 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>>  
>>  	iounmap(msix_tbl);
>>  
>> -	if (vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT)
>> +	if (vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT) {
>> +		dev_err(pci->dev, "MSI-X entry ctrl set\n");
> 
> I would make it dev_dbg() given debugging is the reason you are adding
> it, can I make this change ?

I see your point. Yes, of course, please do it.

Gustavo

> 
> Lorenzo
> 
>>  		return -EPERM;
>> +	}
>>  
>>  	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
>>  				  epc->mem->page_size);
>> -- 
>> 2.7.4
>>

