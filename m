Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16461C43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 10:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD24D2089D
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 10:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.b="mTFka4Mp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD24D2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cesnet.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbeJARdy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:33:54 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:55434 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbeJARdy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Oct 2018 13:33:54 -0400
Received: from localhost (unknown [IPv6:2001:718:1:2e:618c:c23d:a7ac:fd26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 2C596400052;
        Mon,  1 Oct 2018 12:56:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2; t=1538391398;
        bh=3A6M1Vfh9xUz8J314WuAp1cXCiOOkZfm3McYgyNjY9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=mTFka4Mp7idrybu0HmWuMSBbVtQjYUQF7hJgimUZHZD8vo6XmI4EYkMaPU6R5PmiJ
         Om0MutcClbcUWVZZSnlkE1ouGKBj0rpBnWCy6p+IMxmjaFvZFKt7Yp/+vDNpF+Wla5
         0MGBqnKE7GTNbWzV9B9YuhUn1KtjF/1Zbrm5i1T8=
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since =?iso-8859-1?Q?"PCI:_mvebu:_Only_remap_I/O_space_if_configured"?=
Date:   Mon, 01 Oct 2018 12:56:37 +0200
MIME-Version: 1.0
Message-ID: <0f80dc88-dffe-4ca6-bb85-c4e5c967e0e1@cesnet.cz>
In-Reply-To: <20180924165218.26c7c418@windsurf>
References: <20180912231050.GX30658@n2100.armlinux.org.uk>
 <20180913094515.351967bb@windsurf>
 <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
 <20180913104241.65db8243@windsurf>
 <20180924101213.GO30658@n2100.armlinux.org.uk>
 <20180924122614.70738b5c@windsurf>
 <20180924111341.GP30658@n2100.armlinux.org.uk>
 <20180924141203.3df9707a@windsurf>
 <20180924124620.GA10322@e107981-ln.cambridge.arm.com>
 <20180924151040.5e57462b@windsurf>
 <20180924141512.GA11875@e107981-ln.cambridge.arm.com>
 <20180924165218.26c7c418@windsurf>
Organization: CESNET
User-Agent: Trojita/v0.7-361-gfee56b6f-dirty; Qt/5.11.0; xcb; Linux; Gentoo Base System release 2.4.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On pond=C4=9Bl=C3=AD 24. z=C3=A1=C5=99=C3=AD 2018 16:52:18 CEST, Thomas Petaz=
zoni wrote:
> Hello,
>
> On Mon, 24 Sep 2018 15:15:12 +0100, Lorenzo Pieralisi wrote:
>
>> I understand that, I wanted to make sure we come up with a fix asap
>> and what I put forward would cover everything discussed in this thread,
>> at least temporarily, giving us time to check ISA related issues while
>> unmapping IO space.
>
> Something like this should implemented what you suggest I guess:
>
> diff --git a/drivers/pci/controller/pci-mvebu.c=20
> b/drivers/pci/controller/pci-mvebu.c
> index 50eb0729385b..a41d79b8d46a 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -1145,7 +1145,6 @@ static int=20
> mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
>  {
>         struct device *dev =3D &pcie->pdev->dev;
>         struct device_node *np =3D dev->of_node;
> -       unsigned int i;
>         int ret;
> =20
>         INIT_LIST_HEAD(&pcie->resources);
> @@ -1179,13 +1178,58 @@ static int=20
> mvebu_pcie_parse_request_resources(struct mvebu_pcie *pcie)
>                                          resource_size(&pcie->io) - 1);
>                 pcie->realio.name =3D "PCI I/O";
> =20
> +               pci_add_resource(&pcie->resources, &pcie->realio);
> +       }
> +
> +       return devm_request_pci_bus_resources(dev, &pcie->resources);
> +}
> +
> +/*
> + * This is a copy of pci_host_probe(), except that it does the I/O
> + * remap as the last step, once we are sure we won't fail.
> + *
> + * It should be removed once the I/O remap error handling issue has
> + * been sorted out.
> + */
> +static int mvebu_pci_host_probe(struct pci_host_bridge *bridge)
> +{
> +       struct mvebu_pcie *pcie;
> +       struct pci_bus *bus, *child;
> +       int ret;
> +
> +       ret =3D pci_scan_root_bus_bridge(bridge);
> +       if (ret < 0) {
> +               dev_err(bridge->dev.parent, "Scanning root bridge failed");=

> +               return ret;
> +       }
> +
> +       pcie =3D pci_host_bridge_priv(bridge);
> +       if (resource_size(&pcie->io) !=3D 0) {
> +               unsigned int i;
> +
>                 for (i =3D 0; i < resource_size(&pcie->realio); i +=3D SZ_6=
4K)
>                         pci_ioremap_io(i, pcie->io.start + i);
> +       }
> =20
> -               pci_add_resource(&pcie->resources, &pcie->realio);
> +       bus =3D bridge->bus;
> +
> +       /*
> +        * We insert PCI resources into the iomem_resource and
> +        * ioport_resource trees in either pci_bus_claim_resources()
> +        * or pci_bus_assign_resources().
> +        */
> +       if (pci_has_flag(PCI_PROBE_ONLY)) {
> +               pci_bus_claim_resources(bus);
> +       } else {
> +               pci_bus_size_bridges(bus);
> +               pci_bus_assign_resources(bus);
> +
> +               list_for_each_entry(child, &bus->children, node)
> +                       pcie_bus_configure_settings(child);
>         }
> =20
> -       return devm_request_pci_bus_resources(dev, &pcie->resources);
> +       pci_bus_add_devices(bus);
> +       return 0;
>  }
> =20
>  static int mvebu_pcie_probe(struct platform_device *pdev)
> @@ -1268,7 +1312,7 @@ static int mvebu_pcie_probe(struct=20
> platform_device *pdev)
>         bridge->align_resource =3D mvebu_pcie_align_resource;
>         bridge->msi =3D pcie->msi;
> =20
> -       return pci_host_probe(bridge);
> +       return mvebu_pci_host_probe(bridge);
>  }
> =20
>  static const struct of_device_id mvebu_pcie_of_match_table[] =3D {
>
> If that's what you meant, I'll go ahead and test on actual hardware and
> submit as a proper patch.

Thomas, Russell, Lorenzo,
did you have time to convert this into a patch which can hit 4.19? I don't=20=

see anything related in 4.19-rc6, but perhaps I missed something. Is there=20=

something that I should test or otherwise help?

With kind regards,
Jan
