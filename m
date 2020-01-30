Return-Path: <SRS0=PJbn=3T=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7787CC2D0DB
	for <linux-pci@archiver.kernel.org>; Thu, 30 Jan 2020 20:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA002083E
	for <linux-pci@archiver.kernel.org>; Thu, 30 Jan 2020 20:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580417734;
	bh=9DKv4XnZE1n+vDCavbocWHj6Gbmd6v+IO+oNqvfhSn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=jm9PG35E/I0cnOcfGi+LzlltHw6XBMVPbibK2y0GBY0d9GKPspn8rPEn4WdRIHZgV
	 6ldbfIRz5bLdjwMV8jIc4Y9kipSwGyhKglNG2j4Lqj7My+uXz3SYXPykVeSd/bU1DQ
	 rRnbC7i3kOF5RrVqt/74O0JB6rJycF0mvtciJJrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgA3Uzd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:55:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgA3Uzd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jan 2020 15:55:33 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D4312082E;
        Thu, 30 Jan 2020 20:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580417732;
        bh=9DKv4XnZE1n+vDCavbocWHj6Gbmd6v+IO+oNqvfhSn8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=P3T3P0fZVHS5zQS5VJ61WKl6MjkUd35tWa9j3lqZV+EfxLcOaHF7YsBfGRWzWdfxV
         lMnWj5E1Pfcwz3HYRd7IFKU68LNR3vQ1zBdwUXORjDtEi0Cf8TLbsg7rEcDmZDrFxO
         HNQ2z7nEbcVZKFdIuU1gGQgOvBZnGs85diQaeCD8=
Date:   Thu, 30 Jan 2020 14:55:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v2 0/4] PCI: Allow Thunderbolt to work with resources
 from pci=hpmemsize
Message-ID: <20200130205530.GA123630@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB04388C465B8CD6FBEB8FDA3880370@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 15, 2020 at 05:56:42PM +0000, Nicholas Johnson wrote:
> Changes:
> 	- Add Mika Westerberg's Reviewed-by: tags that he gave for 1, 2
> 	- Change commit description slightly in 1
> 	- Change commit description more substantially in 3, 4
> 	- Fix indentation in 3, oops. I thought I ran checkpatch.pl on
> 	  it, clearly I was asleep or missed that one
> 	- Update 4 to remove usage of reset_resource() which Bjorn says
> 	  he considers to be depricated.
> 
> I have not heard back from Bjorn in a while from my latest replies, so I
> am moving ahead with PATCH v2. I have tried to act on his initial
> feedback the best I can.
> 
> Apply this series after series:
> "PCI: Fix failure to assign BARs with alignment >1M with Thunderbolt"
> 
> Nicholas Johnson (4):
>   PCI: In extend_bridge_window() change available to new_size
>   PCI: Rename extend_bridge_window() to adjust_bridge_window()
>   PCI: Change extend_bridge_window() to set resource size directly
>   PCI: Allow extend_bridge_window() to shrink resource if necessary
> 
>  drivers/pci/setup-bus.c | 41 ++++++++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 21 deletions(-)

Applied to pci/resource for v5.6, thanks!
