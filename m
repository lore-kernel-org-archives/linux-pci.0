Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36545 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755503AbcCCKuV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2016 05:50:21 -0500
Date: Thu, 3 Mar 2016 10:50:05 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] arm: kernel: pci: remove pci=firmware command line
 parameter handling
Message-ID: <20160303105004.GU19428@n2100.arm.linux.org.uk>
References: <1456767800-6609-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20160229174258.GL5891@wantstofly.org>
 <20160301095832.GC31766@red-moon>
 <20160302223142.GS5891@wantstofly.org>
 <20160303104845.GB28359@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160303104845.GB28359@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 03, 2016 at 10:48:45AM +0000, Lorenzo Pieralisi wrote:
> I think we should go ahead otherwise we are stuck forever with it,
> it is probably best for this patch to land in -next beginning of
> next cycle to unearth possible issues, that's the same thing
> we did for the latest changes in arm pcibios that we feared could
> trigger regressions.
> 
> Russell, what's your opinion on this ? Please let me know.

I'm happy with the suggested approach.

Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
