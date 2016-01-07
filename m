Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43920 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752427AbcAGRle (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 7 Jan 2016 12:41:34 -0500
Date: Thu, 7 Jan 2016 11:41:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, nsekhar@ti.com,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH 0/2] DRA72/DRA74: Add 2 lane support
Message-ID: <20160107174126.GB14105@localhost>
References: <1452077393-25880-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452077393-25880-1-git-send-email-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Richard]

Hi Kishon,

On Wed, Jan 06, 2016 at 04:19:51PM +0530, Kishon Vijay Abraham I wrote:
> Add driver modifications in pci-dra7xx to get x2 mode working in
> DRA72 and DRA74. Certain modifications is needed in PHY driver also
> which will be sent as a separate series.
> 
> Certain board modifications has to be done in order to test
> x2 mode in dra72-evm.
> 
> These patches were created on pci next.
> 
> Changes from RFC:
> *) .b1co_mode_sel_mask is now set with the correct value.
> *) cleanup the patch
> 
> Kishon Vijay Abraham I (2):
>   pci: host: pci-dra7xx: use "num-lanes" property to find phy count
>   pci: host: pci-dra7xx: Enable x2 mode support
> 
>  Documentation/devicetree/bindings/pci/ti-pci.txt |    8 +-
>  drivers/pci/host/pci-dra7xx.c                    |  104 +++++++++++++++++++---
>  2 files changed, 97 insertions(+), 15 deletions(-)

Apparently dra7xx in mainline doesn't work [1].  Until that's
resolved, I'm going to ignore dra7xx patches.

Bjorn

[1] http://lkml.kernel.org/r/20160106214518.GA6106@localhost.localdomain
