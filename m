Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51551 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752898AbcBEPwT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Feb 2016 10:52:19 -0500
Date: Fri, 5 Feb 2016 09:52:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: dra7xx driver status
Message-ID: <20160205155215.GA29306@localhost>
References: <20160204204534.GC7031@localhost>
 <56B421E1.9090005@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56B421E1.9090005@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 05, 2016 at 09:45:29AM +0530, Kishon Vijay Abraham I wrote:
> Hi Bjorn,
> 
> On Friday 05 February 2016 02:15 AM, Bjorn Helgaas wrote:
> > Hi Kishon,
> > 
> > What's the state of dra7xx?  In my tree, it's still marked with
> > CONFIG_BROKEN.  Last I heard there was a reset issue that needed to
> > be worked out, but I don't know whether that's been done yet.
> 
> I've posted pdata-quirks mechanism to do the reset (which will get PCIe
> working). Tony had some comments and we are expecting feedback from Paul. I'll
> ping him again in that thread.

Great, thanks, can you cc me as well?  I want to make sure we don't
carry dra7xx around forever marked as broken.  I'd like to either
make progress or remove it.

Bjorn
