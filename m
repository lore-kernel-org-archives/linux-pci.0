Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37648 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbbDQIiU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Apr 2015 04:38:20 -0400
Received: by widdi4 with SMTP id di4so12468441wid.0
        for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2015 01:38:19 -0700 (PDT)
Message-ID: <5530C678.5080702@gmail.com>
Date: Fri, 17 Apr 2015 10:38:16 +0200
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Jisheng Zhang <jszhang@marvell.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
CC: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, CPGS <cpgs@samsung.com>
Subject: Re: [query] how to use "ranges" in device tree
References: <20150416215938.347caa68@xhacker> <55303EE1.1050108@samsung.com> <20150417102413.705b1ca0@xhacker> <20150417115016.69857a77@xhacker>
In-Reply-To: <20150417115016.69857a77@xhacker>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 17.04.2015 05:50, Jisheng Zhang wrote:
> I got the solution, the ranges can define two or more ranges. What I need to do
> is just add ranges for 0xe0000000 - 0xf0000000 as the following:

Jisheng,

the beauty of ranges property often reminds me of perl code: once you
stop looking at it, you cannot recall how you did it nor how that
has ever worked.

What the ranges property does is to map an address range back to the
address space of the parent node. In this case, the parent node of
"soc" is the root node with "ranges;", i.e. 1:1 mapping.

> soc {
> 	ranges = <0 0xf7000000 0x1000000

The line above maps 0x1000000 bytes starting at 0 back to 0xf7000000
of the parent node's address space. This allows us to leave the 0xf7
prefix for each of the internal bus nodes below.

> 		  0xe0000000 0xe0000000 0x10000000>;  //add this line

You could have chosen any address as the first value that does not
interfere with 0x0-0x1000000 of the first range, e.g.

0x20000000 0xe0000000 0x10000000

would allow you to access the pcie memory space at 0x20000000 in nodes
below that ranges property.

Sebastian

> 	pcie: pcie@e40000 {
> 		...
> 		reg = <0xe40000 0x10000>, <0xe0000000 0x8000000>;
> 		reg-names = "dbi", "pad", "config";
> 		...
> 	};
> }
>
> Now, we can get the config space correctly.

