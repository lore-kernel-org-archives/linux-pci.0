Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([136.243.66.71]:38996 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbcB2RwU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Feb 2016 12:52:20 -0500
Date: Mon, 29 Feb 2016 19:42:58 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Lennert Buytenhek <kernel@wantstofly.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	Russell King <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH] arm: kernel: pci: remove pci=firmware command line
 parameter handling
Message-ID: <20160229174258.GL5891@wantstofly.org>
References: <1456767800-6609-1-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456767800-6609-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 29, 2016 at 05:43:20PM +0000, Lorenzo Pieralisi wrote:

> According to kernel documentation, the pci=firmware command line
> parameter is only meant to be used on IXP2000 ARM platforms to prevent
> the kernel from assigning PCI resources configured by the bootloader.
> 
> Since the IXP2000 ARM platforms support has been removed from the
> kernel in commit:
> 
> commit c65f2abf54a6 ("ARM: remove ixp23xx and ixp2000 platforms")
> 
> its platforms specific kernel parameters should be removed
> too from the kernel documentation along with the kernel code
> currently handling them in that they have just become obsolete.
> 
> This patch removes the pci=firmware command line parameter handling
> from ARM code and the related kernel parameters documentation
> section.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Lennert Buytenhek <kernel@wantstofly.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>

Acked-by: Lennert Buytenhek <kernel@wantstofly.org>
