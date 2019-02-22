Return-Path: <SRS0=XWMu=Q5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309AFC43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 04:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FD62086D
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 04:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550811507;
	bh=I4ShC4YCmsZFq3DMmzPL0udo2cIjoofETobgnuisngk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u6r0hPRBMVNqdZynWAtQSrWBTN5HSJ1qp905iWJhSjihQINl1hdV2XnlXsSdqDcoR
	 v3SSgAx161/xyvSmNDSkiqnhR+KPF0R0kAsoo/xcL8KPd+owqFXos0QGwByORWGaXi
	 stgeDRPIyJnUd+NhHIq8WUi7vFuOf7BOpxVeRiEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfBVE60 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 23:58:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:58336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbfBVE60 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Feb 2019 23:58:26 -0500
Received: from localhost (c-73-15-1-238.hsd1.ca.comcast.net [73.15.1.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B43420818;
        Fri, 22 Feb 2019 04:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550811505;
        bh=I4ShC4YCmsZFq3DMmzPL0udo2cIjoofETobgnuisngk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOn0PZqwrqYCN4h3qOExEXetKVw5wTRshcXmTiqF7ZPFwWw6Jq5ufDzBmCH0sjvEI
         URYayxI9NAl4qcFIEGobYDWFtVYfmCvAqtJ07kDcD6c7/yVtuoPmSQhe6S/PvjSK+3
         tndeIgVM35HqHuIa23fcFL+PzseIfBADoA0LHxio=
Date:   Thu, 21 Feb 2019 22:58:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     RussianNeuroMancer <russianneuromancer@ya.ru>,
        David Ward <david.ward@ll.mit.edu>,
        Frederick Lawler <fred@fredlawl.com>,
        Patrick Talbert <ptalbert@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] PCI/ASPM: Fix LTR issues
Message-ID: <20190222045824.GD219879@google.com>
References: <154992561743.7864.14353823538864422094.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154992561743.7864.14353823538864422094.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 11, 2019 at 04:55:33PM -0600, Bjorn Helgaas wrote:
> These are to fix a couple LTR-related issues found while investigating
> https://bugzilla.kernel.org/show_bug.cgi?id=201469
> 
> I don't claim that these fix the whole problem of that bugzilla, but I
> think it's pretty clear that these are problems we need to fix, so I want
> to give these a little more exposure.
> 
> Feedback welcome!
> 
> ---
> 
> Bjorn Helgaas (2):
>       PCI/ASPM: Use LTR if already enabled by platform
>       PCI/ASPM: Save LTR Capability for suspend/resume
> 
> 
>  drivers/pci/pci.c   |   53 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/pci/probe.c |   36 ++++++++++++++++++++++-------------
>  2 files changed, 74 insertions(+), 15 deletions(-)

I applied these to pci/aspm for v5.1.

I think Vidya is absolutely right that we also need to save/restore
the ASPM L1 Substates capability.  But I haven't had a chance to
write that up yet, and I think these two patches by themselves
are an improvement even without ASPM L1 SS.

Bjorn
