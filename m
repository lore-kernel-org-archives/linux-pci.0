Return-Path: <SRS0=srx4=WX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D24C3A5A3
	for <linux-pci@archiver.kernel.org>; Tue, 27 Aug 2019 23:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B7B21883
	for <linux-pci@archiver.kernel.org>; Tue, 27 Aug 2019 23:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566948945;
	bh=T9m9XmpzH8jBEMEmZWUN2FqKhKwpx8mydEgMFVIbsr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cRIa1pkWLWxRTGRvU6bqQqSmErip3naNrtNWpO1gT+OtEjd4FugeXE+Sll/OZGK0x
	 RXPq5QwxH+dUK/+UaRJTWXS2h+X07lLmdstzzFrJ9Ubh2uH8pQ7ueTAthp4Y9oXhYA
	 ooi4TmYlaP0b++DXtWg4qLXFZvjOWYvbsmKeAF/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfH0Xfp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:35:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfH0Xfp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 19:35:45 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEDFD2186A;
        Tue, 27 Aug 2019 23:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566948944;
        bh=T9m9XmpzH8jBEMEmZWUN2FqKhKwpx8mydEgMFVIbsr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ihQ1/znH/DeYAFnC94LAjWSKr6YgG7DdVlUK/8MOMh/f0X3w+xVit8mU3JRhCLEo9
         WoMpJyjyjIE6cc2FfNHW7nKUTw9MwZOTnSv3BUTuqIEQh1YxgspRc4+GpDO4cSyc8W
         Dix957mTY0JqmvY964d0oAWARtl04ilzai1hxlDk=
Date:   Tue, 27 Aug 2019 18:35:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 0/4] PCI/ASPM: add sysfs attributes for controlling
 ASPM
Message-ID: <20190827233541.GL9987@google.com>
References: <3797de51-0135-07b6-9566-a1ce8cf3f24e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3797de51-0135-07b6-9566-a1ce8cf3f24e@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 24, 2019 at 05:39:37PM +0200, Heiner Kallweit wrote:
> Background of this extension is a problem with the r8169 network driver.
> Several combinations of board chipsets and network chip versions have
> problems if ASPM is enabled, therefore we have to disable ASPM per
> default. However especially on notebooks ASPM can provide significant
> power-saving, therefore we want to give users the option to enable
> ASPM. With the new sysfs attributes users can control which ASPM
> link-states are disabled.
> 
> v2:
> - use a dedicated sysfs attribute per link state
> - allow separate control of ASPM and PCI PM L1 sub-states
> 
> v3:
> - patch 3: statically allocate the attribute group
> - patch 3: replace snprintf with printf
> - add patch 4
> 
> v4:
> - patch 3: add call to sysfs_update_group because is_visible callback
>            returns false always at file creation time
> - patch 3: simplify code a little
> 
> Heiner Kallweit (4):
>   PCI/ASPM: add L1 sub-state support to pci_disable_link_state
>   PCI/ASPM: allow to re-enable Clock PM
>   PCI/ASPM: add sysfs attributes for controlling ASPM link states
>   PCI/ASPM: remove Kconfig option PCIEASPM_DEBUG and related code
> 
>  Documentation/ABI/testing/sysfs-bus-pci |  13 ++
>  drivers/pci/pci-sysfs.c                 |  10 +-
>  drivers/pci/pci.h                       |  12 +-
>  drivers/pci/pcie/Kconfig                |   7 -
>  drivers/pci/pcie/aspm.c                 | 236 ++++++++++++++++--------
>  include/linux/pci-aspm.h                |  10 +-
>  6 files changed, 195 insertions(+), 93 deletions(-)

I can fix this if you don't get to it, but this doesn't apply cleanly
to either my "master" branch (v5.3-rc1) or my "next" branch.  I always
prefer series based on my "master" branch when possible.

Bjorn
