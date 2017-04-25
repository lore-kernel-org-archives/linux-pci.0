Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:22846 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S946181AbdDYNBM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Apr 2017 09:01:12 -0400
Date: Tue, 25 Apr 2017 16:00:19 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Piotr Jaroszynski <pjaroszynski@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci-hyperv: Use only 16 bit integer for PCI domain
Message-ID: <20170425130019.h5rwcbw5iuhwhjdk@mwanda>
References: <1492706123-22913-1-git-send-email-haiyangz@exchange.microsoft.com>
 <CAErSpo4iFS05Kk3Km54fFmpMf11XCoaPmGxSzqE3QuA5P=T6=Q@mail.gmail.com>
 <BLUPR03MB1412F7A0A693B67685D5FE9FCA1B0@BLUPR03MB1412.namprd03.prod.outlook.com>
 <8ff72ec3-d61e-07d9-8c9d-92951195b67d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8ff72ec3-d61e-07d9-8c9d-92951195b67d@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 24, 2017 at 04:06:37PM -0700, John Hubbard wrote:
> First, a tiny nit about the patch: it would be good to add "Fixing a problem
> that was introduced with commit <4a9b0933bdfc>", in the patch commit
> message.
> 

Please use the Fixes tag.

Fixes: 123456789012 ("blah blah blah")

regards,
dan carpenter
