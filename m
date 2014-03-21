Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:47144 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751786AbaCUOyE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Mar 2014 10:54:04 -0400
In-Reply-To: <532C5ADE.4030708@cogentembedded.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com> <1395397968-6242-7-git-send-email-phil.edworthy@renesas.com> <532C5ADE.4030708@cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
From: Phil.Edworthy@renesas.com
Message-ID: <OF4D80B18E.5A1F55AB-ON80257CA2.0051AADA-80257CA2.0051D412@eu.necel.com>
Date: Fri, 21 Mar 2014 14:53:48 +0000
Subject: Re: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes for R8A7790
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sergei,

On: 21/03/2014 14:30, Sergei wrote:
> Subject: Re: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes 
for R8A7790
> 
> Hello.
> 
> On 03/21/2014 01:32 PM, Phil Edworthy wrote:
> 
> > This patch adds the device tree nodes for R8A7790
> 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> >   arch/arm/boot/dts/r8a7790.dtsi | 19 +++++++++++++++++++
> >   1 file changed, 19 insertions(+)
> 
> > diff --git a/arch/arm/boot/dts/r8a7790.dtsi 
b/arch/arm/boot/dts/r8a7790.dtsi
> > index df9ec61..e7d498a 100644
> > --- a/arch/arm/boot/dts/r8a7790.dtsi
> > +++ b/arch/arm/boot/dts/r8a7790.dtsi
> > @@ -821,4 +821,23 @@
> >         #size-cells = <0>;
> >         status = "disabled";
> >      };
> > +
> > +   pcie: pcie@fe000000 {
> > +      compatible = "renesas,r8a7790-pcie";
> 
>     The convention adopted on this list is to put the "pcie" first, and 
SoC 
> name the last.
Ok, shame that all the other PCI hosts use vendor,device-pcie


> > +      reg = <0 0xfe000000 0 0x80000>;
> > +      #address-cells = <3>;
> > +      #size-cells = <2>;
> > +      device_type = "pci";
> 
>     This legacy property is only meaningful for the true OF firmware and 
thus 
> have been phased out (it's only actively used for the memory nodes).
Ok, thanks for pointing this out.

> WBR, Sergei
> 

Thanks
Phil
