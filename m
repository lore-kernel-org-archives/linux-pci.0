Return-Path: <SRS0=yH3J=UY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C848BC48BD5
	for <linux-pci@archiver.kernel.org>; Tue, 25 Jun 2019 12:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6E6213F2
	for <linux-pci@archiver.kernel.org>; Tue, 25 Jun 2019 12:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbfFYMZ6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:25:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:33707 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfFYMZ6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 08:25:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5PCNXCK001877;
        Tue, 25 Jun 2019 07:23:34 -0500
Message-ID: <5c1b2d42b21be354894ea5ae6a208664ad0df9e0.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] PCI: Skip resource distribution when no hotplug
 bridges
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 25 Jun 2019 22:23:33 +1000
In-Reply-To: <20190625120455.GF2640@lahna.fi.intel.com>
References: <20190622210310.180905-1-helgaas@kernel.org>
         <20190622210310.180905-3-helgaas@kernel.org>
         <20190624112449.GJ2640@lahna.fi.intel.com>
         <8a53232416cce158fad35b781eb80b3ace3afc08.camel@kernel.crashing.org>
         <20190625100534.GZ2640@lahna.fi.intel.com>
         <c4daf43a302eeb1c507b9cf4a353200669e04ad8.camel@kernel.crashing.org>
         <20190625120455.GF2640@lahna.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2019-06-25 at 15:04 +0300, Mika Westerberg wrote:
> > What's your experience in that area ? How (well) do they handle it in
> > the boot firmware ? at least on arm64, boot firmwares are rather
> > catastrophic when it comes to PCI, and on other embedded devices they
> > are basically non-existent.
> 
> Well my experience is quite limited to recent Macs and PCs which usually
> handle the initial resource allocation just fine. In case of Thunderbolt
> some "older" PCs handle everything in firmware, even the runtime
> resource allocation via SMI handler accompanied with ACPI hotplug.

Ah so this is what Lenovo calls "Thunderbolt firmware assist" in the
BIOS ? I turned that on, it did help with Linux :)

Cheers,
Ben.


