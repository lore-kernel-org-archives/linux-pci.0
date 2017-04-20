Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:37305 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943580AbdDTTMR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2017 15:12:17 -0400
Date: Thu, 20 Apr 2017 12:12:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Piotr Jaroszynski <pjaroszynski@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci-hyperv: Use only 16 bit integer for PCI domain
Message-ID: <20170420191212.GA25415@infradead.org>
References: <1492706123-22913-1-git-send-email-haiyangz@exchange.microsoft.com>
 <CAErSpo4iFS05Kk3Km54fFmpMf11XCoaPmGxSzqE3QuA5P=T6=Q@mail.gmail.com>
 <BLUPR03MB1412F7A0A693B67685D5FE9FCA1B0@BLUPR03MB1412.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BLUPR03MB1412F7A0A693B67685D5FE9FCA1B0@BLUPR03MB1412.namprd03.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 20, 2017 at 06:37:35PM +0000, Haiyang Zhang wrote:
> It's Nvidia driver.

Which of the many nvidia drivers in the tree?  Just fix it instead of
coming up with stupid workarounds like this.
