Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:52324 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030184AbaGCK0u (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jul 2014 06:26:50 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Tanmay Inamdar <tinamdar@apm.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	linaro-kernel <linaro-kernel@lists.linaro.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Device Tree ML <devicetree@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Will Deacon <Will.Deacon@arm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	patches <patches@apm.com>, Kukjin Kim <kgene.kim@samsung.com>,
	Suravee Suthikulanit <suravee.suthikulpanit@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v8 2/9] pci: Export find_pci_host_bridge() function.
Date: Thu, 03 Jul 2014 12:26:32 +0200
Message-ID: <12857279.nHR7kEbqBW@wuerfel>
In-Reply-To: <CACoXjcn5wdOwQx6PSfhTyuo-FQqBL62o-MNj3i6EfENRnUNt6g@mail.gmail.com>
References: <1404240214-9804-1-git-send-email-Liviu.Dudau@arm.com> <7101568.8DVJFku5jp@wuerfel> <CACoXjcn5wdOwQx6PSfhTyuo-FQqBL62o-MNj3i6EfENRnUNt6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 02 July 2014 13:43:41 Tanmay Inamdar wrote:
> On Wed, Jul 2, 2014 at 12:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > I think EXPORT_SYMBOL_GPL() is better here. The new symbols are unlikely
> > to be used by a peripheral device driver, and PCI host controllers are
> > already restricted by EXPORT_SYMBOL_GPL.
> >
> 
> You are right as long as the functions are not used directly. But what
> if GPL functions are called indirectly.  For example, 'pci_domain_nr'
> implementation in Liviu's V7 series calls 'find_pci_host_bridge'.

Good point. If pci_domain_nr() doesn't require access to an EXPORT_SYMBOL_GPL
symbol, it should not start doing that after this patch.

For of_create_pci_host_bridge() however, I can't think of any reason to use
a legacy EXPORT_SYMBOL.

	Arnd
