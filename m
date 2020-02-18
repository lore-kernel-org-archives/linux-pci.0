Return-Path: <SRS0=a8aH=4G=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BFFC34026
	for <linux-pci@archiver.kernel.org>; Tue, 18 Feb 2020 14:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFA421D56
	for <linux-pci@archiver.kernel.org>; Tue, 18 Feb 2020 14:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582035766;
	bh=LzzH1+A9k81pYpE+xt8iuTzMyoqX7NohKSq641i4n7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=mHtm/VjmOWm5wiylIcBTtJhjh2WGAuKsd86I4h4EK5NaI7QE8Or6pa2+ntUeDo/OW
	 RfEdjNeBvYvN904HYOzz2TleLWI/DUGhgt0AUmdS+6m3xDE0xikk+zfTArQ0hjmvxN
	 8ePY8UFuHI5gv6up/ICA5ipDPb+E4A6Wbf0Phj/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgBROWq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:22:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbgBROWp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Feb 2020 09:22:45 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D45C208C4;
        Tue, 18 Feb 2020 14:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582035765;
        bh=LzzH1+A9k81pYpE+xt8iuTzMyoqX7NohKSq641i4n7k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=xthntggz/VRh21wg6I4oQxiRVt8eefs49JMKKrhstEdoYAwKSMSoWb9lw0xEuAnQ9
         lQPd2zq6L9rwzq4hkSxaSOKyCTAUZOUX0z3SibON2b+hml194pt+7eBAm9/Df1ZbW3
         Xy8RYmQ6i1fjR6hZI9UeHHFu4o5mS+HD4+WMJyhA=
Date:   Tue, 18 Feb 2020 08:22:43 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Stack trace when removing Thunderbolt devices while kernel
 shutting down
Message-ID: <20200218142243.GA190321@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB0438220243C0097569D4B2DB80110@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 18, 2020 at 02:18:40PM +0000, Nicholas Johnson wrote:
> Hi Bjorn,
> 
> If I surprise remove Thunderbolt 3 devices just as the kernel is 
> shutting down, I get stack dumps, when those devices would not normally 
> cause stack dumps if the kernel were not shutting down.
> 
> Because the kernel is shutting down, it makes it difficult to capture 
> the logs without a serial console.
> 
> In your mind, is this cause for concern? There is no harm caused and the 
> kernel still shuts down. The main thing I am worried about is if this 
> means that the locking around the subsystem is not strict enough.
> 
> If you think this is worth looking into, I will try to learn about how 
> the native interrupts are handled and try to investigate, and I will 
> also try to get my serial console working again to capture the details.

Yes, I think this is worth looking into.
