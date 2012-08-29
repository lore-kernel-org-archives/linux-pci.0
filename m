Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from yes.iam.tj ([109.74.197.121]:49895 "EHLO tjworld.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751000Ab2H2OTH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 29 Aug 2012 10:19:07 -0400
Received: from [10.254.251.51] (unknown [10.254.251.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by tjworld.net (Postfix) with ESMTPSA id 5A6C21ADD5
	for <linux-pci@vger.kernel.org>; Wed, 29 Aug 2012 15:19:05 +0100 (BST)
Message-ID: <503E24D8.3010601@iam.tj>
Date: Wed, 29 Aug 2012 15:19:04 +0100
From: TJ <tj@iam.tj>
MIME-Version: 1.0
CC: linux-pci@vger.kernel.org
Subject: Re: Limiting BAR resource  region size allocation (device claims
 2x what it needs) ?
References: <503E1027.6050104@iam.tj> <20120829132415.GA21160@parisc-linux.org>
In-Reply-To: <20120829132415.GA21160@parisc-linux.org>
Content-Type: text/plain; charset=UTF-8
To: unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 29/08/12 14:24, Matthew Wilcox wrote:
> On Wed, Aug 29, 2012 at 01:50:47PM +0100, TJ wrote:
>> The CPU is 64-bit but the i945PM northbridge is 32-bit (so no physical > 4GB addressing). With PCI allocations as they are the system is limited to 2GB of RAM under Linux (3GB on Windows Vista).
> 
> According to the laptop specs, it's limited to 2GB RAM:
> 
> http://www.sony.co.uk/support/en/product/VGN-FE41Z/specifications
> 
> Personally, I'm not terribly excited about doing much work to enhance
> a 6 year old laptop...
> 
I've had it from new. It supports 4GB physically - 2 SO-DIM slots @ 2GB each.

Up until now I've been using my own resource allocation patches I wrote in 2009 to do things the same way as Windows does, to allow access to 3GB of RAM. At that time I discussed them with Jesse
Barnes and analysed the problem comprehensively. See http://tjworld.net/wiki/Linux/Kernel/Bug/PciAllocationAlgorithm

I'd now like to work with a mainline kernel but that would force me to lose 1/3 of RAM as things stand.

As things have changed significantly in PCI-land since I wrote my patches they no longer fit so I'm looking to find a way to use mainline and keep the 3GB of RAM.

Relatively recently I realised the VRAM is only 128MB so I wondered if there might be a slightly easier way by forcing the region size allocation to match. Reducing the region size to 128MB would also
mean double the number of boundaries it could align to. That might avoid the need for my custom patches to shuffle allocations around.


