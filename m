Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1bnnq-9iuse43bCNX_9TirZPOtmH_vFsvJ9VOAsoUBzQ@mail.gmail.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-6-lorenzo.pieralisi@arm.com>
 <CAK8P3a1bnnq-9iuse43bCNX_9TirZPOtmH_vFsvJ9VOAsoUBzQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 28 Apr 2017 14:52:14 +0200
Message-ID: <CAK8P3a26HBoN=ZcNwB30AGheEy3AU1GrTWGXQ9pmQHe8sH+vTw@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 05/18] ARM: PCI: dove: Convert PCI scan API to
 pci_scan_root_bus_bridge()
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Andrew Lunn <andrew@lunn.ch>, Pratyush Anand <pratyush.anand@gmail.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 linux-pci <linux-pci@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
 Will Deacon <will.deacon@arm.com>, Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Matthew Minter <matt@masarand.com>, Rob Herring <robh@kernel.org>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Wenrui Li <wenrui.li@rock-chips.com>,
 Russell King <linux@armlinux.org.uk>, Murali Karicheri <m-karicheri2@ti.com>,
 Jason Cooper <jason@lakedaemon.net>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 28, 2017 at 2:38 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Apr 26, 2017 at 1:17 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>> The introduction of pci_scan_root_bus_bridge() provides a PCI core
>> API to scan a PCI root bus backed by an already initialized
>> struct pci_host_bridge object, which simplifies the bus scan
>> interface and makes the PCI scan root bus interface easier to
>> generalize as members are added to the struct pci_host_bridge().
>>
>> Convert ARM dove platform code to pci_scan_root_bus_bridge() to improve
>> the PCI root bus scanning interface.
>>
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>
> Is this patch required for one of the later steps in the series?
>
> As non-DT dove uses the traditional pci_common_init() helper rather
> than registering its own driver, I wonder if there is anything to gain here.

Thinking about it some more, if we make the change to allocate from
pcibios_init_hw(), we can also initialize most of the fields there and
do the cleanup in common code when the scan callback fails, which
in turn makes the changes in arch/arm/mach*/pci.c drivers very simple.

        Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
