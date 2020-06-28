Return-Path: <SRS0=zxFR=AJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F8DC433E0
	for <linux-pci@archiver.kernel.org>; Sun, 28 Jun 2020 17:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF40D20674
	for <linux-pci@archiver.kernel.org>; Sun, 28 Jun 2020 17:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgF1RCr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 28 Jun 2020 13:02:47 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:53675 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgF1RCr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Jun 2020 13:02:47 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 2061328004EA1;
        Sun, 28 Jun 2020 19:02:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C2B8A5BA090; Sun, 28 Jun 2020 19:02:41 +0200 (CEST)
Date:   Sun, 28 Jun 2020 19:02:41 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Manish Raturi <raturi.manish@gmail.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: PCie Hot Plug query
Message-ID: <20200628170241.ljqft2ri36nhsgq4@wunner.de>
References: <CAHn-FMzcKbVY1H+bn+KKhO24QP1UpafEkj0PD_eCvnZWZ=fPSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHn-FMzcKbVY1H+bn+KKhO24QP1UpafEkj0PD_eCvnZWZ=fPSw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 28, 2020 at 09:53:51PM +0530, Manish Raturi wrote:
> For the hot-plug , if we disable the "Power Control Present" bit in
> slot capabilities register for the PCIE root port , then does it
> impact any hotplug functionality?

It should only result in Slot Power not being turned on when bringing up
the slot upon a DLLSC or PDC event (and off when bringing it down).
