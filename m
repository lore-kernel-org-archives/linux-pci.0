Return-Path: <SRS0=tm3/=36=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B388BC352A4
	for <linux-pci@archiver.kernel.org>; Mon, 10 Feb 2020 07:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF3820733
	for <linux-pci@archiver.kernel.org>; Mon, 10 Feb 2020 07:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgBJHBY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Feb 2020 02:01:24 -0500
Received: from verein.lst.de ([213.95.11.211]:53901 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgBJHBX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Feb 2020 02:01:23 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E6E8E68C65; Mon, 10 Feb 2020 08:01:16 +0100 (CET)
Date:   Mon, 10 Feb 2020 08:01:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Pawel Baldysiak <pawel.baldysiak@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC 0/9] PCIe Hotplug Slot Emulation driver
Message-ID: <20200210070115.GA7748@lst.de>
References: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 07, 2020 at 04:59:58PM -0700, Jon Derrick wrote:
> This set adds an emulation driver for PCIe Hotplug. There may be platforms with
> specific configurations that can support hotplug but don't provide the logical
> slot hotplug hardware. For instance, the platform may use an
> electrically-tolerant interposer between the slot and the device.

The code seems like one giant hack to me.  What is the real life
use case for this?  Another Intel chipset fuckup like vmd or the ahci
remapping?

