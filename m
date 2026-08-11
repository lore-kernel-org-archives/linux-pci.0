Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03AA4334A0;
	Tue, 11 Aug 2026 23:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786492697; cv=none; b=NuguUJitZTjcQGnhrw39B2fnIEUG6idtsViQCRtEkk54WQ0Vk1ZlSqd3zlFWoWZLdrrfubdG4qosSay/HuPT9L8bYX1ZFTLbNUFUXKZ99ilQETw+WYZslNG1MeeEAMGGX/UeFxRlxcZeN1TYcLtsEjIbHIQktjKgdDVk2uYmOPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786492697; c=relaxed/simple;
	bh=b7dQev5Ku9pkTnreR36tN19QYIy6STNKVTtZccOSqrY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EOoNL1XBpcxYhNdKE0B4sVs72r8qEfrs7tcw+FWzG5WI1Ur0FQESaoWsZqQrE0K9/xWpuRrfU5y1iONR6rzKNCpSMpDJRuxjAMSXNgvLmG0zaipSPaLY+DavnvO1ZYSvReHf3d3QlLeKztD2OYe8OnrWXIfP0D+7zk9M5usv51s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4RqXzEv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4RqXzEv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6DA1F000E9;
	Tue, 11 Aug 2026 23:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786492695;
	bh=EVMsQ3Od/WQnrEZmwQjHueMQ/bSOuNCGNfxfosJYuiE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=d4RqXzEv5yvX18P2SsTJ9bayg+1aTVcULSpZ/CORVW6PBimDGIBbP8YNv3bK4xchR
	 vn1NNN30ywJN5I0VTwr3wwYNtmp7iHuSf3sOZ5iatn9iOBssnVbDk09MbnyjbQ/p1Z
	 jfQeABPEprmUr7glCdHKss+kHuyUiais4+Z0WWLSuLu3789J1NvoUEaB4EcYOurYRa
	 qP3bfEFyEs3Hp3GLE85iZxWcBgcOaNhzUcAeS/fXRRFuSRKMEQm6Oy4r+9vvpm+Wcs
	 PmcrlnYyhJ/vLTpRdiDbKJ1abO689XzxF68aF0s0rH3W4OmijgF2XwEj6V2psSRa1n
	 eZIvKKt6y6xew==
Date: Tue, 11 Aug 2026 18:58:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org, quic_vbadigan@quicinc.com,
	sherry.sun@nxp.com, driver-core@lists.linux.dev,
	devicetree@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v12] PCI: Add support for PCIe WAKE# interrupt
Message-ID: <20260811235814.GA815007@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-wakeirq_support-v12-1-b4453f5bcc97@oss.qualcomm.com>

On Tue, Jul 07, 2026 at 05:01:43PM +0530, Krishna Chaitanya Chundru wrote:
> According to the PCI Express specification (PCIe r7.0, Section 5.3.3.2),
> two link wakeup mechanisms are defined: Beacon and WAKE#. Beacon is a
> hardware-only mechanism and is invisible to software (PCIe r7.0,
> Section 4.2.7.8.1). This change adds support for the WAKE# mechanism
> in the PCI core.
> 
> According to the PCIe specification, multiple WAKE# signals can exist in
> a system or each component in the hierarchy could share a single WAKE#
> signal. In configurations involving a PCIe switch, each downstream port
> (DSP) of the switch may be connected to a separate WAKE# line, allowing
> each endpoint to signal WAKE# independently. From figure 5.4 in sec
> 5.3.3.2, WAKE# can also be terminated at the switch itself. Such topologies
> are typically not described in Device Tree, therefore it is out of scope
> for this series.
> 
> To support this, the WAKE# should be described in the device tree node of
> the endpoint/bridge. If all endpoints share a single WAKE# line, then each
> endpoint node shall describe the same WAKE# signal or a single WAKE# in
> the Root Port node.
> 
> In pci_device_add(), PCI framework will search for the WAKE# in device
> node. Once found, register for the wake IRQ through
> dev_pm_set_dedicated_wake_irq() associates a wakeup IRQ with a device
> and requests it, but the PM core keeps the IRQ disabled by default. The
> IRQ is enabled by the PM core, only when the device is permitted to wake
> the system, i.e. during system suspend and after runtime suspend, and
> only when device wakeup is enabled.
> 
> If the same WAKE# GPIO is described in multiple device tree nodes, only the
> first device that successfully registers the wake IRQ will succeed, while
> subsequent registrations may fail. This limitation does not affect
> functional correctness, since WAKE# is only used to bring the link to D0,
> and endpoint-specific wakeup handling is resolved later through
> PME detection (PME_EN is set in suspend path by PCI core by default).
> 
> When the wake IRQ fires, the wakeirq handler invokes pm_runtime_resume() to
> bring the device back to an active power state, such as transitioning from
> D3cold to D0. Once the device is active and the link is usable, the
> endpoint may generate a PME, which is then handled by the PCI core through
> PME polling or the PCIe PME service driver to complete the wakeup of the
> endpoint.
> 
> WAKE# is added in dts schema and merged based on below links.
> 
> Link: https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/
> Link: https://github.com/devicetree-org/dt-schema/pull/170
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Applied to pci/wake for v7.3, thanks!

> ---
> PCIe WAKE# interrupt is needed for bringing back PCIe device state from
> D3cold to D0.
> 
> This is pending from long time, there was two attempts done previously to
> add WAKE# support[1], [2]. Those series tried to add support for legacy
> interrupts along with WAKE#. Legacy interrupts are already available in
> the latest kernel and we can ignore them. For the wake IRQ the series is
> trying to use interrupts property define in the device tree.
> 
> WAKE# is added in dts schema and merged based on this patch.
> https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/
> 
> [1]: https://lore.kernel.org/all/b2b91240-95fe-145d-502c-d52225497a34@nvidia.com/T/
> [2]: https://lore.kernel.org/all/20171226023646.17722-1-jeffy.chen@rock-chips.com/
> ---
> Changes in v12:
> - move platform_pci_configure_wake() before device_add() (sashiko).
> - set irq type based on the wake-gpios property (Sashiko).
> - Link to v11: https://patch.msgid.link/20260624-wakeirq_support-v11-1-120fbfaebe59@oss.qualcomm.com
> 
> Changes in v11:
> - Add device_init_wakeup() as client driver is not expected to enable
>   bridge dev wakeup capability.
> - Link to v10: https://patch.msgid.link/20260511-wakeirq_support-v10-0-c10af9c9eb8c@oss.qualcomm.com
> 
> Changes in v10:
> - As sashiko pointed, shared irq has plenty of race conditions.
> - So we are moving away from the shared IRQ patch and registering with
>   dedicated wake irq only, as part of wake irq the link will come to D0
>   as the parent controller driver will be runtime resume first and then
>   pme service will kick in wake up correct endpoint driver.
> - Removed device_init_wakeup() since it enabling wakeup explicitly,
>   which is not intended as this should be set by endpoint driver only.
> - Link to v9: https://lore.kernel.org/r/20260403-wakeirq_support-v9-0-1cbecf3b58d7@oss.qualcomm.com
> 
> Changes in v9:
> - Call device_init_wakeup() only if
>   dev_pm_set_dedicated_shared_wake_irq() succeeds (Mani).
> - Change the IRQ_TYPE from IRQ_TYPE_EDGE_FALLING to IRQ_TYPE_LEVEL_LOW (Mani).
> - Link to v8: https://lore.kernel.org/r/20260313-wakeirq_support-v8-0-48a0a702518a@oss.qualcomm.com
> 
> Changes in v8:
> - Moved the stub functions under CONFIG_OF_IRQ(mani).
> - Added the description of how dev_pm_set_dedicated_shared_wake_irq()
>   works.
> - Link to v7: https://lore.kernel.org/r/20260218-wakeirq_support-v7-0-0d4689830207@oss.qualcomm.com
> 
> Changes in v7:
> - Updated the commit text (Mani).
> - Couple of nits like using pci_err instead of dev_err,
>   use platform_pci_configure_wake(), platform_pci_remove_wake() instead
>   of calling directly calling pci_configure_of_wake_gpio() & pci_remove_of_wake_gpio() etc (Mani).
> - Add a new fwnode_gpiod_get() API that wraps fwnode_gpiod_get_index(..0..), similar to
>   devm_fwnode_gpiod_get() (Mani).
> - Link to v6: https://lore.kernel.org/r/20251127-wakeirq_support-v6-0-60f581f94205@oss.qualcomm.com
> 
> Changes in v6:
> - Change the name to dev_pm_set_dedicated_shared_wake_irq() and make the
>   changes pointed by (Rafael). 
> - Link to v5: https://lore.kernel.org/r/20251107-wakeirq_support-v5-0-464e17f2c20c@oss.qualcomm.com
> 
> Changes in v5:
> - Enable WAKE# irq only when there is wake -gpios defined in its device
>   tree node (Bjorn).
> - For legacy bindings for direct atach check in root port if we haven't
>   find the wake in the endpoint node.
> - Instead of hooking wake in driver bound case, do it in the framework
>   irrespective of the driver state (Bjorn).
> - Link to v4: https://lore.kernel.org/r/20250801-wake_irq_support-v4-0-6b6639013a1a@oss.qualcomm.com
> 
> Changes in v4:
> - Move wake from portdrv to core framework to endpoint (Bjorn).
> - Added support for multiple WAKE# case (Bjorn). But traverse from
>   endpoint upstream port to root port till you get WAKE#. And use
>   IRQF_SHARED flag for requesting interrupts.
> - Link to v3: https://lore.kernel.org/r/20250605-wake_irq_support-v3-0-7ba56dc909a5@oss.qualcomm.com
> 
> Changes in v3:
> - Update the commit messages, function names etc as suggested by Mani.
> - return wake_irq if returns error (Neil).
> - Link to v2: https://lore.kernel.org/r/20250419-wake_irq_support-v2-0-06baed9a87a1@oss.qualcomm.com
> 
> Changes in v2:
> - Move the wake irq teardown after pcie_port_device_remove
>   and move of_pci_setup_wake_irq before pcie_link_rcec (Lukas)
> - teardown wake irq in shutdown also.
> - Link to v1: https://lore.kernel.org/r/20250401-wake_irq_support-v1-0-d2e22f4a0efd@oss.qualcomm.com
> 
> To: Bjorn Helgaas <bhelgaas@google.com>
> To: Rob Herring <robh@kernel.org>
> To: Saravana Kannan <saravanak@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>  drivers/pci/of.c       | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.c      | 11 +++++++
>  drivers/pci/pci.h      |  2 ++
>  drivers/pci/probe.c    |  2 ++
>  drivers/pci/remove.c   |  1 +
>  include/linux/of_pci.h |  6 ++++
>  include/linux/pci.h    |  2 ++
>  7 files changed, 102 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 8b18c4ba845c..5df6b11cdf9f 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -7,6 +7,7 @@
>  #define pr_fmt(fmt)	"PCI: OF: " fmt
>  
>  #include <linux/cleanup.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
> @@ -15,6 +16,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_wakeirq.h>
>  #include "pci.h"
>  
>  #ifdef CONFIG_PCI
> @@ -586,6 +588,82 @@ int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
>  	return irq_create_of_mapping(&oirq);
>  }
>  EXPORT_SYMBOL_GPL(of_irq_parse_and_map_pci);
> +
> +static void pci_configure_wake_irq(struct pci_dev *pdev, struct gpio_desc *wake)
> +{
> +	int ret, wake_irq, irq_type;
> +
> +	wake_irq = gpiod_to_irq(wake);
> +	if (wake_irq < 0) {
> +		pci_err(pdev, "Failed to get wake irq: %d\n", wake_irq);
> +		return;
> +	}
> +
> +	/*
> +	 * dev_pm_set_dedicated_wake_irq() associates a wakeup IRQ with the
> +	 * device and requests it, but the PM core keeps it disabled by default.
> +	 * The IRQ is enabled only when the device is allowed to wake the system
> +	 * (during system suspend and after runtime suspend), and only if device
> +	 * wakeup is enabled.
> +	 *
> +	 * When the wake IRQ fires, the wakeirq handler invokes pm_runtime_resume()
> +	 * to bring the device back to an active power state (e.g. from D3cold to D0).
> +	 * Once the device is active and the link is usable, the endpoint may signal
> +	 * a PME, which is then handled by the PCI core (either via PME polling or the
> +	 * PCIe PME service driver) to wakeup particular endpoint.
> +	 */
> +	ret = dev_pm_set_dedicated_wake_irq(&pdev->dev, wake_irq);
> +	if (ret < 0) {
> +		pci_err(pdev, "Failed to set WAKE# IRQ: %d\n", ret);
> +		return;
> +	}
> +
> +	irq_type = gpiod_is_active_low(wake) ? IRQ_TYPE_LEVEL_LOW :
> +						IRQ_TYPE_LEVEL_HIGH;
> +	ret = irq_set_irq_type(wake_irq, irq_type);
> +	if (ret < 0) {
> +		dev_pm_clear_wake_irq(&pdev->dev);
> +		pci_err(pdev, "Failed to set irq_type: %d\n", ret);
> +		return;
> +	}
> +
> +	device_init_wakeup(&pdev->dev, true);
> +}
> +
> +void pci_configure_of_wake_gpio(struct pci_dev *dev)
> +{
> +	struct device_node *dn = pci_device_to_OF_node(dev);
> +	struct gpio_desc *gpio;
> +
> +	if (!dn && !dev->wake)
> +		return;
> +	/*
> +	 * fwnode_gpiod_get() may fail with -EBUSY (e.g. shared WAKE#), but the
> +	 * actual WAKE# trigger from the device would still work and the host
> +	 * controller driver will enable power to the topology.
> +	 *
> +	 * -EPROBE_DEFER cannot be propagated here since pci_device_add() has no
> +	 *  retry mechanism.
> +	 */
> +	gpio = fwnode_gpiod_get(of_fwnode_handle(dn), "wake", GPIOD_IN, NULL);
> +	if (!IS_ERR(gpio)) {
> +		dev->wake = gpio;
> +		pci_configure_wake_irq(dev, gpio);
> +	}
> +}
> +
> +void pci_remove_of_wake_gpio(struct pci_dev *dev)
> +{
> +	struct device_node *dn = pci_device_to_OF_node(dev);
> +
> +	if (!dn)
> +		return;
> +
> +	device_init_wakeup(&dev->dev, false);
> +	dev_pm_clear_wake_irq(&dev->dev);
> +	gpiod_put(dev->wake);
> +	dev->wake = NULL;
> +}
>  #endif	/* CONFIG_OF_IRQ */
>  
>  static int pci_parse_request_of_pci_ranges(struct device *dev,
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee61..14ec6c064cf1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -17,6 +17,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/msi.h>
>  #include <linux/of.h>
> +#include <linux/of_pci.h>
>  #include <linux/pci.h>
>  #include <linux/pm.h>
>  #include <linux/slab.h>
> @@ -1114,6 +1115,16 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>  	return acpi_pci_bridge_d3(dev);
>  }
>  
> +void platform_pci_configure_wake(struct pci_dev *dev)
> +{
> +	pci_configure_of_wake_gpio(dev);
> +}
> +
> +void platform_pci_remove_wake(struct pci_dev *dev)
> +{
> +	pci_remove_of_wake_gpio(dev);
> +}
> +
>  /**
>   * pci_update_current_state - Read power state of given device and cache it
>   * @dev: PCI device to handle.
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4469e1a77f3c..17d392dfda51 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -285,6 +285,8 @@ void pci_msix_init(struct pci_dev *dev);
>  bool pci_bridge_d3_possible(struct pci_dev *dev);
>  void pci_bridge_d3_update(struct pci_dev *dev);
>  int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
> +void platform_pci_configure_wake(struct pci_dev *dev);
> +void platform_pci_remove_wake(struct pci_dev *dev);
>  
>  static inline bool pci_bus_rrs_vendor_id(u32 l)
>  {
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index dd0abbc63e18..27008e2ea5af 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2749,6 +2749,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  
>  	pci_init_capabilities(dev);
>  
> +	platform_pci_configure_wake(dev);
> +
>  	/*
>  	 * Add the device to our list of discovered devices
>  	 * and the bus list for fixup functions, etc.
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index d8bffa21498a..e711ac1d4e38 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -34,6 +34,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
>  	if (pci_dev_test_and_set_removed(dev))
>  		return;
>  
> +	platform_pci_remove_wake(dev);
>  	pci_doe_sysfs_teardown(dev);
>  	pci_npem_remove(dev);
>  
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 29658c0ee71f..649fe8eafcfa 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -30,12 +30,18 @@ static inline void of_pci_check_probe_only(void) { }
>  
>  #if IS_ENABLED(CONFIG_OF_IRQ)
>  int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
> +void pci_configure_of_wake_gpio(struct pci_dev *dev);
> +void pci_remove_of_wake_gpio(struct pci_dev *dev);
>  #else
>  static inline int
>  of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
>  {
>  	return 0;
>  }
> +
> +static inline void pci_configure_of_wake_gpio(struct pci_dev *dev) { }
> +
> +static inline void pci_remove_of_wake_gpio(struct pci_dev *dev) { }
>  #endif
>  
>  #endif
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 64b308b6e61c..09134d0a559f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -587,6 +587,8 @@ struct pci_dev {
>  	/* These methods index pci_reset_fn_methods[] */
>  	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
>  
> +	struct gpio_desc *wake; /* Holds WAKE# gpio */
> +
>  #ifdef CONFIG_PCIE_TPH
>  	u16		tph_cap;	/* TPH capability offset */
>  	u8		tph_mode;	/* TPH mode */
> 
> ---
> base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
> change-id: 20251104-wakeirq_support-f54c4baa18c5
> 
> Best regards,
> --  
> Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 
