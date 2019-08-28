Return-Path: <SRS0=6piv=WY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C066C3A5A1
	for <linux-pci@archiver.kernel.org>; Wed, 28 Aug 2019 13:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012FA233A1
	for <linux-pci@archiver.kernel.org>; Wed, 28 Aug 2019 13:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566997601;
	bh=lAavAO3u2s7xbBO8bMVVg5vr1RXGF8RDf50uj1HCBrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A5WxYbCnPFyJdepFY4Ok2HkDotqFwD12vka21B8OPKUXs77W/FnmnZeAtoClnF81m
	 EGxlRJLqDQGmsnvHFEcMNwkJs+RttWFH0947qhYmJgaIBsgncmqyKZJMwbscphsYX2
	 i/ijrIcf60FrLBh4xzpP6NfNMjlTIpJ57ld+zBTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfH1NGk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfH1NGk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 09:06:40 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D68E2339E;
        Wed, 28 Aug 2019 13:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566997599;
        bh=lAavAO3u2s7xbBO8bMVVg5vr1RXGF8RDf50uj1HCBrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h0i96Urizaj+kGQP9kbnIpDXRLVGD+u+UH2BZ0cUrGzg4ypdA8rGKCIniUjOHeh31
         YbaZgP8fLY81Uz/p3wB3xqS4ILTfVw1ZVVkqxtQTF3I3L6Gxx9YkEXDzr6JoZLc5PV
         flTPyqoZxQPNQGBLeZDrWp001ktRLMei4Mt6XRTo=
Date:   Wed, 28 Aug 2019 08:06:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 0/4] PCI/ASPM: add sysfs attributes for controlling
 ASPM
Message-ID: <20190828130638.GB4550@google.com>
References: <3797de51-0135-07b6-9566-a1ce8cf3f24e@gmail.com>
 <20190827233541.GL9987@google.com>
 <4eace423-8727-2957-79ab-bf954a050e20@gmail.com>
 <acfcbedc-4019-95b8-71a3-4fb5d1185a92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acfcbedc-4019-95b8-71a3-4fb5d1185a92@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 28, 2019 at 07:48:18AM +0200, Heiner Kallweit wrote:
> On 28.08.2019 07:40, Heiner Kallweit wrote:
> > On 28.08.2019 01:35, Bjorn Helgaas wrote:
> >> On Sat, Aug 24, 2019 at 05:39:37PM +0200, Heiner Kallweit wrote:
> >>> Background of this extension is a problem with the r8169 network driver.
> >>> Several combinations of board chipsets and network chip versions have
> >>> problems if ASPM is enabled, therefore we have to disable ASPM per
> >>> default. However especially on notebooks ASPM can provide significant
> >>> power-saving, therefore we want to give users the option to enable
> >>> ASPM. With the new sysfs attributes users can control which ASPM
> >>> link-states are disabled.
> >>>
> >>> v2:
> >>> - use a dedicated sysfs attribute per link state
> >>> - allow separate control of ASPM and PCI PM L1 sub-states
> >>>
> >>> v3:
> >>> - patch 3: statically allocate the attribute group
> >>> - patch 3: replace snprintf with printf
> >>> - add patch 4
> >>>
> >>> v4:
> >>> - patch 3: add call to sysfs_update_group because is_visible callback
> >>>            returns false always at file creation time
> >>> - patch 3: simplify code a little
> >>>
> >>> Heiner Kallweit (4):
> >>>   PCI/ASPM: add L1 sub-state support to pci_disable_link_state
> >>>   PCI/ASPM: allow to re-enable Clock PM
> >>>   PCI/ASPM: add sysfs attributes for controlling ASPM link states
> >>>   PCI/ASPM: remove Kconfig option PCIEASPM_DEBUG and related code
> >>>
> >>>  Documentation/ABI/testing/sysfs-bus-pci |  13 ++
> >>>  drivers/pci/pci-sysfs.c                 |  10 +-
> >>>  drivers/pci/pci.h                       |  12 +-
> >>>  drivers/pci/pcie/Kconfig                |   7 -
> >>>  drivers/pci/pcie/aspm.c                 | 236 ++++++++++++++++--------
> >>>  include/linux/pci-aspm.h                |  10 +-
> >>>  6 files changed, 195 insertions(+), 93 deletions(-)
> >>
> >> I can fix this if you don't get to it, but this doesn't apply cleanly
> >> to either my "master" branch (v5.3-rc1) or my "next" branch.  I always
> >> prefer series based on my "master" branch when possible.
> >>
> > I based it on top of linux-next, can rebase it to your master branch.

That'd be great.  linux-next is a moving target, so I never apply
patches based directly on that.

> Ah, one more point:
> This series has a dependency on Mika Westerberg's
> "PCI: Make pcie_downstream_port() available outside of access.c"
> that is sitting in your inbox. How do you want to deal with this?

Just mention the dependency in the cover letter and I'll take care of
it.

Thanks!
