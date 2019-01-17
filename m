Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0C0C43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 05:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5DF20854
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 05:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547701485;
	bh=nwM+6FTacMSpXA37t57Gq80XJqpOZn/wC4DZvjGVptA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PN7d9uoN+9buX0D/m5lUIMt11spX/aso3D+rtsELeH+Sxh6sEwPbhYBneG9p+M/MW
	 +Tl3FVNtr1qJLdJ7yPaRI8vTozd0pqTL92NsGX9btb9eexvs27iogZDmDah++cp4zt
	 eRPLFUVUnaxVYKAobas2k1jOIVlDXagP/PLBZXHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfAQFEo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 00:04:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:50248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbfAQFEo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jan 2019 00:04:44 -0500
Received: from localhost (unknown [122.178.200.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10ADF205C9;
        Thu, 17 Jan 2019 05:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547701482;
        bh=nwM+6FTacMSpXA37t57Gq80XJqpOZn/wC4DZvjGVptA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CSX7wn8uwXHashrES7tbqFd1fcLGwTHsM3Q8BFqIvX0Menpx1R3FTq/EmwOaec6Xf
         5VQb5ZkfQpiYCiwZcXuneNKRwihfnbURRZ+h5zArD+O4u8OJ2Z3c97+WNcrOePnCDi
         vpqMFo/izL5+coHTaaapAeqYz1GkOkfIQndhoW70=
Date:   Thu, 17 Jan 2019 10:33:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
Subject: Re: [RFC v3 7/7] dmaengine: Add Synopsys eDMA IP test and sample
 driver
Message-ID: <20190117050308.GF13372@vkoul-mobl.Dlink>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
 <cc195ac53839b318764c8f6502002cd6d933a923.1547230339.git.gustavo.pimentel@synopsys.com>
 <20190111194819.GV9170@smile.fi.intel.com>
 <2de7f43e-0702-9ab3-b24c-a1b212e18f7c@synopsys.com>
 <20190115054531.GC9170@smile.fi.intel.com>
 <453ecbd8-af75-1d5c-18d0-c272142d4424@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453ecbd8-af75-1d5c-18d0-c272142d4424@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15-01-19, 13:02, Gustavo Pimentel wrote:
> On 15/01/2019 05:45, Andy Shevchenko wrote:
> > On Mon, Jan 14, 2019 at 11:44:22AM +0000, Gustavo Pimentel wrote:
> >> On 11/01/2019 19:48, Andy Shevchenko wrote:
> >>> On Fri, Jan 11, 2019 at 07:33:43PM +0100, Gustavo Pimentel wrote:
> >>>> Add Synopsys eDMA IP test and sample driver to be use for testing
> >>>> purposes and also as a reference for any developer who needs to
> >>>> implement and use Synopsys eDMA.
> >>>>
> >>>> This driver can be compile as built-in or external module in kernel.
> >>>>
> >>>> To enable this driver just select DW_EDMA_TEST option in kernel
> >>>> configuration, however it requires and selects automatically DW_EDMA
> >>>> option too.
> >>>>
> >>>
> >>> Hmm... This doesn't explain what's wrong with dmatest module.
> >>
> >> There isn't anything wrong with dmatest module, that I know of. In beginning I
> >> was planning to used it, however only works with MEM_TO_MEM transfers, that's
> >> why I created a similar module but for MEM_TO_DEV and DEV_TO_MEM with
> >> scatter-gather and cyclic transfers type for my use case. I don't know if can be
> >> applied to other cases, if that is feasible, I'm glad to share it.
> > 
> > What I'm trying to tell is that the dmatest driver would be nice to have such
> > capability.
> > 
> 
> At the beginning I thought to add those features to dmatest module, but because
> of several points such as:
>  - I didn't want, by any chance, to broke dmatest module while implementing the
> support of those new features;
>  - Since I'm still gaining knowledge about this subsystem I preferred to do in a
> more controlled environment;
>  - Since this driver is also a reference driver aim to teach and to be use by
> someone how to use the dmaengine API, I preferred to keep it simple.
> 
> Maybe in the future both modules could be merged in just one tool, but for now I
> would prefer to keep it separated specially to fix any immaturity error of this
> module.

With decent testing we should be able to iron out kinks in dmatest
module. It gets tested for memcpy controllers so we should easily catch
issues.

Said that, it would make sense to add support in generic dmatest so that
other folks can reuse and contribute as well. Future work always gets
side tracked by life, so lets do it now :)


-- 
~Vinod
