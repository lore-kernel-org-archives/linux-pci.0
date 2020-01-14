Return-Path: <SRS0=eZdz=3D=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D98CC33CB3
	for <linux-pci@archiver.kernel.org>; Tue, 14 Jan 2020 19:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070FD24679
	for <linux-pci@archiver.kernel.org>; Tue, 14 Jan 2020 19:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579028825;
	bh=4Ev8ap2VqtQ0F1aiYKeN/13TLf0ae9A2fOJ8gxXMaJo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=wnKyT5b19XyxMpVKX0rQkNsqZLP7IQrnjlTPiw62XItvD0Od2547c5YDZIv2whcgR
	 sUdzsBSfTCEleDvO2SKWmPrP/jPMNuMzcW6qcvSwb5EVYOnWdOn1G6y2JB7YgX5+Bm
	 S7VyC3ns36WYIDrEubvhCpbKjLNl1pisHj1NeKtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgANTHE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:07:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbgANTHE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 14:07:04 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C47624672;
        Tue, 14 Jan 2020 19:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579028823;
        bh=4Ev8ap2VqtQ0F1aiYKeN/13TLf0ae9A2fOJ8gxXMaJo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BpCHhg88cdGU69qecfkv9GBRwKg/A2BWsBH+iaKgvOUKcIYqyQ0QW+BvbdULb+caa
         eVgnc3pLzstNLxtpc4GVMfT1T2hAaN5ZrZVBHCP1Gz8ecU4BxTUkFl3QXOTje1/D4O
         iEzbh0l/2midTQ6c0r3vRiQUuv+mqbhwtLLUqCek=
Date:   Tue, 14 Jan 2020 13:07:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Kelvin.Cao@microchip.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, epilmore@gigaio.com, dmeyer@gigaio.com
Subject: Re: [PATCH 03/12] PCI/switchtec: Add support for new events
Message-ID: <20200114190701.GA262120@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1ec69e8-624a-8e35-9a9e-3f8193fe9f68@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 14, 2020 at 11:21:45AM -0700, Logan Gunthorpe wrote:
> Bjorn,
> 
> On 2020-01-13 7:07 p.m., Kelvin.Cao@microchip.com wrote:
> > 'InterComm' is the spelling in the latest datasheet, it's short for "Inter Fabric Manager Communication". Thanks.
> 
> I noticed you fixed up the spelling in your branch but the IOCTL define
> is still spelled INTERCOM, which is arguably the most important seeing
> it's a userspace interface.

Thanks, I missed that one.  Fixed now.
