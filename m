Return-Path: <SRS0=55Kx=PI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037C1C43387
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 15:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDD221019
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 15:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeLaPu7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 31 Dec 2018 10:50:59 -0500
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:41172 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeLaPu7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Dec 2018 10:50:59 -0500
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Dec 2018 10:50:58 EST
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id C0641281E57; Mon, 31 Dec 2018 16:42:20 +0100 (CET)
Date:   Mon, 31 Dec 2018 16:42:20 +0100
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Linux-PCI Mailing List <linux-pci@vger.kernel.org>
Cc:     pci-admins@ucw.cz, Matthew Smith <MatthewSmith9999@hotmail.com>
Subject: RFC: Breaking changes around pci.ids
Message-ID: <mj+md-20181231.153350.78427.nikam@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello, world!\n

Over the years, several problems have accumulated around handling
of PCI vendor/device/subsystem IDs in pciutils. Some of them will
probably require breaking changes to the PCI ID database and the
pci.ids file.

Before I start changing anything, I would like to solicit comments
on what could be improved and what should be kept as-is.

The most important issues I see are:

  - Some vendors (most importantly AMD) use the same device ID
    for a family of devices, which are further differentiated
    by Revision ID. This will probably require separate names
    for revisions.

  - Motherboards frequently use the same subsystem ID for all
    on-board devices. This leads to duplication of subsystem
    entries and unnecessary effort for maintaining them.
    (Stand-alone subsystems tied to no particular device are
    already partially implemented, but they never made it to
    the web interface.)

Do you have any further ideas?

		Have a nice new year
					Martin
