Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752771AbcKJK5L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Nov 2016 05:57:11 -0500
Date: Thu, 10 Nov 2016 10:58:06 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tomasz Nowicki <tn@semihalf.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Jon Masters <jcm@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 00/16] ACPI IORT ARM SMMU support
Message-ID: <20161110105806.GA20209@red-moon>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
 <CAJZ5v0j09fsp4Y66v2UANOGnW4FNO7PWxpZY=Pgw=bUccEL_eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0j09fsp4Y66v2UANOGnW4FNO7PWxpZY=Pgw=bUccEL_eA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

On Thu, Nov 10, 2016 at 12:36:12AM +0100, Rafael J. Wysocki wrote:
> Hi Lorenzo,
> 
> On Wed, Nov 9, 2016 at 3:19 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > This patch series is v7 of a previous posting:
> >
> > https://lkml.org/lkml/2016/10/18/506
> 
> I don't see anything objectionable in this series.

Thank you very much !

> Please let me know which patches in particular to look at in detail.

Apart from patch 1, patch 7 (and patch 16 that adds on top of it)
requires an ack from an ACPI core perspective. acpi_dma_configure()
should not affect x86/ia64 systems at all so those patches should
not really be controversial (patch 16 adds an IORT hook into
acpi_dma_configure() that is a nop by design on anything other than
ARM64), please let me know if they are ok.

Thank you again for your time,
Lorenzo
