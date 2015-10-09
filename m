Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:65452 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933355AbbJIISq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2015 04:18:46 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	Michal Simek <michals@xilinx.com>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"tinamdar@apm.com" <tinamdar@apm.com>,
	"treding@nvidia.com" <treding@nvidia.com>,
	"rjui@broadcom.com" <rjui@broadcom.com>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"m-karicheri2@ti.com" <m-karicheri2@ti.com>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL PCIe Host Controller
Date: Fri, 09 Oct 2015 10:18:21 +0200
Message-ID: <5676910.8cxuyuvhpA@wuerfel>
In-Reply-To: <56177669.2000302@arm.com>
References: <1444146289-28940-1-git-send-email-bharatku@xilinx.com> <8520D5D51A55D047800579B09414719801690CD0@XAP-PVEXMBX01.xlnx.xilinx.com> <56177669.2000302@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 09 October 2015 09:10:17 Marc Zyngier wrote:
> > Please let me know whether we require a separate msi file as
> > suggested in your previous comments to separate MSI controller and
> > PCIE controller in two files, if we don't have separate node. If we
> > do not need a separate node do we need to embed MSI controller child
> > node  in PCIe controller node itself, and what properties does this
> > child node will require other than 'interrupts'.
> 
> If you want to keep them in the same file, please at least have two
> separate patches. These are two different functions, and they should be
> reviewed separately.
> 
> It will help everyone to understand your code, and speed up the
> reviewing process.

Agreed. Also, the part we really want is to have the PCI controller
code decoupled enough from the MSI code that it will not require
further changes once Xilinx comes out with a chip that has a modern
GIC in it and the same PCIe host.

	Arnd
