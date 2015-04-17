Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:43339 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751603AbbDQDxm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Apr 2015 23:53:42 -0400
Date: Fri, 17 Apr 2015 11:50:16 +0800
From: Jisheng Zhang <jszhang@marvell.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, CPGS <cpgs@samsung.com>
Subject: Re: [query] how to use "ranges" in device tree
Message-ID: <20150417115016.69857a77@xhacker>
In-Reply-To: <20150417102413.705b1ca0@xhacker>
References: <20150416215938.347caa68@xhacker>
	<55303EE1.1050108@samsung.com>
	<20150417102413.705b1ca0@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

I got the solution, the ranges can define two or more ranges. What I need to do
is just add ranges for 0xe0000000 - 0xf0000000 as the following:

soc {
	ranges = <0 0xf7000000 0x1000000
		  0xe0000000 0xe0000000 0x10000000>;  //add this line
	...
	pcie: pcie@e40000 {
		...
		reg = <0xe40000 0x10000>, <0xe0000000 0x8000000>;
		reg-names = "dbi", "pad", "config";
		...
	};
}

Now, we can get the config space correctly.


Thanks,
Jisheng

On Thu, 16 Apr 2015 19:24:13 -0700
Jisheng Zhang <jszhang@marvell.com> wrote:

> Hi Jaehoon,
> 
> On Thu, 16 Apr 2015 15:59:45 -0700
> Jaehoon Chung <jh80.chung@samsung.com> wrote:
> 
> > Hi,
> > 
> > Well, I'm not sure..
> > But in my understanding..configuration range might be support both "ranges" and "config" of reg.
> > 
> > On 04/16/2015 10:59 PM, Jisheng Zhang wrote:
> > > Hi all,
> > > 
> > > I didn't fully understand the "ranges" usage, here is one situation which I dunno
> > > how to handle.
> > > 
> > > In arch/arm/boot/dts/berlin2q.dtsi, we describe the /soc ranges as
> > > 
> > > ranges = <0 0xf7000000 0x1000000>;
> > > 
> > > That's fine. Now there's a pci device based on pcie-designware.c which prefer
> > > put "config" space in reg. But the config space starts at 0xe0000000, due to
> > > the /soc ranges, the "config" space following pcie node is not correct in fact.
> > > 
> > > soc {
> > > 	ranges = <0 0xf7000000 0x1000000>;
> > > 	...
> > > 	pcie: pcie@e40000 {
> > > 		compatible = "...";
> > > 		reg = <0xe40000 0x10000>, <0xe0000000 0x8000000>;
> > > 		reg-names = "dbi", "pad", "config";
> > > 		...
> > > 	};
> > > 	...
> > > };
> > 
> > According to yours,
> > 
> > reg = <0xe40000 0x1000		/* dbi */
> > 	0xe000000 0x800000	/* pad */
> > 	0xf7000000 0x1000000>;	/* config ? */
> 
> oops, there's no pad at all, dbi starts at 0xf7e40000, config space starts at 0xe0000000
> 
> so my pcie in my understanding is
> 
> pcie: pcie@e40000 {
> 	compatible = "...";
> 	reg = <0xe40000 0x10000>, <0xe0000000 0x8000000>;
> 	reg-names = "dbi", "config";
> };
> 
> But the "/soc" ranges is defined as "<0 0xf7000000 0x1000000>;", so the config space
> in the above dts is not correct.
> 
> My solution is change the "/soc" ranges as following:
> 
> soc {
> 	ranges;
> 	...
> };
> 
> Is there any elegant solutions for this situation?
> 
> > 
> > If there is not "config" into reg-names, it should be tried to find it into "ranges".
> 
> The pcie-designware driver prefers users define config space in "reg"
> 
> Thanks for your help,
> Jisheng
> 
> > 
> > If my understanding is wrong, let me know, plz.
> > 
> > In my case,
> > 
> > 	reg = <0x156b0000 0x1000
> > 		0x15680000 0x1000
> > 		0x0c000000 0x1000>;
> > 	reg-names = "elbi", "phy", "config";
> > 
> > 	ranges = < ..... /* downstream I/O */
> > 		  ...... /* non-prefetchable memory */
> > 
> > 
> > Best Regards,
> > Jaehoon Chung	
> > 
> > > 
> > > How to define the "config" space in this situation? Did we need to change
> > > the /soc ranges as the following?
> > > 
> > > soc {
> > > 	ranges;
> > > }
> > > 
> > > Thanks in advance,
> > > Jisheng
> > > 
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > > 
> > 
> 

