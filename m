Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jim Quinlan' <jim2101024@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, "Brian
 Norris" <computersforpeace@gmail.com>, Russell King
 <rmk+kernel@armlinux.org.uk>, Robin Murphy <robin.murphy@arm.com>,
 "Christoph Hellwig" <hch@lst.de>, Florian Fainelli <f.fainelli@gmail.com>
Subject: RE: [PATCH 4/8] PCI: host: brcmstb: add dma-ranges for inbound traffic
Date: Wed, 25 Oct 2017 09:46:45 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD00A252D@AcuExch.aculab.com>
References: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
 <1508868949-16652-5-git-send-email-jim2101024@gmail.com>
In-Reply-To: <1508868949-16652-5-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Kevin Cernekee <cernekee@gmail.com>, Ralf Baechle <ralf@linux-mips.org>,
 "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Jim Quinlan
> Sent: 24 October 2017 19:16
> The Broadcom STB PCIe host controller is intimately related to the
> memory subsystem.  This close relationship adds complexity to how cpu
> system memory is mapped to PCIe memory.  Ideally, this mapping is an
> identity mapping, or an identity mapping off by a constant.  Not so in
> this case.
> 
> Consider the Broadcom reference board BCM97445LCC_4X8 which has 6 GB
> of system memory.  Here is how the PCIe controller maps the
> system memory to PCIe memory:
> 
>   memc0-a@[        0....3fffffff] <=> pci@[        0....3fffffff]
>   memc0-b@[100000000...13fffffff] <=> pci@[ 40000000....7fffffff]
>   memc1-a@[ 40000000....7fffffff] <=> pci@[ 80000000....bfffffff]
>   memc1-b@[300000000...33fffffff] <=> pci@[ c0000000....ffffffff]
>   memc2-a@[ 80000000....bfffffff] <=> pci@[100000000...13fffffff]
>   memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]

I presume the first column is the 'cpu physical address'
and the second the 'pci' address?

...

Isn't this just the same as having an iommu that converts 'bus'
addresses into 'physical' ones?

A simple table lookup of the high address bits will do the
conversion.

	David


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
