Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104D4C433F5
	for <linux-pci@archiver.kernel.org>; Fri,  3 Sep 2021 06:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB6F6601FA
	for <linux-pci@archiver.kernel.org>; Fri,  3 Sep 2021 06:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhICGTS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 3 Sep 2021 02:19:18 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:53149 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbhICGTR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Sep 2021 02:19:17 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id AB73830027F59;
        Fri,  3 Sep 2021 08:18:14 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9CB8F32415; Fri,  3 Sep 2021 08:18:14 +0200 (CEST)
Date:   Fri, 3 Sep 2021 08:18:14 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     linux-pci@vger.kernel.org, Nathan Rossi <nathan.rossi@digi.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Add ACS errata for Pericom PI7C9X2G404 switch
Message-ID: <20210903061814.GA15994@wunner.de>
References: <20210903034029.306816-1-nathan@nathanrossi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903034029.306816-1-nathan@nathanrossi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 03, 2021 at 03:40:29AM +0000, Nathan Rossi wrote:
> The Pericom PI7C9X2G404 PCIe switch has an errata for ACS P2P Request
> Redirect behaviour when used in the cut-through forwarding mode. The
> recommended work around for this issue is to use the switch in store and
> forward mode.
> 
> This change adds a fixup specific to this switch that when enabling the
> downstream port it checks if it has enabled ACS P2P Request Redirect,
> and if so changes the device (via the upstream port) to use the store
> and forward operating mode.

From a quick look at the datasheet, this switch seems to support
hot-plug on its Downstream Ports:

https://www.diodes.com/assets/Datasheets/PI7C9X2G404SL.pdf

I think your quirk isn't executed if a device is hotplugged to an
initially-empty Downstream Port.

Also, if a device which triggered the quirk is hot-removed and none
of its siblings uses ACS P2P Request Redirect, cut-through forwarding
isn't reinstated.

Perhaps we need additional pci_fixup ELF sections which are used on
hot-add and hot-remove?

Thanks,

Lukas
