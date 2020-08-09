Return-Path: <SRS0=cJqg=BT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6351DC433DF
	for <linux-pci@archiver.kernel.org>; Sun,  9 Aug 2020 18:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46E502065D
	for <linux-pci@archiver.kernel.org>; Sun,  9 Aug 2020 18:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHISkz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 9 Aug 2020 14:40:55 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:54051 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgHISkz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Aug 2020 14:40:55 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 3FB7630000D25;
        Sun,  9 Aug 2020 20:40:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 090DE17E55; Sun,  9 Aug 2020 20:40:52 +0200 (CEST)
Date:   Sun, 9 Aug 2020 20:40:52 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: Lockdep warning in PCI-e hotplug code
Message-ID: <20200809184052.evq42lngznypxi4f@wunner.de>
References: <b469d86a-7567-db43-23d1-e499b32cb449@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b469d86a-7567-db43-23d1-e499b32cb449@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 09, 2020 at 08:23:20PM +0200, Hans de Goede wrote:
> [  139.759255] ============================================
> [  139.759257] WARNING: possible recursive locking detected
> [  139.759259] 5.8.0+ #16 Tainted: G            E
> [  139.759260] --------------------------------------------
> [  139.759261] irq/125-pciehp/143 is trying to acquire lock:
> [  139.759263] ffff95ee9f3d1f38 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_check_presence+0x23/0x80
> [  139.759269]
>                but task is already holding lock:
> [  139.759270] ffff95eee497e738 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_ist+0xdf/0x120

False positive, the reset_lock is per-controller and multiple
instances of the lock are held concurrently because pciehp
controllers are nested with Thunderbolt.

This was already reported by Theodore T'so:
https://lore.kernel.org/linux-pci/20190402021933.GA2966@mit.edu/

So the issue is on my radar and I have some ideas how to fix it.
Let me get back to you with a solution later.  In the meantime,
thank you for the report.

Lukas
