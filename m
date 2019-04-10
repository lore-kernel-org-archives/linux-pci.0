Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84504C10F14
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 21:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDDD2082A
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 21:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554931598;
	bh=R3RcqlgtSRofjmdewpgM4gJOxlYrG/FlOB7Bm+y5fnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eug7jJFfoAL6oTiJd/N4SBnShykvapHzWUbRl2qO0uS9BnTdo8dRQIMF34sx7Gcx6
	 U2wK3Wf298uamIMuqhOFmnshgc+QhViBSzSvGEQtgajNilIMN1YwhhiFy0STFfB/8m
	 OBMIE1wqNQZMuD9qDcM+oZRHW66++0Dia+McGybg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfDJV0h (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:26:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfDJV0h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 17:26:37 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15AE920830;
        Wed, 10 Apr 2019 21:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554931596;
        bh=R3RcqlgtSRofjmdewpgM4gJOxlYrG/FlOB7Bm+y5fnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dev3GwXgxQ1Wz6pKw8sEQn2uwtKgo1mQGvqFyUHoEZFUjXkeHHvrLy6XX+5t/oOqd
         ljh52RElC4fuydK26nEkhoSUyTwQLPGiHTiDPrdKBPdJHj66BXmQDJPgzWbD0Uje9y
         Ry6OB9jn6i7COQEBmUoUjnk8BMKiF9PibJ86lTLY=
Date:   Wed, 10 Apr 2019 16:26:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nikolai Kostrigin <nickel@basealt.ru>
Cc:     Nikolai Kostrigin <nickel@altlinux.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, jroedel@suse.de,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH RESEND 1/1] PCI: Add ATS-disable quirk for AMD Radeon R7
 GPUs
Message-ID: <20190410212634.GJ256045@google.com>
References: <20190408103725.30426-1-nickel@altlinux.org>
 <20190408103725.30426-2-nickel@altlinux.org>
 <20190409215927.GC256045@google.com>
 <8b4659c8-3f49-de62-a616-a35a1d0c68b9@basealt.ru>
 <ea366789-8c9f-ecb6-15a3-9204d6826167@basealt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea366789-8c9f-ecb6-15a3-9204d6826167@basealt.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 10, 2019 at 11:03:20AM +0300, Nikolai Kostrigin wrote:
> 10.04.2019 10:26, Nikolai Kostrigin пишет:
> > Hello!
> >
> > 10.04.2019 00:59, Bjorn Helgaas пишет:
> >> [+cc Alex]
> >>
> >> This claims to be a resend, but I don't see a previous posting.
> > For some reason, unknown to me, my previous letter didn't appear
> > neither in linux-kernel@, nor in linux-pci@ mailing lists.
> I'm sorry. Now it's obvious I didn't manage to turn HTML formatting off
> before.

No worries, happens to me all the time since gmail is so unfriendly about
text-only email!

Bjorn
