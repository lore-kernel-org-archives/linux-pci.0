Return-Path: <SRS0=IDzV=PY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32860C43387
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 18:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0317520866
	for <linux-pci@archiver.kernel.org>; Wed, 16 Jan 2019 18:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfAPSag (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:30:36 -0500
Received: from ale.deltatee.com ([207.54.116.67]:35230 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbfAPSag (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jan 2019 13:30:36 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gjpxR-0003Sc-G2; Wed, 16 Jan 2019 11:30:34 -0700
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Stephen Bates <sbates@raithlin.com>
References: <20190115173203.14850-1-logang@deltatee.com>
 <48a93172-25a2-d6a6-e908-7d27249f1bc2@linux.intel.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <44629b35-8315-c090-eca7-ca1e9347ba13@deltatee.com>
Date:   Wed, 16 Jan 2019 11:30:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <48a93172-25a2-d6a6-e908-7d27249f1bc2@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, bhelgaas@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, jarkko.nikula@linux.intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] PCI: fix using __initdata memory after free in
 disable_acs_redir parameter
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-01-16 2:37 a.m., Jarkko Nikula wrote:
> So this doesn't happen if you revert c5eb1190074c?

Yes, but the bug was fully mine in the disable_acs_redir code. That
patch only just made it noticable to me.

> I guess this is due dev->state_saved being true set by 
> pci_pm_runtime_suspend() -> pci_save_state() after my patch and now 
> pci_pm_runtime_resume() -> pci_restore_standard_config() -> 
> pci_restore_state() reach the pci_enable_acs(). I think this is possible 
> to trigger also before my patch if device has the runtime PM callback 
> defined?

Yes, I also think it was possible to trigger without that patch. I just
never hit it.

> I wasn't able to trigger this but I saw
> "PCI: Can't parse disable_acs_redir parameter: " followed by a few lines 
> of junk during boot when I defined pci=disable_acs_redir=0000:00:xy.z 
> which disappear after your patch.

Yes, I guess in theory, it will also depend what happens to the RAM the
parameter pointer points too. On my system it's panicing trying to
access unallocated RAM, on yours it may be reading RAM that's used for
another purpose and spewing garbage because of it.

> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Thanks!

Logan
