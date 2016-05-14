Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:43351 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbcENJ76 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 May 2016 05:59:58 -0400
Received: from camelot.kam.mff.cuni.cz (camelot.kam.mff.cuni.cz [195.113.17.209])
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTP id BB8B254213B
	for <linux-pci@vger.kernel.org>; Sat, 14 May 2016 11:59:55 +0200 (CEST)
Date: Sat, 14 May 2016 11:59:55 +0200
From: Martin Mares <mj@ucw.cz>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH] pciutils: Add support for 32-bit PCI domains
Message-ID: <mj+md-20160514.095828.61188.camelot@ucw.cz>
References: <1458242357-28833-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458242357-28833-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

> This adds support for new host bridges that may create PCI domain number
> values requiring more than 16 bits. The new domain 32-bit integer is
> signed to allow -1 for "any", and is sufficient as the domain number
> will never require the full 32-bits.
> 
> The domain field is appended at the end of struct pci_dev, and the
> current location of the 16-bit domain remains for compatibility. The
> domain number is truncated and copied into the legacy domain location
> so existing applications linking to the library will continue to work
> without modification. We accept that these applications may not work
> correctly on machines with host bridges exporting 32-bit domains.
> 
> In order to force new programs to link to the new ABI, the pci_init
> function call is versioned in this commit.

Sorry for the delay.

I have applied the patch and fixed a couple of minor problems. Most
importantly, the 16-bit domain number was maintained in the sysfs back-end,
so backward compatibility was not kept on other systems.

Could you please review the changes in pciutils.git?

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Q: Who invented the first airplane that did not fly?  A: The Wrong Brothers.
