Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.lynxeye.de ([87.118.118.114]:41333 "EHLO lynxeye.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751246Ab3HYXrh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 25 Aug 2013 19:47:37 -0400
Message-ID: <1377474634.1622.17.camel@tellur>
Subject: Re: Tegra PCIe system hangs
From: Lucas Stach <dev@lynxeye.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jay Agarwal <jagarwal@nvidia.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Mon, 26 Aug 2013 01:50:34 +0200
In-Reply-To: <1377450840.1622.15.camel@tellur>
References: <1377450840.1622.15.camel@tellur>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Ok, turn out this seems to be an issue with legacy PCI interrupts.
Nouveau wasn't really using MSI interrupts, switching them on seems to
fix the stability issue.

Still I would be interested in the root cause and would like to see this
documented somewhere.

Thanks,
Lucas

Am Sonntag, den 25.08.2013, 19:14 +0200 schrieb Lucas Stach:
> Hi all,
> 
> I've been experimenting with the Nouveau driver on Tegra for a few days
> now and made some promising progress. The one thing that keeps throwing
> me back is that I get seemingly random system lockups, which are not
> recoverable.
> 
> I think this could be the same issue that was reported by Jay Agarwal
> earlier. (Message-id:
> <C79B248886DD134989C8FF6B096A91AB91B603D82B@BGMAIL01.nvidia.com>)
> I also found a WAR for a system hang issue in the NVidia downstream
> kernel [1], but when tried on upstream it had no effect on the issue.
> 
> I'm reasonably sure that this is not driver software related, as I've
> already hunted down most of the caching issues and acceleration seems to
> work at this point. So either this is a random HW hang, or there is some
> software condition I'm not aware of.
> 
> I'm running a NV92 connected to the NVidia Beaver board. Kernel is
> next-20130809 with the PCIe series + the LP2 workaround applied.
> 
> Could you please investigate if there are any other known errata for the
> Tegra PCIe controller, which could hang the entire system?
> 
> Thanks,
> Lucas
> 
> [1]
> http://nv-tegra.nvidia.com/gitweb/?p=linux-2.6.git;a=blobdiff;f=arch/arm/mach-tegra/pcie.c;h=9fab5de016cfd3cd2ebd8176da5bdbedfac73cd8;hp=44749685e2bf822665c9345aec45151b8d2447c4;hb=c5d1bcfb7249b291453a80122148155a00e5456a;hpb=704125ef90e12bc41de057001cc96d81d7cc0376
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


