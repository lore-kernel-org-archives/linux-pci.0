Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.lynxeye.de ([87.118.118.114]:38064 "EHLO lynxeye.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753791Ab3HYRU2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 25 Aug 2013 13:20:28 -0400
Message-ID: <1377450840.1622.15.camel@tellur>
Subject: Tegra PCIe system hangs
From: Lucas Stach <dev@lynxeye.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Jay Agarwal <jagarwal@nvidia.com>,
	Stephen Warren <swarren@wwwdotorg.org>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Sun, 25 Aug 2013 19:14:00 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

I've been experimenting with the Nouveau driver on Tegra for a few days
now and made some promising progress. The one thing that keeps throwing
me back is that I get seemingly random system lockups, which are not
recoverable.

I think this could be the same issue that was reported by Jay Agarwal
earlier. (Message-id:
<C79B248886DD134989C8FF6B096A91AB91B603D82B@BGMAIL01.nvidia.com>)
I also found a WAR for a system hang issue in the NVidia downstream
kernel [1], but when tried on upstream it had no effect on the issue.

I'm reasonably sure that this is not driver software related, as I've
already hunted down most of the caching issues and acceleration seems to
work at this point. So either this is a random HW hang, or there is some
software condition I'm not aware of.

I'm running a NV92 connected to the NVidia Beaver board. Kernel is
next-20130809 with the PCIe series + the LP2 workaround applied.

Could you please investigate if there are any other known errata for the
Tegra PCIe controller, which could hang the entire system?

Thanks,
Lucas

[1]
http://nv-tegra.nvidia.com/gitweb/?p=linux-2.6.git;a=blobdiff;f=arch/arm/mach-tegra/pcie.c;h=9fab5de016cfd3cd2ebd8176da5bdbedfac73cd8;hp=44749685e2bf822665c9345aec45151b8d2447c4;hb=c5d1bcfb7249b291453a80122148155a00e5456a;hpb=704125ef90e12bc41de057001cc96d81d7cc0376

