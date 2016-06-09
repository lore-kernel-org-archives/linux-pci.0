Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33258 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbcFIWbP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 9 Jun 2016 18:31:15 -0400
Date: Thu, 9 Jun 2016 17:31:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	bhelgaas@google.com, arnd@arndb.de
Subject: Re: [PATCH v2 0/2] pci: host: Broadcom STB PCIE RC controller support
Message-ID: <20160609223110.GA19309@localhost>
References: <1462475700-1654-1-git-send-email-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462475700-1654-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 05, 2016 at 12:14:58PM -0700, Florian Fainelli wrote:
> Hi all,
> 
> This patch series adds support for Broadcom STB SoC's PCIe root complex driver.
> 
> This was primarily tested on BCM7445 (ARM) and BCM7435 (MIPS).
> 
> Jim is the original author, and I picked up our downstream 4.1 driver and
> updated it to utilize the non-ARM hw_pci functions as well as made some
> stylistic changes.
> 
> Thanks!
> 
> Jim Quinlan (2):
>   Documentation: DT: bindings: Add Broadcom STB PCIe bindings
>   pci: host: Add Broadcom STB PCIE RC controller

Hi Florian,

There was some discussion about these patches, so I assume you'll post
a new version addressing that.  When you do, can you include
/proc/iomem and /proc/ioports contents?

I'm looking to avoid problems like this:
http://lkml.kernel.org/r/20160606230537.20936.2892.stgit@bhelgaas-glaptop2.roam.corp.google.com

Also, it will save me time if you take note of this:
http://lkml.kernel.org/r/20160607231326.GA4759@localhost

Bjorn
