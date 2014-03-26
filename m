Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:56873 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbaCZFjI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Mar 2014 01:39:08 -0400
MIME-Version: 1.0
In-Reply-To: <1395766604-30926-10-git-send-email-phil.edworthy@renesas.com>
References: <1395766604-30926-1-git-send-email-phil.edworthy@renesas.com>
	<1395766604-30926-10-git-send-email-phil.edworthy@renesas.com>
Date: Wed, 26 Mar 2014 14:39:06 +0900
Message-ID: <CANqRtoRCK8rLKDuy9kuyES=Y0Ek00BVnzzTdCeTKpPjrxiP7RQ@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] ARM: koelsch: Add HAVE_ARM_ARCH_TIMER to defconfig
From: Magnus Damm <magnus.damm@gmail.com>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: linux-pci@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Ben Dooks <ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 26, 2014 at 1:56 AM, Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> This is fixes a boot problem when the R-Car PCIe driver is enabled.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>  arch/arm/configs/koelsch_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
> index ec14547..67666b6 100644
> --- a/arch/arm/configs/koelsch_defconfig
> +++ b/arch/arm/configs/koelsch_defconfig
> @@ -15,6 +15,7 @@ CONFIG_MACH_KOELSCH=y
>  CONFIG_CPU_BPREDICT_DISABLE=y
>  CONFIG_PL310_ERRATA_588369=y
>  CONFIG_ARM_ERRATA_754322=y
> +CONFIG_HAVE_ARM_ARCH_TIMER=y

Hi Phil,

Thanks for your patches! I appreciate that you send out a whole series
with broken out patches, that makes it easier to see what is going on.

However, regarding this particular patch I'm not so sure if your fix
is correct. The issue is most likely there, no doubt about that, but
this "select" does not match well with how we currently handle timers
for the rest of the SoCs in mach-shmobile. We for instance want to be
able to boot with CMT only.

So here's a gentle "NAK" on this particular patch. I think this shows
that either deferred probing or a different init ordering is needed
somehow.

Thanks,

/ magnus
