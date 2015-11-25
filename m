Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20151125075018.68e97010@arm.com>
References: <1447911323-12567-1-git-send-email-bharatku@xilinx.com>
	<20151124173556.18aff6b5@arm.com>
	<8520D5D51A55D047800579B0941471982586607F@XAP-PVEXMBX01.xlnx.xilinx.com>
	<20151125075018.68e97010@arm.com>
Date: Wed, 25 Nov 2015 14:23:29 +0530
Message-ID: <CABHD4K9PH-1tpwmxmPSBK3dW04G3XMfNtPFqtWFb7gnThe=uNQ@mail.gmail.com>
Subject: Re: [PATCH v9] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
From: Amit Tomer <amittomer25@gmail.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"tinamdar@apm.com" <tinamdar@apm.com>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"m-karicheri2@ti.com" <m-karicheri2@ti.com>,
	Michal Simek <michals@xilinx.com>,
	"rjui@broadcom.com" <rjui@broadcom.com>,
	"treding@nvidia.com" <treding@nvidia.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"sbranden@broadcom.com" <sbranden@broadcom.com>,
	"dhdang@apm.com" <dhdang@apm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"galak@codeaurora.org" <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sorry to intervene but just trying to learn from your comments.

 > You have plenty, and that's the whole of your device space. *All of it*. So
>   just take the base address of your PCIe controller, and be done with
>   it.

but isn't few of PCIe controller's registers itself are mapped
here(base address). So, how can we use this address for MSI?

Or you said from base address of PCIe controller, find an offset that
can be used as MSI address?

Thanks
Amit.
