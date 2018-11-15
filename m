Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02336C43610
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 17:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71C3223CB
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 17:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUjbQmNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71C3223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388789AbeKPDi7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:38:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:41620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388263AbeKPDi7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 22:38:59 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A09321582;
        Thu, 15 Nov 2018 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542303015;
        bh=616VF2c0zwHLmP5zBeZAFrZeAKzD51E0R1HGIPVl/I0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JUjbQmNCO9XV/xyCWSKJmW6ndAJp8+mV55hj9MfIZ5rqtY0GqQxLLqIpQhrr1x7tL
         k13RcHWK4OsIlDvRveANohhY4BQ5moNhn9ruUEv83MqHZSRZzcVF7pe4tZmJZG8IWl
         w5Q1wHNRnyO6fl64scXvG52e7puawLu4cPSnMKdU=
Date:   Thu, 15 Nov 2018 11:30:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     AceLan Kao <acelan.kao@canonical.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pci: prevent sk hynix nvme from entering D3
Message-ID: <20181115173015.GB229449@google.com>
References: <20181106071214.12745-1-acelan.kao@canonical.com>
 <20181109002157.GK41183@google.com>
 <B21C5A96-AB21-4405-BBF1-9AD343425CA9@canonical.com>
 <20181115145809.GA207836@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115145809.GA207836@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 15, 2018 at 08:58:09AM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 15, 2018 at 03:16:29PM +0800, Kai Heng Feng wrote:
> > On Nov 9, 2018, at 08:21, Bjorn Helgaas <helgaas@kernel.org> wrote:

> > > I'm not sure we want a quirk for this at all, since as Christoph
> > > points out, it doesn't fix a functional issue as the other uses of
> > > quirk_no_ata_d3() do.
> > > 
> > > From your emails with Christoph, it sounds like this quirk is a
> > > workaround for a firmware defect.  If we *do* end up wanting a quirk,
> > > the changelog should at least mention the firmware defect and maybe
> > > check whether it has been fixed.
> > 
> > According to SK Hynix folks and new evidence on the new Intel NVMe
> > we have, this is something we are going to see more often.
> 
> Hmmm, are you suggesting that if we went this quirk route, we'd be
> updating the quirk frequently to add new devices?
> 
> I'm opposed to that as a strategy because it makes needless work.  You
> have to update the quirk, backport it to older kernels, re-release
> distro kernels, etc.

But I guess you have to do this anyway just to add the vendor/device
ID to the driver, so maybe this isn't a big deal to you.  If you can
do a quirk like this in the driver, it would be invisible to me and I
wouldn't care.  I just don't want to deal with ongoing tweaks like
this in the PCI core :)

Bjorn
