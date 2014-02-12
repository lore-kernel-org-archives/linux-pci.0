Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64535 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542AbaBLXXD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2014 18:23:03 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] bus: mvebu-mbus: Fix incorrect size for PCI aperture resources
Date: Thu, 13 Feb 2014 00:22:57 +0100
Message-ID: <1701545.GmtElNcB8L@wuerfel>
In-Reply-To: <1392245828-23244-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1392245828-23244-1-git-send-email-jgunthorpe@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 12 February 2014 15:57:07 Jason Gunthorpe wrote:
> reg[0] is the DT base, reg[1] is the DT length in bytes,
> struct resource.end is the inclusive end address, so a -1 is
> required.
> 
> Tested on kirkwood.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
