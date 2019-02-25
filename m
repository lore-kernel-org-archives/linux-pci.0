Return-Path: <SRS0=2sVk=RA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387C2C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 20:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084DD20C01
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 20:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JxH8EWIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfBYUTo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Feb 2019 15:19:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35092 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfBYUTo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Feb 2019 15:19:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id t18so11410134wrx.2
        for <linux-pci@vger.kernel.org>; Mon, 25 Feb 2019 12:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4zH89Zq9SqbJJu7X0gOSlL1cMnZgSF1TBndwsxSXR2g=;
        b=JxH8EWInUFaoaG/PYRjMl0vHlFqBoX4GsxzppxKlaiQBtf3eBujQ4mnHkxI8b8bvpS
         bFtVL8OR57GUxBkbJb/jMqs+6sbEibQLY/nfWfmW8kVmRNiCH3qHPk42aa2JZbQBnMzv
         3Wp0ikvAwBW0eQgIy3xQ6yOtb+0x7JLg+qLDJOYBnBj+bKLSsRViaRFpIeb3f/chXBO/
         syxYHi2OSB8QlLQZIBsq9PDSKmNu5DROnVSBReyfJWUtJn/MIdwKH1rBk6rc2SwJ8k3D
         mDvRXMMEIhd2bvWZQ3bDa8X0WYszIQ/oZAF3zQseQ2KSU/BjgDucTmooyj1eUr+yhZGd
         zCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4zH89Zq9SqbJJu7X0gOSlL1cMnZgSF1TBndwsxSXR2g=;
        b=DqFEKnIhVebkjSQXtjRvhqVlLKt5HdydVse9tWIKmxUuQl8kY42e0pjZHKFZC0FW+A
         BzWroNcvOZFavCu/+4RNUyvvgkTSsRX0sevN5k6HslazvuAa7d4uNyL2a2MIa8SwwsBF
         FX98+9S7K9E2MD2+uAF3M/+v/r5T+5SvOaIHoYzQH4fC5s2xnVIFSs+Mhduu0XTatOlQ
         5AeQtbsLwNd3oYpjV2uGBeptM4hLtQLdrHKaBijBleRLdcCMAmw3WRXl0fI/7jpWSYKN
         ykb82KbW41o0WLY1MUitcLoevT9dhnb/2lJWFXnVCG/WHpGNUkg1AV3bGOFAVDwXr5xC
         t8hg==
X-Gm-Message-State: AHQUAuYrdIl+pdWkSyio2BhQNpctIhMFepNF3W/DS0pt/YEw4phxnSsj
        GA703iQqx9QHutC6zUgEEWatXNXwx6f/7QwG2AXl
X-Google-Smtp-Source: AHgI3Ia+zikICm+RtadFdqBxWDOUiH21rCjXy5mzgTiwTjidC/t4O54+udjfT1xTSyqueYKwO4agkivV89FdeqFUF0M=
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr13385818wrw.120.1551125982379;
 Mon, 25 Feb 2019 12:19:42 -0800 (PST)
MIME-Version: 1.0
References: <20190225160226.11924-1-stefan@agner.ch> <34b23c031a8e0964b3e87a6252dd5cefaa62cc95.camel@nxp.com>
 <1551113572.3075.172.camel@impinj.com>
In-Reply-To: <1551113572.3075.172.camel@impinj.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 25 Feb 2019 14:19:31 -0600
Message-ID: <CAErSpo5CesyZkJ_2gFJtVh_Dtac3gY1YRLiRn25mazuRsHVovQ@mail.gmail.com>
Subject: Re: [PATCH v7] PCI: imx6: limit DBI register length
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "stefan@agner.ch" <stefan@agner.ch>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Thinh]

On Mon, Feb 25, 2019 at 10:52 AM Trent Piepho <tpiepho@impinj.com> wrote:
> On Mon, 2019-02-25 at 16:15 +0000, Leonard Crestez wrote:
> > On Mon, 2019-02-25 at 17:02 +0100, Stefan Agner wrote:
> > > Define the length of the DBI registers and limit config space to its
> > > length. This makes sure that the kernel does not access registers
> > > beyond that point, avoiding the following abort on a i.MX 6Quad:
> > >
> > > +static void imx6_pcie_quirk(struct pci_dev *dev)
> > > +{
> > > +   struct pci_bus *bus = dev->bus;
> > > +   struct pcie_port *pp = bus->sysdata;
> > > +
> > > +   if (bus->number == pp->root_bus_nr) {
> > > +           struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +           struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
> > > +
> > > +           /*
> > > +            * Limit config length to avoid the kernel reading beyond
> > > +            * the register set and causing an abort on i.MX 6Quad
> > > +            */
> > > +           if (imx6_pcie->drvdata->dbi_length)
> > > +                   dev->cfg_size = imx6_pcie->drvdata->dbi_length;
> > > +   }
> > > +}
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, imx6_pcie_quirk);
> >
> > This looks like a default from SYNOPSYS so it likely run on other SOCs
> > using the DesignWare PCI IP and crash because of those unchecked casts.
>
> Yes, it's used on IMX7d too.  But it's worse than that, there's a USB
> controller core that uses the same vendor and device id,
> PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3.  The quirk for that one uses class ==
> PCI_CLASS_SERIAL_USB_DEVICE to avoid matching this PCI-e IP.  See
> thread "PCI: Check for USB xHCI class for HAPS platform"

If we could get these vendors to allocate their own Vendor/Device IDs,
maybe we could consider a DECLARE_PCI_FIXUP_EARLY quirk that would fix
up pdev->vendor and pdev->device?  That might be cleaner than
cluttering all these quirks with details of this screwup.

Bjorn
