Return-Path: <SRS0=pqED=WI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883C1C31E40
	for <linux-pci@archiver.kernel.org>; Mon, 12 Aug 2019 20:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598502064A
	for <linux-pci@archiver.kernel.org>; Mon, 12 Aug 2019 20:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565640107;
	bh=NSkesDbyTebD+v4e1h6gv7mP58q17+gzV7RA4nbnT38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F/puUOUMXvmnXKbOlTNUF5Su22rAkjiJMLAefhnrUYFRZjIXr94YCpv+o2kZcPyyw
	 BxImjZ6xhR3YkrFgKMtAYHhayUprRSmw2/w8jypxSL7/4I/MhNj3JGNNRIxRURYKKH
	 5hCTUB30XQ2EfxXuQeIrmBC6vk5f+OiM6kAvR42I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfHLUBh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfHLUBh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 16:01:37 -0400
Received: from localhost (c-73-15-1-175.hsd1.ca.comcast.net [73.15.1.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08C522064A;
        Mon, 12 Aug 2019 20:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565640096;
        bh=NSkesDbyTebD+v4e1h6gv7mP58q17+gzV7RA4nbnT38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PM1nIv8I5QbxVroLS05rramZ5dZ0VSEA0hPtM4Nyi7x6O/cRZHpnUn2JqpjpSzmIf
         3OIovcheUk0W4Xtzb1WjvkRcCUn7GWelbDPWulT11bQc2tDiTREjjfnPGKgCeb+cbF
         g9JmGWAKO4QpqNwLOoGbde2poi97UEyKOHfYIiIc=
Date:   Mon, 12 Aug 2019 15:01:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     Sebastian Ott <sebott@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        netdev@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Add definition for the number of standard PCI BARs
Message-ID: <20190812200134.GB11785@google.com>
References: <20190811150802.2418-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811150802.2418-1-efremov@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 11, 2019 at 06:07:55PM +0300, Denis Efremov wrote:
> Code that iterates over all standard PCI BARs typically uses
> PCI_STD_RESOURCE_END, but this is error-prone because it requires
> "i <= PCI_STD_RESOURCE_END" rather than something like
> "i < PCI_STD_NUM_BARS". We could add such a definition and use it the same
> way PCI_SRIOV_NUM_BARS is used. There is already the definition
> PCI_BAR_COUNT for s390 only. Thus, this patchset introduces it globally.
> 
> The patch is splitted into 7 parts for different drivers/subsystems for
> easy readability.

This looks good.  I can take all these together, since they all depend
on the first patch.  I have a few comments on the individual patches.

> Denis Efremov (7):
>   PCI: Add define for the number of standard PCI BARs
>   s390/pci: Replace PCI_BAR_COUNT with PCI_STD_NUM_BARS
>   x86/PCI: Use PCI_STD_NUM_BARS in loops instead of PCI_STD_RESOURCE_END
>   PCI/net: Use PCI_STD_NUM_BARS in loops instead of PCI_STD_RESOURCE_END
>   rapidio/tsi721: use PCI_STD_NUM_BARS in loops instead of
>     PCI_STD_RESOURCE_END
>   efifb: Use PCI_STD_NUM_BARS in loops instead of PCI_STD_RESOURCE_END
>   vfio_pci: Use PCI_STD_NUM_BARS in loops instead of
>     PCI_STD_RESOURCE_END
> 
>  arch/s390/include/asm/pci.h                      |  5 +----
>  arch/s390/include/asm/pci_clp.h                  |  6 +++---
>  arch/s390/pci/pci.c                              | 16 ++++++++--------
>  arch/s390/pci/pci_clp.c                          |  6 +++---
>  arch/x86/pci/common.c                            |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c |  4 ++--
>  drivers/net/ethernet/synopsys/dwc-xlgmac-pci.c   |  2 +-
>  drivers/pci/quirks.c                             |  2 +-
>  drivers/rapidio/devices/tsi721.c                 |  2 +-
>  drivers/vfio/pci/vfio_pci.c                      |  4 ++--
>  drivers/vfio/pci/vfio_pci_config.c               |  2 +-
>  drivers/vfio/pci/vfio_pci_private.h              |  4 ++--
>  drivers/video/fbdev/efifb.c                      |  2 +-
>  include/linux/pci.h                              |  2 +-
>  include/uapi/linux/pci_regs.h                    |  1 +
>  15 files changed, 29 insertions(+), 31 deletions(-)
> 
> -- 
> 2.21.0
> 
