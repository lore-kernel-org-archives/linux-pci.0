Return-Path: <SRS0=hk3Y=RB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5866FC43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 09:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2391E217F5
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 09:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="GHM0ZCcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfBZJzv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:55:51 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:55804 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbfBZJzv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Feb 2019 04:55:51 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 1C50E5C00AC;
        Tue, 26 Feb 2019 10:55:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1551174948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GGDfq8gyIRW6P77kWmoItADXSQYhOhSagTVgZhBHwdg=;
        b=GHM0ZCcK1vXHql+UXFpxM4Ofg/X0kmXb7rCJi7mMl85g147wr2yZy8qgA+1+/mnu3XBd0Y
        reYkIrE+dzpYFmHybfreUtkVCMQQGTBNqcLR8ZWAaF/HGHIOxlQOxVSuF3mH7reWXIvjKt
        ghnk0xKSNbv1sNzp2byKhvmZTRCBOfE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Feb 2019 10:55:48 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Trent Piepho <tpiepho@impinj.com>, leonard.crestez@nxp.com,
        hongxing.zhu@nxp.com, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, lorenzo.pieralisi@arm.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        l.stach@pengutronix.de, Thinh Nguyen <thinh.nguyen@synopsys.com>
Subject: Re: [PATCH v7] PCI: imx6: limit DBI register length
In-Reply-To: <CAErSpo5CesyZkJ_2gFJtVh_Dtac3gY1YRLiRn25mazuRsHVovQ@mail.gmail.com>
References: <20190225160226.11924-1-stefan@agner.ch>
 <34b23c031a8e0964b3e87a6252dd5cefaa62cc95.camel@nxp.com>
 <1551113572.3075.172.camel@impinj.com>
 <CAErSpo5CesyZkJ_2gFJtVh_Dtac3gY1YRLiRn25mazuRsHVovQ@mail.gmail.com>
Message-ID: <ac84df908213ef5c786961e7237e896e@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25.02.2019 21:19, Bjorn Helgaas wrote:
> [+cc Thinh]
> 
> On Mon, Feb 25, 2019 at 10:52 AM Trent Piepho <tpiepho@impinj.com> wrote:
>> On Mon, 2019-02-25 at 16:15 +0000, Leonard Crestez wrote:
>> > On Mon, 2019-02-25 at 17:02 +0100, Stefan Agner wrote:
>> > > Define the length of the DBI registers and limit config space to its
>> > > length. This makes sure that the kernel does not access registers
>> > > beyond that point, avoiding the following abort on a i.MX 6Quad:
>> > >
>> > > +static void imx6_pcie_quirk(struct pci_dev *dev)
>> > > +{
>> > > +   struct pci_bus *bus = dev->bus;
>> > > +   struct pcie_port *pp = bus->sysdata;
>> > > +
>> > > +   if (bus->number == pp->root_bus_nr) {
>> > > +           struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> > > +           struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
>> > > +
>> > > +           /*
>> > > +            * Limit config length to avoid the kernel reading beyond
>> > > +            * the register set and causing an abort on i.MX 6Quad
>> > > +            */
>> > > +           if (imx6_pcie->drvdata->dbi_length)
>> > > +                   dev->cfg_size = imx6_pcie->drvdata->dbi_length;
>> > > +   }
>> > > +}
>> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, imx6_pcie_quirk);
>> >
>> > This looks like a default from SYNOPSYS so it likely run on other SOCs
>> > using the DesignWare PCI IP and crash because of those unchecked casts.
>>
>> Yes, it's used on IMX7d too.  But it's worse than that, there's a USB
>> controller core that uses the same vendor and device id,
>> PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3.  The quirk for that one uses class ==
>> PCI_CLASS_SERIAL_USB_DEVICE to avoid matching this PCI-e IP.  See
>> thread "PCI: Check for USB xHCI class for HAPS platform"
> 
> If we could get these vendors to allocate their own Vendor/Device IDs,
> maybe we could consider a DECLARE_PCI_FIXUP_EARLY quirk that would fix
> up pdev->vendor and pdev->device?  That might be cleaner than
> cluttering all these quirks with details of this screwup.

According to www.pcilookup.com there is a vendor/product id allocated
for recovery mode (Freescale i.MX 6, 15a2:0054). Is this a real PCI id?
The same Vendor/Device ID is used for USB recovery...

--
Stefan
