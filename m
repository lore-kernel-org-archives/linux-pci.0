Return-Path: <SRS0=bOp+=MB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A25ECE566
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 22:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5D821524
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 22:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjQMoVOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5D821524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbeITDyx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:54:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731348AbeITDyx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 23:54:53 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A70E2146E;
        Wed, 19 Sep 2018 22:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537395293;
        bh=c8EHfMTLJQCM8kGKG2inf3tagRTE97KcBv94+eWhHAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fjQMoVOMsvBJS7qYQ0/9LAZzm/vMtsbvU8HVYdr1+175NNbC0qsiS2vcT8d2UYe5A
         ZQ/U89v5TserzQzxJ5KRFnJg2nAlU8BpKXQo+j4PoXSmZTDSyOgyDewauNXwaXpn0v
         rVQzpKdZByQHkX23lR2ij0qxa4a+9qMkrSaAALVI=
Date:   Wed, 19 Sep 2018 17:14:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Russell Currey <ruscur@russell.cc>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, oohall@gmail.com,
        sbobroff@linux.ibm.com
Subject: Re: [PATCH] MAINTAINERS: Add PPC contacts for PCI core error handling
Message-ID: <20180919221452.GC261184@bhelgaas-glaptop.roam.corp.google.com>
References: <153677132617.23091.12307288405707171077.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180918215854.GH13616@bhelgaas-glaptop.roam.corp.google.com>
 <1020abbb3d8a8f121d25da7327e296cfa1aaa698.camel@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1020abbb3d8a8f121d25da7327e296cfa1aaa698.camel@russell.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 19, 2018 at 11:49:26AM +1000, Russell Currey wrote:
> On Tue, 2018-09-18 at 16:58 -0500, Bjorn Helgaas wrote:
> > On Wed, Sep 12, 2018 at 11:55:26AM -0500, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > The original PCI error recovery functionality was for the powerpc-specific
> > > IBM EEH feature.  PCIe subsequently added some similar features, including
> > > AER and DPC, that can be used on any architecture.
> > > 
> > > We want the generic PCI core error handling support to work with all of
> > > these features.  Driver error recovery callbacks should be independent of
> > > which feature the platform provides.
> > > 
> > > Add the generic PCI core error recovery files to the powerpc EEH
> > > MAINTAINERS entry so the powerpc folks will be copied on changes to the
> > > generic PCI error handling strategy.
> > > 
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > I applied the following to for-linus for v4.19.  Russell, if you want
> > to be removed, let me know and I'll do that.
> 
> Oliver's email address for kernel stuff is oohall@gmail.com, I think benh has been
> CCing his IBM address.  But other than that,
> 
> Acked-by: Russell Currey <ruscur@russell.cc>

I updated Oliver's email address and added your ack, thanks!
