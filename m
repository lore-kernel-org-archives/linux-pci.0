Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EDEC433ED
	for <linux-pci@archiver.kernel.org>; Sat, 17 Apr 2021 19:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2306A61245
	for <linux-pci@archiver.kernel.org>; Sat, 17 Apr 2021 19:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbhDQTnL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 17 Apr 2021 15:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236212AbhDQTnL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 17 Apr 2021 15:43:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50D5361210;
        Sat, 17 Apr 2021 19:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618688564;
        bh=kDCeGLiIbk3s1J+iRbwzWhKCRZTMQX5ViQwwKLvHukY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GFEF7SRTA7SU/2d2scU1gX8zykLfkbLKw6fLSamla2je+pWSdMF3od8VGvk1QiTK5
         GQJavOxvTaxVNefkI9eMqKJZ/UaXFm9QVNBaEYoYBvVLMBJBCdbyOB+TKKBaiBinAU
         rSNQYn5mEB4Jw+Nft42aGJXaNhq+c9HvH12q/XRd09/BAx5pcxFNcAhnEhXDSeJJD6
         y983EOoF9nNZR04KEMvegOQR57E47DqDePP7rL8hou4bPfmlijod8ZG/VP2aoeFXg8
         BqZTVzkTBtwoMujNO1j8Q3m1qF4TPDwNXQqu3/SsUkLZsE/6MXXZD3dBqHM3VZC52l
         JAe+2cXGIydCQ==
Received: by pali.im (Postfix)
        id BD0359F7; Sat, 17 Apr 2021 21:42:41 +0200 (CEST)
Date:   Sat, 17 Apr 2021 21:42:41 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Rob Herring <robh+dt@kernel.org>, Marek Behun <marek.behun@nic.cz>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Set linux,pci-domain
 to zero
Message-ID: <20210417194241.zobxpau3ejwzhzbj@pali>
References: <20210412123936.25555-1-pali@kernel.org>
 <CAL_JsqLSse=W3TFu=Wc=eEAV4fKDGfsQ6JUvO3KyG_pnGTVg6A@mail.gmail.com>
 <20210415083640.ntg6kv6ayppxldgd@pali>
 <20210415104537.403de52e@thinkpad>
 <CAL_JsqL2gjprb3MDv8KPSpe0CUBFjGajnMbF71DM+F9Yewp2uw@mail.gmail.com>
 <20210417144953.pznysgn5rdraxggx@pali>
 <YHr8ikD+zoT2/K3W@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHr8ikD+zoT2/K3W@lunn.ch>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Saturday 17 April 2021 17:19:38 Andrew Lunn wrote:
> > Currently this code is implemented in pci_bus_find_domain_nr() function.
> > IIRC domain number is 16bit integer, so plain bitmap would consume 8 kB
> > of memory. I'm not sure if it is fine or some other tree-based structure
> > for allocated domain numbers is needed.
> 
> Hi Pali
> 
> Have a look at lib/idr.c
> 
>      Andrew

Great! So number allocation is already implemented in kernel (via radix trees).
