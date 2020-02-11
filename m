Return-Path: <SRS0=Uo2K=37=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269BEC35242
	for <linux-pci@archiver.kernel.org>; Tue, 11 Feb 2020 19:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED63521734
	for <linux-pci@archiver.kernel.org>; Tue, 11 Feb 2020 19:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581450212;
	bh=7v7GNx1cE+DiOgWGjKLdqk3KxePnb6wTWsFdj/hI028=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=gdVE7vmaxWSjj3m+4ePlTjgAKkh58hoFfEpsmhxIRzQfXeucTsz0ppaGGskYzwc9O
	 cjxeKrwWSEOkXK0tL80WWK0sPk/5+iTufIgqzteSaTdzd+Sb+2TK1gylOhfB5AA9QU
	 GB/oRLFlJ+Fk2If8Bo01y2OpxIp9WXAjtP9aSO64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgBKTnb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:43:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727668AbgBKTnb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Feb 2020 14:43:31 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DE5420842;
        Tue, 11 Feb 2020 19:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581450210;
        bh=7v7GNx1cE+DiOgWGjKLdqk3KxePnb6wTWsFdj/hI028=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=g07OuRwtN188q+6kIdJmlY3ZxNcYcg64hwrbqbKPP9GTougzcbfxRQbKGikaQ3iA9
         93Cy1bquwY64nWuiuxxqCqfciUG3LXLBwu4P1J3gnARzZnh/4IrcfyU3UxUli0iADA
         XOv5VwI7Zam0ltrTOjRFrhc1PFooKuOVg0z/yb50=
Date:   Tue, 11 Feb 2020 13:43:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Yicong Yang <yangyicong@hisilicon.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        fangjian 00545541 <f.fangjian@huawei.com>
Subject: Re: PCI: bus resource allocation error
Message-ID: <20200211194328.GA230920@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB04433D05965A7D1C0E6A4BD680180@SL2P216MB0443.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 11, 2020 at 01:43:16PM +0000, Nicholas Johnson wrote:
> If the BIOS assigned the resources with different packing than what the 
> kernel would do, then the rescan may not fit into the space. You can try 
> pci=realloc,nocrs if you have not already. Your system looks like it is 
> ARM64 so you cannot use pci=nocrs, unfortunately. 

"pci=nocrs" is a poor workaround for BIOS and Linux bugs.  It is
guaranteed to break hot-add on multi-host bridge systems because _CRS
is what tells us what resources go to each bridge.  Even on
single-bridge systems "pci=nocrs" is dangerous because it may cause
Linux to assign resources that aren't routed to PCI or are being used
by other devices.

It's fine for debugging, but it's never the right long-term answer.

> The ideal situation is 
> if the kernel throws away everything the BIOS did and does everything 
> itself (assuming that this will not cause platform conflicts).

I do not think this is the ideal situation.  If the assignment done by
BIOS works, I think Linux should leave it alone.

If the BIOS assignment *doesn't* work, or if we hot-add a device and
can't assign resources to it, sure, it makes sense for Linux to try to
reassign things.  But we should not throw away the BIOS assignments as
a matter of course.

Bjorn
