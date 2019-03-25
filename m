Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF395C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 19:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C785920850
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 19:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfCYTNU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:13:20 -0400
Received: from smtprelay0245.hostedemail.com ([216.40.44.245]:33482 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729473AbfCYTNT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 15:13:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 2C55018224BA9;
        Mon, 25 Mar 2019 19:13:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stage25_1ca9ef1f74401
X-Filterd-Recvd-Size: 2376
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 19:13:16 +0000 (UTC)
Message-ID: <1542313a5e6de85b2991e63eab75f3a94a0eb30f.camel@perches.com>
Subject: Re: [PATCH 4/4] CPER: Remove unnecessary use of user-space types
From:   Joe Perches <joe@perches.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Mon, 25 Mar 2019 12:13:15 -0700
In-Reply-To: <20190325182608.GS251185@google.com>
References: <20190325181425.247227-1-helgaas@kernel.org>
         <20190325181425.247227-5-helgaas@kernel.org>
         <20190325182608.GS251185@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2019-03-25 at 13:26 -0500, Bjorn Helgaas wrote:
> On Mon, Mar 25, 2019 at 01:14:25PM -0500, helgaas@kernel.org wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > "__u32" and similar types are intended for things exported to user-space,
> > including structs used in ioctls; see include/uapi/asm-generic/int-l64.h.
> > 
> > They are not needed for the CPER struct definitions, which not exported to
> > user-space and not used in ioctls.  Replace them with the typical "u32" and
> > similar types.  No functional change intended.
[]
> I *think* the conclusion there was that this sort of change makes
> sense, but I want to make sure.  If it does make sense, I'm surprised
> at how much stuff in include/linux/ still uses __u32 when it doesn't
> appear to need it.

It is a fairly large number.

$ git grep -w -P '__[us](?:8|16|32|64)' include/linux/ | wc -l
2318

It's a rather large number of patches though to make all the
actual function definitions match the declarations that are
spread around the kernel sources as well.

Whatever struct member uses of possible temporary assignments
could also be changed to match.

Perhaps it's a lot of churn for relatively little benefit
though I do find __ prefixes unsightly when unnecessary.

A gradual conversion would eventually help isolate uapi uses
in the kernel sources.

