Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA84FC38145
	for <linux-pci@archiver.kernel.org>; Tue,  6 Sep 2022 21:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiIFVqP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Sep 2022 17:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIFVqN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 17:46:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A23F7B293;
        Tue,  6 Sep 2022 14:46:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6590616EF;
        Tue,  6 Sep 2022 21:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F046AC433D6;
        Tue,  6 Sep 2022 21:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662500772;
        bh=t669WiXDoTikYWP/P6pn5svximbzMJMemRpEmdcmFs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zu5442/LXJMRa8CviQJgQ8L10lM91D8mwWWvtWjV1EUDx4dM6PRurgwFNVqGZSqHq
         C/wVFZ2zdQSnkwoEjOdqWoJpffF4pVFYJixEV3elhgb3gZ0LZbSA2YKkzG6mCU9stA
         Dl7dilZdyVGfVseR9Ww8yVs8k7Ips05MtZ6NW0RFEnO2OSZN4MW2eOvOIN6G0crpDj
         I30yufddnNe+QTyGSzUXEBuOGw8XkaQzRJhRSUPjolddWFGmtwaV6fHUA87g86nu7l
         14MtBmtR9kJNl7vArhgpnQ/4sTEHDz9V0K1vs+8oPukmf3j3Yb4szUJxTIcI9z72OB
         e+7yv94a9L8Kg==
Received: by pali.im (Postfix)
        id 29F79742; Tue,  6 Sep 2022 23:46:09 +0200 (CEST)
Date:   Tue, 6 Sep 2022 23:46:09 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: histb: switch to using gpiod API
Message-ID: <20220906214609.pp5rp7ixor6koku2@pali>
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
 <20220906210811.5kzdq66eeeauk2d3@pali>
 <Yxe+gPl5qeqJuC4Z@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yxe+gPl5qeqJuC4Z@google.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 06 September 2022 14:41:20 Dmitry Torokhov wrote:
> On Tue, Sep 06, 2022 at 11:08:11PM +0200, Pali Rohár wrote:
> > On Tuesday 06 September 2022 13:43:00 Dmitry Torokhov wrote:
> > > +	ret = gpiod_set_consumer_name(hipcie->reset_gpio,
> > > +				      "PCIe device power control");
> > 
> > Just unrelated thing, I know it was there before, but I saw it just now
> > and have to comment it: This is absolute nonsense name. "reset-gpios"
> > device tree property specifies PERST# signal pin (PciE ReSeT) as defined
> > in PCIe CEM (Card ElectroMagnetic) specification and it has absolute
> > nothing with PCIe power control.
> > 
> > My suggestion for maintainers would be to remove this critic name at
> > all as it would just mislead other people reading that code.
> 
> I can respin the patch is you suggest a more sensible label...

Lets do renaming in different/separate patch. It is better to split API
change patch (which should have any visible functional changes) and
fixups (which will have some visible changes) in separate patches.

Lorenzo, Bjorn, Krzysztof: This is something for you... Do you have any
ideas or suggestions in unifying or fixing these names? I guess more
drivers have misleading names and it is better to do any such changes
globally and not just in one driver.

> > 
> > > +	if (ret) {
> > > +		dev_err(dev, "unable to set reset gpio name: %d\n", ret);
> > > +		return ret;
> > >  	}
> 
> Thanks.
> 
> -- 
> Dmitry
