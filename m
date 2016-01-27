Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51051 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752998AbcA0JgQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 27 Jan 2016 04:36:16 -0500
Date: Wed, 27 Jan 2016 09:36:10 +0000
From: Will Deacon <will.deacon@arm.com>
To: David Daney <ddaney.cavm@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v4 0/2] pci: Add host controller driver for Cavium
 ThunderX PCIe
Message-ID: <20160127093609.GA2390@arm.com>
References: <1453844781-24380-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453844781-24380-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 26, 2016 at 01:46:19PM -0800, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Some Cavium ThunderX processors require quirky access methods for the
> config space of the PCIe bridge.
> 
> There are two patches:
> 
> 1) Refactor code in pci-host-generic so that it can more easily be
>    used by other drivers.  This splits the driver for CAM and ECAM
>    access methods to a separate file from the common host driver code.
> 
> 2) Add the ThunderX PCIe driver, which leverages the code in
>    pci-host-generic
> 
> Changes from v3: Add some Acked-by, rebased to v4.5.0-rc1
> 
> Changes from v2: Improve device tree binding example as noted by Rob
> Herring.  Rename pcie-thunder-pem.* to pci-thunder-pem.* for better
> consistency.  Update MAINTAINERS to reflect the changes.
> 
> Changes from v1: Split CAM and ECAM code from common driver code as
> suggested by Arnd Bergmann.  Fix spelling errors in
> pcie-thunder-pem.txt

Bjorn -- I guess you'll pick these up directly?

Will
