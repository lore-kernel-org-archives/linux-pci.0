Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "timur@codeaurora.org" <timur@codeaurora.org>,
 "cov@codeaurora.org" <cov@codeaurora.org>
Subject: RE: [PATCH V2] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
Date: Tue, 28 Feb 2017 11:03:08 +0000
Message-ID: <92EBB4272BF81E4089A7126EC1E7B2846666830C@IRSMSX101.ger.corp.intel.com>
References: <1485891928-14573-1-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1485891928-14573-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

>
>When the operating system is booted with the default ASPM policy
>(POLICY_DEFAULT), the current code is determining the ASPM policy
>set up by the BIOS by querying the enable/disable states from ASPM
>registers.
>
>In the case of hotplug removal, the ASPM registers get cleared by
>calling the pcie_aspm_exit_link_state() function.
>

I see the same problem. So cherry-picked your change to resolve the problem
on top of Linus mainline.

>An insertion following hotplug removal reads incorrect policy as
>ASPM disabled even though ASPM was enabled during boot.
>
>Adding a flag to the struct pci_dev and saving the power up policy
>in the bridge to be reused during hotplug insertion. Bridge's enable
>counter is used as a switch to determine when to use saved value.
>
>Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>---
> drivers/pci/pcie/aspm.c | 21 +++++++++++++++++----
> include/linux/pci.h     |  1 +
> 2 files changed, 18 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>index 17ac1dc..5cfcc6d 100644
>--- a/drivers/pci/pcie/aspm.c
>+++ b/drivers/pci/pcie/aspm.c
>@@ -338,8 +338,9 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
> 	}
> }
>
>-static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>+static void pcie_aspm_cap_init(struct pci_dev *pdev, int blacklist)
> {
>+	struct pcie_link_state *link = pdev->link_state;
> 	struct pci_dev *child, *parent = link->pdev;
> 	struct pci_bus *linkbus = parent->subordinate;
> 	struct aspm_register_info upreg, dwreg;
>@@ -397,8 +398,20 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
> 	link->latency_up.l1 = calc_l1_latency(upreg.latency_encoding_l1);
> 	link->latency_dw.l1 = calc_l1_latency(dwreg.latency_encoding_l1);
>
>-	/* Save default state */
>-	link->aspm_default = link->aspm_enabled;

But, I am finding a problem with this change, if Policy is set to default,
BIOS enables ASPM L1, but pcie_config_aspm_link() disables ASPM L1
due to link->aspm_enabled is different than link->aspm_default while
called from pcie_aspm_init_link_state() during hotplug insertion.


>+	/*
>+	 * Save default state from FW when enabling ASPM for the first time
>+	 * during boot by looking at the calculated link->aspm_enabled bits
>+	 * above and enable_cnt will be zero.
>+	 *
>+	 * If this path is getting called for the second/third time
>+	 * (enable_cnt will be non-zero). Assume that the current state of the
>+	 * ASPM registers may not necessarily match what FW asked us to do as
>+	 * in the case of hotplug insertion/removal.
>+	 */
>+	if (!atomic_read(&pdev->enable_cnt))
>+		pdev->aspm_default = link->aspm_default = link->aspm_enabled;
>+	else
>+		link->aspm_default = pdev->aspm_default;
>
> 	/* Setup initial capable state. Will be updated later */
> 	link->aspm_capable = link->aspm_support;
>@@ -599,7 +612,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
> 	 * upstream links also because capable state of them can be
> 	 * update through pcie_aspm_cap_init().
> 	 */
>-	pcie_aspm_cap_init(link, blacklist);
>+	pcie_aspm_cap_init(pdev, blacklist);
>
> 	/* Setup initial Clock PM state */
> 	pcie_clkpm_cap_init(link, blacklist);
>diff --git a/include/linux/pci.h b/include/linux/pci.h
>index e2d1a12..521f88c 100644
>--- a/include/linux/pci.h
>+++ b/include/linux/pci.h
>@@ -321,6 +321,7 @@ struct pci_dev {
>
> #ifdef CONFIG_PCIEASPM
> 	struct pcie_link_state	*link_state;	/* ASPM link state */
>+	unsigned int	aspm_default;		/* ASPM policy set by BIOS */
> #endif
>
> 	pci_channel_state_t error_state;	/* current connectivity state */
>--
>1.9.1
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
