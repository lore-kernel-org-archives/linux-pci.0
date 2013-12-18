Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:64375 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab3LRBDy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Dec 2013 20:03:54 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXZ002Q99MGM410@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 18 Dec 2013 10:03:52 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Andrew Lunn' <andrew@lunn.ch>
Cc: 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Jason Cooper' <jason@lakedaemon.net>,
	linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <1386178241-10453-1-git-send-email-andrew@lunn.ch>
 <20131217204510.GA2281@lunn.ch>
In-reply-to: <20131217204510.GA2281@lunn.ch>
Subject: Re: [PATCH] PCI: MVEBU: Remove duplicate clock get
Date: Wed, 18 Dec 2013 10:03:51 +0900
Message-id: <006c01cefb8d$043e37f0$0cbaa7d0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 18, 2013 5:45 AM, Andrew Lunn wrote:
> On Wed, Dec 04, 2013 at 06:30:41PM +0100, Andrew Lunn wrote:
> > Probably due to a merge conflict resolution gone bad, the pci clock is
> > got twice. Remove the second redundent of_clk_get_by_name().
> >
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  drivers/pci/host/pci-mvebu.c | 8 --------
> >  1 file changed, 8 deletions(-)
> 
> Hi Folks
> 
> This patch has been Acked by Jingoo Han.

I just 'Reviewed', not 'Acked'. :-)

> 
> So my question is, which maintainer is going to accept it for
> mainline? Is there anything i need to do?

As Bjorn said, this patch was already applied to 'pci/host-mvebu'
branch for v3.14.

Also, MVEBU PCIe will be maintained by Thomas Petazzoni, and
Jason Cooper as below.

PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
M:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
M:     Jason Cooper <jason@lakedaemon.net>
L:     linux-pci@vger.kernel.org
L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
S:     Maintained
F:     drivers/pci/host/*mvebu*

Thank you.

Best regards,
Jingoo Han

