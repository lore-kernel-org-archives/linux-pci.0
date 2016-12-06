Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:58760 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752079AbcLFP7O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Dec 2016 10:59:14 -0500
Date: Tue, 6 Dec 2016 16:58:18 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: iommu@lists.linux-foundation.org,
        Will Deacon <will.deacon@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sricharan R <sricharan@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ACPI/IORT: Make dma masks set-up IORT specific
Message-ID: <20161206155817.GA27203@8bytes.org>
References: <20161206142011.11859-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161206142011.11859-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 06, 2016 at 02:20:11PM +0000, Lorenzo Pieralisi wrote:
>  drivers/acpi/arm64/iort.c | 22 ++++++++++++++++++++++
>  drivers/acpi/scan.c       | 14 +-------------
>  include/linux/acpi_iort.h |  2 ++
>  3 files changed, 25 insertions(+), 13 deletions(-)

Applied, thanks.
