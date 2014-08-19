Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:64342 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbaHSMk4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Aug 2014 08:40:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v9 02/12] PCI: OF: Parse and map the IRQ when adding the PCI device.
Date: Tue, 19 Aug 2014 14:39:56 +0200
Cc: Liviu Dudau <liviu@dudau.co.uk>, Liviu Dudau <Liviu.Dudau@arm.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Russell King <linux@arm.linux.org.uk>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Sinan Kaya <okaya@codeaurora.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Suravee Suthikulanit <suravee.suthikulpanit@amd.com>,
	"linux-pci" <linux-pci@vger.kernel.org>,
	"linux-arch" <linux-arch@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Device Tree ML <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com> <20140818213054.GB13147@bart.dudau.co.uk> <20140818220906.GJ24600@localhost>
In-Reply-To: <20140818220906.GJ24600@localhost>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201408191439.56493.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 19 August 2014, Catalin Marinas wrote:
> On Mon, Aug 18, 2014 at 10:30:54PM +0100, Liviu Dudau wrote:
> > At this point I would like to hear more from people doing the conversion of
> > the drivers. I cannot answer fully for all arm or arm64 drivers.
> 
> As I read the description of pcibios_add_device(), it is meant as an
> architecture hook. While it's nice to generalise this, I'm not sure we
> we can find a common denominator. For example, we may want to call
> set_dma_ops() as powerpc does but the ops would be arm64 specific (so
> even the __weak implementation may not be used by any architecture).

Right. I'm a strong advocate of the idea of having no architecture specific
parts in the PCI support, but I can see the set_dma_ops() call as a
good reason to make an exception here.

We could add another layer of indirection for the purpose of API purity
here, to call an architecture specific DMA setup function, but it doesn't
really add that much benefits, in particular when the DMA setup is currently
in flux as well.

	Arnd
