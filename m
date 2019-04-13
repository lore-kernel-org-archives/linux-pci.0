Return-Path: <SRS0=v2Vw=SP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1B6C10F11
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 15:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D555E208E3
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 15:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555169197;
	bh=J/j6vTOFm0xDUgBr7NLnAvO6mXoT2NAdyDPHNpI1+n4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R4IoIi6KdQWO7QyPoEOjtbAEgN6NobRBithv6sVwDoVhRT0HXpIL7pctqkgnsMx9z
	 vDc/L0c2I6O8hWeWm+xhW/mJ2QvpzxW9ZPsYSMDzbbxMj+dxVvMIO1KeGjG9Rf3/z1
	 1ykxLGXZpJPnTtf5oSJET+Mp/+digQ6568CQKnPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfDMP0g (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 13 Apr 2019 11:26:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbfDMP0g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 13 Apr 2019 11:26:36 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28A642084D;
        Sat, 13 Apr 2019 15:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555169195;
        bh=J/j6vTOFm0xDUgBr7NLnAvO6mXoT2NAdyDPHNpI1+n4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zw0VdTGdBsTjJEaM2/P3VtsHeu6d1RYqHUgNTz5xKXfROkYL4D5pMILgx1HWrM42T
         ORjjQM+huuc4b6a0rIcS/MOhvxcuOqFDnxiHD77+zz5SAvfok8/geRRqk3KDBGdMpb
         vB+N9c7Fh0aRakETStrt634H1EJ9oYh9lUyU2Tc8=
Date:   Sat, 13 Apr 2019 10:26:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH v3 14/26] PCI: keystone: Add support for PCIe RC in
 AM654x Platforms
Message-ID: <20190413152633.GF126710@google.com>
References: <20190325093947.32633-1-kishon@ti.com>
 <20190325093947.32633-15-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325093947.32633-15-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 25, 2019 at 03:09:35PM +0530, Kishon Vijay Abraham I wrote:
> Add PCIe RC support for AM654x Platforms in pci-keystone.c

> +static int ks_pcie_am654_msi_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct device *dev = pci->dev;
> +
> +	dev_vdbg(dev, "dummy function so that DW core doesn't configure MSI\n");

Drive-by nit: this is the first occurrence of dev_vdbg() in
drivers/pci, and while dev_vdbg() might be useful somewhere, I'm not
sure this is the place.

It took me 10 minutes of archaeology to figure out what it is and how
to use it.  Apparently it does nothing at all unless you define
VERBOSE_DEBUG, which can be set via Kconfig in a few cases:

  drivers/dma/Makefile:subdir-ccflags-$(CONFIG_DMADEVICES_VDEBUG) += -DVERBOSE_DEBUG
  drivers/usb/dwc2/Makefile:ccflags-$(CONFIG_USB_DWC2_VERBOSE)    += -DVERBOSE_DEBUG
  drivers/usb/gadget/Makefile:subdir-ccflags-$(CONFIG_USB_GADGET_VERBOSE) += -DVERBOSE_DEBUG

but is more commonly set by adding "#define VERBOSE_DEBUG" manually
in a source file.  Neither one applies here, so I don't think this
actually does anything.

Anyway, I suspect this particular message would make a lot of sense as
a *comment*, but maybe not as a mysterious dev_vdbg() that never
actually does anything.

> +	return 0;
> +}
