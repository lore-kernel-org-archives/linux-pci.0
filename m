Return-Path: <SRS0=tm3/=36=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A1DC352A3
	for <linux-pci@archiver.kernel.org>; Mon, 10 Feb 2020 16:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390FB214DB
	for <linux-pci@archiver.kernel.org>; Mon, 10 Feb 2020 16:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgBJQ7B (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:59:01 -0500
Received: from verein.lst.de ([213.95.11.211]:56630 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbgBJQ7B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Feb 2020 11:59:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 057FD68B20; Mon, 10 Feb 2020 17:58:58 +0100 (CET)
Date:   Mon, 10 Feb 2020 17:58:57 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Baldysiak, Pawel" <pawel.baldysiak@intel.com>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [RFC 0/9] PCIe Hotplug Slot Emulation driver
Message-ID: <20200210165857.GA19419@lst.de>
References: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com> <20200210070115.GA7748@lst.de> <3a4de58ad83a88f90f372e162c39d09eeebd8043.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a4de58ad83a88f90f372e162c39d09eeebd8043.camel@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 10, 2020 at 03:05:47PM +0000, Derrick, Jonathan wrote:
> > The code seems like one giant hack to me.  What is the real life
> > use case for this?  Another Intel chipset fuckup like vmd or the ahci
> > remapping?
> > 
> Exactly as the cover letter describes. An interposer being used on a
> non-hotplug slot.

That isn't a use a case, that iѕ a description of the implementation.
Why would you want this code?
