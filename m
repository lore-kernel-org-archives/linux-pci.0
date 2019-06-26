Return-Path: <SRS0=+zKV=UZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D88C48BD3
	for <linux-pci@archiver.kernel.org>; Wed, 26 Jun 2019 20:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEB6208E3
	for <linux-pci@archiver.kernel.org>; Wed, 26 Jun 2019 20:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfFZUDu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:03:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40778 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfFZUDt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2019 16:03:49 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DA22C14DB71D4;
        Wed, 26 Jun 2019 13:03:48 -0700 (PDT)
Date:   Wed, 26 Jun 2019 13:03:48 -0700 (PDT)
Message-Id: <20190626.130348.743645536748522991.davem@davemloft.net>
To:     skhan@linuxfoundation.org
Cc:     gnomes@lxorguk.ukuu.org.uk, puranjay12@gmail.com,
        bjorn@helgaas.com, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/3] net: fddi: skfp: Use PCI generic definitions
 instead of private duplicates
From:   David Miller <davem@davemloft.net>
In-Reply-To: <5f04f52d-8911-4db9-4321-00334d357d54@linuxfoundation.org>
References: <20190621094607.15011-1-puranjay12@gmail.com>
        <20190621162024.53620dd9@alans-desktop>
        <5f04f52d-8911-4db9-4321-00334d357d54@linuxfoundation.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Jun 2019 13:03:49 -0700 (PDT)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Shuah Khan <skhan@linuxfoundation.org>
Date: Fri, 21 Jun 2019 10:36:02 -0600

> Stephen Hemminger is suggesting removal as well. Makes sense to me.
 ...
> What would you recommend the next steps are? Would like driver
> removed?

If you hadn't proposed the cleanups nobody would have said to remove
this driver.  Really if someone wants to go through the tree and
send removal patches for seemingly really unused drivers, that is
a separate piece of work unrelated to your cleanup.

While something still is in the tree we should clean it up from
stuff like this.

Therefore, I'll be applying v5 of your changes, thanks.
