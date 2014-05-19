Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:52980 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420AbaESNCf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 May 2014 09:02:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Sunil Kovvuri <sunil.kovvuri@gmail.com>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linaro-kernel <linaro-kernel@lists.linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Grant Likely <grant.likely@secretlab.ca>, kdb@lurndal.org,
	yu.zhao@intel.com
Subject: Re: [PATCH v7 0/3] Add support for PCI in AArch64
Date: Mon, 19 May 2014 15:01:59 +0200
Message-ID: <4292818.mI6kZGgTzd@wuerfel>
In-Reply-To: <CA+sq2Ccok5wtKjCZUkBhhj3WsiqFAoMgHK7LY210aBtMku+8SA@mail.gmail.com>
References: <1394811258-1500-1-git-send-email-Liviu.Dudau@arm.com> <CA+sq2Ccok5wtKjCZUkBhhj3WsiqFAoMgHK7LY210aBtMku+8SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 16 May 2014 16:03:04 Sunil Kovvuri wrote:
> When the SR-IOV capable device's driver tries to enable sriov
> (pci_enable_sriov()) it fails to create/add PCI device for each
> virtual function reporting  "not enough MMIO resources for SR-IOV".

I assume you have checked that there is indeed enough MMIO space
available, right?

> In sriov_enable() (drivers/pci/iov.c)
> 
>  296        for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>  297                 bars |= (1 << (i + PCI_IOV_RESOURCES));
>  298                 res = dev->resource + PCI_IOV_RESOURCES + i;
>  299                 if (res->parent)
>  300                         nres++;
>  301         }
>  302         if (nres != iov->nres) {
>  303                 dev_err(&dev->dev, "not enough MMIO resources for
>  SR-IOV\n");
>  304                 return -ENOMEM;
>  305         }
> 
> Here its checking if physical function's IOV resource has a parent or not.
> Which is pci-pci bridge in this case. Otherwise it doesn't consider
> that resource.
> 
> Added below api to your patch.
> This will try to claim a resource while creating a PCI device which
> inturn sets 'res->parent'.

This looks like the wrong approach. The PCI host controller should
really have been registered with the root 'iomem_resource' during
the probe of the host controller.

	Arnd
