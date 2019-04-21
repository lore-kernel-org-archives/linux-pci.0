Return-Path: <SRS0=bBXA=SX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECD0C282E3
	for <linux-pci@archiver.kernel.org>; Sun, 21 Apr 2019 14:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90C32086A
	for <linux-pci@archiver.kernel.org>; Sun, 21 Apr 2019 14:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfDUOTM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 21 Apr 2019 10:19:12 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36651 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727904AbfDUOTL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 21 Apr 2019 10:19:11 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44nBfP4KXyz9sNF; Mon, 22 Apr 2019 00:19:09 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0235854e1c25069d14512a35ea5cd05372e31fd6
X-Patchwork-Hint: ignore
In-Reply-To: <20190411042752.22039-1-lukas.bulwahn@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-pci@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: MAINTAINERS: Update remaining @linux.vnet.ibm.com addresses
Message-Id: <44nBfP4KXyz9sNF@ozlabs.org>
Date:   Mon, 22 Apr 2019 00:19:09 +1000 (AEST)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2019-04-11 at 04:27:52 UTC, Lukas Bulwahn wrote:
> Paul McKenney attempted to update all email addresses @linux.vnet.ibm.com
> to @linux.ibm.com in commit 1dfddcdb95c4
> ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com"), but
> some still remained.
> 
> We update the remaining email addresses in MAINTAINERS, hopefully finally
> catching all cases for good.
> 
> Fixes: 1dfddcdb95c4 ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0235854e1c25069d14512a35ea5cd053

cheers
