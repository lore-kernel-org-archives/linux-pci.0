Return-Path: <SRS0=O37L=DB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3EAC4363D
	for <linux-pci@archiver.kernel.org>; Thu, 24 Sep 2020 12:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E98238D6
	for <linux-pci@archiver.kernel.org>; Thu, 24 Sep 2020 12:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600949407;
	bh=Q2Pyd20nkzH5RcR2DXUGrcfyCzRdQdQbglCmLc8qUHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iC6Wlcvz64l25mDKWZ1MO+RlPgZXEmgf3J4xcIWnWyFSB7/PGPK62RGkTNWpA10KT
	 PPUXYkQWdXLPU/17bZIG5Zo9ZeoKEBBKHRxYlSpPqzmMMHWQKliMOaNkqxnksK5F72
	 ZtuKOiwCgZspeoC+dEjon31LfAVFJcx8IVOHcgHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgIXMKC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Sep 2020 08:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727478AbgIXMKA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 08:10:00 -0400
Received: from localhost (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5105223787;
        Thu, 24 Sep 2020 12:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600949399;
        bh=Q2Pyd20nkzH5RcR2DXUGrcfyCzRdQdQbglCmLc8qUHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gKRsq62RWwZyvuQF9n7kPBbr0UmaFfJr73oCx2/4Kz08aFhC+e3DMZHcGVDVE6vH2
         a9a3lQkRM+MEX43LoXWqicdZDOssTQ0BcaAuESV55tke8rRH5sJw87/hS6VlVB2gOL
         v4MSRtMxJ5FkvmDWAQEK7nQS/9uWn5xc030slumQ=
Date:   Thu, 24 Sep 2020 14:09:57 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     peterz@infradead.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        mtosatti@redhat.com, sassmann@redhat.com,
        jesse.brandeburg@intel.com, lihong.yang@intel.com,
        helgaas@kernel.org, jeffrey.t.kirsher@intel.com,
        jacob.e.keller@intel.com, jlelli@redhat.com, hch@infradead.org,
        bhelgaas@google.com, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com, thomas.lendacky@amd.com,
        jerinj@marvell.com, mathias.nyman@intel.com, jiri@nvidia.com,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org
Subject: Re: [PATCH v2 1/4] sched/isolation: API to get housekeeping online
 CPUs
Message-ID: <20200924120956.GA19346@lenoir>
References: <20200923181126.223766-1-nitesh@redhat.com>
 <20200923181126.223766-2-nitesh@redhat.com>
 <20200924084029.GC1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924084029.GC1362448@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 10:40:29AM +0200, peterz@infradead.org wrote:
> On Wed, Sep 23, 2020 at 02:11:23PM -0400, Nitesh Narayan Lal wrote:
> > Introduce a new API hk_num_online_cpus(), that can be used to
> > retrieve the number of online housekeeping CPUs that are meant to handle
> > managed IRQ jobs.
> > 
> > This API is introduced for the drivers that were previously relying only
> > on num_online_cpus() to determine the number of MSIX vectors to create.
> > In an RT environment with large isolated but fewer housekeeping CPUs this
> > was leading to a situation where an attempt to move all of the vectors
> > corresponding to isolated CPUs to housekeeping CPUs were failing due to
> > per CPU vector limit.
> > 
> > Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> > ---
> >  include/linux/sched/isolation.h | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> > index cc9f393e2a70..2e96b626e02e 100644
> > --- a/include/linux/sched/isolation.h
> > +++ b/include/linux/sched/isolation.h
> > @@ -57,4 +57,17 @@ static inline bool housekeeping_cpu(int cpu, enum hk_flags flags)
> >  	return true;
> >  }
> >  
> > +static inline unsigned int hk_num_online_cpus(void)
> 
> This breaks with the established naming of that header.

I guess we can make it housekeeping_num_online_cpus() ?
