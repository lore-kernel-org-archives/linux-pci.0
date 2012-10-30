Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:57160 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349Ab2JaH1f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Oct 2012 03:27:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH 09/15] SPEAr13xx: dts: Fix PCIe core address ranges
Date: Tue, 30 Oct 2012 21:55:04 +0000
Cc: shiraz.hashim@st.com, viresh.linux@gmail.com,
	spear-devel@list.st.com, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, olof@lixom.net
References: <cover.1351492562.git.pratyush.anand@st.com> <6ed9683e3149a640b4333cf3039ae31063b23e3b.1351492562.git.pratyush.anand@st.com>
In-Reply-To: <6ed9683e3149a640b4333cf3039ae31063b23e3b.1351492562.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201210302155.05206.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 29 October 2012, Pratyush Anand wrote:
> sible by
> AHB and used to communicate with PCIe devices connected with the host
> controller.
> 
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> ---
>  arch/arm/boot/dts/spear13xx.dtsi |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
> index 9ff4f5f..b7990754 100644
> --- a/arch/arm/boot/dts/spear13xx.dtsi
> +++ b/arch/arm/boot/dts/spear13xx.dtsi
> @@ -76,7 +76,8 @@
>                 #size-cells = <1>;
>                 compatible = "simple-bus";
>                 ranges = <0x50000000 0x50000000 0x10000000
> -                         0xb0000000 0xb0000000 0x10000000
> +                         0x80000000 0x80000000 0x20000000
> +                         0xb0000000 0xb0000000 0x20000000
>                           0xd0000000 0xd0000000 0x02000000
>                           0xd8000000 0xd8000000 0x01000000
>                           0xe0000000 0xe0000000 0x10000000>;
> @@ -194,7 +195,7 @@
>                 pcie0@b1000000 {
>                         compatible = "st,pcie-gadget", "st,pcie-host" ;
>                         reg = < 0xb1000000 0x4000
> -                               0x80000000 0x2000
> +                               0x80000000 0x10000000
>                                 0xeb800000 0x1000 >;
>                         interrupts = <0 68 0x4>;
>                         status = "disabled";

The code that I'm looking at in the upstream kernel looks very different, so I don't
see how this patch would apply. Also, the version that you are patching as well
as the changes you do don't actually follow the generic PCI bindings at all
and should be done quite differently.

Please have a look at how to configure the PCI ranges in the IEEE1275 PCI
bindings and in examples you find in arch/powerpc/.

Most importantly, the compatible string used here can't really refer to both
the host and the endpoint mode, you really need separate bindings for those
and have only one of the two used in a particular system. What you can do is
to put both into the dtsi file and mark them as "disabled" and then enable
just one of the two on a given board file.

	Arnd
