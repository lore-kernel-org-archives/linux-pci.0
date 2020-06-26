Return-Path: <SRS0=ji5Z=AH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7476CC433E0
	for <linux-pci@archiver.kernel.org>; Fri, 26 Jun 2020 20:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47BD7207FC
	for <linux-pci@archiver.kernel.org>; Fri, 26 Jun 2020 20:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgFZUYY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZUYY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jun 2020 16:24:24 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825CEC03E979;
        Fri, 26 Jun 2020 13:24:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A99DF1273A67E;
        Fri, 26 Jun 2020 13:24:23 -0700 (PDT)
Date:   Fri, 26 Jun 2020 13:24:22 -0700 (PDT)
Message-Id: <20200626.132422.894237350931462294.davem@davemloft.net>
To:     helgaas@kernel.org
Cc:     kuba@kernel.org, ayal@mellanox.com, saeedm@mellanox.com,
        mkubecek@suse.cz, netdev@vger.kernel.org, tariqt@mellanox.com,
        linux-pci@vger.kernel.org, alexander.h.duyck@linux.intel.com
Subject: Re: [net-next 10/10] net/mlx5e: Add support for PCI relaxed
 ordering
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200626201254.GA2932090@bjorn-Precision-5520>
References: <20200624102258.4410008d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <20200626201254.GA2932090@bjorn-Precision-5520>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 26 Jun 2020 13:24:24 -0700 (PDT)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Fri, 26 Jun 2020 15:12:54 -0500

> I'm totally lost, but maybe it doesn't matter because it looks like
> David has pulled this series already.

I pulled an updated version of this series with this patch removed.
