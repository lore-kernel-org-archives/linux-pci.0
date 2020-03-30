Return-Path: <SRS0=Lghl=5P=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4DAC43331
	for <linux-pci@archiver.kernel.org>; Mon, 30 Mar 2020 17:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7753B20776
	for <linux-pci@archiver.kernel.org>; Mon, 30 Mar 2020 17:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgC3Rt4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:49:56 -0400
Received: from verein.lst.de ([213.95.11.211]:34955 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbgC3Rty (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Mar 2020 13:49:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB2B468B05; Mon, 30 Mar 2020 19:49:50 +0200 (CEST)
Date:   Mon, 30 Mar 2020 19:49:50 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "helgaas@kernel.org" <helgaas@kernel.org>,
        "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "Baldysiak, Pawel" <pawel.baldysiak@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "stuart.w.hayes@gmail.com" <stuart.w.hayes@gmail.com>
Subject: Re: [RFC 0/9] PCIe Hotplug Slot Emulation driver
Message-ID: <20200330174950.GA19929@lst.de>
References: <20200328215123.GA130140@google.com> <97b916ad6ad03f39ccdf5b62fe7d7b9e10190708.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97b916ad6ad03f39ccdf5b62fe7d7b9e10190708.camel@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 30, 2020 at 05:43:33PM +0000, Derrick, Jonathan wrote:
> > There's a lot of good work in here, and I don't claim to understand
> > the use case and all the benefits.
> I've received more info that the customer use case is an AIC that
> breaks out 1-4 M.2 cards which have been made hotplug tolerant.

Which sounds completely bogus.  M.2 cards are eletrically not designed
for this at all, and neither is the AIC.  If people want to support
similar use cases they need to get them standardized by PCI SIG
and handled by hotplug capable slots.
