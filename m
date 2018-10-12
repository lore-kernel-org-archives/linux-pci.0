Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566EDC6783C
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 13:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A76F2098A
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 13:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A76F2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeJLVT6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:19:58 -0400
Received: from foss.arm.com ([217.140.101.70]:51538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbeJLVT6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Oct 2018 17:19:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79B1DED1;
        Fri, 12 Oct 2018 06:47:26 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F161A3F5BC;
        Fri, 12 Oct 2018 06:47:23 -0700 (PDT)
Date:   Fri, 12 Oct 2018 14:47:21 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Gustavo.Pimentel@synopsys.com, Mark Rutland <mark.rutland@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 00/40] Cleanup pci-keystone.c and Add AM654 PCIe
 Support
Message-ID: <20181012134721.GD23257@e107981-ln.cambridge.arm.com>
References: <20180921102155.22839-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 21, 2018 at 03:51:15PM +0530, Kishon Vijay Abraham I wrote:
> Add PCIe RC support for TI's AM654 SoC. The PCIe controller in AM654
> uses Synopsys core revision 4.90a and uses the same TI wrapper as used
> in keystone2 with certain modification. Hence AM654 will use the same
> pci wrapper driver pci-keystone.c
> 
> The initial support for AM654 was merged recently [1]
> 
> [1] -> https://lore.kernel.org/lkml/20180626162615.19194-1-nm@ti.com/
> 
> Patch series includes the following
>  *) Merge pci-keystone-dw.c into pci-keystone.c so that we have single
>     file for PCIe keystone driver.
>  *) Cleanup the pci-keystone driver. In certain cases the DT binding is
>     also modified since PCIe in keystone has never worked in mainline
>     due to lack of PHY support.
>  *) Included the PHY driver here for completeness (though the driver
>     might go via linux-phy tree)
>  *) Included the device tree patches here. Once this series is reviewed
>     it'll be sent to be merged via Tony's tree.
>  *) Patch to fix ATU identification for designware version >= 4.80 in
>     designware core is also included here.
> 
> TODO:
>  *) Add Endpoint Support for AM654
>  *) Send a patch to fix the MRRS after the correct value is identified.
> 
> Once this series is reviewed I'll split the series and send to
> corresponding subsytem Maintainers after removing RFC in subject.

Hi Kishon,

I started reviewing the series, I noticed that some patches are
clean-ups that I would like to queue to cut the delta so that you
can rebase on top of them, do you have time to post the clean-up
patches (no functional changes) stand-alone so that I can queue
them up please ?

I think you should drop the RFC tag from this series.

Thanks,
Lorenzo
