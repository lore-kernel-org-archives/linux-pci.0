Return-Path: <SRS0=Ym/o=Y5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4247C010C0
	for <linux-pci@archiver.kernel.org>; Tue,  5 Nov 2019 11:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F3921D6C
	for <linux-pci@archiver.kernel.org>; Tue,  5 Nov 2019 11:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbfKEL2u (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Nov 2019 06:28:50 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61890 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbfKEL2t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2019 06:28:49 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 38ee2767fad8bdf3; Tue, 5 Nov 2019 12:28:47 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/5] PCI: PM: Cleanups related to power state changes
Date:   Tue, 05 Nov 2019 12:28:47 +0100
Message-ID: <3568330.mzdaIbGaoM@kreacher>
In-Reply-To: <2771503.n70vfTtcVb@kreacher>
References: <2771503.n70vfTtcVb@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday, November 5, 2019 11:11:57 AM CET Rafael J. Wysocki wrote:
> Hi,
> 
> This series rearranges some PCI power management code to make it somewhat
> easier to follow and explicitly consolidate the power-up (transitions to
> D0) code path.
> 
> It is not intended to change the functionality of the code.

This series applies on top of 5.4-rc6 with your pci/pm-2 branch from today
merged on top of it.

I guess I can make it apply on top of pci/pm-2, but there were some PCI PM
changes in 5.4-rc later than -rc1 in that area and they need to be taken
into account anyway.

Cheers!



