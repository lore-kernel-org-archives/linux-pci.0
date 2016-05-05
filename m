Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56728 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754846AbcEETmp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 5 May 2016 15:42:45 -0400
Date: Thu, 5 May 2016 14:42:35 -0500
From: Rob Herring <robh@kernel.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, aik@ozlabs.ru, bhelgaas@google.com,
	robherring2@gmail.com, dja@axtens.net, alistair@popple.id.au
Subject: Re: [PATCH v9 21/22] drivers/of: Export of_detach_node()
Message-ID: <20160505194235.GA13790@rob-hp-laptop>
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1462281773-26438-22-git-send-email-gwshan@linux.vnet.ibm.com>
 <20160504133603.GA30081@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160504133603.GA30081@gwshan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 04, 2016 at 11:36:03PM +1000, Gavin Shan wrote:
> On Tue, May 03, 2016 at 11:22:52PM +1000, Gavin Shan wrote:
> >This exports of_detach_node() for PowerPC PowerNV PCI hotplug
> >driver. No functional changes introduced.
> >
> >Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> 
> Rob, I'm not sure it's late to cache the 4.7 merge window.
> Also, I was told this series is needed by new CAPI driver which
> is being developed. The developers hope to push the new CAPI driver
> in 4.8 merge window (perhaps) or linux-next before 4.8 merge window
> is opened. It means the new CAPI driver depends on this series which
> has to be pushed to linux-next before 4.8 merge window.
> 
> If it's fine, could you please merge 16 to 21? With them merged to
> 4.7, the left patches won't depend on FDT changes. Thanks in advance
> for your help.

I've applied the 6 patches.

Rob
