Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C11C169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 15:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621F121855
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 15:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900010;
	bh=oP7XB0aSfjpaHlv/zTX+apPKrmsKRZu0WcKYfuIBffI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sg96dMH4yxD/zLnKifsxWiRYpAQJegH9P4xhBrzeeqAxz2b8m6myoXdQq3WM9qqnn
	 4pjcY783bzgBFzqNlVqIPwpAgOJG/k2z4SA8I/sCbBO8gTqP/hXIPAI4hANwMoq1e6
	 t8RVhBnUoKl6AwFTqxsfBGUOsgUwW01HAzwAGxa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbfBKOmM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:42:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:53828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732363AbfBKOmI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Feb 2019 09:42:08 -0500
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23A922081B;
        Mon, 11 Feb 2019 14:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896127;
        bh=oP7XB0aSfjpaHlv/zTX+apPKrmsKRZu0WcKYfuIBffI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ax+h3qR37wfOYYoRX+lxeYVg6Fp4Cov5AiClWFSZ2gmcShtv+hX/zcjyhfdhJDu46
         vtnd6EJby+abYJftmxdtv4gg6J4a/5PAXGxI89QPGSbg5AmLKAkFvv31QGJ7dhphEr
         A++NnzQyAUNjM6CFkCXzHnRLEiVw2/fc4IAbuxqw=
Date:   Mon, 11 Feb 2019 08:42:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Fixup the RTIT_BAR of Intel TH on Denverton
Message-ID: <20190211144205.GB151039@google.com>
References: <20190207133005.67328-1-alexander.shishkin@linux.intel.com>
 <20190211074141.GA49295@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211074141.GA49295@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 11, 2019 at 08:41:41AM +0100, Ingo Molnar wrote:
> 
> * Alexander Shishkin <alexander.shishkin@linux.intel.com> wrote:
> 
> > On Denverton's integration of the Intel(R) Trace Hub (for a reference
> > and overview see Documentation/trace/intel_th.txt) the reported size of
> > one of its resources (RTIT_BAR) doesn't match its actual size, which
> > leads to overlaps with other devices' resources.
> 
> Note that in the latest kernels it's Documentation/trace/intel_th.rst, 
> not .txt.

I fixed this, thanks, Ingo!
