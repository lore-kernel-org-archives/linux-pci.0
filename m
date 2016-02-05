Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48013 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750723AbcBEEPi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 23:15:38 -0500
Subject: Re: dra7xx driver status
To: Bjorn Helgaas <helgaas@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Paul Walmsley <paul@pwsan.com>
References: <20160204204534.GC7031@localhost>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <56B421E1.9090005@ti.com>
Date: Fri, 5 Feb 2016 09:45:29 +0530
MIME-Version: 1.0
In-Reply-To: <20160204204534.GC7031@localhost>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Friday 05 February 2016 02:15 AM, Bjorn Helgaas wrote:
> Hi Kishon,
> 
> What's the state of dra7xx?  In my tree, it's still marked with
> CONFIG_BROKEN.  Last I heard there was a reset issue that needed to
> be worked out, but I don't know whether that's been done yet.

I've posted pdata-quirks mechanism to do the reset (which will get PCIe
working). Tony had some comments and we are expecting feedback from Paul. I'll
ping him again in that thread.

Thanks
Kishon
> 
> Bjorn
> 
