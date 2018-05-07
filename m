Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 7 May 2018 16:35:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] PCI: pciehp: Add quirk for QDF2400 Command Completed
 erratum
Message-ID: <20180507213531.GB133147@bhelgaas-glaptop.roam.corp.google.com>
References: <1525602662-1873-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1525602662-1873-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: sulrich@codeaurora.org, Kees Cook <keescook@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, open list <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
 Lukas Wunner <lukas@wunner.de>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Markus Elfring <elfring@users.sourceforge.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, May 06, 2018 at 06:30:53AM -0400, Sinan Kaya wrote:
> The QDF2400 controller does not set the Command Completed bit unless
> writes to the Slot Command register change "Control" bits.  Command
> Completed is never set for writes that only change software notification
> "Enable" bits.  This results in timeouts like this:
> 
> pciehp 0000:00:00.0:pcie004: Timeout on hotplug command 0x1038
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Since there's no bisection benefit for keeping these separate, I folded
this into the original quirk and added Mika's reviewed-by.

I also added the following ID patch and used PCI_VENDOR_ID_QCOM:

commit 333c8c1216c1e7ead6af7b3d667b43eb425b5034
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon May 7 15:52:55 2018 -0500

    PCI: Add Qualcomm vendor ID
    
    Add the Qualcomm vendor ID to pci_ids.h and use it in quirks.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2990ad1e7c99..e7bf44515fd6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4361,8 +4361,8 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_INTEL, 0x15b7, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_INTEL, 0x15b8, pci_quirk_mf_endpoint_acs },
 	/* QCOM QDF2xxx root ports */
-	{ 0x17cb, 0x400, pci_quirk_qcom_rp_acs },
-	{ 0x17cb, 0x401, pci_quirk_qcom_rp_acs },
+	{ PCI_VENDOR_ID_QCOM, 0x0400, pci_quirk_qcom_rp_acs },
+	{ PCI_VENDOR_ID_QCOM, 0x0401, pci_quirk_qcom_rp_acs },
 	/* Intel PCH root ports */
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_pch_acs },
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_spt_pch_acs },
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index cc608fc55334..883cb7bf78aa 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2387,6 +2387,8 @@
 
 #define PCI_VENDOR_ID_LENOVO		0x17aa
 
+#define PCI_VENDOR_ID_QCOM		0x17cb
+
 #define PCI_VENDOR_ID_CDNS		0x17cd
 
 #define PCI_VENDOR_ID_ARECA		0x17d3

> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index e70eba5..974a8f1 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -914,3 +914,9 @@ static void quirk_cmd_compl(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
>  			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
> +
> +DECLARE_PCI_FIXUP_CLASS_EARLY(0x17cb, 0x400,
> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
> +
> +DECLARE_PCI_FIXUP_CLASS_EARLY(0x17cb, 0x401,
> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
