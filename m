Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:48376 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbaDAD6s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 31 Mar 2014 23:58:48 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Pratyush Anand' <pratyush.anand@st.com>
Cc: 'Kukjin Kim' <kgene.kim@samsung.com>,
	linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
	'Jingoo Han' <jg1.han@samsung.com>
References: <000001cf4d55$c4455230$4ccff690$%han@samsung.com>
 <20140401034344.GA18207@pratyush-vbox>
In-reply-to: <20140401034344.GA18207@pratyush-vbox>
Subject: Re: [PATCH] ARM: dts: Increase the size of PCIe configuration space
 for EXYNOS5440
Date: Tue, 01 Apr 2014 12:58:46 +0900
Message-id: <000201cf4d5e$ae96b290$0bc417b0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, April 01, 2014 12:44 PM, Pratyush Anand wrote:
> On Tue, Apr 01, 2014 at 10:54:57AM +0800, Jingoo Han wrote:
> > Increase the size of PCIe configuration space to 8kB from 4kB,
> > because 4kB for cfg0 and 4kB for cfg1 are required respectively.
> > If 2kB for cfg0 and 2kB for cfg1 are set, it will make problems
> > when a PCIe card having multiple EPs below a bridge is used.
> >
> > Suggested-by: Pratyush Anand <pratyush.anand@st.com>
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  arch/arm/boot/dts/exynos5440.dtsi |   12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
> > index d600733..5d08be8 100644
> > --- a/arch/arm/boot/dts/exynos5440.dtsi
> > +++ b/arch/arm/boot/dts/exynos5440.dtsi
> > @@ -281,9 +281,9 @@
> >  		#address-cells = <3>;
> >  		#size-cells = <2>;
> >  		device_type = "pci";
> > -		ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00001000   /* configuration space */
> > -			  0x81000000 0 0	  0x40001000 0 0x00010000   /* downstream I/O */
> > -			  0x82000000 0 0x40011000 0x40011000 0 0x1ffef000>; /* non-prefetchable memory */
> > +		ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00002000   /* configuration space */
> > +			  0x81000000 0 0	  0x40002000 0 0x00010000   /* downstream I/O */
> > +			  0x82000000 0 0x40012000 0x40012000 0 0x1ffee000>; /* non-prefetchable memory */
> >  		#interrupt-cells = <1>;
> >  		interrupt-map-mask = <0 0 0 0>;
> >  		interrupt-map = <0x0 0 &gic 53>;
> > @@ -302,9 +302,9 @@
> >  		#address-cells = <3>;
> >  		#size-cells = <2>;
> >  		device_type = "pci";
> > -		ranges = <0x00000800 0 0x60000000 0x60000000 0 0x00001000   /* configuration space */
> > -			  0x81000000 0 0	  0x60001000 0 0x00010000   /* downstream I/O */
> > -			  0x82000000 0 0x60011000 0x60011000 0 0x1ffef000>; /* non-prefetchable memory */
> > +		ranges = <0x00000800 0 0x60000000 0x60000000 0 0x00002000   /* configuration space */
> > +			  0x81000000 0 0	  0x60002000 0 0x00020000   /* downstream I/O */
> 
> is I/O size change intentional?

Hi Pratyush Anand,

No, it is my mistake. I/O size should not be modified.
I really appreciate your review. I will send v2 patch. :-)
Thank you.

Best regards,
Jingoo Han

> 
> Regards
> Pratyush
> > +			  0x82000000 0 0x60012000 0x60012000 0 0x1ffee000>; /* non-prefetchable memory */
> >  		#interrupt-cells = <1>;
> >  		interrupt-map-mask = <0 0 0 0>;
> >  		interrupt-map = <0x0 0 &gic 56>;
> > --
> > 1.7.10.4
> >

