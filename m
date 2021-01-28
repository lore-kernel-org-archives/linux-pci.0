Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E0BC433DB
	for <linux-pci@archiver.kernel.org>; Thu, 28 Jan 2021 08:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95AAD64DD6
	for <linux-pci@archiver.kernel.org>; Thu, 28 Jan 2021 08:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhA1IyR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Jan 2021 03:54:17 -0500
Received: from muru.com ([72.249.23.125]:53906 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231984AbhA1Ixj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jan 2021 03:53:39 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BB07E80A9;
        Thu, 28 Jan 2021 08:54:29 +0000 (UTC)
Date:   Thu, 28 Jan 2021 10:54:21 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 01/15] PCI: pci-dra7xx: Prepare for deferred probe with
 module_platform_driver
Message-ID: <YBJ7vUlzfGR89IQH@atomide.com>
References: <20210126124004.52550-1-tony@atomide.com>
 <20210126124004.52550-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126124004.52550-2-tony@atomide.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

* Tony Lindgren <tony@atomide.com> [210126 12:41]:
> After updating pci-dra7xx driver to probe with ti-sysc and genpd, I
> noticed that dra7xx_pcie_probe() would not run if a power-domains property
> was configured for the interconnect target module.
> 
> Turns out that module_platform_driver_probe uses platform_driver_probe(),
> while module_platform_driver_probe uses platform_driver_register().

I just noticed that the above is confusing with module_platform_driver_probe
mentioned twice. It should be:

Turns out that module_platform_driver_probe uses platform_driver_probe(),
while builtin_platform_driver uses platform_driver_register().

Regards,

Tony
