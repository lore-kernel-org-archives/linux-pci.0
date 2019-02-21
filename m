Return-Path: <SRS0=2g0o=Q4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4928C43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 23:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B50E2077B
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 23:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550791399;
	bh=yAfyThOQRMPrqjQAjPnVKTvRkSiew9cnk1qwxbgFEsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VIuyDupdo79CEf2JkgdZuK04cZM//cL1trROA4JzdTDLg37F9ke5ZsXzszyfTj4w/
	 6yVqBeZvEbuL1f1V4uoRyWdRD6C0j00hvca4ehioF7CC3R6kKpkTUVzzyEN0bjRhFr
	 M6wacUs6/W1gI17ZWweUS+udF1pjmamlApVT2ZeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfBUXXT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 18:23:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfBUXXS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Feb 2019 18:23:18 -0500
Received: from localhost (unknown [104.133.8.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBD1D20838;
        Thu, 21 Feb 2019 23:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550791398;
        bh=yAfyThOQRMPrqjQAjPnVKTvRkSiew9cnk1qwxbgFEsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2j0FplgHYyNp9sD9rhPFHMcK936zGjydgron0x5bjSYZRTa0in/JekdlXB7SfdER2
         nqGrS1qyX4wydhXT4aD00FV7fDYV8QFtNofKOmdZWrfzd2w6Hw3l0L4RP/VPJW9Fv3
         s+kyiIpceD7mlRlY0D/r3KT+Bmjugrz0b9NfGutc=
Date:   Thu, 21 Feb 2019 17:23:17 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Leigh Brown <leigh@solinno.co.uk>,
        =?iso-8859-1?Q?Lu=EDs?= Mendes <luis.p.mendes@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 0/2] PCI: fix pci-mvebu after conversion to common bridge
 emul code
Message-ID: <20190221232317.GB219879@google.com>
References: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 20, 2019 at 10:48:39AM +0100, Thomas Petazzoni wrote:
> Hello,
> 
> This set of two patches aim at fixing some regression reported by two
> users (Luis and Leigh), that were introduced by the conversion of the
> pci-mvebu driver to the common PCI bridge emulation code shared
> between pci-aardvark and pci-mvebu.
> 
> Due to this conversion, some registers of the PCI configuration that
> used to be read-only are now read-write, making the Linux PCI core
> believe that some features are implemented by the PCI bridge. Namely
> in the case of pci-mvebu, the prefetchable memory base/limit registers
> were read-only, while they are now read-write. Due to this, the Linux
> PCI core now believes it can configure a prefetchable memory area, but
> this is not supported by pci-mvebu, which does not have the logic to
> create the appropriate MBUs windows.
> 
> This set of two commits allow PCI controller code to tell the PCI
> bridge emulation logic about their capabilities. Because we envision
> that other capabilities than prefetchable memory support might need to
> be communicated from the PCI controller code to the PCI bridge
> emulation code in the future, we introduce a "flags" argument, even if
> for now only one flag is supported.
> 
> Lorenzo, let me know what you think about this approach. I am open to
> suggestions if the proposed approach is not satisfying.
> 
> Both patches have been confirmed by Luis and Leigh to fix the
> regression, but I'll let them give a formal Tested-by.
> 
> Best regards,
> 
> Thomas Petazzoni
> 
> Thomas Petazzoni (2):
>   PCI: pci-bridge-emul: Create per-bridge copy of register behavior
>   PCI: pci-bridge-emul: Extend pci_bridge_emul_init() with flags
> 
>  drivers/pci/controller/pci-aardvark.c |  2 +-
>  drivers/pci/controller/pci-mvebu.c    |  2 +-
>  drivers/pci/pci-bridge-emul.c         | 86 ++++++++++++++++++---------
>  drivers/pci/pci-bridge-emul.h         | 13 +++-
>  4 files changed, 73 insertions(+), 30 deletions(-)

Lorenzo, I assume you'll take both of these, so for both patches,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Maybe we should add a stable tag (v4.20+)?
