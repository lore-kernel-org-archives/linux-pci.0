Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3042C433B4
	for <linux-pci@archiver.kernel.org>; Fri, 14 May 2021 13:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4CE061451
	for <linux-pci@archiver.kernel.org>; Fri, 14 May 2021 13:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhENNJ6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 May 2021 09:09:58 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:41785 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhENNJ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 09:09:57 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 53D60100AF508;
        Fri, 14 May 2021 15:08:45 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 20B3A6F8BB; Fri, 14 May 2021 15:08:45 +0200 (CEST)
Date:   Fri, 14 May 2021 15:08:45 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Krzysztof Wilczy??ski <kw@linux.com>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/portdrv: Use link bandwidth notification
 capability bit
Message-ID: <20210514130845.GA26314@wunner.de>
References: <20210512213314.7778-1-stuart.w.hayes@gmail.com>
 <20210514130303.GD9537@rocinante.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514130303.GD9537@rocinante.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 14, 2021 at 03:03:03PM +0200, Krzysztof Wilczy??ski wrote:
> > The pcieport driver can fail to attach to a downstream port that doesn't
> > support bandwidth notification.  This can happen when, in
> > pcie_port_device_register(), pci_init_service_irqs() tries (and fails) to
> > set up a bandwidth notification IRQ for a device that doesn't support it.
> > 
> > This patch changes get_port_device_capability() to look at the link
> > bandwidth notification capability bit in the link capabilities register of
> > the port, instead of assuming that all downstream ports have that
> > capability.
> 
> I was wondering - is this fix connected to an issue filled in Bugzilla
> or does it fix a known commit that introduced this problem?  Basically,
> I am trying to see whether a "Fixes:" would be in order.

The fix is for a driver which has been removed from the tree (for now),
including in stable kernels.  The fix will prevent an issue that will
occur once the driver is re-introduced (once we've found a way to
overcome the issues that led to its removal).  A Fixes tag is thus
uncalled for.

Thanks,

Lukas
