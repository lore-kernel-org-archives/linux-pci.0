Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.horizon.com ([71.41.210.147]:26303 "HELO ns.horizon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753850AbaEJOIQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 10 May 2014 10:08:16 -0400
Date: 10 May 2014 10:08:14 -0400
Message-ID: <20140510140814.16061.qmail@ns.horizon.com>
From: "George Spelvin" <linux@horizon.com>
To: alex.williamson@redhat.com, linux@horizon.com
Subject: Re: [PATCH v2 00/15] PCI/iommu: Fix DMA alias problems
Cc: acooks@gmail.com, bhelgaas@google.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernrl.org,
	linux-pci@vger.kernel.org
In-Reply-To: <1399727869.17639.157.camel@ul30vt.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> What's the device ID of these devices?

Oops!  It's

05:00.0 SATA controller [0106]: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller [1b4b:9172] (rev 11)
06:00.0 SATA controller [0106]: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller [1b4b:9172] (rev 11)
07:00.0 SATA controller [0106]: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller [1b4b:9172] (rev 11)

> The dma-alias branch only has the v1 patchset.  There are several more
> Marvell devices included in the quirks in the v2 set.  Please re-test
> with this code.  Thanks,

Oh, okay!  I got the patches from github because it was a lot easier
to get the whole set that way.  (I don't actually have an SMTP LKML
subscription, so I have to copy them all from a web archive, then
manually edit the headers into something RFC822-like enough for "git am"
to accept.)

Mea culpa for forgetting to check the version.  And thank you for the response!
