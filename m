Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BD7C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 20:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD10120854
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 20:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553544787;
	bh=qoi4DrLeJag4i+ibJhvNB/437GAaTrRKrsZpH2QftsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UfY5Jdu/T2J+kKNAHjYppC+cIA5vByrY7Jyy2jnN/UtyCw09X3Fe0W7JHAjUaF9fn
	 ULGvjkGPJmQcgM5IPLiXwLuF3I+Fsi4tBDnvViL3X3ynEVu6eXT1f67NvxIijRDSSZ
	 56aSwhE9PYVChYtsnIJqYR0CHWxO2WA7iO7umn2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfCYUNH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:13:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729283AbfCYUNH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Mar 2019 16:13:07 -0400
Received: from localhost (unknown [218.237.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4976A2087C;
        Mon, 25 Mar 2019 20:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553544786;
        bh=qoi4DrLeJag4i+ibJhvNB/437GAaTrRKrsZpH2QftsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rYDTTCG5Q6mKGHs4Mqlf1lNp6KRD9cnGaqxJpr5XLQwpWY7gboBSRQ/889KV/CbRO
         igLP1FtFy/tTJpT1u7+opXtUUfVP84110qxIj+V73OMGfYW1JfloF2BkKqab6JFfPS
         VcBx+C0Rc9FQg4HJfGLe0eLinPimDJXgpeJ3TtFc=
Date:   Tue, 26 Mar 2019 04:56:05 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/4] CPER: Remove unnecessary use of user-space types
Message-ID: <20190325195605.GA21965@kroah.com>
References: <20190325181425.247227-1-helgaas@kernel.org>
 <20190325181425.247227-5-helgaas@kernel.org>
 <20190325182608.GS251185@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325182608.GS251185@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 25, 2019 at 01:26:08PM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 25, 2019 at 01:14:25PM -0500, helgaas@kernel.org wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > "__u32" and similar types are intended for things exported to user-space,
> > including structs used in ioctls; see include/uapi/asm-generic/int-l64.h.
> > 
> > They are not needed for the CPER struct definitions, which not exported to
> > user-space and not used in ioctls.  Replace them with the typical "u32" and
> > similar types.  No functional change intended.
> > 
> > The reason for changing this is to remove the question of "why do we use
> > __u32 here instead of u32?"  We should use __u32 when there's a reason for
> > it; otherwise, we should prefer u32 for consistency.
> > 
> > Reference: Documentation/process/coding-style.rst
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > CC: Masahiro Yamada <yamada.masahiro@socionext.com>
> > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > CC: Andrew Morton <akpm@linux-foundation.org>
> 
> I cc'd you folks because you were part of this conversation:
> 
>   https://lore.kernel.org/lkml/1526350925-14922-3-git-send-email-yamada.masahiro@socionext.com/T/#u
> 
> I *think* the conclusion there was that this sort of change makes
> sense, but I want to make sure.  If it does make sense, I'm surprised
> at how much stuff in include/linux/ still uses __u32 when it doesn't
> appear to need it.

People just cut/paste and don't think about it.  We used to have a bunch
of known structures that didn't use __u32 and friends as people didn't
realize it, so it doesn't surprise me that the other way is also the
case :(

greg k-h
