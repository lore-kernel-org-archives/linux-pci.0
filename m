Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:58056 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbbDUHRa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Apr 2015 03:17:30 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Feng Kan <fkan@apm.com>, Marc Zyngier <marc.zyngier@arm.com>,
	linux-pci@vger.kernel.org, Duc Dang <dhdang@apm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Grant Likely <grant.likely@linaro.org>, Loc Ho <lho@apm.com>
Subject: Re: [PATCH v4 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX termination driver
Date: Tue, 21 Apr 2015 09:16:49 +0200
Message-ID: <2940382.sQOGMMprLX@wuerfel>
In-Reply-To: <CAL85gmB_1zTy7wHw2zud5ofmX=dXY1sQ49dLJPysk+Z0N4TiaQ@mail.gmail.com>
References: <cover.1429263201.git.dhdang@apm.com> <3188893.aaXgNln69B@wuerfel> <CAL85gmB_1zTy7wHw2zud5ofmX=dXY1sQ49dLJPysk+Z0N4TiaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 20 April 2015 11:49:37 Feng Kan wrote:
> >
> > Obviously they appear on the PCI host bridge in order, because that
> > is a how PCI works. My question was about what happens then. On a lot
> > of SoCs, there is something like an AXI bus that uses posted
> > transactions between PCI and RAM, so you have a do a full manual
> > syncronization of ongoing PIC DMAs when the MSI catcher signals the
> > top-level interrupt. Do you have a bus between PCI and RAM that does
> > not require this, or does the MSI catcher have logic to flush all DMAs?
> 
> Our hardware has an automatic mechanism to flush the content to DRAM before the
> MSI write is committed.

Ok, excellent!

	Arnd
