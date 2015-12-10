Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v11] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
To: Bjorn Helgaas <helgaas@kernel.org>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
References: <1448798633-12697-1-git-send-email-bharatku@xilinx.com>
 <20151209231921.GI31930@localhost>
CC: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<sorenb@xilinx.com>, <bhelgaas@google.com>, <arnd@arndb.de>,
	<tinamdar@apm.com>, <treding@nvidia.com>, <rjui@broadcom.com>,
	<Minghuan.Lian@freescale.com>, <m-karicheri2@ti.com>,
	<hauke@hauke-m.de>, <marc.zyngier@arm.com>, <dhdang@apm.com>,
	<sbranden@broadcom.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	"Ravi Kiran Gummaluri" <rgummal@xilinx.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Paul Burton <paul.burton@imgtec.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	"Alexandre Courbot" <gnurou@gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <5669236D.30805@xilinx.com>
Date: Thu, 10 Dec 2015 08:02:05 +0100
MIME-Version: 1.0
In-Reply-To: <20151209231921.GI31930@localhost>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 10.12.2015 00:19, Bjorn Helgaas wrote:
> [+cc Michal, Paul, Thierry, Stephen, Alexandre (see irq_dispose_mapping questions below)]
> 
> On Sun, Nov 29, 2015 at 05:33:53PM +0530, Bharat Kumar Gogada wrote:
>> Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
>>
>> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
>> Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
>> Acked-by: Rob Herring <robh@kernel.org>
> 
> This needs either a MAINTAINERS update or an ack from Michal (whose
> MAINTAINERS entry matches anything containing "xilinx").

We have done it in this way because driver owners are changing time to
time and my entry cover it that I can pass it to appropriate person who
is responsible for it.

For this Maintainers part here is my:
Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
