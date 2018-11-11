Return-Path: <SRS0=P2LY=NW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C09DC43441
	for <linux-pci@archiver.kernel.org>; Sun, 11 Nov 2018 18:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F00720871
	for <linux-pci@archiver.kernel.org>; Sun, 11 Nov 2018 18:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F00720871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbeKLEND (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 11 Nov 2018 23:13:03 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37904 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbeKLEND (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Nov 2018 23:13:03 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 704AE14931186;
        Sun, 11 Nov 2018 10:23:48 -0800 (PST)
Date:   Sun, 11 Nov 2018 10:23:47 -0800 (PST)
Message-Id: <20181111.102347.179167538258592040.davem@davemloft.net>
To:     hkallweit1@gmail.com
Cc:     bhelgaas@google.com, isdn@linux-pingi.de, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next v2] PCI: add USR vendor id and use it in r8169
 and w6692 driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <f35fbe1d-b1f3-c0f8-82d6-18b0c7cda0b4@gmail.com>
References: <9af6abf5-ba01-155f-17d1-ca4b71b74fa6@gmail.com>
        <f35fbe1d-b1f3-c0f8-82d6-18b0c7cda0b4@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 11 Nov 2018 10:23:48 -0800 (PST)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Sun, 11 Nov 2018 11:50:08 +0100

> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 69f0abe1b..1fac231fe 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2359,6 +2359,10 @@
>  
>  #define PCI_VENDOR_ID_SYNOPSYS		0x16c3
>  
> +#define PCI_VENDOR_ID_USR		0x16ec
> +#define PCI_DEVICE_ID_USR_997902	0x0116
> +#define PCI_DEVICE_ID_USR_6692		0x3409
> +
>  #define PCI_VENDOR_ID_VITESSE		0x1725
>  #define PCI_DEVICE_ID_VITESSE_VSC7174	0x7174

Generally, as I understand the policy for linux/pci_ids.h, we only add
things used in multiple locations.

So PCI_VENDOR_ID_USR is OK, since it is used in both r8169 and w6692.

But the device IDs are not, since only w6692 uses them.
