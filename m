Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:36032 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbbIQPaP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2015 11:30:15 -0400
Received: by ioii196 with SMTP id i196so25850818ioi.3
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2015 08:30:14 -0700 (PDT)
Date: Thu, 17 Sep 2015 10:30:09 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Will Deacon <will.deacon@arm.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Alexander Graf <agraf@suse.de>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/4] PCI: arm64/powerpc: Fix parsing of
 linux,pci-probe-only
Message-ID: <20150917153009.GH25767@google.com>
References: <1441385411-7624-1-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441385411-7624-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 04, 2015 at 05:50:07PM +0100, Marc Zyngier wrote:
> The pci-host-generic driver parses the linux,pci-probe-only property,
> and assumes that it will have a boolean parameter.
> 
> Turns out that the Seattle DTS file has a naked "linux,pci-probe-only"
> property, which leads to the driver dereferencing some unsuspecting
> memory location. Nothing really bad happens (we end up reading some
> other bit of DT, fortunately), but that not a reason to keep it this
> way. Turns out that the Pseries code (where this code was lifted from)
> may suffer from the same issue.
> 
> The first patch introduces a common (and fixed) version of that check
> that can be used by drivers and architectures that require it. The two
> following patches change the pci-host-generic driver and the powerpc
> code to use it.
> 
> Finally, the bad property is removed from the Seatle DTS, because it
> is simply not necessary (it actually prevents me from using SR-IOV,
> which otherwise runs fine without the probe-only thing).
> 
> This has been tested on the offending Seattle board.
> 
> * From v3:
>   - Restrict the property lookup to /chosen (Rob)
>   - Acked-by on patch #4 from Suravee
>   - I swear this is the last time I rework these patches! ;-)
> 
> * From v2:
>   - Use of_property_read_u32 to safely read the property (Rob)
>   - Add a log message to indicate when we enable probe-only
>     (probably quite useful for debugging)
> 
> * From v1:
>   - Consolidate the parsing in of_pci.c (Bjorn)
> 
> Marc Zyngier (4):
>   of/pci: Add of_pci_check_probe_only to parse "linux,pci-probe-only"
>   PCI: pci-host-generic: Fix lookup of linux,pci-probe-only property
>   powerpc: PCI: Fix lookup of linux,pci-probe-only property
>   arm64: dts: Drop linux,pci-probe-only from the Seattle DTS
> 
>  arch/arm64/boot/dts/amd/amd-overdrive.dts |  1 -
>  arch/powerpc/platforms/pseries/setup.c    | 14 ++------------
>  drivers/of/of_pci.c                       | 28 ++++++++++++++++++++++++++++
>  drivers/pci/host/pci-host-generic.c       |  9 +--------
>  include/linux/of_pci.h                    |  3 +++
>  5 files changed, 34 insertions(+), 21 deletions(-)

Applied with the comment tweak and acks to pci/host-generic for v4.4,
thanks!
