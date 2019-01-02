Return-Path: <SRS0=YnKd=PK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9AEC43387
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 01:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECABB21871
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 01:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546391700;
	bh=zZnndJDsLws64tetl6IqT7F3YlAXOLO3e8DUus80V/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kXAlRDWso2TJsZUbdUHPcwvqq4CMpLbUDwXA3pYFteM/3i4LYVlJPIA0zXITrpEf5
	 6lR6xUyO4yCBMLV6N+Rsl5QRIVhM1pgrB7+BLMR+6w2pruRyCBa+YF7txXt08okR+r
	 70knQPrYjWS6kil779aQD8LglTjwM08IASSDE3G0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfABBO7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 1 Jan 2019 20:14:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfABBO7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Jan 2019 20:14:59 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9C022080A;
        Wed,  2 Jan 2019 01:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546391698;
        bh=zZnndJDsLws64tetl6IqT7F3YlAXOLO3e8DUus80V/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DzydY/U46KF/RHCKgNBQpb9GTgUOHniD7ICnO+H3/fFiZb/vRjZCuWl9dqhgD+9Ib
         cgZKy4CZPlbBBtMqQR6O2VE/XtVBcxIsqp+BSfeN1frgk8kC6ium+Jq7MorEV/0HY+
         ZhU1QC2JB3BtACLLLM3rT2zJcCSXIW5bOrF8fjpI=
Date:   Tue, 1 Jan 2019 19:14:54 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sebastian Ott <sebott@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-pci@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] PCI/IOV: provide flag to skip VF scanning
Message-ID: <20190102011453.GA126384@google.com>
References: <20181217173546.GA4106@infradead.org>
 <20181218101650.23089-1-sebott@linux.ibm.com>
 <20181220200750.GF183878@google.com>
 <alpine.LFD.2.21.1812211514570.22598@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1812211514570.22598@schleppi>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 21, 2018 at 03:19:49PM +0100, Sebastian Ott wrote:
> Hello Bjorn,
> 
> On Thu, 20 Dec 2018, Bjorn Helgaas wrote:
> > I think the strategy is fine, but can you restructure the patches
> > like this:
> > 
> >   1) Factor out sriov_add_vfs() and sriov_dev_vfs().  This makes no
> >      functional change at all.
> > 
> >   2) Add dev->no_vf_scan, set it in the s390 pcibios_add_device(), and
> >      test it in sriov_add_vfs(), and sriov_del_vfs().
> > 
> > I think both pieces will be easier to review that way.
> 
> Done. I took the liberty to add Christoph's R-b to the first two patches
> since it's just a split of the patch he gave the R-b to.

Thanks.

It's really way too late to do this, but they're pretty trivial, and
I've been out longer than expected for vacation and illness, so I applied
these to pci/virtualization for v4.21.

Bjorn
