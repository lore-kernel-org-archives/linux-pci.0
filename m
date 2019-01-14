Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38F7C43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 18:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8CA204EC
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 18:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfANSFT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:05:19 -0500
Received: from verein.lst.de ([213.95.11.211]:48119 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfANSFS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Jan 2019 13:05:18 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C714868D93; Mon, 14 Jan 2019 19:05:16 +0100 (CET)
Date:   Mon, 14 Jan 2019 19:05:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        fin4478 fin4478 <fin4478@hotmail.com>,
        Dou Liyang <douliyangs@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org
Subject: Re: Please remove warnings from msi.c:1269 and blk-mq-pci.c:52
 some day
Message-ID: <20190114180516.GA8858@lst.de>
References: <AM0PR06MB3969BE1DFD53EFF6228E1A0AA1800@AM0PR06MB3969.eurprd06.prod.outlook.com> <CAErSpo5B2m406Mk6SUUcnmF31OEa8vC5YQTKB0ws3z3F5y_fEw@mail.gmail.com> <20190114170338.GA27149@localhost.localdomain> <20190114180207.GC27149@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114180207.GC27149@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 14, 2019 at 11:02:07AM -0700, Keith Busch wrote:
> User fin4478 <fin4478@hotmail.com> informs me Ming's patch above fixes
> the warnings, but responding to the mailing lists from that email account
> are blocked for "security or policy reasons" and requested I forward
> the successful test result.
> 
> Christoph, Jens: may we queue this up for -rc3?

It is in my local queue for -rc3 already.
