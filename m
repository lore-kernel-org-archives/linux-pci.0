Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60050 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932066AbbIAKkw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 1 Sep 2015 06:40:52 -0400
Message-ID: <55E580AF.6060302@arm.com>
Date: Tue, 01 Sep 2015 11:40:47 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Ley Foon Tan <lftan@altera.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>
CC: Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, lftan.linux@gmail.com,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v6 0/6] Altera PCIe host controller driver with MSI support
References: <1441103408-8433-1-git-send-email-lftan@altera.com>
In-Reply-To: <1441103408-8433-1-git-send-email-lftan@altera.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/09/15 11:30, Ley Foon Tan wrote:
> This is the 6th version of patch set to add support for Altera PCIe host
> controller with MSI feature on Altera FPGA device families. This patchset
> mainly resolve comments from Marc Zyngier in v5 and minor fixes.

The merge window has just started, and I'm not going to go through
another review at that stage - too many things in flight.

Please ping me again once 4.3-rc1 is out.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
