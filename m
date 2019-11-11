Return-Path: <SRS0=GTBH=ZD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC735C43331
	for <linux-pci@archiver.kernel.org>; Mon, 11 Nov 2019 22:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716E621925
	for <linux-pci@archiver.kernel.org>; Mon, 11 Nov 2019 22:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573511559;
	bh=6nJHdaOx51l52K83j2un8QsW4MPpN5Rp/d7y6ySsr2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=0QTM605ZCwdf7yyh2WpfReXbh3qDe8yGP3J/qYCEZR13D8uVunRGat/LdSXeJPN6q
	 rZ1WDDoC+1KnkX8Fmd+5DBExZxn0/BfykmNd8G5AyX2Quq+gCZuvSZ0xygomh+ybm2
	 ggZpAlMYmO4lQ6CUA9kuh8ddn+3RO+ZWSN5W4fz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfKKWcj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Nov 2019 17:32:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:53588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfKKWci (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Nov 2019 17:32:38 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D84920659;
        Mon, 11 Nov 2019 22:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573511557;
        bh=6nJHdaOx51l52K83j2un8QsW4MPpN5Rp/d7y6ySsr2k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=k/qXTDPFNSK8ZDXI16rnOlhJC60EOlHfdE3TGJvYKN/02ZmTGggqrPwPcR91GXLs8
         tBI/isvV1LcMleEQHlaHnAgbnNniFSbYxlb+1wOaBpCgS+gUDmxcXbYkL5e7SMRdEi
         MotnVaaQyEgJ5q+w2II8TX+tU9dX4wf25Gv3Gk74=
Date:   Mon, 11 Nov 2019 16:32:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Andrew Murray <andrew.murray@arm.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
Message-ID: <20191111223235.GA38578@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71f545f7-f14a-d2d9-215c-b3fb22000a5c@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 11, 2019 at 11:31:18AM +0530, Vidya Sagar wrote:
> On 11/6/2019 10:11 PM, Bjorn Helgaas wrote:

> > Based on Vidya's backtrace, I think the resume path with problems
> > is this:
> > 
> >    pci_pm_resume_noirq
> >      pci_pm_default_resume_early
> >        pci_power_up
> >          if (platform_pci_power_manageable(dev))
> >            platform_pci_set_power_state(dev, PCI_D0)  # <-- FW delay here?
> >          pci_raw_set_power_state
> >          pci_update_current_state
> >            pci_device_is_present        # <-- config read returns CRS
> > 
> > So I think your suggestion is that Vidya's firmware should be
> > doing the delay inside platform_pci_set_power_state()?
> > 
> > Vidya, you typically work on Tegra, so I assume this is on an
> > arm64 system?  Does it have ACPI?  Do you have access to the
> > firmware developers to ask about who they expect to do the delays?
>
> Yes. This is on arm64 (Tegra) and we don't have any ACPI or any
> other firmware for that matter. PCIe is brought up directly in the
> kernel.

I assume that your device is coming out of D3cold because apparently
you're seeing a CRS status from the config read when
pci_update_current_state() calls pci_device_is_present().  CRS status
should only happen after reset or power-on from D3cold, and you're not
doing a reset.

I'm pretty sure platform_pci_power_manageable() returns false on
your system (can you confirm that?) because the only scenarios with
platform power management are MID (Intel platform) and ACPI (which you
don't have).

Maybe you have some other platform-specific mechanism that controls
power to PCI devices, and it's not integrated into the
platform_pci_*() framework?

Bjorn
