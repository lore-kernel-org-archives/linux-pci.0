Return-Path: <SRS0=fb+J=4F=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F89C34021
	for <linux-pci@archiver.kernel.org>; Mon, 17 Feb 2020 14:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3909B2072C
	for <linux-pci@archiver.kernel.org>; Mon, 17 Feb 2020 14:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgBQOXg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:23:36 -0500
Received: from verein.lst.de ([213.95.11.211]:34035 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728404AbgBQOXg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Feb 2020 09:23:36 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CBC4568B05; Mon, 17 Feb 2020 15:23:33 +0100 (CET)
Date:   Mon, 17 Feb 2020 15:23:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
Message-ID: <20200217142333.GA28421@lst.de>
References: <f76af743-dcb5-f59d-b315-f2332a9dc906@ti.com> <20200203142155.GA16388@lst.de> <a5eb4f73-418a-6780-354f-175d08395e71@ti.com> <20200205074719.GA22701@lst.de> <4a8bf1d3-6f8e-d13e-eae0-4db54f5cab8c@ti.com> <20200205084844.GA23831@lst.de> <88d50d13-65c7-7ca3-59c6-56f7d66c3816@ti.com> <20200205091959.GA24413@lst.de> <9be3bed4-3804-1b3e-a91a-ed52407524ce@ti.com> <20200205160542.GA30981@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205160542.GA30981@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 05, 2020 at 05:05:42PM +0100, Christoph Hellwig wrote:
> On Wed, Feb 05, 2020 at 03:03:13PM +0530, Kishon Vijay Abraham I wrote:
> > Yes, I see the mismatch after reverting the above patches.
> 
> In which case the data mismatch is very likely due to a different root
> cause.

Did you manage to dig into this a little more?
