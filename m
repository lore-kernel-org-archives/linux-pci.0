Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD701C433ED
	for <linux-pci@archiver.kernel.org>; Thu, 29 Apr 2021 20:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92541613E1
	for <linux-pci@archiver.kernel.org>; Thu, 29 Apr 2021 20:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbhD2UQy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Apr 2021 16:16:54 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:42207 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbhD2UQy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Apr 2021 16:16:54 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id F20EA2801C2B0;
        Thu, 29 Apr 2021 22:16:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E5C243ABB22; Thu, 29 Apr 2021 22:16:03 +0200 (CEST)
Date:   Thu, 29 Apr 2021 22:16:03 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ethan Zhao <haifeng.zhao@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI: pciehp: Ignore Link Down/Up caused by DPC
Message-ID: <20210429201603.GA18851@wunner.de>
References: <b70e19324bbdded90b728a5687aa78dc17c20306.1616921228.git.lukas@wunner.de>
 <20210429193648.GA26517@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429193648.GA26517@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 30, 2021 at 04:36:48AM +0900, Keith Busch wrote:
> On Sun, Mar 28, 2021 at 10:52:00AM +0200, Lukas Wunner wrote:
> > Downstream Port Containment (PCIe Base Spec, sec. 6.2.10) disables the
> > link upon an error and attempts to re-enable it when instructed by the
> > DPC driver.
> > 
> > A slot which is both DPC- and hotplug-capable is currently brought down
> > by pciehp once DPC is triggered (due to the link change) and brought up
> > on successful recovery.  That's undesirable, the slot should remain up
> > so that the hotplugged device remains bound to its driver.  DPC notifies
> > the driver of the error and of successful recovery in pcie_do_recovery()
> > and the driver may then restore the device to working state.
> 
> This is a bit strange. The PCIe spec says DPC capable ports suppress
> Link Down events specifically because it will confuse hot-plug
> surprise ports if you don't do that. I'm specifically looking at the
> "Implementation Note" in PCIe Base Spec 5.0 section 6.10.2.4.

I suppose you mean 6.2.10.4?

   "Similarly, it is recommended that a Port that supports DPC not
    Set the Hot-Plug Surprise bit in the Slot Capabilities register.
    Having this bit Set blocks the reporting of Surprise Down errors,
    preventing DPC from being triggered by this important error,
    greatly reducing the benefit of DPC."

The way I understand this, DPC isn't triggered on Surprise Down if
the port supports surprise removal.

However what this patch aims to fix is the Link Down seen by pciehp
which is caused by DPC containing (other) errors.

It seems despite the above-quoted recommendation against it, vendors
do ship ports which support both DPC and surprise removal.


> Do these ports have out-of-band Precense Detect capabilities? If so, we
> can ignore Link Down events on DPC capable ports as long as PCIe Slot
> Status PDC isn't set.

Hm, and what about ports with in-band Presence Detect?

Thanks,

Lukas
