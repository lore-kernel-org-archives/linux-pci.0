Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:46247 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbaBYWT0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2014 17:19:26 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so51912pad.11
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2014 14:19:26 -0800 (PST)
Date: Tue, 25 Feb 2014 14:19:22 -0800
From: Jens Axboe <axboe@kernel.dk>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	linux-pci@vger.kernel.org,
	Asai Thambi S P <asamymuthupa@micron.com>
Subject: Re: [PATCH 10/9] skd: Use pci_enable_msix_exact() instead of
 pci_enable_msix_range()
Message-ID: <20140225221922.GA10563@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140225213317.GB20652@dhcp-26-207.brq.redhat.com>
 <20140225213109.GA20652@dhcp-26-207.brq.redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 25 2014, Alexander Gordeev wrote:
> Function pci_enable_msix_exact() is a variation of
> pci_enable_msix_range() that allows a device driver
> to request a particular number of MSI-X interrupts,
> rather than any number within a specified range.

Applied 10-11, thanks.

-- 
Jens Axboe

