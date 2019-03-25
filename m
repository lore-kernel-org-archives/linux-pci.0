Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0E9C4360F
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 22:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528C82082F
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 22:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553553239;
	bh=m90jt+o4HjTl0PCwTyC4LapMHF7uIuf0C8GFY2AVtWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ExoBDYSd+B0nlFKOrYCpoSt+avZbJM8bIRhrPWs5QZARa2hMOgr0dizBj9R9cWRP0
	 TtRTMMPp1yyncuhjRK/A/eKNn9BbkTiWZpja/5VKEeQPpjJ+CUm1K6HbE6DWmudJw7
	 qohm3lSzkq9N5oAc6njVlhWYGlSIG6axharMsgGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfCYWd6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:33:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbfCYWd6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Mar 2019 18:33:58 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC626206DF;
        Mon, 25 Mar 2019 22:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553553238;
        bh=m90jt+o4HjTl0PCwTyC4LapMHF7uIuf0C8GFY2AVtWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zcHmD+rx+syFxAl4URHS8DjMzDxNvSWG+PKaXqcNLhjBmsveOXvXd+JXtZ8stJBhm
         Y6F+/3jGxNHmrMWt2X61TR8/69f/barEfqBXzkUDSayVEa69zAeji4mdj50i7pX/ao
         OI/lQsG9Mb+b/lz0HdEZ/INj2HCU/0EX0LfZwoRY=
Date:   Mon, 25 Mar 2019 17:33:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-pci@vger.kernel.org, Austin Bolen <austin_bolen@dell.com>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>,
        Shyam Iyer <Shyam_Iyer@Dell.com>, Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH 0/2] Link bandwidth notification fixes
Message-ID: <20190325223356.GD24180@google.com>
References: <cover.1553078908.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553078908.git.lukas@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 20, 2019 at 12:05:30PM +0100, Lukas Wunner wrote:
> These two small patches fix issues that showed up on my laptop when
> testing the new bandwidth notification port service.  It may be worth
> applying them to 5.1 still.
> 
> They're intended to be applied on top of Alexandru's patch "Do not leave
> interrupt handler NULL" (or an updated version thereof which moves the
> call to pcie_update_link_speed() to pcie_bw_notification_irq() per my
> suggestion).
> 
> Thanks,
> 
> Lukas
> 
> Lukas Wunner (2):
>   PCI/LINK: bw_notification: Clear interrupt before enabling it
>   PCI/LINK: bw_notification: Deduplicate reports for multi-function
>     devices
> 
>  drivers/pci/pci.h                  | 1 +
>  drivers/pci/pcie/bw_notification.c | 4 +++-
>  drivers/pci/probe.c                | 2 +-
>  3 files changed, 5 insertions(+), 2 deletions(-)

Applied both with Alexandru's reviewed-by to for-linus for v5.1, since this
functionality is new in v5.1, thanks!
