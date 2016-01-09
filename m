Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52622 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752850AbcAIWx0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 9 Jan 2016 17:53:26 -0500
Date: Sat, 9 Jan 2016 16:53:21 -0600
From: Rob Herring <robh@kernel.org>
To: David Daney <ddaney.cavm@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v3 2/2] pci, pci-thunder-pem: Add PCIe host driver for
 ThunderX processors.
Message-ID: <20160109225321.GA22053@rob-hp-laptop>
References: <1452297553-19911-1-git-send-email-ddaney.cavm@gmail.com>
 <1452297553-19911-3-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452297553-19911-3-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 08, 2016 at 03:59:13PM -0800, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Some Cavium ThunderX processors require quirky access methods for the
> config space of the PCIe bridge.  Add a driver to provide these config
> space accessor functions.  The pci-host-common code is used to
> configure the PCI machinery.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  .../devicetree/bindings/pci/pci-thunder-pem.txt    |  43 ++++

Acked-by: Rob Herring <robh@kernel.org>

>  MAINTAINERS                                        |   8 +
>  drivers/pci/host/Kconfig                           |   7 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pci-thunder-pem.c                 | 283 +++++++++++++++++++++
>  5 files changed, 342 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
>  create mode 100644 drivers/pci/host/pci-thunder-pem.c
