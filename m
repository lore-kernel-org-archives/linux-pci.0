Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0FBC63797
	for <linux-pci@archiver.kernel.org>; Mon,  6 Feb 2023 16:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjBFQ3y (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 6 Feb 2023 11:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjBFQ3t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 11:29:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B29BBAE;
        Mon,  6 Feb 2023 08:29:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5404B60F79;
        Mon,  6 Feb 2023 16:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6BEC433EF;
        Mon,  6 Feb 2023 16:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675700987;
        bh=t+/Gdj3C67a1A/yTEK03Y1DOIWZ1vJ7RZoTdIAgXbYI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UzNmkbfOh8Eu9LwKxi5rsFG9lowa8FkR3n7xYOC/g6tFeSMEc7I6CyNbWkyfHG7P5
         if+aFIFSpfi31bWqWHCcp6zm3mwpOLeRbJqiYlpUn4bscH9EtydrZvM2b0qgnjzfYk
         KUyx5981bZOj4hmx7ox3wZNAnDdQ9JRrY9CRpgZA5QCHguAMhhbH7TBj0iS8kBeO/p
         2Yep5nyenHTi38YhOUrrTyIDsCIIFUAmc9/IalMBtaPlpySd4jv/891ZFhHGB/VH4G
         52EISVkM9KYgYYUZACU31/X11k5I+6hF6xbC6wSB/bmoqNboJ8m6CORa3adR+yi+cv
         fsyoiuq4B0UaA==
Date:   Mon, 6 Feb 2023 10:29:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-next@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Update PCI git tree location for linux-next
Message-ID: <20230206162945.GA2214315@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230206075337.43b3e4da@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 06, 2023 at 07:53:37AM +1100, Stephen Rothwell wrote:
> Hi Bjorn,
> 
> On Fri, 3 Feb 2023 16:27:05 -0600 Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > Hi Stephen,
> > 
> > Can you please replace this PCI tree:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
> > 
> > with this new shared one:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> > 
> > The branch names intended for linux-next ("for-linus" and "next") are
> > staying the same.
> 
> All done.  Do you want any contacts for this tree added to my list?

Yes, please!  Can you add:

  Lorenzo Pieralisi <lpieralisi@kernel.org>
  Krzysztof Wilczyński <kw@linux.com>

Thanks,
  Bjorn
