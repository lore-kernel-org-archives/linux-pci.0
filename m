Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C873C32793
	for <linux-pci@archiver.kernel.org>; Wed, 18 Jan 2023 17:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjARRBV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 18 Jan 2023 12:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjARRBQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 12:01:16 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0C8FF45BDA
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2023 09:01:14 -0800 (PST)
Received: (qmail 214419 invoked by uid 1000); 18 Jan 2023 12:01:13 -0500
Date:   Wed, 18 Jan 2023 12:01:13 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Madalin Bucur <madalin.bucur@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 7/7] usb: host: ohci-exynos: Convert to
 devm_of_phy_optional_get()
Message-ID: <Y8gl2bLxqWwXPMfS@rowland.harvard.edu>
References: <cover.1674036164.git.geert+renesas@glider.be>
 <cd685d8e4d6754c384acfc1796065d539a2c3ea8.1674036164.git.geert+renesas@glider.be>
 <Y8gb8l18XzYOPhoD@rowland.harvard.edu>
 <CAMuHMdUsULA0PM26Y8WL2bGiBHGAGADS6eYLUp0CDVgm4N5kow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUsULA0PM26Y8WL2bGiBHGAGADS6eYLUp0CDVgm4N5kow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 18, 2023 at 05:50:00PM +0100, Geert Uytterhoeven wrote:
> Hi Alan,
> 
> On Wed, Jan 18, 2023 at 5:26 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Wed, Jan 18, 2023 at 11:15:20AM +0100, Geert Uytterhoeven wrote:
> > > Use the new devm_of_phy_optional_get() helper instead of open-coding the
> > > same operation.
> > >
> > > This lets us drop several checks for IS_ERR(), as phy_power_{on,off}()
> > > handle NULL parameters fine.
> >
> > The patch ignores a possible -ENOSYS error return.  Is it known that
> > this will never happen?
> 
> While some phy_*() dummies in include/linux/phy/phy.h do return -ENOSYS
> if CONFIG_GENERIC_PHY is not enabled, devm_of_phy_optional_get()
> returns NULL in that case, so I think this cannot happen.

You could mention that in the patch description.  Apart from this one 
issue:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
