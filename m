Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: pcie-designware: Incorrect programming of msi address register on
 some setups.
To: Jingoo Han <jingoohan1@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Message-ID: <922851d0-a847-762a-5067-88c92d416d58@linaro.org>
Date: Tue, 24 Jan 2017 14:07:56 +0000
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Recently I hit a bug with pcie-designware driver with triggers a board 
reboot, this is my analysis so far on the issue. Issue is because 
designware driver is programming msi address which is above 32 address 
space eventhough one of the pcie endpoint indicated that it does not 
support 64 bit msi addresses.

My setup is arm64 board DB820c with 3 root complexes, and the system has 
memory which spans across 4GB address space.
First root complex is connected to a WLAN Chip (QCA6174) only supports 
32 bit addresses.
Second one is connected to a Ethernet Controller (ATL1c)

value of MSI control register aka PCI_MSI_FLAGS (0x2) for device QCA6174 
is 0x106
value of MSI control register aka PCI_MSI_FLAGS (0x2) for device ATL1C 
is 0x80

Now the problem is that on Synopsis IP, the MSI address register is 
programmed at two places
1> one at controller config dbi address space itself in 
PCIE_MSI_ADDR_LO(0x820)  & PCIE_MSI_ADDR_HI (0x824)

2> at PCI_MSI_ADDRESS_LO (0x2) and PCI_MSI_ADDRESS_HI of the device cfg.

If step 1 allocates msi address which is above 32 bit address space, 
then step 2 would truncate it to 32 bit address if it discovers endpoint 
which does not support 64 bit msi address.
Then if endpoint tries to read/write this address as part of MSI 
mechanism it would fault and crash system.

Am not sure how we can solve this correctly because we do not know about 
endpoints at step 1. On the other hand if we can force step 1 to 
allocate addresses with in 32 bit address space than it would work for 
both 32 bit and 64 bit.

Has anyone hit this issue before?
Do we already have a solution?
Any suggestions?

Below ugly Hack is what Am using to workaround this issue on my platform 
  but am not sure how this will influence other platforms.

---------------------------->cut<-------------------------------
diff --git a/drivers/pci/host/pcie-designware.c 
b/drivers/pci/host/pcie-designware.c
index 4a81b72..d694e66 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -286,9 +286,8 @@ void dw_pcie_msi_init(struct pcie_port *pp)
  {
         u64 msi_target;

-       pp->msi_data = __get_free_pages(GFP_KERNEL, 0);
+       pp->msi_data = __get_free_pages(GFP_KERNEL | GFP_DMA, 0);
         msi_target = virt_to_phys((void *)pp->msi_data);

         /* program the msi_data */
         dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
                             (u32)(msi_target & 0xffffffff));
---------------------------->cut<-------------------------------


Thanks,
srini

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
