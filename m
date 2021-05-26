Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081ECC47082
	for <linux-pci@archiver.kernel.org>; Wed, 26 May 2021 18:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16A0613DC
	for <linux-pci@archiver.kernel.org>; Wed, 26 May 2021 18:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhEZSTq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 May 2021 14:19:46 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:32915 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbhEZSTp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 14:19:45 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 974E2100AFFE6;
        Wed, 26 May 2021 20:18:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6327B40898F; Wed, 26 May 2021 20:18:10 +0200 (CEST)
Date:   Wed, 26 May 2021 20:18:10 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Lambert Wang <lambert.q.wang@gmail.com>
Cc:     Krzysztof Wilczy??ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: add pci_dev_is_alive API
Message-ID: <20210526181810.GA13052@wunner.de>
References: <20210525125925.112306-1-lambert.q.wang@gmail.com>
 <20210525132035.GA66609@rocinante.localdomain>
 <CAATamay8WTiJnB=5OLYdFTqVUcRF9LarN6_1Eej3QUgFzWRnkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAATamay8WTiJnB=5OLYdFTqVUcRF9LarN6_1Eej3QUgFzWRnkA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 26, 2021 at 02:12:38PM +0800, Lambert Wang wrote:
> The user is our new PCI driver under development for WWAN devices .
> Surprise removal could happen under multiple circumstances.
> e.g. Exception, Link Failure, etc.
> 
> We wanted this API to detect surprise removal or check device recovery
> when AER and Hotplug are disabled.

You may want to take a look at pci_dev_is_disconnected().

Be aware of its limitations, which Bjorn has already pointed out
and which are discussed in more detail under the following link
in the "Surprise removal" section:

https://lwn.net/Articles/767885/

Thanks,

Lukas
