Return-Path: <SRS0=VYo7=45=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71FEC10DCE
	for <linux-pci@archiver.kernel.org>; Thu, 12 Mar 2020 20:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B062071C
	for <linux-pci@archiver.kernel.org>; Thu, 12 Mar 2020 20:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgCLUuE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 12 Mar 2020 16:50:04 -0400
Received: from mail.rc.ru ([151.236.222.147]:46884 "EHLO mail.rc.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgCLUuD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 16:50:03 -0400
Received: from mail.rc.ru ([2a01:7e00:e000:1bf::1]:36050)
        by mail.rc.ru with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ink@jurassic.park.msu.ru>)
        id 1jCUmF-0005Ez-P8; Thu, 12 Mar 2020 20:49:59 +0000
Date:   Thu, 12 Mar 2020 20:49:58 +0000
From:   Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Matt Turner <mattst88@gmail.com>, Yinghai Lu <yinghai@kernel.org>,
        linux-pci@vger.kernel.org,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Jay Estabrook <jay.estabrook@gmail.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Some Alphas broken by f75b99d5a77d (PCI: Enforce bus address
 limits in resource allocation)
Message-ID: <20200312204958.GA20087@mail.rc.ru>
References: <CAEdQ38HhKq9L3UF=Hapmx-BJ7eLLRfo26ZxFUFqXx+ZEY0Axxg@mail.gmail.com>
 <20200312201900.GA174932@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312201900.GA174932@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 12, 2020 at 03:19:00PM -0500, Bjorn Helgaas wrote:
> On Wed, Mar 11, 2020 at 09:28:33PM -0700, Matt Turner wrote:
> > If the PCI bits are fine with you, I assume you'd like them to go
> > through your tree, etc? I'm perfectly happy to see the alpha bits go
> > through the same tree.
> 
> Yes, I think this looks reasonable.  We should get this posted in the
> usual format (commit log, signed-off-by, etc), and then get it into
> -next to see how it flies.

Ok, I'll do it this weekend.

Ivan.
