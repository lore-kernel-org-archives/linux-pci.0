Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959D0C43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 12:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715C720449
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 12:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfC0Mb1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:31:27 -0400
Received: from foss.arm.com ([217.140.101.70]:53870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfC0Mb1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Mar 2019 08:31:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D21EC374;
        Wed, 27 Mar 2019 05:31:26 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 577C53F557;
        Wed, 27 Mar 2019 05:31:25 -0700 (PDT)
Date:   Wed, 27 Mar 2019 12:31:15 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] Add IPROC PCIe new features
Message-ID: <20190327123114.GA9636@e107981-ln.cambridge.arm.com>
References: <1551415936-30174-1-git-send-email-srinath.mannam@broadcom.com>
 <CABe79T5M3FJQed018aGfRhS7eLBbtmoO33mFP=K+xHgavto64Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABe79T5M3FJQed018aGfRhS7eLBbtmoO33mFP=K+xHgavto64Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 27, 2019 at 02:08:46PM +0530, Srinath Mannam wrote:
> Hi Lorenzo/Bjorn,
> 
> Could you please help to review this patch series when you have time?
> I believe I have addressed all your review comments.

I will shortly keeping in mind that you should really ask HW designers
to get to grips with a proper design because there are ways too many HW
quirks this driver has to fix-up, it has become an unmanageable
collection of work arounds.

Lorenzo

> Thanks,
> Srinath.
> 
> On Fri, Mar 1, 2019 at 10:22 AM Srinath Mannam
> <srinath.mannam@broadcom.com> wrote:
> >
> > This patch set extends support of new IPROC PCIe host controller features
> >  - Add CRS check using controller register status flags
> >  - Add outbound window mapping configuration for 32-bit I/O region
> >
> > This patch set is based on Linux-5.0-rc2.
> >
> > Changes from v3:
> >   - Addressed Lorenzo Pieralisi comments.
> >
> > Changes from v2:
> >   - Based on Lorenzo Pieralisi comments, commit logs are expanded.
> >
> > Changes from v1:
> >   - Addressed Bjorn Helgaas comments.
> >   - Removed set order mode patch from patchset.
> >
> > Srinath Mannam (2):
> >   PCI: iproc: Add CRS check in config read
> >   PCI: iproc: Add outbound configuration for 32-bit I/O region
> >
> >  drivers/pci/controller/pcie-iproc.c | 44 +++++++++++++++++++++++++++++++++----
> >  1 file changed, 40 insertions(+), 4 deletions(-)
> >
> > --
> > 2.7.4
> >
