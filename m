Return-Path: <SRS0=j7DB=XS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA1DC3A5A6
	for <linux-pci@archiver.kernel.org>; Mon, 23 Sep 2019 08:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7772087C
	for <linux-pci@archiver.kernel.org>; Mon, 23 Sep 2019 08:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393638AbfIWI2a (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:28:30 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:37191 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392172AbfIWI23 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Sep 2019 04:28:29 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 87F293000119E;
        Mon, 23 Sep 2019 10:28:27 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5ECE832A5C; Mon, 23 Sep 2019 10:28:27 +0200 (CEST)
Date:   Mon, 23 Sep 2019 10:28:27 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Keith Busch <keith.busch@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Prevent deadlock on disconnect
Message-ID: <20190923082827.mfss42uizrjtalhb@wunner.de>
References: <20190812143133.75319-1-mika.westerberg@linux.intel.com>
 <20190812143133.75319-2-mika.westerberg@linux.intel.com>
 <20190923053403.jdjw6ed3sub6iuou@wunner.de>
 <20190923081237.GB2773@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923081237.GB2773@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 23, 2019 at 11:12:37AM +0300, Mika Westerberg wrote:
> Regarding suggestion of unbinding PCI drivers without
> pci_lock_rescan_remove() hold, I haven't looked it too closely but I
> think we need to take that lock anyway because when we are unbinding a
> hotplug driver it is supposed to remove the hierarchy below touching the
> shared structures, possibly concurrently. Unfortunately there is no
> documentation what data pci_lock_rescan_remove() actually protects so
> first one needs to understand that. I think one way to clean up this is
> to use finer grained locking (with documented lock ordering) for PCI bus
> structures that can be accessed simultaneusly by different threads. But
> that is not a simple task.

Right.  I'm (still) working on that, albeit slowly as I'm caught up with
other stuff.

Thanks,

Lukas
