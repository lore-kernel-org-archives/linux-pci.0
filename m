Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:53305 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbaIIUXb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Sep 2014 16:23:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Murali Karicheri <m-karicheri2@ti.com>, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	bhelgaas@google.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: keystone: remove handle of PCI mode configuration
Date: Tue, 09 Sep 2014 22:22:54 +0200
Message-ID: <2873880.LROUF1qxur@wuerfel>
In-Reply-To: <1410293835-13050-1-git-send-email-m-karicheri2@ti.com>
References: <1410293835-13050-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 09 September 2014 16:17:14 Murali Karicheri wrote:
> Keystone PCI hardware supports both RC and EP modes and devcfg
> register has bits to boot strap the device to either of these modes.
> It seems proper to add this functionality to the boot loader rather
> than in the driver as device will be operating in either mode, not
> both any time. Currently the driver supports only RC mode and hence
> register configuration in the driver is not needed and driver can
> assume this is a RC hardware.
> 
> Also update the DT documentation accordingly.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> 

Thanks for doing this,

Acked-by: Arnd Bergmann <arnd@arndb.de>
