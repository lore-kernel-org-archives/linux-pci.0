Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15533C43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 19:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D828B218A3
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 19:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbfC2TYW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:24:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:32765 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729380AbfC2TYW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Mar 2019 15:24:22 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 12:24:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,285,1549958400"; 
   d="scan'208";a="145015390"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2019 12:24:19 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h9x6w-0000KY-1W; Fri, 29 Mar 2019 21:24:18 +0200
Date:   Fri, 29 Mar 2019 21:24:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stefan =?iso-8859-1?Q?M=E4tje?= <stefan.maetje@esd.eu>
Cc:     bhelgaas@google.com, bhull@redhat.com, linux-pci@vger.kernel.org,
        rafael.j.wysocki@intel.com, ptalbert@redhat.com, lukas@wunner.de,
        fred@fredlawl.com
Subject: Re: [PATCH v3 0/3] Add a quirk to work around link retrain errata of
 Pericom PCIe brigdes
Message-ID: <20190329192418.GA9224@smile.fi.intel.com>
References: <20190329170736.1648-1-stefan.maetje@esd.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190329170736.1648-1-stefan.maetje@esd.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 29, 2019 at 06:07:33PM +0100, Stefan Mätje wrote:
> This patch provides a quirk that works around PCIe link retrain issues
> with some Pericom PCIe-to-PCI bridges.
> 
> This patches should be backported to the stable kernels ([1/3] and [2/3]). The
> problem shows up since our customers use kernels 4.10 and later.
> 
> The original patch was only for the Pericom PI7C9X111SL bridge. This is the
> only hardware I can test with.
> 
> In the meantime Brett Hull <bhull@redhat.com> brought to my attention that
> the PI7C9X110 and PI7C9X130 devices are also affected. I had access to the
> errata sheet for the PI7C9X130 PCI bridge and its has the same issue
> documented.
> 
> Therefore the patch will now handle all three mentioned devices.
> 
> I'd like to quote the errata sheet PI7C9X111SLB_errata_rev1.2_102711.pdf
> 
> > In Reverse Mode, retrain Link bit is not cleared automatically; this bit
> > needs to be cleared manually by configuration write after it is set.
> >
> > Problem:
> > In Reverse mode, after setting Retrain Link (bit 5 of register C0h), this
> > bit will stay on and PI7C9x111SL will continuously retrain until this bit
> > is cleared by another Configuration Write to register C0h.
> >
> > Workaround:
> > Issue another configuration write to clear Retrain Link bit after setting
> > this bit. No delay is required between these two configuration write.
> 
> There is no public URL to download these errata sheets. Because Pericom has
> been acquired by Diodes Inc. all information has to be downloaded from their
> web site. Following the link below one can find a datasheet and there is a
> button to request additional documents like the errata sheet for instance.
> 
> https://www.diodes.com/products/connectivity-and-timing/pcie-packet-switchbridges/pcie-pci-bridges/part/PI7C9X111SL#tab-details
> 
> I'm still using msleep(1) here because I don't want to change the timing for
> other parts of the kernel unintentionally.
> Some notes regarding this:
> 
> a) The link retraining is fast. The time measured on two different PCs and PCIe
> 	bridges is below 5µs.
> b) My slower test PC needs ~2.5µs for a checking the PCI_EXP_LNKSTA register the
> 	faster test PC needs ~1.5µs for that. So it comes the slower test PC runs
> 	through the wait loop without calling msleep(1) but the faster machine needs
> 	to wait once with msleep(1).
> 	In this case waiting with udelay(10) would perhaps be more appropriate but
> 	I didn't want to burden this pure bug fix patch with a timing change that
> 	possibly needs discussion.
> 
> History:
> 	[V3]
> 		- Split into more patches to make backporting easier.
> 		- Applied Andy Shevchenko's recommendations regarding wording and
> 			code style.
> 	[V2]
> 		https://lore.kernel.org/linux-pci/20190305173122.11875-1-stefan.maetje@esd.eu/
> 	[V1]
> 		https://lore.kernel.org/linux-pci/20181101192229.48352-2-stefan.maetje@esd.eu/
> 

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Stefan Mätje (3):
>   PCI/ASPM: Prepare stand-alone pcie_retrain_link() function
>   PCI/ASPM: Work around link retrain errata of Pericom PCIe-to-PCI
>     bridges
>   PCI/ASPM: Trivial rework wait code in pcie_retrain_link()
> 
>  drivers/pci/pcie/aspm.c | 47 ++++++++++++++++++++++++++++++++---------------
>  drivers/pci/quirks.c    | 20 ++++++++++++++++++++
>  include/linux/pci.h     |  2 ++
>  3 files changed, 54 insertions(+), 15 deletions(-)
> 
> --
> 2.15.0
> 

-- 
With Best Regards,
Andy Shevchenko


