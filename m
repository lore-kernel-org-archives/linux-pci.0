Return-Path: <SRS0=5kiX=4S=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54F2C3F2D1
	for <linux-pci@archiver.kernel.org>; Sun,  1 Mar 2020 05:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B9B21744
	for <linux-pci@archiver.kernel.org>; Sun,  1 Mar 2020 05:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgCAF2A (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 1 Mar 2020 00:28:00 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38712 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgCAF2A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Mar 2020 00:28:00 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 40AEC15BD950A;
        Sat, 29 Feb 2020 21:28:00 -0800 (PST)
Date:   Sat, 29 Feb 2020 21:27:59 -0800 (PST)
Message-Id: <20200229.212759.1192215762119235356.davem@davemloft.net>
To:     jacob.e.keller@intel.com
Cc:     linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        bhelgaas@google.com, jeffrey.t.kirsher@intel.com,
        QLogic-Storage-Upstream@cavium.com, michael.chan@broadcom.com
Subject: Re: [PATCH 1/5] pci: introduce pci_get_dsn
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200227223635.1021197-3-jacob.e.keller@intel.com>
References: <20200227223635.1021197-1-jacob.e.keller@intel.com>
        <20200227223635.1021197-3-jacob.e.keller@intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 29 Feb 2020 21:28:00 -0800 (PST)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 27 Feb 2020 14:36:31 -0800

> +int pci_get_dsn(struct pci_dev *dev, u8 dsn[])
> +{
> +	u32 dword;
> +	int pos;
> +
> +

Just one empty line after the local variable declarations please.

Thank you.
