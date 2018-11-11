Return-Path: <SRS0=P2LY=NW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96300C43441
	for <linux-pci@archiver.kernel.org>; Sun, 11 Nov 2018 22:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D61921104
	for <linux-pci@archiver.kernel.org>; Sun, 11 Nov 2018 22:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D61921104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbeKLHuL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Nov 2018 02:50:11 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40696 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbeKLHuK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Nov 2018 02:50:10 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0F094141E140B;
        Sun, 11 Nov 2018 14:00:20 -0800 (PST)
Date:   Sun, 11 Nov 2018 14:00:19 -0800 (PST)
Message-Id: <20181111.140019.2064956560683911866.davem@davemloft.net>
To:     hkallweit1@gmail.com
Cc:     bhelgaas@google.com, isdn@linux-pingi.de, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next v3] PCI: add USR vendor id and use it in r8169
 and w6692 driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <a1c56e9d-b427-af43-840e-c527c79feadc@gmail.com>
References: <9af6abf5-ba01-155f-17d1-ca4b71b74fa6@gmail.com>
        <a1c56e9d-b427-af43-840e-c527c79feadc@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 11 Nov 2018 14:00:20 -0800 (PST)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Sun, 11 Nov 2018 20:31:21 +0100

> The PCI vendor id of U.S. Robotics isn't defined in pci_ids.h so far,
> only ISDN driver w6692 has a private definition. Move the definition
> to pci_ids.h and use it in the r8169 driver too.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - The original patch caused a build failure in w6692 driver because
>   it broke the private PCI device id definition.
> v3:
> - Don't move device id's to pci_ids.h because they are used in
>   one module only respectively.

Yep, that's better.

Applied, thanks!
