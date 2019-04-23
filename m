Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CC8C10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 17:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510DB214AE
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 17:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556039452;
	bh=/yDo69GNbQIHWXaiPgSdIL4wlfGzv/OoO6sxsg/wy6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aTbhRQ9y9dGAIP0hZo3AculrN2IJW2Ovg5vy3jKhLFRDo2wu3HOz8GCgP3oCoSAeF
	 0Ahxp6optfXj56NHMx8pHcWa4b6a06lVl3jJuV2H2OoCC3z5hLmrvT61tVyMdGQiu3
	 wOW4lDR6qCX4bl4y/jSAI8xYNiDFKWQDRGS4Qcxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfDWRKv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbfDWRKv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Apr 2019 13:10:51 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA4FC208E4;
        Tue, 23 Apr 2019 17:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556039451;
        bh=/yDo69GNbQIHWXaiPgSdIL4wlfGzv/OoO6sxsg/wy6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tRNc2Zi8ORYU3Vca13rkylA6HheK2cWuzA+n31+v76NaWYjYKU37oK01lvxIUPApu
         UzyHqTeA0sR/QA9uelDLUmIX+5lo8eLrdO1hhZd2XytlOtuWSBGWAKsOG+mhaktXUM
         SfItgnwVhL2Q/rR//dAHWKptLZUOEeukfrvpHcws=
Date:   Tue, 23 Apr 2019 12:10:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex G <mr.nuke.me@gmail.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, austin_bolen@dell.com,
        alex_gagniuc@dellteam.com, keith.busch@intel.com,
        Shyam_Iyer@Dell.com, lukas@wunner.de, okaya@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/LINK: Account for BW notification in vector
 calculation
Message-ID: <20190423171050.GA37199@google.com>
References: <155597243666.19387.1205950870601742062.stgit@gimli.home>
 <d1126250-14e0-192c-f219-f143f62c9cdd@gmail.com>
 <20190422183347.51ba522c@x1.home>
 <84300da7-9bbd-4f32-c7fa-23724db60b88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84300da7-9bbd-4f32-c7fa-23724db60b88@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 23, 2019 at 09:33:53AM -0500, Alex G wrote:
> On 4/22/19 7:33 PM, Alex Williamson wrote:
> > There is nothing wrong happening here that needs to fill logs.  I
> > thought maybe if I enabled notification of autonomous bandwidth
> > changes that it might categorize these as something we could
> > ignore, but it doesn't.  How can we identify only cases where this
> > is an erroneous/noteworthy situation?  Thanks,
> 
> You don't. Ethernet doesn't. USB doesn't. This logging behavior is
> consistent with every other subsystem that deals with multi-speed links.

Can you point me to the logging in these other subsystems so I can
learn more about how they deal with this?

I agree that emitting log messages for normal and expected events will
lead to user confusion and we need to do something.

e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth
notification") was merged in v5.1-rc1, so we still have (a little)
time to figure this out before v5.1.

Bjorn
