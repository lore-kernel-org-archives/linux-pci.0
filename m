Return-Path: <SRS0=9OyC=PS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B0CC43387
	for <linux-pci@archiver.kernel.org>; Thu, 10 Jan 2019 12:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1574A2173B
	for <linux-pci@archiver.kernel.org>; Thu, 10 Jan 2019 12:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfAJMKw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:10:52 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54710 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfAJMKw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jan 2019 07:10:52 -0500
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ghZAW-0002x4-0E; Thu, 10 Jan 2019 13:10:40 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alan Douglas <adouglas@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/15] PCI: endpoint: Cleanup EPC features
Date:   Thu, 10 Jan 2019 13:10:39 +0100
Message-ID: <17209565.32fjuqOkZh@phil>
In-Reply-To: <ce1e4bab-5c7c-5593-d28f-2187a04baef6@ti.com>
References: <20190107064148.10152-1-kishon@ti.com> <1936135.agpnLP3rXd@phil> <ce1e4bab-5c7c-5593-d28f-2187a04baef6@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Donnerstag, 10. Januar 2019, 06:05:00 CET schrieb Kishon Vijay Abraham I:
> Hi Heiko,
> 
> On 07/01/19 8:05 PM, Heiko Stuebner wrote:
> > Am Montag, 7. Januar 2019, 07:41:33 CET schrieb Kishon Vijay Abraham I:
> >> Hi Lorenzo,
> >>
> >> The Endpoint controller driver uses features member in 'struct pci_epc'
> >> to advertise the list of supported features to the endpoint function
> >> driver.
> >>
> >> There are a few shortcomings with this approach.
> >>   *) Certain endpoint controllers support fixed size BAR (e.g. TI's
> >>      AM654 uses Designware configuration with fixed size BAR). The
> >>      size of each BARs cannot be passed to the endpoint function
> >>      driver.
> >>   *) Too many macros for handling EPC features.
> >>      (EPC_FEATURE_NO_LINKUP_NOTIFIER, EPC_FEATURE_BAR_MASK,
> >>       EPC_FEATURE_MSIX_AVAILABLE, EPC_FEATURE_SET_BAR,
> >>       EPC_FEATURE_GET_BAR)
> >>   *) Endpoint controllers are directly modifying struct pci_epc
> >>      members. (I have plans to move struct pci_epc to
> >>      drivers/pci/endpoint so that pci_epc members are referenced
> >>      only by endpoint core).
> >>
> >> To overcome the above shortcomings, introduced pci_epc_get_features()
> >> API, pci_epc_features structure and a ->get_features() callback.
> >>
> >> Also added a patch to set BAR flags in pci_epf_alloc_space and
> >> remove it from pci-epf-test function driver.
> >>
> >> Tested on TI's DRA7xx platform.
> > 
> > While I don't have that much PCI experience and hence cannot judge
> > this cleanup as a whole, I can at least say, that my Rockchip rk3399
> > still does find its PCIE-connected wifi card, so this series on rk3399
> > 
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> 
> Thank you for testing this series with PCIe controller configured in RC mode.
> It would be great if it could be tested with EP mode too.
> 
> Thanks for the help.

Sadly I don't have hardware for that, but the support was done by Shawn,
maybe he can help with testing EP mode and will hopefully see this mail
and give it a spin.

Heiko


