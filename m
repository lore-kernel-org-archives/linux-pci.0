Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51807C43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 19:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047682084C
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 19:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jC/owy6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047682084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbeJBBkN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 21:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbeJBBkN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Oct 2018 21:40:13 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33F3F2084C;
        Mon,  1 Oct 2018 19:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538420461;
        bh=VurJDvoZcwsVJVgsaGhT4O+8SNz0YTREqdnYAAZj5SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jC/owy6ZYEMVY5TRC5IJpr/5GMypq8xBXXAdkmgtCXmuwo8T5+A+v2ilcHSbI7zDJ
         DiQwqsp6qZin7/pZBHIZSkiRyUL1M3IqprnQ3KIUXnAUAZWNjpjGlmD1UxJkqHNy7Y
         RBATyEJFZxR1P3jbf3aJ5Emdst2i+ic/93VQe8oE=
Date:   Mon, 1 Oct 2018 14:00:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kevin Wilson <wkevils@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: A question about pcim_iomap_regions() and Managed Device
 Resource API
Message-ID: <20181001190059.GC142872@bhelgaas-glaptop.roam.corp.google.com>
References: <CAGXs5wXBdmjp-3XcuNHFCykLdT5LJj=tMPJnqLexAL18n=wLNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXs5wXBdmjp-3XcuNHFCykLdT5LJj=tMPJnqLexAL18n=wLNg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kevin,

On Sun, Sep 30, 2018 at 12:15:01PM +0300, Kevin Wilson wrote:
> HI, linux-pci developers,
> 
> There are very few Ethernet drivers which use
> pcim_iomap_regions(); for example,
> drivers/net/ethernet/realtek/r8169.c.
> 
> My question is: why do they use this
> Managed Device Resource API and not
> the regular Device Resource API (ioremap() for example), which is used in
> **most** Ethernet Linux device drivers, for example, in I40E driver:
> 
> ...
>     err = pci_request_mem_regions(pdev, i40e_driver_name);
>     ...
>     hw->hw_addr = ioremap(pci_resource_start(pdev, 0), pf->ioremap_len);
> ...
> 
> Is there some inherent HW feature in r8169 (or the other
> drivers, see list below) which requires using this API ? Is usage
> of this API (the managed devices, with pcim_iomap_regions(), etc) is
> mandatory for these device drivers, and cannot be
> use in most drivers (like I40E and most of the others) ?
> 
> The other Linux Ethenet drivers that use
> pcim_iomap_regions() are:
> amd/xgbe, cavium/common/cavium_ptp.c, intel/ice/ice_main.c,
> oki-semi/pch_gbe/pch_gbe_main.c, stmicro/stmmac/stmmac_pci.c,
> synopsys/dwc-xlgmac-pci.c and toshiba/tc35815.c.

The choice of the managed API (pcim_iomap_regions(), etc) vs the
regular one (ioremap()) has nothing to do with the features of the
hardware.  It's completely up to the driver writer.  The managed API
[1] is intended to make things easier for the driver writer by
simplifying error and cleanup paths.

Bjorn

[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/driver-model/devres.txt
