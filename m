Return-Path: <SRS0=gM90=7H=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDA2C433DF
	for <linux-pci@archiver.kernel.org>; Mon, 25 May 2020 10:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C547920812
	for <linux-pci@archiver.kernel.org>; Mon, 25 May 2020 10:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389848AbgEYKro (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 May 2020 06:47:44 -0400
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:50628 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389484AbgEYKro (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 May 2020 06:47:44 -0400
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 May 2020 06:47:43 EDT
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id 68D062808B4; Mon, 25 May 2020 12:37:59 +0200 (CEST)
Date:   Mon, 25 May 2020 12:37:59 +0200
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Sean V Kelley <sean.v.kelley@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        f.fangjian@huawei.com, huangdaode@hisilicon.com
Subject: Re: [PATCH v7 0/2] pciutils: Add basic decode support for CXL DVSEC
Message-ID: <mj+md-20200525.103642.86045.nikam@ucw.cz>
References: <20200511174618.10589-1-sean.v.kelley@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511174618.10589-1-sean.v.kelley@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

I applied your patch (by mistake, I applied v6 first, so the vendor ID change
is a separate commit).

I have cleaned up the code a bit, so that the DVSEC header is not parsed
multiple times.

Could you also update the cap-dvsec-cxl test to match the new vendor ID?

			Have a nice day
						Martin
