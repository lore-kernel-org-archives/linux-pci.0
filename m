Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59219 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754672AbbKDIw6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 Nov 2015 03:52:58 -0500
Message-ID: <5639C763.7000707@arm.com>
Date: Wed, 04 Nov 2015 08:52:51 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	Amit Tomer <amittomer25@gmail.com>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	Michal Simek <michals@xilinx.com>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"tinamdar@apm.com" <tinamdar@apm.com>,
	"treding@nvidia.com" <treding@nvidia.com>,
	"rjui@broadcom.com" <rjui@broadcom.com>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"m-karicheri2@ti.com" <m-karicheri2@ti.com>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>,
	"dhdang@apm.com" <dhdang@apm.com>,
	"sbranden@broadcom.com" <sbranden@broadcom.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v7] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
References: <1446564227-4704-1-git-send-email-bharatku@xilinx.com>	<5638DE62.6050605@arm.com>	<8520D5D51A55D047800579B09414719801693C20@XAP-PVEXMBX01.xlnx.xilinx.com> <CABHD4K_BWU7-c1NM0y5ZwFkfpG0+c9_9DpwyNXNcTvavmy8rJw@mail.gmail.com> <8520D5D51A55D047800579B09414719801693C5C@XAP-PVEXMBX01.xlnx.xilinx.com>
In-Reply-To: <8520D5D51A55D047800579B09414719801693C5C@XAP-PVEXMBX01.xlnx.xilinx.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/11/15 07:54, Bharat Kumar Gogada wrote:
>>> Without #ifdefs if we compile driver for legacy, MSI structures will not be
>> available and we get compile time error.
>>
>> Sorry for nitpicking but at least can we use elegant version of #ifdefs .i.e. #if
>> IS_ENABLED() here ?
>>
> Since IS_ENABLED() is checked at runtime, compile time error would come for legacy.

You're seriously misguided. IS_ENABLED() is specifically designed *not*
to be checked at runtime, but instead to use the compiler optimization
phase to get rid of code sections at compile time.

	M.
-- 
Jazz is not dead. It just smells funny...
