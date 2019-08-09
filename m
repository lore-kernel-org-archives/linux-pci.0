Return-Path: <SRS0=qC1o=WF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6899C31E40
	for <linux-pci@archiver.kernel.org>; Fri,  9 Aug 2019 05:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D412089E
	for <linux-pci@archiver.kernel.org>; Fri,  9 Aug 2019 05:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfHIFlY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 9 Aug 2019 01:41:24 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56274 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfHIFlX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2019 01:41:23 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F019C14470BBA;
        Thu,  8 Aug 2019 22:41:22 -0700 (PDT)
Date:   Thu, 08 Aug 2019 22:41:22 -0700 (PDT)
Message-Id: <20190808.224122.502527952774552494.davem@davemloft.net>
To:     efremov@linux.com
Cc:     bjorn.helgaas@gmail.com, dchickles@marvell.com, sburla@marvell.com,
        fmanlunas@marvell.com, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] liquidio: Use pcie_flr() instead of reimplementing it
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190808045753.5474-1-efremov@linux.com>
References: <20190808045753.5474-1-efremov@linux.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 08 Aug 2019 22:41:23 -0700 (PDT)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Denis Efremov <efremov@linux.com>
Date: Thu,  8 Aug 2019 07:57:53 +0300

> octeon_mbox_process_cmd() directly writes the PCI_EXP_DEVCTL_BCR_FLR
> bit, which bypasses timing requirements imposed by the PCIe spec.
> This patch fixes the function to use the pcie_flr() interface instead.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Applied to net-next.
