Return-Path: <SRS0=seBN=3Z=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED14DC35247
	for <linux-pci@archiver.kernel.org>; Wed,  5 Feb 2020 16:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C3520702
	for <linux-pci@archiver.kernel.org>; Wed,  5 Feb 2020 16:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgBEQFp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:05:45 -0500
Received: from verein.lst.de ([213.95.11.211]:37822 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgBEQFp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Feb 2020 11:05:45 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2499868B05; Wed,  5 Feb 2020 17:05:43 +0100 (CET)
Date:   Wed, 5 Feb 2020 17:05:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
Message-ID: <20200205160542.GA30981@lst.de>
References: <20200130164235.GA6705@lst.de> <f76af743-dcb5-f59d-b315-f2332a9dc906@ti.com> <20200203142155.GA16388@lst.de> <a5eb4f73-418a-6780-354f-175d08395e71@ti.com> <20200205074719.GA22701@lst.de> <4a8bf1d3-6f8e-d13e-eae0-4db54f5cab8c@ti.com> <20200205084844.GA23831@lst.de> <88d50d13-65c7-7ca3-59c6-56f7d66c3816@ti.com> <20200205091959.GA24413@lst.de> <9be3bed4-3804-1b3e-a91a-ed52407524ce@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9be3bed4-3804-1b3e-a91a-ed52407524ce@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 05, 2020 at 03:03:13PM +0530, Kishon Vijay Abraham I wrote:
> Yes, I see the mismatch after reverting the above patches.

In which case the data mismatch is very likely due to a different root
cause.
