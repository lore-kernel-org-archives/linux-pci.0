Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 15 Aug 2017 12:03:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ding Tianhong <dingtianhong@huawei.com>
Subject: Re: [PATCH net RESEND] PCI: fix oops when try to find Root Port for
 a PCI device
Message-ID: <20170815170331.GA4099@bhelgaas-glaptop.roam.corp.google.com>
References: <1502810688-12420-1-git-send-email-dingtianhong@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1502810688-12420-1-git-send-email-dingtianhong@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, gabriele.paoloni@huawei.com, asit.k.mallick@intel.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linuxarm@huawei.com,
 alexander.duyck@gmail.com, ashok.raj@intel.com, eric.dumazet@gmail.com,
 jeffrey.t.kirsher@intel.com, linux-pci@vger.kernel.org, ganeshgr@chelsio.com,
 Bob.Shaw@amd.com, leedom@chelsio.com, patrick.j.cramer@intel.com,
 bhelgaas@google.com, werner@chelsio.com, linux-arm-kernel@lists.infradead.org,
 amira@mellanox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 David.Laight@aculab.com, Suravee.Suthikulpanit@amd.com, robin.murphy@arm.com,
 davem@davemloft.net, l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 15, 2017 at 11:24:48PM +0800, Ding Tianhong wrote:
> Eric report a oops when booting the system after applying
> the commit a99b646afa8a ("PCI: Disable PCIe Relaxed..."):
> ...

> It looks like the pci_find_pcie_root_port() was trying to
> find the Root Port for the PCI device which is the Root
> Port already, it will return NULL and trigger the problem,
> so check the highest_pcie_bridge to fix thie problem.

The problem was actually with a Root Complex Integrated Endpoint that
has no upstream PCIe device:

  00:05.2 System peripheral: Intel Corporation Device 0e2a (rev 04)
        Subsystem: Intel Corporation Device 0e2a
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal+ Unsupported+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 128 bytes

> Fixes: a99b646afa8a ("PCI: Disable PCIe Relaxed Ordering if unsupported")

This also

Fixes: c56d4450eb68 ("PCI: Turn off Request Attributes to avoid Chelsio T5 Completion erratum")

which added pci_find_pcie_root_port().  Prior to this Relaxed Ordering
series, we only used pci_find_pcie_root_port() in a Chelsio quirk that
only applied to non-integrated endpoints, so we didn't trip over the
bug.

> Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
> Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>
> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
> ---
>  drivers/pci/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index af0cc34..7e2022f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -522,7 +522,8 @@ struct pci_dev *pci_find_pcie_root_port(struct pci_dev *dev)
>  		bridge = pci_upstream_bridge(bridge);
>  	}
>  
> -	if (pci_pcie_type(highest_pcie_bridge) != PCI_EXP_TYPE_ROOT_PORT)
> +	if (highest_pcie_bridge &&
> +	    pci_pcie_type(highest_pcie_bridge) != PCI_EXP_TYPE_ROOT_PORT)
>  		return NULL;
>  
>  	return highest_pcie_bridge;
> -- 

I think structuring the fix as follows is a little more readable:

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af0cc3456dc1..587cd7623ed8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -522,10 +522,11 @@ struct pci_dev *pci_find_pcie_root_port(struct pci_dev *dev)
 		bridge = pci_upstream_bridge(bridge);
 	}
 
-	if (pci_pcie_type(highest_pcie_bridge) != PCI_EXP_TYPE_ROOT_PORT)
-		return NULL;
+	if (highest_pcie_bridge &&
+	    pci_pcie_type(highest_pcie_bridge) == PCI_EXP_TYPE_ROOT_PORT)
+		return highest_pcie_bridge;
 
-	return highest_pcie_bridge;
+	return NULL;
 }
 EXPORT_SYMBOL(pci_find_pcie_root_port);
 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
