Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755488AbcKOKLz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Nov 2016 05:11:55 -0500
Date: Tue, 15 Nov 2016 10:12:57 +0000
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
Message-ID: <20161115101257.GB16261@red-moon>
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
> 
> Please let me know which patches in particular to look at in detail.

Are patches 7 and consequently 16 (that builds on top of 7) ok with
you ? They should be equivalent to nop on anything other than ARM64
but they touch ACPI core so they require an ACK if they are ok please.

Thank you very much !
Lorenzo
