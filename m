Return-Path: <SRS0=XWMu=Q5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF6CC43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 12:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AF32081B
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 12:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfBVMEX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:04:23 -0500
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:48318 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfBVMEX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Feb 2019 07:04:23 -0500
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Feb 2019 07:04:22 EST
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id 77814281080; Fri, 22 Feb 2019 12:58:34 +0100 (CET)
Date:   Fri, 22 Feb 2019 12:58:34 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] lspci: Decode all defined fields in the Device
 Capabilities 2 register
Message-ID: <mj+md-20190222.115820.2033.nikam@ucw.cz>
References: <20190222051326.5031-1-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222051326.5031-1-fred@fredlawl.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

> Decode all defined fields in the Device Capabilities 2 register.

Thanks, applied.

				Martin
