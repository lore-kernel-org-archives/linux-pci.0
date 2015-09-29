Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:60197 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755800AbbI2Hn0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2015 03:43:26 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: David Daney <ddaney.cavm@gmail.com>, linux-kernel@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	"Sean O. Stalley" <sean.stalley@intel.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [RFC PATCH] PCI/pci-host-generic: Add support for Cavium Thunder fixed BARs.
Date: Tue, 29 Sep 2015 09:42:48 +0200
Message-ID: <1981236.3bSkWiA8PH@wuerfel>
In-Reply-To: <1443488184-12633-1-git-send-email-ddaney.cavm@gmail.com>
References: <1443488184-12633-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 28 September 2015 17:56:24 David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Early versions of the Cavium Thunder CN88XX processor are missing
> Enhanced Allocation (EA) capabilities for the fixed BAR addresses used
> by the on-SoC hardware blocks.
> 
> Add config access functions that synthesize the missing EA
> capabilities for versions that are missing that information.  Since
> this is a little hacky, gate the inclusion of the code with a new
> Kconfig variable.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
> 
> As suggested by Bjorn Helgaas...  It is RFC at this point, but this is
> working well for me.

I don't have an opinion on the way you implement the config space
accessors, but it seems that the overall amount of code is comparable
to the normal pci-host-generic driver without this, and it is not
really generic at all.

I think because of this, it makes more sense to have a separate top-level
driver for this and not reuse the pci-host-generic implementation here.

	Arnd
