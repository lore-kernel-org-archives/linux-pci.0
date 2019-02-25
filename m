Return-Path: <SRS0=2sVk=RA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98EEC43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 15:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8634A20C01
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 15:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="vSoLrEJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfBYPfl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:35:41 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:42046 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfBYPfl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Feb 2019 10:35:41 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 8898B5C2A43;
        Mon, 25 Feb 2019 16:35:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1551108939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vlSDAgO/nXXh4PmhdCrl3yP03f1NY0PRUY8ztoL1UmA=;
        b=vSoLrEJXgDCH8bCR9v2cwn2YHmNWhx+sgkXjuA2AKW55kdGR66voa0/2mtd/NYOeA2CyQJ
        GOwIHQ31YQ3/yA+AxekeU4G3wXX0VMzxOrhV7NQ27tJkuRXdtexjl3Qp4lfEF+cbT2UXR3
        sXmijYzh24r2x5iLn3cQDdnpIVDRTFs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 25 Feb 2019 16:35:39 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     linux-kernel@vger.kernel.org, jingoohan1@gmail.com,
        lorenzo.pieralisi@arm.com, gustavo.pimentel@synopsys.com,
        tpiepho@impinj.com, linux-pci@vger.kernel.org, bhelgaas@google.com,
        l.stach@pengutronix.de
Subject: Re: [PATCH v6] PCI: imx6: limit DBI register length
In-Reply-To: <cc1df497422f38649b8d62cba794ed4ad7aa6619.camel@nxp.com>
References: <20190225142537.29042-1-stefan@agner.ch>
 <cc1df497422f38649b8d62cba794ed4ad7aa6619.camel@nxp.com>
Message-ID: <eb40c43946c46570da67d8a710b87062@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25.02.2019 15:47, Leonard Crestez wrote:
> On Mon, 2019-02-25 at 15:25 +0100, Stefan Agner wrote:
>> Define the length of the DBI registers and limit config space to its
>> length. This makes sure that the kernel does not access registers
>> beyond that point, avoiding the following abort on a i.MX 6Quad:
>>   # cat /sys/devices/soc0/soc/1ffc000.pcie/pci0000\:00/0000\:00\:00.0/config
>>   [  100.021433] Unhandled fault: imprecise external abort (0x1406) at 0xb6ea7000
>>   ...
>>   [  100.056423] PC is at dw_pcie_read+0x50/0x84
>>   [  100.060790] LR is at dw_pcie_rd_own_conf+0x44/0x48
>>
>> +static void imx6_pcie_quirk(struct pci_dev *dev)
>> +{
>> +	struct pci_bus *bus = dev->bus;
>> +	struct pcie_port *pp = bus->sysdata;
>> +
>> +	if (bus->number == pp->root_bus_nr) {
>> +		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +		struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
>> +
>> +		/*
>> +		 * Limit config length to avoid the kernel reading beyond
>> +		 * the register set and causing an abort on i.MX 6Quad
>> +		 */
>> +		dev->cfg_size = imx6_pcie->drvdata->dbi_length;
>> +	}
>> +}
>> +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, imx6_pcie_quirk);
> 
> Are you sure that this quirk is only applied to imx6-pcie?
> Superficially it looks like it would apply to all PCI roots and this
> could be a problem on configs which enable all drivers, like arm64.

That was inspired by the FIXUP in keystone, which uses
PCI_ANY_ID/PCI_ANY_ID too.

However, keystone also does not have arm64 variants it seems.
Furthermore, the keystone fixup checks PCI ids in code.

> 
> Maybe the linker magic inside DECLARE_PCI_FIXUP deals with that, in
> that case I apologize.

I don't think there is special linker magic, if CONFIG_PCI_IMX6 is
enabled this will get called.

I agree, I should use PCI_VENDOR_ID_SYNOPSYS, 0xabcd here.


Btw, while looking at the patch again I realized that I need to check
imx6_pcie->drvdata->dbi_length for 0 and not apply in this case to avoid
breaking other i.MX designs.

I will send a v7.

--
Stefan
