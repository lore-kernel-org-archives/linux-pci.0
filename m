Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:63023 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbeHPJGa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Aug 2018 05:06:30 -0400
Date: Thu, 16 Aug 2018 09:10:15 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add ACS quirk for Intel 300 series chipset
Message-ID: <20180816061015.GD2343@lahna.fi.intel.com>
References: <20180427104423.2203-1-mika.westerberg@linux.intel.com>
 <20180815152139.4e469fd4@t450s.home>
 <20180815164308.6ad5dd39@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180815164308.6ad5dd39@t450s.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 15, 2018 at 04:43:08PM -0600, Alex Williamson wrote:
> Sorry for the self follow-up, but another user pointed me to these:
> 
> https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/300-series-chipset-pch-datasheet-vol-1.pdf
> https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/300-series-c240-series-chipset-pch-spec-update.pdf
> 
> And the device IDs match and the errata is #3 in the second link, yet:
> 
> 00:1c.0 PCI bridge [0604]: Intel Corporation Device [8086:a338] (rev f0) (prog-if 00 [Normal decode])
> 00:1c.2 PCI bridge [0604]: Intel Corporation Device [8086:a33a] (rev f0) (prog-if 00 [Normal decode])
> 	Capabilities: [140 v1] Access Control Services
> 		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
> 		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
> 00:1c.5 PCI bridge [0604]: Intel Corporation Device [8086:a33d] (rev f0) (prog-if 00 [Normal decode])
> 	Capabilities: [140 v1] Access Control Services
> 		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
> 		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
> 00:1c.6 PCI bridge [0604]: Intel Corporation Device [8086:a33e] (rev f0) (prog-if 00 [Normal decode])
> 	Capabilities: [140 v1] Access Control Services
> 		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
> 		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
> 00:1c.7 PCI bridge [0604]: Intel Corporation Device [8086:a33f] (rev f0) (prog-if 00 [Normal decode])
> 	Capabilities: [140 v1] Access Control Services
> 		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
> 		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd- EgressCtrl- DirectTrans-
> 
> And the dump of config space is (1c.2):
> 
> 140: 0d 00 01 15 0f 00 0d 00 00 00 00 00 00 00 00 00
>                  ^^^^^ ^^^^^
>                   Cap   Ctl

It certainly looks like so.

> So it sure seems like the quirk shouldn't apply here.  Note that the
> user calls this a C246 chipset, though this isn't a directly addressed
> product SKU in either document.  The LPC device ID is a309, which also
> is not directly addressed by the above datasheet.  Has Intel fixed this
> in some SKUs, but not others, both using the same root port device
> IDs?  Thanks,

Let me ask around and see if someone here can explain this.
