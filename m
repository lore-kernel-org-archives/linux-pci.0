Return-Path: <SRS0=aQFd=XK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E77C4CECC
	for <linux-pci@archiver.kernel.org>; Sun, 15 Sep 2019 17:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B328216C8
	for <linux-pci@archiver.kernel.org>; Sun, 15 Sep 2019 17:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbfIORAn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 15 Sep 2019 13:00:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44412 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfIORAn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Sep 2019 13:00:43 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i9XYh-00032u-0f; Sun, 15 Sep 2019 16:39:31 +0000
Date:   Sun, 15 Sep 2019 17:39:30 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: pci: endpoint test BUG
Message-ID: <20190915163930.GX1131@ZenIV.linux.org.uk>
References: <5d9eda26-fb92-063e-f84d-7dfafe5d6b29@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d9eda26-fb92-063e-f84d-7dfafe5d6b29@infradead.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 15, 2019 at 09:34:37AM -0700, Randy Dunlap wrote:
> Kernel is 5.3-rc8 on x86_64.
> 
> Loading and removing the pci-epf-test module causes a BUG.

Ugh...  Could you try to reproduce it on earlier kernels?
