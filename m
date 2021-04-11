Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DB0C433B4
	for <linux-pci@archiver.kernel.org>; Sun, 11 Apr 2021 09:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4114A611F0
	for <linux-pci@archiver.kernel.org>; Sun, 11 Apr 2021 09:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhDKJcT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 11 Apr 2021 05:32:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:32982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235005AbhDKJcS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 11 Apr 2021 05:32:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 012C0610E9;
        Sun, 11 Apr 2021 09:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618133522;
        bh=hHupB1eLGwjzMyzVCQyKhi+SnTMbneghjDlPD7+s43w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UOm/fIL1owj9+eeGLJOMYAAsUBLjDzNbFApOnRvT0wN1TmBCyAQLI3woIxJW7X0/I
         JbcLQ0Y6kQB5lAgcuwNO3rNfO/q6tFEtC8Y9LjYfUt3Uffk5tq+PPRNttLOdFvGD0w
         +EkUP111m/uJ0JHuFW/0XtQAzPQrmE2e76PFxNLwtJK9wgBFWHBBQ9RT74LM7OlsVi
         o13IG5iSmPBLJJdU50J7SnEzpjiANVc0suXDp8lWdkCCFQwNkDbU7c7f0ogJRSwBzg
         TgOU/brjYOLkLJYzfsWbq95hhNw7w9P1RLhOwK7hzELhoGYbGVSqCkLOt4etjsAbhI
         ayvLfTvy+B+Og==
Date:   Sun, 11 Apr 2021 12:31:58 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Raphael Norwitz <raphael.norwitz@nutanix.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ameynarkhede03@gmail.com" <ameynarkhede03@gmail.com>
Subject: Re: [PATCH v2] PCI: merge slot and bus reset implementations
Message-ID: <YHLCDkFqS66xDdvY@unreal>
References: <20210408182328.12323-1-raphael.norwitz@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408182328.12323-1-raphael.norwitz@nutanix.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 08, 2021 at 06:23:40PM +0000, Raphael Norwitz wrote:
> Slot resets are bus resets with additional logic to prevent a device
> from being removed during the reset. Currently slot and bus resets have
> separate implementations in pci.c, complicating higher level logic. As
> discussed on the mailing list, they should be combined into a generic
> function which performs an SBR. This change adds a function,
> pci_reset_bus_function(), which first attempts a slot reset and then
> attempts a bus reset if -ENOTTY is returned, such that there is now a
> single device agnostic function to perform an SBR.
> 
> This new function is also needed to add SBR reset quirks and therefore
> is exposed in pci.h.
> 
> Link: https://lkml.org/lkml/2021/3/23/911
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> ---
>  drivers/pci/pci.c   | 19 +++++++++++--------
>  include/linux/pci.h |  1 +
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
