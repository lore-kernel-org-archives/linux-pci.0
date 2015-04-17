Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:11241 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753597AbbDQIzK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Apr 2015 04:55:10 -0400
Date: Fri, 17 Apr 2015 16:51:35 +0800
From: Jisheng Zhang <jszhang@marvell.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, CPGS <cpgs@samsung.com>
Subject: Re: [query] how to use "ranges" in device tree
Message-ID: <20150417165135.76f58eb8@xhacker>
In-Reply-To: <5530C678.5080702@gmail.com>
References: <20150416215938.347caa68@xhacker>
	<55303EE1.1050108@samsung.com>
	<20150417102413.705b1ca0@xhacker>
	<20150417115016.69857a77@xhacker>
	<5530C678.5080702@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 17 Apr 2015 01:38:16 -0700
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> On 17.04.2015 05:50, Jisheng Zhang wrote:
> > I got the solution, the ranges can define two or more ranges. What I need to do
> > is just add ranges for 0xe0000000 - 0xf0000000 as the following:
> 
> Jisheng,
> 
> the beauty of ranges property often reminds me of perl code: once you
> stop looking at it, you cannot recall how you did it nor how that
> has ever worked.
> 
> What the ranges property does is to map an address range back to the
> address space of the parent node. In this case, the parent node of
> "soc" is the root node with "ranges;", i.e. 1:1 mapping.
> 
> > soc {
> > 	ranges = <0 0xf7000000 0x1000000
> 
> The line above maps 0x1000000 bytes starting at 0 back to 0xf7000000
> of the parent node's address space. This allows us to leave the 0xf7
> prefix for each of the internal bus nodes below.
> 
> > 		  0xe0000000 0xe0000000 0x10000000>;  //add this line
> 
> You could have chosen any address as the first value that does not
> interfere with 0x0-0x1000000 of the first range, e.g.
> 
> 0x20000000 0xe0000000 0x10000000
> 
> would allow you to access the pcie memory space at 0x20000000 in nodes
> below that ranges property.
> 

Thanks for this explanation which gives me good guide about the "ranges" usage.

> 
> > 	pcie: pcie@e40000 {
> > 		...
> > 		reg = <0xe40000 0x10000>, <0xe0000000 0x8000000>;
> > 		reg-names = "dbi", "pad", "config";
> > 		...
> > 	};
> > }
> >
> > Now, we can get the config space correctly.
> 

