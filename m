Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:59218 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756250Ab3LECSl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Dec 2013 21:18:41 -0500
From: Marek Vasut <marex@denx.de>
To: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH v5 0/2] Kernel oops from pci_disable_msi
Date: Thu, 5 Dec 2013 03:18:39 +0100
Cc: "=?iso-8859-1?q?=27Bj=F8rn_Erik?= Nilsen'" <ben@datarespons.no>,
	"'Pratyush Anand'" <pratyush.anand@gmail.com>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	"'Kishon Vijay Abraham I'" <kishon@ti.com>,
	"'Mohit KUMAR'" <Mohit.KUMAR@st.com>,
	"'Ajay KHANDELWAL'" <ajay.khandelwal@st.com>,
	"'Tim Harvey'" <tharvey@gateworks.com>,
	"'Eric Nelson'" <Eric.Nelson@boundarydevices.com>,
	"'Troy Kisky'" <troy.kisky@boundarydevices.com>
References: <003101ceecd5$dd4e79e0$97eb6da0$%han@samsung.com> <1385732125-28630-1-git-send-email-ben@datarespons.no> <000301cef15c$acf95630$06ec0290$%han@samsung.com>
In-Reply-To: <000301cef15c$acf95630$06ec0290$%han@samsung.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201312050318.39418.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, December 05, 2013 at 02:52:38 AM, Jingoo Han wrote:
> On Friday, November 29, 2013 10:35 PM, Bjørn Erik Nilsen wrote:
> > This patchset address Marek Vasut's comments on the previous
> > patches. I decided to split into two separate commits as they are
> > unrelated.
> > 
> > Bjørn Erik Nilsen (2):
> >   PCI: designware: Fix crash in dw_msi_teardown_irq
> >   PCI: designware: Remove redundant call to pci_write_config
> >  
> >  drivers/pci/host/pcie-designware.c | 57
> >  +++++++++++++++++++++++++++----------- 1 file changed, 41
> >  insertions(+), 16 deletions(-)
> 
> I tested these patches on Exynos platform, and checked that
> the kernel panic was resolved.
> 
> Marek Vasut, Bjørn Erik Nilsen,
> Is there any issue for accepting these patches?

No issue on my end.

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
