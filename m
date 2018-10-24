Return-Path: <SRS0=WZ4f=NE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B65ECDE46
	for <linux-pci@archiver.kernel.org>; Wed, 24 Oct 2018 16:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FCB2082F
	for <linux-pci@archiver.kernel.org>; Wed, 24 Oct 2018 16:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NocfZ3z1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FCB2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbeJYBDK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:03:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbeJYBDK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Oct 2018 21:03:10 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 602592075D;
        Wed, 24 Oct 2018 16:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540398864;
        bh=2E5mJKUwnl0a+kjgQh1Z1XJoWrklllr8UWxtWPjrd0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NocfZ3z1QgM3w5i1JSiR6O6r4yvKjRewEDYF6VZtKwoin9FwlsJ2wfPsUXln7CNni
         +yQ9/l5NkNBYK2DaigIveqEyDJCUOd+a4v83PmBhm5m/E8AIGCy8reRcWmfKaWH6Nf
         keLEF+gwL8jfZ5Gu5kYdnGvFGuEHfJVONZ4d2ZXA=
Date:   Wed, 24 Oct 2018 11:34:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Meelis Roos <mroos@linux.ee>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: HP DL585 warm boot fail (old)
Message-ID: <20181024163422.GB214775@bhelgaas-glaptop.roam.corp.google.com>
References: <alpine.LRH.2.21.1807051515260.21817@math.ut.ee>
 <CAErSpo6Fp8XpTQi7gcSQEuvpuJMYCMn5Y0cXRNvmO_opSR08HQ@mail.gmail.com>
 <b36c537a-90ee-c474-9efa-df2ead8e0376@linux.ee>
 <20181024134946.GA214775@bhelgaas-glaptop.roam.corp.google.com>
 <8a8c6cf8-dd21-87db-3498-48f1ddb8fbc1@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a8c6cf8-dd21-87db-3498-48f1ddb8fbc1@linux.ee>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 24, 2018 at 05:47:17PM +0300, Meelis Roos wrote:
> > Can you try the patch below?  This is extracted from the code here:
> > https://github.com/joyent/illumos-joyent/blob/b6a0b04d591f5b877cfe05f45e81f0e8a5cfc2b3/usr/src/uts/intel/io/pci/pci_boot.c#L1805
> 
> Thank you. Unfortunately it does not change anything noticable.

Do you see the "disabling NMI on error" message?

Can you boot with "pci=earlydump vga=0xf07" and capture the output?
Drop the "vga=0xf07" if it doesn't work or makes the screen
unreadable.

> > I'm not sure why this would be only an intermittent problem, but at
> > least we can see if this is related.
> 
> It seems 4.19 and current git are 100% reproducers so far - I have
> not managed to successfully boot either of them yet. I have seen
> 4.19-rc1 era git kernel booting at least once.
> 
> I noticed that Debian packaged 4.17 with initramfs worked fine so
> far for my test, from these I have in grub menu. My selfcompiled
> kernels do not use initramfs.

It seems like the hang happens long before we would do anything with
an initramfs, but maybe there's a timing or memory map issue.  It
seems like a hassle to pursue this angle, but if we can't figure it
out otherwise, maybe we'll have to.

Bjorn
