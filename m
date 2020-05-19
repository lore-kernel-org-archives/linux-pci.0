Return-Path: <SRS0=17ui=7B=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D450EC433E1
	for <linux-pci@archiver.kernel.org>; Tue, 19 May 2020 22:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A73DA207E8
	for <linux-pci@archiver.kernel.org>; Tue, 19 May 2020 22:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgESWcn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 May 2020 18:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgESWcm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 18:32:42 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91A5C061A0E;
        Tue, 19 May 2020 15:32:42 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3A188128EDAAA;
        Tue, 19 May 2020 15:32:41 -0700 (PDT)
Date:   Tue, 19 May 2020 15:32:39 -0700 (PDT)
Message-Id: <20200519.153239.1577517664546707472.davem@davemloft.net>
To:     vaibhavgupta40@gmail.com
Cc:     hkallweit1@gmail.com, vaibhav.varodek@gmail.com,
        netdev@vger.kernel.org, helgaas@kernel.org, bhelgaas@google.com,
        bjorn@helgaas.com, linux-kernel-mentees@lists.linuxfoundation.org,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH net-next v3 0/2] realtek ethernet : use generic power
 management.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200518150214.100491-1-vaibhavgupta40@gmail.com>
References: <20200518150214.100491-1-vaibhavgupta40@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 May 2020 15:32:41 -0700 (PDT)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Date: Mon, 18 May 2020 20:32:12 +0530

> The purpose of this patch series is to remove legacy power management callbacks
> from realtek ethernet drivers.
> 
> The callbacks performing suspend() and resume() operations are still calling
> pci_save_state(), pci_set_power_state(), etc. and handling the powermanagement
> themselves, which is not recommended.
> 
> The conversion requires the removal of the those function calls and change the
> callback definition accordingly.
> 
> All Changes are compile-tested only.

Series applied, thanks.
