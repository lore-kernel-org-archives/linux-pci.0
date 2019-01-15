Return-Path: <SRS0=HN6g=PX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030B4C43387
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 22:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA6F214AE
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 22:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391195AbfAOWqo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:46:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390155AbfAOWqo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jan 2019 17:46:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B470158E51;
        Tue, 15 Jan 2019 22:46:43 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E6355101963A;
        Tue, 15 Jan 2019 22:46:37 +0000 (UTC)
Date:   Wed, 16 Jan 2019 06:46:32 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH] PCI/MSI: preference to returning -ENOSPC from
 pci_alloc_irq_vectors_affinity
Message-ID: <20190115224631.GA22558@ming.t460p>
References: <20190103013106.26452-1-ming.lei@redhat.com>
 <20190114232338.GE33971@google.com>
 <20190115131140.GB28672@lst.de>
 <05cb9e71-e455-a717-c64c-b5242ec38bad@kernel.dk>
 <20190115193135.GH33971@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115193135.GH33971@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 15 Jan 2019 22:46:43 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

I think Christoph and Jens are correct, we should make this patch into
5.0 because the issue is triggered since 3b6592f70ad7b4c2 ("nvme: utilize
two queue maps, one for reads and one for writes"), which is merged to
5.0-rc.

For example, before 3b6592f70ad7b4c2, one nvme controller may be
allocated 64 irq vectors; but after that commit, only 1 irq vector
is assigned to this controller.

On Tue, Jan 15, 2019 at 01:31:35PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 15, 2019 at 09:22:45AM -0700, Jens Axboe wrote:
> > On 1/15/19 6:11 AM, Christoph Hellwig wrote:
> > > On Mon, Jan 14, 2019 at 05:23:39PM -0600, Bjorn Helgaas wrote:
> > >> Applied to pci/msi for v5.1, thanks!
> > >>
> > >> If this is something that should be in v5.0, let me know and include the
> > >> justification, e.g., something we already merged for v5.0 or regression
> > >> info, etc, and a Fixes: line, and I'll move it to for-linus.
> > > 
> > > I'd be tempted to queues this up for 5.0.  Ming, what is your position?
> > 
> > I think we should - the API was introduced in this series, I think there's
> > little (to no) reason NOT to fix it for 5.0.
> 
> I'm guessing the justification goes something like this (I haven't
> done all the research, so I'll leave it to Ming to fill in the details):
> 
>   pci_alloc_irq_vectors_affinity() was added in v4.x by XXXX ("...").

dca51e7892fa3b ("nvme: switch to use pci_alloc_irq_vectors")

>   It had this return value defect then, but its min_vecs/max_vecs
>   parameters removed the need for callers to interatively reduce the
>   number of IRQs requested and retry the allocation, so they didn't
>   need to distinguish -ENOSPC from -EINVAL.
> 
>   In v5.0, XXX ("...") added IRQ sets to the interface, which

3b6592f70ad7b4c2 ("nvme: utilize two queue maps, one for reads and one for writes")

>   reintroduced the need to check for -ENOSPC and possibly reduce the
>   number of IRQs requested and retry the allocation.

Thanks,
Ming
