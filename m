Return-Path: <SRS0=zOpN=BH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5FDC433E0
	for <linux-pci@archiver.kernel.org>; Tue, 28 Jul 2020 20:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C132075A
	for <linux-pci@archiver.kernel.org>; Tue, 28 Jul 2020 20:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595969420;
	bh=0RUGLkw9bXMRltztQqQdqFDeEUBYONqp+73QRhQhnGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=aBOQfFmeniXjJi0McjqidC3o1sE0gpA7lEfzWhgJFGvm3x/zMqcYZeUwwEU5sdXhH
	 3BBCGCPpkcmF7FYVuSMrGrdr43w34aGTX8bENU/EqCcBMHwMRq0nHFzmKtdfVC3tjY
	 JeqYxueuDzOTTjq17Qo+QiHK07pLqh8cLoP+RyEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgG1UuU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgG1UuT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 16:50:19 -0400
Received: from localhost (mobile-166-175-62-240.mycingular.net [166.175.62.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AD9320714;
        Tue, 28 Jul 2020 20:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595969419;
        bh=0RUGLkw9bXMRltztQqQdqFDeEUBYONqp+73QRhQhnGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fLJtpmdLbfBGpy59khpGVfrHKjrXBdgSNOk6NKiIfQkWsoFcqs+EyO+AEClAnTIev
         Tq4Hx6sV6lm44gYJrXhKjy1i6xEoLaEjuYdJ8MuqBOPJaX1weZz98Cfn5wwRyX03CE
         jPQy1wY+iB9fcYIuqDqGbH5pSjvEUoCK9WyNpdrE=
Date:   Tue, 28 Jul 2020 15:50:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci_lost_interrupt still needed?
Message-ID: <20200728205017.GA1861444@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63322b3a-3fae-2437-8359-e6f32bede850@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 28, 2020 at 10:28:08PM +0200, Heiner Kallweit wrote:
> On 28.07.2020 22:21, Bjorn Helgaas wrote:
> > On Tue, Jul 28, 2020 at 09:20:34PM +0200, Heiner Kallweit wrote:
> >> Seems that pci_lost_interrupt() has no user. Do we still need this function?
> >> Same applies for related enum pci_lost_interrupt_reason.
> > 
> > If there's no user, remove it.  Bonus points if you look up the
> > removal of the last use.
> > 
> It was introduced in 2.6.27, and apparently there never has been a single user.
> So I'll submit a patch to remove it.

Strange.  Please include the commit that added it and cc: the author.
