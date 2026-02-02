Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC135A943;
	Mon,  2 Feb 2026 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770030001; cv=none; b=L5K97W4WG8yAB9RqswInsqWmYkHa8OcDPIDGqsey84MilHA7K1Fynd2pCpxRJYu87EXC/X6VkBQwcofEfb59BkSNp8JGuqH+l+XRETo1THv1nwk3Um8aUjbqsjRj6PA4KW9zgYKXUQlAiKBqzKfY8q2HnmIs05OCD4Nn05ityTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770030001; c=relaxed/simple;
	bh=TUnLtH/hGYDDh2Iz7+OkTetuo8jQN0M82oo7UEGB3Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/oVHXKDncNrBoj4bNqQD03rHZKmqs1+oHXAI0hYQ/XTEcJUjIdlRt9MaHnjkxI+OMD5sxJjEnW5yfXtIiqEWPaLgvUxVo9NqyjXk8aBNO4f56Ad3wyLZqMEWsZUrkmuZ0kxeB2Y9foLA9Ss4flFv4XQSwVJYYy6QaPnK18IN+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlkMDBZg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlkMDBZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A81C116C6;
	Mon,  2 Feb 2026 10:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770030001;
	bh=TUnLtH/hGYDDh2Iz7+OkTetuo8jQN0M82oo7UEGB3Yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GlkMDBZg6unx+96Zcs1IKoVEox02V85SUcZeN0y1r+gsBiDn0EWevG33GMpRscrzm
	 gnMppSFRPNWQRafon2cp/69/5vh4MT+WYsk1+H5P8+WATrj9vTCLRe9ldjqwIFAS3F
	 hh32lbtHKMXLcPxTZlK1x2E4fMHqzs4rVXntSdC2/m/YGfZRLwayaDq4nSVNvfOGlc
	 HJB4VTC7QlF8QbUXQ1KGIn1gRQKwr+QLZCLpHcZUTEk1q3kDBzJPtykh+JwQdqzzSS
	 vk3IaxeaLgFPEJu8AuOromDEC+3fyRC5tqMpGx6VevjPT2bj3gTOg3boJTF9X3gCwp
	 hU91tEau63b9g==
Date: Mon, 2 Feb 2026 16:29:51 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: zhangsenchuan@eswincomputing.com
Cc: bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	christian.bruel@foss.st.com, shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com, 
	thippeswamy.havalige@amd.com, inochiama@gmail.com, Frank.li@nxp.com, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
Subject: Re: [PATCH v10 0/2] Add driver support for Eswin EIC7700 SoC PCIe
 controller
Message-ID: <4vqlkw2cr3caqj7whlld7r2d5nenrxsufuc72zwwy5a6a5wmza@3haxytsqqigj>
References: <20260129092629.1866-1-zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129092629.1866-1-zhangsenchuan@eswincomputing.com>

On Thu, Jan 29, 2026 at 05:26:28PM +0800, zhangsenchuan@eswincomputing.com wrote:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> 
> Changes in v10:
> - Updates: eswin,eic7700-pcie.yaml
>   - None
> 

This version looks good to me, but it'd be good if Bjorn could give an Ack since
there were previous reviews from him. Also, this week is -rc8, so it is too late
for 7.0. I hope we can merge this series early, once v7.0-rc1 is released.

- Mani

> - Updates: pcie-eic7700.c
>   - Remove devm_clk_bulk_get_all_enabled API, use devm_clk_bulk_get_all
>     and clk_bulk_prepare_enable. Add resource release codes and add
>     eic7700_pcie_host_deinit API.
>   - Update PCI_DEVICE_ID_ESWIN_EIC7700.
>   - Add reset_control_put release resources in "goto err_port:".
>   - Delete trailing comma after a terminator in eic7700_pcie_of_match.
> - Link to V9: https://lore.kernel.org/all/20251229113021.1859-1-zhangsenchuan@eswincomputing.com/
> 
> Changes in v9:
> - Updates: eswin,eic7700-pcie.yaml
>   - None
> 
> - Updates: pcie-eic7700.c
>   - Update comment, s/Rort/Port/.
> - Link to V8: https://lore.kernel.org/all/20251215095928.1712-1-zhangsenchuan@eswincomputing.com/
> 
> Changes in v8:
> - Updates: eswin,eic7700-pcie.yaml
>   - None
> 
> - Updates: pcie-eic7700.c
>   - Remove dw_pcie_suspend_noirq/dw_pcie_resume_noirq API and add a
>     comment, and remove .deinit.
>   - Remove no_pme_handshake flag.
>   - Add dw_pcie_dbi_ro_wr_en/dw_pcie_dbi_ro_wr_dis API.
>   - Add eic7700_pcie_assert helper function.
>   - Update NOIRQ_SYSTEM_SLEEP_PM_OPS to DEFINE_NOIRQ_DEV_PM_OPS.
> - Link to V7: https://lore.kernel.org/all/20251202090225.1602-1-zhangsenchuan@eswincomputing.com/
> 
> Changes in v7:
> - Updates: eswin,eic7700-pcie.yaml
>   - None
> 
> - Updates: pcie-eic7700.c
>   - Update "config PCIE_EIC7700" bool to tristate.
>   - Remove fix MSI-X code, depend on new commit [1].
>   - Add set no_pme_handshake flag.
>   - Update -EINVAL to -ENODATA and add PM runtime function.
>   - Add ".probe_type = PROBE_PREFER_ASYNCHRONOUS,".
>   - Update eic7700_pcie_perst_deassert function name to
>     eic7700_pcie_perst_reset.
>   - Update readw to dw_pcie_readw_dbi function.
>   - Add comments above reset_control_bulk_deassert function.
> 
> - Updates: pcie-designware.h pcie-designware-host.c
>  -  The ESWIN EIC7700 SoC lacks hardware support for the L2/L3 low-power
>     link states. It cannot enter the L2/L3 ready state through the
>     PME_Turn_Off/PME_To_Ack handshake protocol. To address this, add a
>     no_pme_handshake flag skip PME_Turn_Off broadcast and link state check
>     code, other driver can reuse this flag if meet the similar situation.
> - Link to V6: https://lore.kernel.org/linux-pci/20251120101018.1477-1-zhangsenchuan@eswincomputing.com/
> - Link to: https://lore.kernel.org/linux-pci/20251109-remove_cap-v1-3-2208f46f4dc2@oss.qualcomm.com/ [1]
> 
> Changes in v6:
> - Updates: eswin,eic7700-pcie.yaml
>   - Add Reviewed-by: Rob Herring (Arm) <robh@kernel.org>.
> 
> - Updates: pcie-eic7700.c
>   - Remove pci_root_ports_have_device function judgment during suspend.
>   - Remove eic7700_pcie_pme_turn_off and eic7700_pcie_get_ltssm function.
>   - Add set no_suspport_L2 flag.
> 
> - Updates: pcie-designware.h pcie-designware-host.c
>  - The ESWIN EIC7700 soc does not support enter L2 link state. Therefore
>    add no_suspport_L2 flag skip PME_Turn_Off broadcast and link state
>    check code, other driver can reuse this flag if meet the similar
>    situation.
> - Link to V5: https://lore.kernel.org/all/20251110090716.1392-1-zhangsenchuan@eswincomputing.com/
> - Link to: https://lore.kernel.org/all/e7plmtwtkkd4ymrt2hkztcqdx4ugfjk64oksjyf6lpi2oui53d@vhuo5occyref/
> 
> Changes in v5:
> - Updates: eswin,eic7700-pcie.yaml
>   - Modify reg-names: update mgmt to elbi.
>   - Modify clock-names: update pclk to phy_reg.
>   - Modify reset-names: update powerup to pwr.
>   - Remove powerup modify in "snps,dw-pcie-common.yaml" file.
> 
> - Updates: pcie-eic7700.c
>   - Update the driver submission comment, mention EIC7700 in the
>     "config PCIE_EIC7700" and in the driver title.
>   - Update some comments, for examples: "s/PME_TURN_OFF/PME_Turn_Off/",
>     "s/INTX/INTx/", "s/PERST/PERST#/", "s/perst/PERST#/", "s/id/ID/".
>   - Update "struct *_pcie" name and function name, add the eic7700 prefix.
>   - Use PCIEELBI_CTRL0_DEV_TYPE macro and update comment, use FIELD_PREP.
>   - Add eic7700_pcie_data pointer in struct eic7700_pcie.
>   - Update .deinit callback function name and removed the dw_pcie_link_up
>     judgment, add pci_root_ports_have_device function judgment.
>   - Remove devm_platform_ioremap_resource_byname function get mgmt, use
>     platform_get_resource_byname function get elbi in "pcie-designware.c".
>   - Update of_reset_control_get to of_reset_control_get_exclusive, use
>     devm_reset_control_bulk_get_exclusive function get resets, update use
>     reset_control_bulk_assert/reset_control_bulk_deassert function.
> - Link to V4: https://lore.kernel.org/all/20251030082900.1304-1-zhangsenchuan@eswincomputing.com/
> - Link to https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree/?h=controller/dwc
> 
> Changes in v4:
> - Updates: eswin,eic7700-pcie.yaml
>   - Use snps,dw-pcie.yaml instead pci-host-bridge.yaml.
> 
> - Updates: snps,dw-pcie-common.yaml
>   - Add powerup reset property, our powerup property is somewhat different
>     from the general attributes defined by Synopsys DWC binding.
> 
> - Updates: pcie-eic7700.c
>   - Update the driver submission comment.
>   - Alphabetize so the menuconfig entries remain sorted by vendor.
>   - Update use PCI_CAP_LIST_NEXT_MASK macro.
>   - Use readl_poll_timeout function.
>   - Update eswin_pcie_suspend/eswin_pcie_resume name to
>     eswin_pcie_suspend_noirq/eswin_pcie_resume_noirq.
>   - PM use dw_pcie_suspend_noirq and dw_pcie_resume_noirq function and add
>     eswin_pcie_get_ltssm, eswin_pcie_pme_turn_off, eswin_pcie_host_exit
>     function adapt to PM.
> - Link to V3: https://lore.kernel.org/linux-pci/20250923120946.1218-1-zhangsenchuan@eswincomputing.com/
> 
> Changes in v3:
> - Updates: eswin,eic7700-pcie.yaml
>   - Based on the last patch yaml file, devicetree separates the root port
>     node, changing it significantly. Therefore, "Reviewed-by: Krzysztof
>     Kozlowski <krzysztof.kozlowski@linaro.org>" is not added.
>   - Clock and reset drivers are under review. In yaml, macro definitions
>     used in clock and reset can only be replaced by constant values.
>   - Move the num-lanes and perst resets to the PCIe Root Port node, make
>     it easier to support multiple Root Ports in future versions of the
>     hardware.
>   - Update the num-lanes attribute and modify define num-lanes as decimal.
>   - Optimize the ranges attribute and clear the relocatable flag (bit 31)
>     for any regions.
>   - Update comment: inte~inth are actual interrupts and these names align
>     with the interrupt names in the hardware IP, inte~inth interrupts
>     corresponds to Deassert_INTA~Deassert_INTD.
>   - Add Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>.
> 
> - Updates: pcie-eic7700.c
>   - Update the submission comment and add DWC IP revision, data rate, lane
>     information.
>   - Optimize the "config PCIE_EIC7700" configuration.
>   - Optimize the macro definition, add bitfield definition for the mask,
>     and remove redundant comments. optimize comments, make use of 80
>     columns for comments.
>   - Use the dw_pcie_find_capability function to obtain the offset by
>     traversing the function list.
>   - Remove the sets MPS code and configure it by PCI core.
>   - Alphabetize so the menuconfig entries remain sorted by vendor.
>   - Configure ESWIN VID:DID for Root Port as the default values are
> 	invalid,and remove the redundant lane config.
>   - Use reverse Xmas order for all local variables in this driver
>   - Hardware doesn't support MSI-X but it advertises MSI-X capability, set
>     a flag and clear it conditionally.
>   - Resets are all necessary, Update the interface function for resets.
>   - Since driver does not depend on any parent to power on any resource,
>     the pm runtime related functions are removed.
>   - Remove "eswin_pcie_shutdown" function, our comment on the shutdown
>     function is incorrect. Moreover, when the host powers reboots,it will
>     enter the shutdown function, we are using host reset and do not need
>     to assert perst. Therefore, the shutdown function is not necessary.
>   - remove "eswin_pcie_remove", because it is not safe to remove it during
>     runtime, and this driver has been modified to builtin_platform_driver
>     and does not support hot plugging, therefore, the remove function is
>     not needed.
>   - The Suspend function adds link state judgment, and for controllers
>     with active devices, resources cannot be turned off.
>   - Add Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>.
> - Link to V2: https://lore.kernel.org/linux-pci/20250829082021.49-1-zhangsenchuan@eswincomputing.com/
> 
> Changes in v2:
> - Updates: eswin,eic7700-pcie.yaml
>   - Optimize the naming of "clock-names" and "reset-names".
>   - Add a reference to "$ref: /schemas/pci/pci-host-bridge.yaml#".
>     (The name of the reset attribute in the "snps,dw-pcie-common.yaml"
>     file is different from our reset attribute and "snps,dw-pcie.yaml"
>     file cannot be directly referenced)
>   - Follow DTS coding style to optimize yaml attributes.
>   - Remove status = "disabled" from yaml.
> 
> - Updates: pcie-eic7700.c
>   - Remove unnecessary imported header files.
>   - Use dev_err instead of pr_err and remove the WARN_ON function.
>   - The eswin_evb_socket_power_on function is removed and not supported.
>   - The eswin_pcie_remove function is placed after the probe function.
>   - Optimize function alignment.
>   - Manage the clock using the devm_clk_bulk_get_all_enabled function.
>   - Handle the release of resources after the dw_pcie_host_init function
>     call fails.
>   - Remove the dev_dbg function and remove __exit_p.
>   - Add support for the system pm function.
> - Link to V1: https://lore.kernel.org/all/20250516094057.1300-1-zhangsenchuan@eswincomputing.com/
> 
> Senchuan Zhang (2):
>   dt-bindings: PCI: eic7700: Add Eswin PCIe host controller
>   PCI: eic7700: Add Eswin PCIe host controller driver
> 
>  .../bindings/pci/eswin,eic7700-pcie.yaml      | 167 +++++++
>  drivers/pci/controller/dwc/Kconfig            |  11 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  drivers/pci/controller/dwc/pcie-eic7700.c     | 410 ++++++++++++++++++
>  4 files changed, 589 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
>  create mode 100644 drivers/pci/controller/dwc/pcie-eic7700.c
> 
> --
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
