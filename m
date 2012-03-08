Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:22010
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752816Ab2CHHz5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 8 Mar 2012 02:55:57 -0500
From: Zang Roy-R61911 <r61911@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	Zhao Chenhui-B35336 <B35336@freescale.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 1/9] pci_ids: Add device ID for IBM PCI-X bridge
Date: Thu, 8 Mar 2012 07:55:49 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB00209A4B5@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1331024707-15891-1-git-send-email-chenhui.zhao@freescale.com>
 <08B5FFBF-FFF7-45FF-A98D-181CC0E6CEBC@kernel.crashing.org>
In-Reply-To: <08B5FFBF-FFF7-45FF-A98D-181CC0E6CEBC@kernel.crashing.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: linuxppc-dev-bounces+tie-fei.zang=freescale.com@lists.ozlabs.org
> [mailto:linuxppc-dev-bounces+tie-fei.zang=freescale.com@lists.ozlabs.org]
> On Behalf Of Kumar Gala
> Sent: Tuesday, March 06, 2012 20:14 PM
> To: Zhao Chenhui-B35336
> Cc: linux-pci@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 1/9] pci_ids: Add device ID for IBM PCI-X bridge
> 
> 
> On Mar 6, 2012, at 3:05 AM, Zhao Chenhui wrote:
> 
> > Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> > ---
> > include/linux/pci_ids.h |    1 +
> > 1 files changed, 1 insertions(+), 0 deletions(-)
> 
> Just merge this with the 2nd patch that actually uses the ID.
Why does this necessary?
I'd prefer using a separate patch for the PCI ID.
Roy

