Return-Path: <SRS0=UeAH=N3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65746C43441
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 07:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27ACD224E0
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 07:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27ACD224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeKPSAZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:00:25 -0500
Received: from verein.lst.de ([213.95.11.211]:47678 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbeKPSAZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Nov 2018 13:00:25 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9623968D60; Fri, 16 Nov 2018 08:49:10 +0100 (CET)
Date:   Fri, 16 Nov 2018 08:49:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai Heng Feng <kai.heng.feng@canonical.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pci: prevent sk hynix nvme from entering D3
Message-ID: <20181116074910.GA13556@lst.de>
References: <20181106071214.12745-1-acelan.kao@canonical.com> <20181109002157.GK41183@google.com> <B21C5A96-AB21-4405-BBF1-9AD343425CA9@canonical.com> <20181115145809.GA207836@google.com> <20181115173015.GB229449@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115173015.GB229449@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 15, 2018 at 11:30:15AM -0600, Bjorn Helgaas wrote:
> 
> But I guess you have to do this anyway just to add the vendor/device
> ID to the driver, so maybe this isn't a big deal to you.  If you can
> do a quirk like this in the driver, it would be invisible to me and I
> wouldn't care.  I just don't want to deal with ongoing tweaks like
> this in the PCI core :)

No, NVMe is a spec with a class code, and a specification that is
vendor independent.  NVMe devices declare invididual features based
on common fields.

APST is an optional feature with all kinds of parameters, but there
is absolutely no language that a host should not put the device into
D3 mode if APST is supported anywhere in the NVMe spec, and such
behavior is also rather counter intuitive.  If SK Hynix thinks this
is sensible behavior they should bring it up in the NVMe technical
working group.  I've pinged a contact there to see what this whole
story is about.
