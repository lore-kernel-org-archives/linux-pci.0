Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73544C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 21:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4023221473
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 21:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548796220;
	bh=qWO9bM+DuNPqJmOmyb7lU7cbI5oNTcA6OD6LaHnrAgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0XMjDPpTz0v51uZbXv5PST3LUUreOeDpydjVRlsTJ70F242tHeTKDHI4kLzLGgtZJ
	 39VhUUBB1r+OTlgKvFRQ0u2JY+l9VR2kUyGSltxQTjFwJjPA0RB2LN3gJo9S2EfylP
	 sSerNfyA66bYuZmBWfZ9+xNctTy/B9yt+jIxETsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbfA2VKT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:10:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbfA2VKT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 16:10:19 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6727820881;
        Tue, 29 Jan 2019 21:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548796218;
        bh=qWO9bM+DuNPqJmOmyb7lU7cbI5oNTcA6OD6LaHnrAgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ATAhGi2sNENIXqgsDaKRJ1CTeMrwZzJTV+WAOSQpInXRnOebj1m4LyjbTUAGkXpd/
         gUOn0R3XIuTDEAu1cZXROOF89hGa3Y5tMaPapjP7CMZoQPVWR4r8BYtY4mGsqAaBC8
         fHoNhv6oaaQt0knPY9UOcbzx1gj1+F33Myrqqetk=
Date:   Tue, 29 Jan 2019 15:10:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-pci@vger.kernel.org,
        x86@kernel.org, linuxarm@huawei.com,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH V2] x86: Fix an issue with invalid ACPI NUMA config
Message-ID: <20190129211015.GC91506@google.com>
References: <a5a938d3-ecc9-028a-3b28-610feda8f3f8@intel.com>
 <20181212093914.00002aed@huawei.com>
 <20181220151225.GB183878@google.com>
 <65f5bb93-b6be-d6dd-6976-e2761f6f2a7b@intel.com>
 <20181220195714.GE183878@google.com>
 <20190128112904.0000461a@huawei.com>
 <20190128231322.GA91506@google.com>
 <20190129095105.00000374@huawei.com>
 <20190129190556.GB91506@google.com>
 <20190129194534.00004087@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129194534.00004087@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 29, 2019 at 07:45:34PM +0000, Jonathan Cameron wrote:
> On Tue, 29 Jan 2019 13:05:56 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jan 29, 2019 at 09:51:05AM +0000, Jonathan Cameron wrote:

> > > However, if there is NUMA description, but with bugs then we should
> > > protect in depth.  A simple example being that we declare 2 nodes, but
> > > then use _PXM for a third. I've done that by accident and blows up
> > > in a nasty fashion (not done it for a while, but probably still true).
> > > 
> > > Given DSDT is only parsed long after SRAT we can just check on _PXM
> > > queries.  Or I suppose we could do a verification parse for all _PXM
> > > entries and put out some warnings if they don't match SRAT entries?  
> > 
> > I'm assuming the crash happens when we call kmalloc_node() with a node
> > not mentioned in SRAT.  I think that's just sub-optimal implementation
> > in kmalloc_node().
> > 
> > We *could* fail the allocation and return a NULL pointer, but I think
> > even that is excessive.  I think we should simply fall back to
> > kmalloc().  We could print a one-time warning if that's useful.
> > 
> > If kmalloc_node() for an unknown node fell back to kmalloc(), would
> > anything else be required?
> 
> It will deal with that case, but it may not be the only one.  I
> think there are interrupt related issues as well, but will have to
> check.

Sounds like a valid concern.  Also, kmalloc() in general looks like a
performance path, so maybe it would be better to address this on the
other end, i.e., by ensuring that dev->numa_node always contains
something valid for kmalloc(), interrupts, etc.

Maybe set_dev_node() could be made smarter along that line?

Bjorn
