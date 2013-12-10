Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:35516 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787Ab3LJFyD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Dec 2013 00:54:03 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXK00F1VTQ02R50@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Tue, 10 Dec 2013 14:54:01 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Fabio Estevam' <festevam@gmail.com>
Cc: 'Marek Vasut' <marex@denx.de>, linux-pci@vger.kernel.org,
	'Fabio Estevam' <fabio.estevam@freescale.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1385955575-25270-1-git-send-email-festevam@gmail.com>
 <1385955575-25270-2-git-send-email-festevam@gmail.com>
 <20131209223824.GD2135@google.com>
In-reply-to: <20131209223824.GD2135@google.com>
Subject: Re: [PATCH 2/2] PCI: imx6: Remove unneeded 'goto err'
Date: Tue, 10 Dec 2013 14:54:00 +0900
Message-id: <000301cef56c$38fd71d0$aaf85570$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, December 10, 2013 7:38 AM, Bjorn Helgaas wrote:
> On Mon, Dec 02, 2013 at 01:39:35AM -0200, Fabio Estevam wrote:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> >
> > There is no need to use 'goto err' as we can directly return the errors.
> >
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since there's no functional change, I also applied this one to
> pci/host-imx6 for v3.14.  I agree that leaving the DABT handler installed
> is a bug and should be fixed by another patch.

I also agree with Bjorn's opinion. :-)
Fixing the DABT handler problem can be sent as another patch.

Best regards,
Jingoo Han

