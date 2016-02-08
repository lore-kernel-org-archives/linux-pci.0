Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:59587 "EHLO mail5.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754814AbcBHPwA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Feb 2016 10:52:00 -0500
Date: Mon, 8 Feb 2016 10:51:41 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ley Foon Tan <lftan@altera.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	<linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 5/5] drivers/pci: make most of the PCI_DW drivers modular
Message-ID: <20160208155141.GT23093@windriver.com>
References: <1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com>
 <1454889644-27830-6-git-send-email-paul.gortmaker@windriver.com>
 <2730150.DUniNa63fK@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <2730150.DUniNa63fK@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Re: [PATCH 5/5] drivers/pci: make most of the PCI_DW drivers modular] On 08/02/2016 (Mon 11:00) Arnd Bergmann wrote:

> On Sunday 07 February 2016 19:00:44 Paul Gortmaker wrote:
> > We've exported the symbols that we know these specific drivers
> > will need as tristate, so now we can make the conversion from
> > bool to tristate w/o concern for build regressions.
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Ley Foon Tan <lftan@altera.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-arm-msm@vger.kernel.org
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> Looks good, but I'm not sure what happens on unload. Did you check?

Per the 0/N I've not got the capability to do run time testing for any
of this stuff.  And from previous discussions, ISTR that people didn't
want to see a blanket block-unload policy implemented.

> Until this is tested, maybe it's best to prevent module unloading?

If that is what people want, I can add that.

P.
-- 

> 
> 	Arnd
