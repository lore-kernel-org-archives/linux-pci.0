Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51803C1B0E9
	for <linux-pci@archiver.kernel.org>; Thu, 25 Aug 2022 16:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbiHYQA7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Aug 2022 12:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiHYQA6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 12:00:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1988E25;
        Thu, 25 Aug 2022 09:00:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FA25B82A21;
        Thu, 25 Aug 2022 16:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59F3C433D6;
        Thu, 25 Aug 2022 16:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661443255;
        bh=6d8t4lAQRUiv1HCZMNJ5oHnpE6UUfGuzH3WV06ZWWe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m//NniY6niwgBCYViSjRR+mkW742YK08nu4o3P+i0m/tAE1y1vv51/Iy2kTk29uip
         G8p3DayIlwmhKtesRB5hWNp3Ls9AjcrZTKWaXvIAlUJIT8mUyGyIFbzUPMBdSYHQz3
         DWeRQYfe41kdFFwc6s9WYoPHOFgc2BomKjNzY4sKlQjqRs45SUOO4Ii8Urgm9fcztM
         +ixAiZK1ICF0y2Uabz/alErXfCrFD57TgUn9dkhwITviFpwTdizjvGwc42x9CBC/z0
         +P69efUN8BVOqYxw7zM6uvlRFB0CAfBO+7T7XolIBXuc5+1nf094XjFwprRK6mIICD
         wYZKfxq+4S0Ag==
Received: by pali.im (Postfix)
        id BC4E0742; Thu, 25 Aug 2022 18:00:51 +0200 (CEST)
Date:   Thu, 25 Aug 2022 18:00:51 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Mauri Sandberg <maukka@ext.kapsi.fi>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, linux@armlinux.org.uk, kw@linux.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v2 2/2] PCI: mvebu: add support for orion5x
Message-ID: <20220825160051.z52ak45apjcgf3sl@pali>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
 <20220802173423.47230-1-maukka@ext.kapsi.fi>
 <20220802173423.47230-3-maukka@ext.kapsi.fi>
 <YweSGDN7rei2Ugwp@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YweSGDN7rei2Ugwp@lpieralisi>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 25 August 2022 17:15:36 Lorenzo Pieralisi wrote:
> On Tue, Aug 02, 2022 at 08:34:23PM +0300, Mauri Sandberg wrote:
> > Add support for orion5x PCIe controller.
> > 
> > There is Orion-specific errata that config space via CF8/CFC registers
> > is broken. Workaround documented in errata documented (linked from above
> > documentation) does not work when DMA is used and instead other
> 
> Linked to which documentation ?

Hello! Orion Errata document is linked from kernel doc:
https://www.kernel.org/doc/html/latest/arm/marvell.html
