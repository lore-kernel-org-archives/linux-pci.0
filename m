Return-Path: <SRS0=ptcC=4V=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736CFC3F2D1
	for <linux-pci@archiver.kernel.org>; Wed,  4 Mar 2020 02:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E6B208C3
	for <linux-pci@archiver.kernel.org>; Wed,  4 Mar 2020 02:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbgCDC7l (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 3 Mar 2020 21:59:41 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38534 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387532AbgCDC7k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 21:59:40 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 93D9F15AFD85F;
        Tue,  3 Mar 2020 18:59:39 -0800 (PST)
Date:   Tue, 03 Mar 2020 18:59:37 -0800 (PST)
Message-Id: <20200303.185937.1365050844508788930.davem@davemloft.net>
To:     hkallweit1@gmail.com
Cc:     bhelgaas@google.com, nic_swsd@realtek.com, mlindner@marvell.com,
        stephen@networkplumber.org, clemens@ladisch.de, perex@perex.cz,
        tiwai@suse.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 00/10] PCI: Add and use constant
 PCI_STATUS_ERROR_BITS and helper pci_status_get_and_clear_errors
From:   David Miller <davem@davemloft.net>
In-Reply-To: <adeb9e6e-9be6-317f-3fc0-a4e6e6af5f81@gmail.com>
References: <adeb9e6e-9be6-317f-3fc0-a4e6e6af5f81@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 03 Mar 2020 18:59:40 -0800 (PST)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Bjorn, please review and let me know if it is OK to merge this via the
networking tree.

Thank you.
