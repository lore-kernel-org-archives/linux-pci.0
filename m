Return-Path: <SRS0=Hy4z=SU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2F4C10F0E
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 17:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D8D206B6
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 17:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555608268;
	bh=98mzb1UFPSp9bcl6Oy6xtKDs4Kg4g5u/BA/rkRnkjcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=12zyN5pW43Mu3IOetkCJd6NOmhwHmS0ANFhKKN/S3aowdP6yZWcs26EeNTgdxqht1
	 17+Mgb6YT9maxxqBxbOmSFbNtR2VYSrzteXRc8UohZjdoqum3bW2gJ6fRuMqc7+N8N
	 iZCWQlNOmWlZnnLpAp4bqwukG4myJw5v5XNyv5Xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbfDRRY1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:24:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733067AbfDRRY1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Apr 2019 13:24:27 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05A2E20693;
        Thu, 18 Apr 2019 17:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555608267;
        bh=98mzb1UFPSp9bcl6Oy6xtKDs4Kg4g5u/BA/rkRnkjcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XdEWaFZnhagtnCnbhdmwLzVrrQoIgxc+QA2/H7EaPCDLTrfDDbsGj4NB2jpV2digw
         zvUav0PdSLj85Mi40dpFRLLrv0DLkrS3kRDAYvawWSYo//y4Rixo7pae2FzMH6Z7YF
         AIFedt02s3NAXLGL40TFic4jRjvTHaFuhd3dTHTk=
Date:   Thu, 18 Apr 2019 12:24:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, rdunlap@infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: start with a whitelist for root complexes
Message-ID: <20190418172426.GB213349@google.com>
References: <20190418115859.2394-1-christian.koenig@amd.com>
 <20190418163347.GA213349@google.com>
 <22b686f0-572b-d083-915f-5c46c89dfbc3@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22b686f0-572b-d083-915f-5c46c89dfbc3@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 18, 2019 at 10:58:55AM -0600, Logan Gunthorpe wrote:
> On 2019-04-18 10:33 a.m., Bjorn Helgaas wrote:
> > On Thu, Apr 18, 2019 at 01:58:59PM +0200, Christian König wrote:
> > > A lot of root complexes can still do P2P even when PCI devices
> > > don't share a common upstream bridge.
> > > 
> > > Start adding a whitelist and allow P2P if both participants are
> > > attached to known good root complex.
> > 
> > Is there a plan for addressing this in a generic way that doesn't
> > require an OS modification for every new "known good root complex",
> > e.g., some PCIe or ACPI spec update that allows the OS to discover
> > this?
> 
> I'm aware of work going on in the PCI SIG to address this [1].
> 
> But I expect it's going to be a long time before actual hardware advertises
> this capability to indicate support. So in the interim we either need to not
> use p2pdma on root complexes or create a white list. I'm in favour of the
> white list approach.

I agree we need a whitelist; I just want to make sure we also make
progress on some way to limit the amount of time we need to update it.

> [1] https://lore.kernel.org/linux-pci/20181210115653.0000615a@huawei.com/
