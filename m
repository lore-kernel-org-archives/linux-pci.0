Return-Path: <SRS0=hk3Y=RB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA21C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 11:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995CC2173C
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 11:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="G6n56NjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfBZLg7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:36:59 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:57152 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfBZLg7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Feb 2019 06:36:59 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id B79FD5C0096;
        Tue, 26 Feb 2019 12:36:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1551181017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=emWlkXCTcHLXpN7Y363SqQI0Ise2tRtE+A98e6iarg0=;
        b=G6n56NjK2S9tQVhdZ3dnwkIFlymW34Ia9YHZIFfB73gRgX4nTsRB+QCPN5Oyei3AYf5L0K
        eP0A6TRD0SyRiILGj1MxDBKS/OS/gCs6AXH62VIcNF6ZgnUNqcLCzuduhjbood2i+5V43o
        FcVx66Fb56WoVXbhPdHv5ZECrNtQPuI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Feb 2019 12:36:57 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     leonard.crestez@nxp.com, hongxing.zhu@nxp.com,
        linux-kernel@vger.kernel.org, jingoohan1@gmail.com,
        lorenzo.pieralisi@arm.com, gustavo.pimentel@synopsys.com,
        linux-pci@vger.kernel.org, l.stach@pengutronix.de,
        bhelgaas@google.com
Subject: Re: [PATCH v7] PCI: imx6: limit DBI register length
In-Reply-To: <1551113572.3075.172.camel@impinj.com>
References: <20190225160226.11924-1-stefan@agner.ch>
 <34b23c031a8e0964b3e87a6252dd5cefaa62cc95.camel@nxp.com>
 <1551113572.3075.172.camel@impinj.com>
Message-ID: <e38f54385f9ae4383bcb6f368e8d694b@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25.02.2019 17:52, Trent Piepho wrote:
> On Mon, 2019-02-25 at 16:15 +0000, Leonard Crestez wrote:
>> On Mon, 2019-02-25 at 17:02 +0100, Stefan Agner wrote:
>> > Define the length of the DBI registers and limit config space to its
>> > length. This makes sure that the kernel does not access registers
>> > beyond that point, avoiding the following abort on a i.MX 6Quad:
>> >
>> > +static void imx6_pcie_quirk(struct pci_dev *dev)
>> > +{
>> > +	struct pci_bus *bus = dev->bus;
>> > +	struct pcie_port *pp = bus->sysdata;
>> > +
>> > +	if (bus->number == pp->root_bus_nr) {
>> > +		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> > +		struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
>> > +
>> > +		/*
>> > +		 * Limit config length to avoid the kernel reading beyond
>> > +		 * the register set and causing an abort on i.MX 6Quad
>> > +		 */
>> > +		if (imx6_pcie->drvdata->dbi_length)
>> > +			dev->cfg_size = imx6_pcie->drvdata->dbi_length;
>> > +	}
>> > +}
>> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, imx6_pcie_quirk);
>>
>> This looks like a default from SYNOPSYS so it likely run on other SOCs
>> using the DesignWare PCI IP and crash because of those unchecked casts.
> 
> Yes, it's used on IMX7d too.  But it's worse than that, there's a USB
> controller core that uses the same vendor and device id,
> PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3.  The quirk for that one uses class ==
> PCI_CLASS_SERIAL_USB_DEVICE to avoid matching this PCI-e IP.  See
> thread "PCI: Check for USB xHCI class for HAPS platform"

Hm, I see, something like this should fix this:

DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd,
			PCI_CLASS_BRIDGE_PCI, 8, imx6_pcie_quirk);


(this needs "PCI: Work around Synopsys duplicate Device ID (HAPS USB3,
NXP i.MX)" applied, which is in v5.0-rc8 already).

--
Stefan
