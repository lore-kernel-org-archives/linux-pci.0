Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7468CC10F14
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 00:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B10D217F9
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 00:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555632112;
	bh=hTN7M7Y1E1YPJUtKMld7Nl0B/oVdA/JfFzEhI+Kjz1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S73xGcvyaEbLeBpWF2uEHVJVWwaH5DbmqkYxStjX46uYKwkdzZSarpKiYHzuT//ME
	 k/WZ6yWi5IKqB9bFIFlknCmPxMEZGLIXgXTiCW3RzaV1YuoRZKhtJx7vrj2OeUoVfx
	 O4aRf7ODdu65E5bmuTI2ZzfbDvaaNI/mZEnNifBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfDSABv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:01:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfDSABv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Apr 2019 20:01:51 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8442E21736;
        Fri, 19 Apr 2019 00:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555632110;
        bh=hTN7M7Y1E1YPJUtKMld7Nl0B/oVdA/JfFzEhI+Kjz1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HME7ocyxkErS7mgvftHHMoRkTV/G+PTrS9uSZx5Rv399UR7P5u3UJI1VUc3+/hzHm
         1nHlOhxjlC05PDnWNmh+c/k6BdLgRQFO/pPf4hKrNC7CXp285iA3LtX00ORA2g8uIK
         PxxL0kS4jcwhAud54bNhT3qnlJTTw//3s6RXvmX0=
Date:   Thu, 18 Apr 2019 19:01:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/4] PCI: pciehp: Do not turn off slot if presence
 comes up after link
Message-ID: <20190419000148.GI126710@google.com>
References: <20190220012031.10741-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220012031.10741-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alex,

This has languished a long time (sorry about that), and there were
several review comments.  I know you wanted my opinion on strategy,
but would you mind posting a fresh version with the fixes you've
already done and rebased to v5.1-rc1?

On Tue, Feb 19, 2019 at 07:20:26PM -0600, Alexandru Gagniuc wrote:
> If the presence detect state (PDS) becomes active after the link
> comes up (DLLLA), the hotplug code removes the device and then
> re-loads the driver. For most devices, this is a mere inconvenience,
> and for PCIe storage devices that are part of a RAID set which started
> rebuilding, it can get fun.
> 
> Ideally, we wouldn't remove perfectly good devices. According to
> the old PCIe spec PDS would always have to come up at or before DLLLA.
> Since not everyone followed this (looking at you Dell and HPE!!!!),
> this now got standardized in PCIe 4.0. (*).
> 
> This series has two solutions for this problem, and is intended to
> serve as a bikeshedding point for which is better:
>  1. Try to wait for PDS _before_ loading the driver
>  2. Load as usual, and recognize the delayed PDS event as such
> 
> I think (2) is more generic and elegant, but a lot of people seem to
> like something similar to (1).
> 
> (*) ECN was approved in Nov 2018, and is normative spec text. A lot of
> the leaked PCIe 4.0 specs do not have this change.
> 
> 
> 
> Alexandru Gagniuc (4):
>   PCI: hotplug: Add support for disabling in-band presence
>   PCI: pciehp: Do not turn off slot if presence comes up after link
>   PCI: hotplug: Wait for PDS when in-band presence is disabled
>   PCI: hotplug: Add quirk For Dell nvme pcie switches
> 
>  drivers/pci/hotplug/pciehp.h      |  1 +
>  drivers/pci/hotplug/pciehp_ctrl.c | 24 ++++++++++++++
>  drivers/pci/hotplug/pciehp_hpc.c  | 54 ++++++++++++++++++++++++++++++-
>  include/linux/pci.h               |  1 +
>  include/uapi/linux/pci_regs.h     |  2 ++
>  5 files changed, 81 insertions(+), 1 deletion(-)
> 
> -- 
> 2.19.2
> 
