Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:62905 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbaCTM0T (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Mar 2014 08:26:19 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v7 3/3] arm64: Add architecture support for PCI
Date: Thu, 20 Mar 2014 13:26:02 +0100
Cc: Catalin Marinas <Catalin.Marinas@arm.com>,
	"linux-pci" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linaro-kernel" <linaro-kernel@lists.linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Grant Likely <grant.likely@secretlab.ca>
References: <1394811258-1500-1-git-send-email-Liviu.Dudau@arm.com> <201403201217.22339.arnd@arndb.de> <20140320113820.GH6457@e106497-lin.cambridge.arm.com>
In-Reply-To: <20140320113820.GH6457@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201403201326.02377.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 20 March 2014, Liviu Dudau wrote:
> > I don't even understand why you want to create a generic pci_address_to_pio
> > implementation, when we don't need that for arm64 at all. Unless I'm
> > missing something important, that function is only called in case of
> > PCI_PROBE_DEVTREE with pci_of_scan on PowerPC. I don't expect any
> > architecture to do the same thing, and the only other architecture that
> > needs something like it (sparc) has a different implementation.
> 
> Because in my [v7 2/6]* patch for the generic host bridge support I start
> using pci_address_to_pio to fix the conversion of PCI ranges to resources.
> That requires an arm64 (or more correctly, an arch with memory mapped IO
> specific) version of pci_address_to_pio().

Yes, but why do you use it there?

	Arnd
