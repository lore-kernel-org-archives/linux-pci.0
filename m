Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:51956
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751415Ab2CGIlG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 Mar 2012 03:41:06 -0500
From: Zhao Chenhui-B35336 <B35336@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH 1/9] pci_ids: Add device ID for IBM PCI-X bridge
Date: Wed, 7 Mar 2012 08:40:58 +0000
Message-ID: <7AA2FF042C086D469F577FA6723434DA015E98@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1331024707-15891-1-git-send-email-chenhui.zhao@freescale.com>
 <08B5FFBF-FFF7-45FF-A98D-181CC0E6CEBC@kernel.crashing.org>
In-Reply-To: <08B5FFBF-FFF7-45FF-A98D-181CC0E6CEBC@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On Mar 6, 2012, at 3:05 AM, Zhao Chenhui wrote:
> 
> > Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> > ---
> > include/linux/pci_ids.h |    1 +
> > 1 files changed, 1 insertions(+), 0 deletions(-)
> 
> Just merge this with the 2nd patch that actually uses the ID.
> 
> - k

Ok. I put it in the file mpc85xx_cds.c.

-Chenhui

