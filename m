Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48794 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069AbbGQMoS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 17 Jul 2015 08:44:18 -0400
Date: Fri, 17 Jul 2015 13:44:54 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ravikiran Gummaluri <ravikiran.gummaluri@xilinx.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Bharat Kumar Gogada <bharatku@xilinx.com>
Subject: Re: PCIe support for ARM64
Message-ID: <20150717124454.GA19824@red-moon>
References: <loom.20150619T074145-299@post.gmane.org>
 <CAErSpo52WYqB9hfNKo-ADrJF1LASUz5y9vWzsmp2FaCNc9WZfg@mail.gmail.com>
 <loom.20150710T130734-815@post.gmane.org>
 <20150711201634.GA24416@google.com>
 <A12CBBFFEB35D84DABCB166110D762215E41B2C5@XAP-PVEXMBX01.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A12CBBFFEB35D84DABCB166110D762215E41B2C5@XAP-PVEXMBX01.xlnx.xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 17, 2015 at 12:43:42PM +0100, Ravikiran Gummaluri wrote:
> HI Bjorn/Pratyush,
> 	Thanks for your inputs. We were able to do modify our driver according to V4.2-rc1. We were only be able to bring up MSI related changes but not Legacy. Can you point us how to handle Legacy interrupts in new approach (previously in ARM32 handled by map_irq method in hw_pci structure).

Call pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);

in your now ARM/ARM64 common host controller driver.

Lorenzo

> 
> Thanks & Regards
> Ravi Kiran G 
> 
> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com] 
> Sent: Sunday, July 12, 2015 1:47 AM
> To: Ravikiran Gummaluri
> Cc: linux-pci@vger.kernel.org; Pratyush Anand; Bharat Kumar Gogada
> Subject: Re: PCIe support for ARM64
> 
> [+cc Pratyush, Bharat]
> 
> On Fri, Jul 10, 2015 at 11:18:10AM +0000, ravikiran gummaluri wrote:
> > Bjorn Helgaas <bhelgaas <at> google.com> writes:
> > 
> > > 
> > > On Fri, Jun 19, 2015 at 12:43 AM, ravikiran gummaluri <rgummal <at> 
> > > xilinx.com> wrote:
> > > > HI
> > > >
> > > > I am developing PCIe root port driver for Xilinx device. We have 
> > > > used following patch for ARM64 bit support 
> > > > "https://lkml.org/lkml/2014/7/3/764". The link explains it as 
> > > > temporary patch and main line will be updated soon with those 
> > > > changes. We have not seen the changes till now. Can you let us 
> > > > know when we can expect the changes in mainline? We are planning to push our drivers to mainline.
> > > 
> > > There is PCI support for ARM64 in mainline:
> > > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?
> > id=d1e6dc91b532
> > > 
> > > There is also a Xilinx driver already:
> > > 
> > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/dr
> > ivers/
> > pci/host/pcie-xilinx.c
> > > 
> > > I don't know if your device is similar to the AXI device, but it 
> > > would be good if you can share or modify that driver instead of 
> > > adding a new one.
> > > 
> > > As with several other drivers, the current pcie-xilinx.c uses 
> > > pci_common_init_dev(), so it only works on ARM (not ARM64).  This is 
> > > a known issue, and people are working on making these drivers less 
> > > arch-specific.
> > > 
> > > Bjorn
> > > 
> > 
> > Thanks Bjorn. pcie-xilinx.c is AXI device. Now we are developing for 
> > different device using pcie-xilinx.c as reference. When we trying to 
> > compile our new driver with latest kernel we are getting compilation 
> > problems for struct hw_pci and struct pci_sys_data for ARM64. These 
> > structures are not defined in ARM64. The following patch has the 
> > structure definitions "https://lkml.org/lkml/2014/7/3/764". We have 
> > used this patch and able complete our development. Now for up 
> > streaming it we need this patch in main line. From your discursion we 
> > understood that some work is going on ARCH independent API and 
> > structure. When can we expect them in mainline?
> 
> Pratyush already answered this:
> 
>     Please have a look to the latest kernel and try to see what is
>     available for ARM64 PCIe.
> 
>     You may see drivers/pci/host/pci-xgene.c as reference.
> 
>     I see that there is already a driver for xilinx PCIe controller with
>     ARM platform.
>     drivers/pci/host/pcie-xilinx.c
> 
>     If it is the same device on ARM64, then you need to take similar
>     approach what is being discussed
>     for designware on ARM64.
> 
>     http://marc.info/?l=devicetree&m=143394380815743&w=2
> 
> My advice is to adapt your driver so it works using the interfaces and structures in v4.2-rc1 and post that.  As Pratyush mentioned, the X-Gene driver should be a good place to start.
> 
> There will likely be changes to the way we handle arch- and platform- specific data, but you don't need to wait for those to be completed.  When people make changes like that, it is always their responsibility to update all the code in the tree to match.  So once your code is in the tree, you don't have to worry about updating your driver to follow those changes.
> 
> On the other hand, if you do wait for those changes to be completed, you never know when or if they ever will be done, and you'll have to do your own updates before posting your driver.
> 
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
