Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Jon Masters'" <jcm@jonmasters.org>,
 "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
 <linux-pci@vger.kernel.org>
References: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
 <2e24e205-d761-9172-9463-4a53e1a0de4d@jonmasters.org>
In-Reply-To: <2e24e205-d761-9172-9463-4a53e1a0de4d@jonmasters.org>
Subject: Re: [PATCH v4 00/21] PCI: fix config space memory mappings
Date: Tue, 25 Apr 2017 12:20:02 -0400
Message-ID: <000101d2bddf$cd442e80$67cc8b80$@gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: 'Pratyush Anand' <pratyush.anand@gmail.com>,
 'Gabriele Paoloni' <gabriele.paoloni@huawei.com>,
 'Catalin Marinas' <catalin.marinas@arm.com>,
 'Shawn Lin' <shawn.lin@rock-chips.com>, 'Will Deacon' <will.deacon@arm.com>,
 'Michal Simek' <michal.simek@xilinx.com>,
 'Thierry Reding' <thierry.reding@gmail.com>,
 'Tanmay Inamdar' <tinamdar@apm.com>, 'Zhou Wang' <wangzhou1@hisilicon.com>,
 'Joao Pinto' <Joao.Pinto@synopsys.com>, 'Jonathan Corbet' <corbet@lwn.net>,
 'Wenrui Li' <wenrui.li@rock-chips.com>, 'Russell King' <linux@armlinux.org.uk>,
 'Bharat Kumar Gogada' <bharat.kumar.gogada@xilinx.com>,
 'Murali Karicheri' <m-karicheri2@ti.com>,
 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>,
 'Arnd Bergmann' <arnd@arndb.de>, 'Jon Mason' <jonmason@broadcom.com>,
 'Ray Jui' <rjui@broadcom.com>, 'John Garry' <john.garry@huawei.com>,
 'Bjorn Helgaas' <bhelgaas@google.com>, 'Mingkai Hu' <mingkai.hu@freescale.com>,
 linux-arm-kernel@lists.infradead.org,
 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
 linux-kernel@vger.kernel.org, 'Stanimir Varbanov' <svarbanov@mm-sol.com>,
 'Minghuan Lian' <minghuan.Lian@freescale.com>,
 "'Luis R . Rodriguez'" <mcgrof@kernel.org>,
 'Roy Zang' <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, April 25, 2017 2:41 AM, Jon Masters wrote:
> 
> On 04/19/2017 12:48 PM, Lorenzo Pieralisi wrote:
> 
> > On some platforms (ie ARM/ARM64) ioremap fails to comply with the PCI
> > configuration non-posted write transactions requirement, because it
> > provides a memory mapping that issues "bufferable" or, in PCI terms
> > "posted" write transactions. Likewise, the current pci_remap_iospace()
> > implementation maps the physical address range that the PCI translates
> > to I/O space cycles to virtual address space through pgprot_device()
> > attributes that on eg ARM64 provides a memory mapping issuing
> > posted writes transactions, which is not PCI specifications compliant.
> 
> Side note that I've pinged all of the ARM server vendors and asked them
> to verify this patch series on their platforms.

Good! I really want to know the result of these patches on ARM serves.
Please share it with us. Good luck.

Best regards,
Jingoo Han

> 
> Jon.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
