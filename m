Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:51290 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754973Ab2GQKie (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 17 Jul 2012 06:38:34 -0400
Message-ID: <1342521498.3669.7.camel@pasglop>
Subject: Re: [PATCH 05/15] pci: resource assignment based on p2p alignment
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	linuxppc-dev@ozlabs.org, bhelgaas@google.com, yinghai@kernel.org
Date: Tue, 17 Jul 2012 20:38:18 +1000
In-Reply-To: <20120717100314.GB25613@ram-ThinkPad-T61>
References: <1342491799-30303-1-git-send-email-shangw@linux.vnet.ibm.com>
	 <1342491799-30303-6-git-send-email-shangw@linux.vnet.ibm.com>
	 <20120717050547.GD2369@ram-ThinkPad-T61>
	 <20120717052333.GE2369@ram-ThinkPad-T61> <20120717053648.GA18497@shangw>
	 <20120717055715.GF2369@ram-ThinkPad-T61> <1342516619.3669.5.camel@pasglop>
	 <20120717100314.GB25613@ram-ThinkPad-T61>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2012-07-17 at 18:03 +0800, Ram Pai wrote:
>         Lets say we passed that 'type' flag to size the minimum
>         alignment constraints for that b_res.  And window_alignment(bus,
>         type) of your platform  used that 'type' information to
>         determine whether to use the alignment constraints of 32-bit
>         window or 64-bit window.
> 
>         However, later when the b_res is actually allocated a resource,
>         the pci_assign_resource() has no idea whether to allocate 32-bit
>         window resource or 64-bit window resource, because the 'type'
>         information is not captured anywhere in b_res.
> 
>         You would basically have a disconnect between what is sized and 
>         what is allocated. Unless offcourse you pass that 'type' to
>         the b_res->flags, which is currently not the case. 

Right, we ideally would need the core to query the alignment once per
"apertures" it tries as a candidate to allocate a given resource... but
that's for later.

For now we can probably live with giving out the max of the minimum
alignment we support for M64 and our M32 segment size.

Cheers,
Ben.


