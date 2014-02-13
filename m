Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:50609 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537AbaBMMVK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2014 07:21:10 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host controller
Date: Thu, 13 Feb 2014 13:21:04 +0100
Message-ID: <4122896.snWHKCSulY@wuerfel>
In-Reply-To: <20140213120042.GE13576@mudshark.cambridge.arm.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com> <348076699.SKFqCqFVHd@wuerfel> <20140213120042.GE13576@mudshark.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 13 February 2014 12:00:42 Will Deacon wrote:
> > With the patch I just suggested, we can simply keep
> > pci_common_init_dev() for older (non-multiplatform) controllers 
> > and not change them at all but move on to something else for
> > the interesting ones, i.e. those we want to share with arm64.
> 
> Yes, that looks sensible. An alternative is to create an hw_pci in
> pci_host_bridge_register with nr_controllers = 1 then call
> pci_common_init_dev. It would remove slightly more code, but obviously ties
> the thing to arm.

You'd still need to pass all the contents of the hw_pci struct that
get copied into pci_sys_data, so that's not different from passing
hw_pci as we do today.

	Arnd
