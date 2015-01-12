Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:62184 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbbALTqB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jan 2015 14:46:01 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Duc Dang <dhdang@apm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, Feng Kan <fkan@apm.com>,
	linux-pci@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	Loc Ho <lho@apm.com>
Subject: Re: [PATCH 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX termination driver
Date: Mon, 12 Jan 2015 20:44:50 +0100
Message-ID: <1678162.2PJ2o1jRen@wuerfel>
In-Reply-To: <CADaLND=C3AjdZpiMpom7+-Dgwc83NYo5pDjDWo+hrW7VDZ4m3A@mail.gmail.com>
References: <cover.1420499393.git.dhdang@apm.com> <22570652.F088Afk9OX@wuerfel> <CADaLND=C3AjdZpiMpom7+-Dgwc83NYo5pDjDWo+hrW7VDZ4m3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 12 January 2015 10:53:14 Duc Dang wrote:
> On Tue, Jan 6, 2015 at 11:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 06 January 2015 08:15:41 Duc Dang wrote:
> >> X-Gene v1 SOC supports total 2688 MSI/MSIX vectors coalesced into
> >> 16 HW IRQ lines.
> >>
> >> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
> >> Signed-off-by: Duc Dang <dhdang@apm.com>
> >>
> >
> > I might be a little behind the latest development, but why is this
> > not a struct msi_controller?
> 
> X-Gene V1 have a separate MSI block to handle MSI/MSIX and is shared
> among 5 PCIe ports.
> So in this driver for this MSI block, we implement X-Gene v1 sepcific
> arch_teardown_msi_irqs,
> arch_setup_msi_irqs and not using msi_controller struct.

I see.

> Please let me know if this approach needs to be changed to follow
> other implementations of MSI
> drivers in latest kernel.

Yes, your approach does not work on distro kernels which will always
enable multiple targets. You cannot override generic weak functions from
a device driver.

	Arnd
