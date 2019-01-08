Return-Path: <SRS0=3dpc=PQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56188C43387
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 21:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE4F20675
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 21:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfAHVBB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:01:01 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:54761 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbfAHVBB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jan 2019 16:01:01 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id A7B14101955BF;
        Tue,  8 Jan 2019 22:00:58 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 24C92AEDE; Tue,  8 Jan 2019 22:00:58 +0100 (CET)
Date:   Tue, 8 Jan 2019 22:00:58 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Peter Wu <peter@lekensteyn.nl>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Block power management of certain ports with
 slot implemented bit set
Message-ID: <20190108210058.jzou5usx2h35uxrg@wunner.de>
References: <20190107130152.83350-1-mika.westerberg@linux.intel.com>
 <CAJZ5v0iJfUK6FDQ=W6=2+wEG2GHKDT5r_aoRapUn4Qi0FTjaGg@mail.gmail.com>
 <20190108093507.GX2469@lahna.fi.intel.com>
 <20190108101600.5qbeks5ux6wgpbpy@wunner.de>
 <20190108105824.GC23218@al>
 <20190108124559.GZ2469@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108124559.GZ2469@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 08, 2019 at 02:45:59PM +0200, Mika Westerberg wrote:
> I guess that leaves us the blacklist. I can re-send it rebased on top of
> v5.0-rc1 if there are no objections.

Please constrain either the blacklist entry for the Gigabyte mainboard
or the blacklist check itself to x86 using IS_ENABLED() or #ifdef to
avoid code bloat on other arches.

Thanks,

Lukas
