Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:47442 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756303AbdKQNFD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2017 08:05:03 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [91.219.245.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
        by jabberwock.ucw.cz (Postfix) with ESMTPS id 8B1F51C00B8
        for <linux-pci@vger.kernel.org>; Fri, 17 Nov 2017 13:55:59 +0100 (CET)
Date: Fri, 17 Nov 2017 13:55:59 +0100
From: Martin Mares <mj@ucw.cz>
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] configure: use simpler/more portable echo_n
Message-ID: <mj+md-20171117.125546.29516.albireo@ucw.cz>
References: <1466396498-17870-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466396498-17870-1-git-send-email-vapier@gentoo.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> The `echo -n` behavior is not in POSIX and not all shells support it.
> Use the portable `printf` func as defined by POSIX.

Thanks, applied. Sorry for the delay.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"Beware of bugs in the above code; I have only proved it correct, not tried it." -- D.E.K.
