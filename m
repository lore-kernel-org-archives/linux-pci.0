Return-Path: <SRS0=+zKV=UZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC27EC48BD6
	for <linux-pci@archiver.kernel.org>; Wed, 26 Jun 2019 20:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C21216C8
	for <linux-pci@archiver.kernel.org>; Wed, 26 Jun 2019 20:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfFZUHa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:07:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40872 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfFZUHa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2019 16:07:30 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7FA4E14DB8366;
        Wed, 26 Jun 2019 13:07:29 -0700 (PDT)
Date:   Wed, 26 Jun 2019 13:07:29 -0700 (PDT)
Message-Id: <20190626.130729.2125111135503705774.davem@davemloft.net>
To:     puranjay12@gmail.com
Cc:     skhan@linuxfoundation.org, bjorn@helgaas.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] net: ethernet: atheros: atlx: Remove unused and
 private PCI definitions
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190621163921.26188-4-puranjay12@gmail.com>
References: <20190621163921.26188-1-puranjay12@gmail.com>
        <20190621163921.26188-4-puranjay12@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Jun 2019 13:07:29 -0700 (PDT)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 21 Jun 2019 22:09:21 +0530

> Remove unused private PCI definitions from skfbi.h because generic PCI
> symbols are already included from pci_regs.h.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Please also handle the PCI register bit value define duplications as well,
as pointed out by Bjorn.

Thanks.
