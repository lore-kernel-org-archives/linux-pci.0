Return-Path: <SRS0=DeKJ=AE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E0CC433DF
	for <linux-pci@archiver.kernel.org>; Tue, 23 Jun 2020 07:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023572077D
	for <linux-pci@archiver.kernel.org>; Tue, 23 Jun 2020 07:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbgFWHWq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:22:46 -0400
Received: from verein.lst.de ([213.95.11.211]:38091 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730830AbgFWHWp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jun 2020 03:22:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D458668AEF; Tue, 23 Jun 2020 09:22:40 +0200 (CEST)
Date:   Tue, 23 Jun 2020 09:22:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 14/15] docs: fix references for DMA*.txt files
Message-ID: <20200623072240.GA974@lst.de>
References: <cover.1592895969.git.mchehab+huawei@kernel.org> <37b2fd159fbc7655dbf33b3eb1215396a25f6344.1592895969.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37b2fd159fbc7655dbf33b3eb1215396a25f6344.1592895969.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 23, 2020 at 09:09:10AM +0200, Mauro Carvalho Chehab wrote:
> As we moved those files to core-api, fix references to point
> to their newer locations.

Can we please just revert the RST conversion that I didn't ACK?
