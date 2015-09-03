Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40908 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932599AbbICQmM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Sep 2015 12:42:12 -0400
Date: Thu, 3 Sep 2015 17:42:09 +0100
From: Will Deacon <will.deacon@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Jayachandran C <jchandra@broadcom.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [PATCH] ARM64: PCI: do not enable resources on PROBE_ONLY systems
Message-ID: <20150903164209.GI877@arm.com>
References: <1438262039-32085-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20150828211444.GA27890@google.com>
 <20150829124457.GA18125@red-moon>
 <20150831132803.GB647@google.com>
 <20150831163314.GA19309@red-moon>
 <CAErSpo5188hGiySG+JweWOvfj6aZtAfVta4=0wwwRmMTp+9tFg@mail.gmail.com>
 <20150903163504.GH829@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150903163504.GH829@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Thu, Sep 03, 2015 at 05:35:04PM +0100, Bjorn Helgaas wrote:
> On Mon, Aug 31, 2015 at 11:49:20AM -0500, Bjorn Helgaas wrote:
> > OK, if it fixes a problem in my v4.3 pull request, we need to merge
> > it.  I missed the connection, probably because I was browsing the
> > v4.2-rc1 tree, which wouldn't have those changes.
> > 
> > It's OK with me to merge it via the arm64 tree.
> 
> Do you need me to do anything with this?  It'd be nice to get it in
> before -rc1.  The PCI changes have already been merged, and it'd be
> nice to mention the commit that this fixes.

Nope, it's queued in the arm64 tree. I'm just waiting for a dependent
branch in -tip to get merged before I send my pull request.

Cheers,

Will
