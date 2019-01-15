Return-Path: <SRS0=HN6g=PX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBE5C43387
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 19:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CC420859
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 19:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547580700;
	bh=N2YUdzl883TdV8bLGP6F/YGpKbcaOFleF/tMLmeYRq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hv9Nl43lsgnwM6CXbDxDRWqUseZF6CwIAaLcpqdTsIAyyyZW3ZFDmntm9GD8pfmjf
	 DXHsfnvtvl+PQc41AxOHbM05N+AhAkJiE8SH1YZbVkyepgOvBuwI96OYQFIfj3cmrT
	 DaNzt0s6rv6NmAlQ+9fa2oCYQd+XKRwfieAwNrVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbfAOTbj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:31:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:52916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731685AbfAOTbj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jan 2019 14:31:39 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB83320657;
        Tue, 15 Jan 2019 19:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547580699;
        bh=N2YUdzl883TdV8bLGP6F/YGpKbcaOFleF/tMLmeYRq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CEJCAW/VPkb4bsH10p7HnT0dvXaf3kxr+CRdLsDNVrjjNiGNF6h3BqO/DJsQwMfaJ
         UVBjuC4qGF6lAOh1ZQ/CVjFwMQWJa/UNKB5V+fFu86OGjPL2gFAANep5vHozHHVlZg
         yNlMolDRR+QHKhsGM714+novCqawcp9NnyLf21k0=
Date:   Tue, 15 Jan 2019 13:31:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH] PCI/MSI: preference to returning -ENOSPC from
 pci_alloc_irq_vectors_affinity
Message-ID: <20190115193135.GH33971@google.com>
References: <20190103013106.26452-1-ming.lei@redhat.com>
 <20190114232338.GE33971@google.com>
 <20190115131140.GB28672@lst.de>
 <05cb9e71-e455-a717-c64c-b5242ec38bad@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05cb9e71-e455-a717-c64c-b5242ec38bad@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 15, 2019 at 09:22:45AM -0700, Jens Axboe wrote:
> On 1/15/19 6:11 AM, Christoph Hellwig wrote:
> > On Mon, Jan 14, 2019 at 05:23:39PM -0600, Bjorn Helgaas wrote:
> >> Applied to pci/msi for v5.1, thanks!
> >>
> >> If this is something that should be in v5.0, let me know and include the
> >> justification, e.g., something we already merged for v5.0 or regression
> >> info, etc, and a Fixes: line, and I'll move it to for-linus.
> > 
> > I'd be tempted to queues this up for 5.0.  Ming, what is your position?
> 
> I think we should - the API was introduced in this series, I think there's
> little (to no) reason NOT to fix it for 5.0.

I'm guessing the justification goes something like this (I haven't
done all the research, so I'll leave it to Ming to fill in the details):

  pci_alloc_irq_vectors_affinity() was added in v4.x by XXXX ("...").
  It had this return value defect then, but its min_vecs/max_vecs
  parameters removed the need for callers to interatively reduce the
  number of IRQs requested and retry the allocation, so they didn't
  need to distinguish -ENOSPC from -EINVAL.

  In v5.0, XXX ("...") added IRQ sets to the interface, which
  reintroduced the need to check for -ENOSPC and possibly reduce the
  number of IRQs requested and retry the allocation.
