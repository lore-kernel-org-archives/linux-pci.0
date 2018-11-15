Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567CAC43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 14:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C60722419
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 14:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3J1IHYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C60722419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbeKPBGV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:06:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387548AbeKPBGV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 20:06:21 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36C002145D;
        Thu, 15 Nov 2018 14:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542293890;
        bh=VokujUKX9Uj+3nRbl7Hsy9LqlYu2KzRwkugAMRGo460=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q3J1IHYe7XI7Bo8+2X/StayqzKr872Hf1re+gu7WzgqxKy0TaDK236UlTheO9BTTS
         BT8Axdx7Szy6U4p7CkJrSS9SkjntnIoiT1xkacTLJdbYJfVnfagKl/VUw+X0QfNkKU
         ev288S3yq1c1OmMiZ1ZPKTE6DTgFiXs6X9izblvM=
Date:   Thu, 15 Nov 2018 08:58:09 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     AceLan Kao <acelan.kao@canonical.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pci: prevent sk hynix nvme from entering D3
Message-ID: <20181115145809.GA207836@google.com>
References: <20181106071214.12745-1-acelan.kao@canonical.com>
 <20181109002157.GK41183@google.com>
 <B21C5A96-AB21-4405-BBF1-9AD343425CA9@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B21C5A96-AB21-4405-BBF1-9AD343425CA9@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 15, 2018 at 03:16:29PM +0800, Kai Heng Feng wrote:
> > On Nov 9, 2018, at 08:21, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Nov 06, 2018 at 03:12:13PM +0800, AceLan Kao wrote:
> >> It leads to the power consumption raises to 2.2W during s2idle, while
> >> it consumes less than 1W during long idle if put SK hynix nvme to D3
> >> and then enter s2idle.
> >> From SK hynix FE, MS Windows doesn't put nvme to D3, and uses its own
> >> APST feature to do the power management.
> >> To leverage its APST feature during s2idle, we can't disable nvme
> >> device while suspending, too.
> 
> We have a new Intel NVMe [8086:f1a6] that has this “new” behavior.
> 
> > I don't know how APST works, but it sounds like you want to disable D3
> > if you're using APST.  But that's not what this patch does; this
> > disables it always.
> 
> Ok, will work on a new patch that only disables D3 when APST is enabled.

My comment was that the changelog didn't match the code.  I don't know
which one is wrong, so I wasn't trying to suggest that you change the
code.  If the code is right and the changelog is wrong, just change
the changelog.

> > I'm not sure we want a quirk for this at all, since as Christoph
> > points out, it doesn't fix a functional issue as the other uses of
> > quirk_no_ata_d3() do.
> > 
> > From your emails with Christoph, it sounds like this quirk is a
> > workaround for a firmware defect.  If we *do* end up wanting a quirk,
> > the changelog should at least mention the firmware defect and maybe
> > check whether it has been fixed.
> 
> According to SK Hynix folks and new evidence on the new Intel NVMe
> we have, this is something we are going to see more often.

Hmmm, are you suggesting that if we went this quirk route, we'd be
updating the quirk frequently to add new devices?

I'm opposed to that as a strategy because it makes needless work.  You
have to update the quirk, backport it to older kernels, re-release
distro kernels, etc.

If this situation is going to happen frequently, it would be better to
(a) fix the firmware defect (if that's what this is) or (b) pursue
some APST or other spec change so there's a generic documented way to
handle this without requiring device-specific quirks.

Bjorn
