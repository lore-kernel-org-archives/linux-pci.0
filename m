Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40686 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932104AbaBRPlr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2014 10:41:47 -0500
Date: Tue, 18 Feb 2014 15:41:39 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, arnd@arndb.de,
	jgunthorpe@obsidianresearch.com
Subject: Re: [PATCH v3 2/3] ARM: bios32: use pci_enable_resource to enable
	PCI resources
Message-ID: <20140218154139.GF21483@n2100.arm.linux.org.uk>
References: <1392726043-31088-1-git-send-email-will.deacon@arm.com> <1392726043-31088-3-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392726043-31088-3-git-send-email-will.deacon@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 18, 2014 at 12:20:42PM +0000, Will Deacon wrote:
> This patch moves bios32 over to using the generic code for enabling PCI
> resources. Since the core code takes care of bridge resources too, we
> can also drop the explicit IO and MEMORY enabling for them in the arch
> code.
> 
> A side-effect of this change is that we no longer explicitly enable
> devices when running in PCI_PROBE_ONLY mode. This stays closer to the
> meaning of the option and prevents us from trying to enable devices
> without any assigned resources (the core code refuses to enable
> resources without parents).
> 
> Tested-By: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Tested-by: Jingoo Han <jg1.han@samsung.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Tested acceptably fine here with crudbus-from-hell.

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
