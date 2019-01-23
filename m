Return-Path: <SRS0=s0ql=P7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FACC282C0
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 19:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34612184B
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 19:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfAWTH0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:07:26 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:55091 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfAWTH0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jan 2019 14:07:26 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 416812800B1C8;
        Wed, 23 Jan 2019 20:07:24 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E5E8A22130; Wed, 23 Jan 2019 20:07:23 +0100 (CET)
Date:   Wed, 23 Jan 2019 20:07:23 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alex_Gagniuc@Dellteam.com
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        keith.busch@intel.com, Austin.Bolen@dell.com
Subject: Re: PCI: hotplug: Erroneous removal of hotplug PCI devices
Message-ID: <20190123190723.rnt5llkek5st7ddt@wunner.de>
References: <356432a0556d4da59f8ba5cf1d750019@ausx13mps317.AMER.DELL.COM>
 <20190123185420.2pennvzvkuhqfmtj@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123185420.2pennvzvkuhqfmtj@wunner.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 23, 2019 at 07:54:20PM +0100, Lukas Wunner wrote:
> So I don't see a perfect solution.  What device are we talking about
> anyway?  400 ms is a *long* time.

Also, how exactly does this issue manifest itself:  Is it just an
annoyance that the slot is brought up/down/up or does it not work
at all?

Thanks,

Lukas
