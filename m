Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:45073 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab3LJSsl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Dec 2013 13:48:41 -0500
From: Marek Vasut <marex@denx.de>
To: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 2/2] PCI: imx6: Remove unneeded 'goto err'
Date: Tue, 10 Dec 2013 19:48:39 +0100
Cc: "'Bjorn Helgaas'" <bhelgaas@google.com>,
	"'Fabio Estevam'" <festevam@gmail.com>, linux-pci@vger.kernel.org,
	"'Fabio Estevam'" <fabio.estevam@freescale.com>
References: <1385955575-25270-1-git-send-email-festevam@gmail.com> <20131209223824.GD2135@google.com> <000301cef56c$38fd71d0$aaf85570$%han@samsung.com>
In-Reply-To: <000301cef56c$38fd71d0$aaf85570$%han@samsung.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201312101948.39891.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, December 10, 2013 at 06:54:00 AM, Jingoo Han wrote:
> On Tuesday, December 10, 2013 7:38 AM, Bjorn Helgaas wrote:
> > On Mon, Dec 02, 2013 at 01:39:35AM -0200, Fabio Estevam wrote:
> > > From: Fabio Estevam <fabio.estevam@freescale.com>
> > > 
> > > There is no need to use 'goto err' as we can directly return the
> > > errors.
> > > 
> > > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > Since there's no functional change, I also applied this one to
> > pci/host-imx6 for v3.14.  I agree that leaving the DABT handler installed
> > is a bug and should be fixed by another patch.
> 
> I also agree with Bjorn's opinion. :-)
> Fixing the DABT handler problem can be sent as another patch.

Hm, actually I suspect we cannot un-install the handler. See arch/arm/mm/fault.c 
, the hook_fault_code() call is annotated __init , so it disappears after the 
init sequence finishes. This basically leaves us with disallowing the mx6 pcie 
driver to be removed from kernel (don't let it compile as a module), which I 
dont think is much of a problem anyway.

Best regards,
Marek Vasut
