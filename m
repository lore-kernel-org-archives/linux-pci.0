Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A18AC10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 13:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA391217F4
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 13:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554989752;
	bh=JBPZekV6xsXIiOmQIOibJqZN6gsh8iq1CTESrbPngeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CAv6d9VupiLk+fYaTEmqiPtqSZITrG3mPjTslv1KSEfi336JJZeX026J0SjVHcezw
	 jW+/kTkzHwS7f4nenCXEETFjB56TOW9h93busaVgUrWvw9rWi2x+0FqxDTo7jErEH2
	 4lWLZtSlQbj8Bvbp7r0M2P6OJoqhm87KgsjwaTp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfDKNfq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:35:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbfDKNfp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Apr 2019 09:35:45 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 828E7217F4;
        Thu, 11 Apr 2019 13:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554989744;
        bh=JBPZekV6xsXIiOmQIOibJqZN6gsh8iq1CTESrbPngeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vqv2uCpL+0K7ukR+4iBS+e2BBX7x1IdwP64mN0NAzlQxelC3ajALgtxn19TXLGU7E
         vMYp5rOWp9wZQPi1giCjb/i0+TeBwucWa88YPOECE2Op67/21fH7FXxSDU6MDwHGA3
         9QrYyoIn+2SkrwVp1s8kSnZq34u9IaXveDH1Efd4=
Date:   Thu, 11 Apr 2019 08:35:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH 2/2] x86/pci: Clean up usage of X86_DEV_DMA_OPS
Message-ID: <20190411133543.GO256045@google.com>
References: <20190410080220.21705-1-hch@lst.de>
 <20190410080220.21705-3-hch@lst.de>
 <20190410081617.GA54229@gmail.com>
 <20190410214500.GK256045@google.com>
 <20190411051849.GA26205@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411051849.GA26205@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 11, 2019 at 07:18:49AM +0200, Christoph Hellwig wrote:
> On Wed, Apr 10, 2019 at 04:45:01PM -0500, Bjorn Helgaas wrote:
> > [+cc Keith, Jonathan (VMD guys)]
> > 
> > I'm OK with this from a PCI perspective.  It would be nice if
> > 
> >   dma_domain_list
> >   dma_domain_list_lock
> >   add_dma_domain()
> >   del_dma_domain()
> >   set_dma_domain_ops()
> > 
> > could all be moved to vmd.c, since they're really only used there.
> 
> I have another patch to eventually kill that, but it will need a little
> more prep work and thus be delayed to the next merge window.

Awesome, thanks!  I really appreciate all the global cleanup work you do.

Bjorn
