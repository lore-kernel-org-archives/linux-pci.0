Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E5FC0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 08:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6845920862
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 08:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6845920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeKGRse (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 12:48:34 -0500
Received: from verein.lst.de ([213.95.11.211]:47580 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbeKGRsd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 12:48:33 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 977A067358; Wed,  7 Nov 2018 09:19:15 +0100 (CET)
Date:   Wed, 7 Nov 2018 09:19:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-nvme@lists.infradead.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, victor.chang@sk.com, james.chen@sk.com,
        Chih-Hsyuan Ho <chih.ho@canonical.com>
Subject: Re: [PATCH 1/2] pci: prevent sk hynix nvme from entering D3
Message-ID: <20181107081915.GA24841@lst.de>
References: <20181106020402.21120-1-acelan.kao@canonical.com> <20181106071011.GA23935@infradead.org> <CAFv23QmK-BPNLcy9UTuYjF=Jv_xOUFj5dTTem9r-dfijb4WQ8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFv23QmK-BPNLcy9UTuYjF=Jv_xOUFj5dTTem9r-dfijb4WQ8Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 06, 2018 at 06:11:31PM +0800, AceLan Kao wrote:
> Agree, this is not a good fix for Sk hynix nvme, so Dell is still pushing
> Sk hynix to fix it from firmware.
> But before the firmware is ready, this is still a issue that need to be fixed in
> kernel side, and the new firmware may not be applied on the old nvme
> modules.
> This list won't keep growing, and we'll keep an eye on the new firmware and
> co-work with engineers from Sky hynix to make sure this issue won't happen
> again.

We generally quirk for grave issues that make devices unusable.

To me working around a D3 mode that consumers more power than D0
does not quite fit that bill.
