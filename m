Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41494 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835AbcFUPPE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 Jun 2016 11:15:04 -0400
Date: Tue, 21 Jun 2016 10:14:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tyler Baker <tyler.baker@linaro.org>, linux-pci@vger.kernel.org,
	rfi@lists.rocketboards.org, Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Kevin's boot bot <khilman@kernel.org>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
	Simon Horman <horms@verge.net.au>, linux-tegra@vger.kernel.org,
	Alex Benn??e <alex.bennee@linaro.org>,
	S??ren Brinkmann <soren.brinkmann@xilinx.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Scott Branden <sbranden@broadcom.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-renesas-soc@vger.kernel.org, Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH v1 15/25] PCI: generic: Free resource list close to where
 it's allocated
Message-ID: <20160621151407.GC31917@localhost>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160606230636.20936.29083.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <CANMBJr41muA9mTNAa6MtWuMmeNLQxT4NjLe45=ExdFiH8vwzyw@mail.gmail.com>
 <20160620172240.GA30625@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160620172240.GA30625@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 20, 2016 at 06:22:40PM +0100, Lorenzo Pieralisi wrote:
> On Mon, Jun 20, 2016 at 09:56:45AM -0700, Tyler Baker wrote:
> > Hi Bjorn,
> > 
> > On 6 June 2016 at 16:06, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > > Previously we allocated the PCI resource list in
> > > gen_pci_parse_request_of_pci_ranges(), but if we had an error, we freed it
> > > on error in gen_pci_init().
> > >
> > > Reorder gen_pci_init() so we can take care of error path cleanup in
> > > gen_pci_parse_request_of_pci_ranges() instead.
> > >
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > The kernelci.org bot has reported[0] new qemu-aarch64
> > (arm64-defconfig) boot failures[1][2] in next-20160620. I've
> > bisected[3] this boot failure down to this patch, and confirmed
> > reverting it on top of next-20160620 resolves the boot issue.
> > 
> > I have not investigated further, but you can easily reproduce[4] the
> > boot failure on an x86 host running qemu-system-aarch64 (I'm running
> > qemu-system 2.6).
> 
> That's most likely because pci_ecam_create() requires the bus_range
> resource (its busr parameter) to be initialized when it is called
> and that's not the case after this patch is applied if I read it
> correctly.
> 
> It is probably a NULL pointer dereference in pci_ecam_create().

Yep, thanks everybody, I dropped that ill-considered patch altogether.

> > [0] https://kernelci.org/boot/all/job/next/kernel/next-20160620/
> > [1] https://storage.kernelci.org/next/next-20160620/arm64-defconfig/lab-cambridge/boot-apm-mustang-kvm-guest.txt
> > [2] https://storage.kernelci.org/next/next-20160620/arm64-defconfig/lab-tbaker/boot-qemu-aarch64,legacy.txt
> > [3] http://hastebin.com/segiruribu.vbs
> > [4] http://hastebin.com/dafuzicuyi.avrasm
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
