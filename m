Return-Path: <SRS0=fShW=DV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF4FC433E7
	for <linux-pci@archiver.kernel.org>; Wed, 14 Oct 2020 14:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2DA22203
	for <linux-pci@archiver.kernel.org>; Wed, 14 Oct 2020 14:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602686209;
	bh=xEKgNNTGfsVIifzkCaI0e8e0Qvi0htxbQFYzeMHtd/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=neU8bdBZqTsTU4V0DD3/+3XAXbeBm0MP0T6vk3Eb6sRCcFHbzc4+P/0T1SAkcwQZy
	 PW135mdfIMhZ1/snxQcScTR9E7SDkksx4ovPQtJzu/ZwNdse/2uzasyVvs+WASdon4
	 fq9ciipDt4zfpv8542pmGwEfQmeUNLXuNU51PBDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgJNOgt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 14 Oct 2020 10:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbgJNOgt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Oct 2020 10:36:49 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29175212CC;
        Wed, 14 Oct 2020 14:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602686208;
        bh=xEKgNNTGfsVIifzkCaI0e8e0Qvi0htxbQFYzeMHtd/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pJnFhirzzBAAnv029yYsdzKGn3f/nVB719q4H6q9ypYSug7loLSq2L5HJ0dNByu7n
         +QvG2J/FqRNvPQdPbw2JcIxBAm3q6YgGPRKsX1tTAQ5MgLLCH6VYjKMH3UX323paVX
         5Al3oYFDzeeMjvaHIZxyqd4AlesnEg9n6nw/dHDc=
Date:   Wed, 14 Oct 2020 09:36:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1 ASPM
Message-ID: <20201014143646.GA3946160@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA85sZsnMd3SdnH2bchxfkR7_Ka1wDvu9Z592uaK3FFm4rszTw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 14, 2020 at 03:33:17PM +0200, Ian Kumlien wrote:

> I'm actually starting to think that reporting what we do with the
> latency bit could
> be beneficial - i.e. report which links have their L1 disabled due to
> which device...
> 
> I also think that this could benefit debugging - I have no clue of how
> to read the lspci:s - I mean i do see some differences that might be
> the fix but nothing really specific without a proper message in
> dmesg....

Yeah, might be worth doing.  Probably pci_dbg() since I think it would
be too chatty to be enabled all the time.
