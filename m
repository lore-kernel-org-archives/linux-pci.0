Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBD7C4707F
	for <linux-pci@archiver.kernel.org>; Thu, 27 May 2021 11:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999D461355
	for <linux-pci@archiver.kernel.org>; Thu, 27 May 2021 11:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbhE0LmG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 May 2021 07:42:06 -0400
Received: from verein.lst.de ([213.95.11.211]:38448 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233044AbhE0LmF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 07:42:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D266468AFE; Thu, 27 May 2021 13:40:29 +0200 (CEST)
Date:   Thu, 27 May 2021 13:40:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Koba Ko <koba.ko@canonical.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Henrik Juul Hansen <hjhansen2020@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use
 npss.
Message-ID: <20210527114029.GC17266@lst.de>
References: <CAAd53p6TJev=LgdvGxC92A9HOy3B6jbPLymAqeB5bDe2=5Fdsw@mail.gmail.com> <20210526150633.GA1291513@bjorn-Precision-5520> <CAAd53p7Mnv6HUv8hfjnsCpGeaSPXVAiA4D8gMxxdn6Bz8Z1fBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p7Mnv6HUv8hfjnsCpGeaSPXVAiA4D8gMxxdn6Bz8Z1fBQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 27, 2021 at 12:24:06AM +0800, Kai-Heng Feng wrote:
> Yes, that's exactly what they said. Because Windows Modern Standby
> always keep the NVMe at D0, so D3hot is untested by the vendors.

So all the problems we've deal with latetly are that platforms cut the
power off.  So it is not kept always at D0 which would be the right thing,
but moved into D3cold.

Which makes this patch to disable D3cold rather counterintuitive.
