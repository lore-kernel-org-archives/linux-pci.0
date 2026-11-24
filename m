Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546151;
	b=x+soflHgjwnVUHBUmKcJ/C+5oLXKsSePeV0JaQ3144OjolCmXDfwW0T0d9ppRxMuGrFl
	 JhqHI6XO4XilMUDptUNNleZRkCKI4HFnTHOLWakBiMgve4mhTetQ9QmP1flLiDJElzwdt
	 VgEo+fx1KunTx9jhm6X/amTKW27C64CZm2uOpS5MX5zgV3xZW0xtARdX+uHxOujh72gVN
	 Im9kJYsBbYoT2TXwKb1ZXw4hVZ7s/vrnFwGU/ALMbkakes8eiVKYZkureuICjSjo2w0U8
	 tFSZKtSZpQ/YtWy+Tq78IGqOKYJAXY3c0qtXtjhZZAaOhpBUDnkgX7wZyLhpxO/OqTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=4yLPI/bzfD8pEXes+IoGrcyl3dKDKR1GnvriWiKOLpo=;
	b=jLHnpfPk5oWjPJDM1SfF8mapjh39Igi8rTJBNezeVm/Z5xvmpNIfmzaw46K323VvU7a5
	 rOzrE0qZiwhDzsGHYqAGWr364E0Q6tv/D9nL6pLtMG5vYyR3l7o+Tr/GlwOJlRKOvWW3b
	 nUC+CgUibFhJOR72TZ+6Agk7wt3lbgv0NrRDsCUPlJTX/V4I16I1IIrPKok5Q+OEMlIuK
	 xE7729L+D6ttDAdH5Wb+/ep4jxonxNP3PtOrWNEmb8GeomsIr2JVq4k/ey0Pdy5hKRWym
	 TS7cHENxNYo3ONkkDIT+4KBPH087s5EccUvG2RLZIrOdQ98hNlR1dBfi7QrBE0C2QgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=G3hp8gfc;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C59606A321
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 18:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3C59606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=G3hp8gfc
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4b52fcb410dso1268050f8f.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 10:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795546149; x=1796150949; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4yLPI/bzfD8pEXes+IoGrcyl3dKDKR1GnvriWiKOLpo=;
        b=G3hp8gfckd/4YqJylhwOM2V4zLHeR/F33cnRjJlXi8H+zG4x/tkhHg/3TaVxwBBXQQ
         WOIMMeflCtIyrImXli/BFZZOFCai/pzwvA4oD7Nl4N/RWr1gVyl1Z9gaZeL5cD0UOxRV
         oBEt9oTJT6iNyn0B01GKgcTOnauv4eS17mdag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795546149; x=1796150949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4yLPI/bzfD8pEXes+IoGrcyl3dKDKR1GnvriWiKOLpo=;
        b=Hkr0H4TUx4DPVSrpI0pTP5lpqeO9j3WuwgCnpBkNhByMzkdy+r6Edyxo+DYR6Zv6yQ
         yFodTSNHSRR6SZ4ch5yWcrYVaKKG6FZP6x955MjSkGPtZEqbsV4H4mwnfzADpOVLcL6v
         7/wPXjMEwHITpVn9z83GnK/qKujQuZO1obNjF499I5u5rLJwa88vd65rT8idQQE1Ps9/
         i+biMRq9HbjMpVbPkfh5fxzK6anWgSdo6g3vo+L9mPfXOwfY1r1XR4xAnJPLiMyuv/Vn
         I7oeBgjtAcJ8gT/cuJmSuwT1moyHA8DHAOXqphdQCIVRO7aL9sAKweiDUVJi/DUuabT6
         0jKg==
X-Forwarded-Encrypted: i=1; AL+hErFc8e0ak/JstKH3NL4pYzRrMg13sVG16Cjr5g8q4yyAkupLIaqA4xP55wFqC5i1brfVTcI9iAdD66c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8hBLwQv4oea531X2gnKQWaZB9l8+qGWQRkmni2ZPiM7QwJcVyS
	bbBfjU503Vx2SywxAd1943bmWQnunZk829BGT2h3fK3nGyVHOWmZUl7GgA0H4e1kpg==
X-Gm-Gg: AZFdTZdfig5Byy9sT47bOy1XMJyTHkfov+NATnMzvqwvRD/44w1lmibfeciscqEXEoZ
	I7zcL5nwYW7fX5VM3bsHWaz30RKtLh08HEzyk8U33vZ+BZ9WRFLKv57nhVRd+57ggJEAf9rgQlg
	qnjgFvztDn/4QgI6aZ3NLJl7jjxwduEo7OFVFvBlxxkhE9G5rETejIg9sIEGtOLaXbLUGIrmZj4
	5d4Ssu0u/rbmn83RbKoLjc87UZ1GnkwV0v/ZlfRDgHBcQ6LHFwMvoBDhF9LhLIN+c7lLBq+Ta/c
	KWzVMP7/eKgcvoJ+Ydb5xcIawLpLdC/zKV5zVKdGcBUB7Cld7ryjkcQuzTujPHDbh0GhqeYfP3L
	l7+jvkkqCX2ttimzccYtF1zHAa7jRqBtF9jy+14kiFNuB6fNr5+SXcItneD0z334q0eHRKgqA4a
	SI4SuC/RmfgjMWvEuIPGwDIGwhMNgIxzLICBbzUwOv/slXOMDdM58Qzj6DiqzUyM5ND7cDDh6bt
	nsBF7xDXZR8qD/KraNKLbAv+QGnjHX2/uY4DfcDE3wddtkoWyP5Trz6Ps7bs+QZr/IVSwknk57N
	8erneHRvu78i9PEifuIpcKyeO7D8Q4wFMYGaG+nwLi265+rNxGvxOz67L9JRPSYE
X-Received: by 2002:a05:600c:1d09:b0:4bb:66fd:ad68 with SMTP id 5b1f17b1804b1-4bb888160cdmr336029925e9.14.1795546148684;
        Tue, 24 Nov 2026 10:49:08 -0800 (PST)
Received: from google.com ([2a00:79e0:285b:8:af0c:c5f1:ee8a:b81f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm367300855e9.0.2026.11.24.10.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:49:08 -0800 (PST)
Date: Tue, 24 Nov 2026 19:49:04 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	iommu@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI: Detect and trust built-in Thunderbolt chips
Message-ID: <awXXSfrhLHK7TNbp@google.com>
References: <20240910-trust-tbt-fix-v5-1-7a7a42a5f496@chromium.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240910-trust-tbt-fix-v5-1-7a7a42a5f496@chromium.org>

On Tue, Sep 10, 2024 at 05:57:45PM +0000, Esther Shimanovich wrote:
> Some computers with CPUs that lack Thunderbolt features use discrete
> Thunderbolt chips to add Thunderbolt functionality. These Thunderbolt
> chips are located within the chassis; between the root port labeled
> ExternalFacingPort and the USB-C port.
> 
> These Thunderbolt PCIe devices should be labeled as fixed and trusted,
> as they are built into the computer. Otherwise, security policies that
> rely on those flags may have unintended results, such as preventing
> USB-C ports from enumerating.
> 
> Detect the above scenario through the process of elimination.
> 
> 1) Integrated Thunderbolt host controllers already have Thunderbolt
>    implemented, so anything outside their external facing root port is
>    removable and untrusted.
> 
>    Detect them using the following properties:
> 
>      - Most integrated host controllers have the usb4-host-interface
>        ACPI property, as described here:
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers
> 
>      - Integrated Thunderbolt PCIe root ports before Alder Lake do not
>        have the usb4-host-interface ACPI property. Identify those with
>        their PCI IDs instead.
> 
> 2) If a root port does not have integrated Thunderbolt capabilities, but
>    has the ExternalFacingPort ACPI property, that means the manufacturer
>    has opted to use a discrete Thunderbolt host controller that is
>    built into the computer.
> 
>    This host controller can be identified by virtue of being located
>    directly below an external-facing root port that lacks integrated
>    Thunderbolt. Label it as trusted and fixed.
> 
>    Everything downstream from it is untrusted and removable.
> 
> The ExternalFacingPort ACPI property is described here:
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports
> 
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> While working with devices that have discrete Thunderbolt chips, I
> noticed that their internal TBT chips are inaccurately labeled as
> untrusted and removable.
> 
> I've observed that this issue impacts all computers with internal,
> discrete Intel JHL Thunderbolt chips, such as JHL6240, JHL6340, JHL6540,
> and JHL7540, across multiple device manufacturers such as Lenovo, Dell,
> and HP.
> 
> This affects the execution of any downstream security policy that
> relies on the "untrusted" or "removable" flags.
> 
> I initially submitted a quirk to resolve this, which was too small in
> scope, and after some discussion, Mika proposed a more thorough fix:
> https://lore.kernel.org/lkml/20240510052616.GC4162345@black.fi.intel.com
> I refactored it and am submitting as a new patch.
> ---
> Changes in v5:
> - Applied the following edits suggested by Lukas Wunner:
>   - Applied ifdefs edits to ensure code is only compiled on x86 systems
>   with ACPI
>   - Added returns to avoid unecessary checks
>   - Renamed pcie_is_tunneled to arch_pci_dev_is_removable
> - Link to v4: https://lore.kernel.org/r/20240823-trust-tbt-fix-v4-1-c6f1e3bdd9be@chromium.org
> 
> Changes in v4:
> - Applied edits on logic-flow clarity and formatting suggested by Ilpo
>   Järvinen
> - Mario Limonciello tested patch and confirmed works as intended.
> - Link to v3: https://lore.kernel.org/r/20240815-trust-tbt-fix-v3-1-6ba01865d54c@chromium.org
> 
> Changes in v3:
> - Incorporated minor edits suggested by Mika Westerberg.
> - Mika Westerberg tested patch (more details in v2 link)
> - Added "reviewed-by" and "tested-by" lines
> - Link to v2: https://lore.kernel.org/r/20240808-trust-tbt-fix-v2-1-2e34a05a9186@chromium.org
> 
> Changes in v2:
> - I clarified some comments, and made minor fixins
> - I also added a more detailed description of implementation into the
>   commit message
> - Added Cc recipients Mike recommended
> - Link to v1: https://lore.kernel.org/r/20240806-trust-tbt-fix-v1-1-73ae5f446d5a@chromium.org
> ---
>  arch/x86/pci/acpi.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c |  30 +++++++++----
>  include/linux/pci.h |   6 +++
>  3 files changed, 148 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 55c4b07ec1f6..62271668c3b1 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -250,6 +250,125 @@ void __init pci_acpi_crs_quirks(void)
>  		pr_info("Please notify linux-pci@vger.kernel.org so future kernels can do this automatically\n");
>  }
>  
> +/*
> + * Checks if pdev is part of a PCIe switch that is directly below the
> + * specified bridge.
> + */
> +static bool pcie_switch_directly_under(struct pci_dev *bridge,
> +				       struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent = pci_upstream_bridge(pdev);
> +
> +	/* If the device doesn't have a parent, it's not under anything. */
> +	if (!parent)
> +		return false;
> +
> +	/*
> +	 * If the device has a PCIe type, check if it is below the
> +	 * corresponding PCIe switch components (if applicable). Then check
> +	 * if its upstream port is directly beneath the specified bridge.
> +	 */
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_UPSTREAM:
> +		return parent == bridge;
> +
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +		if (pci_pcie_type(parent) != PCI_EXP_TYPE_UPSTREAM)
> +			return false;
> +		parent = pci_upstream_bridge(parent);
> +		return parent == bridge;
> +
> +	case PCI_EXP_TYPE_ENDPOINT:
> +		if (pci_pcie_type(parent) != PCI_EXP_TYPE_DOWNSTREAM)
> +			return false;
> +		parent = pci_upstream_bridge(parent);
> +		if (!parent || pci_pcie_type(parent) != PCI_EXP_TYPE_UPSTREAM)
> +			return false;
> +		parent = pci_upstream_bridge(parent);
> +		return parent == bridge;
> +	}
> +
> +	return false;
> +}
> +
> +static bool pcie_has_usb4_host_interface(struct pci_dev *pdev)
> +{
> +	struct fwnode_handle *fwnode;
> +
> +	/*
> +	 * For USB4, the tunneled PCIe root or downstream ports are marked
> +	 * with the "usb4-host-interface" ACPI property, so we look for
> +	 * that first. This should cover most cases.
> +	 */
> +	fwnode = fwnode_find_reference(dev_fwnode(&pdev->dev),
> +				       "usb4-host-interface", 0);
> +	if (!IS_ERR(fwnode)) {
> +		fwnode_handle_put(fwnode);
> +		return true;
> +	}
> +
> +	/*
> +	 * Any integrated Thunderbolt 3/4 PCIe root ports from Intel
> +	 * before Alder Lake do not have the "usb4-host-interface"
> +	 * property so we use their PCI IDs instead. All these are
> +	 * tunneled. This list is not expected to grow.
> +	 */
> +	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
> +		switch (pdev->device) {
> +		/* Ice Lake Thunderbolt 3 PCIe Root Ports */
> +		case 0x8a1d:
> +		case 0x8a1f:
> +		case 0x8a21:
> +		case 0x8a23:
> +		/* Tiger Lake-LP Thunderbolt 4 PCIe Root Ports */
> +		case 0x9a23:
> +		case 0x9a25:
> +		case 0x9a27:
> +		case 0x9a29:
> +		/* Tiger Lake-H Thunderbolt 4 PCIe Root Ports */
> +		case 0x9a2b:
> +		case 0x9a2d:
> +		case 0x9a2f:
> +		case 0x9a31:
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +bool arch_pci_dev_is_removable(struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent, *root;
> +
> +	/* pdev without a parent or Root Port is never tunneled. */
> +	parent = pci_upstream_bridge(pdev);
> +	if (!parent)
> +		return false;
> +	root = pcie_find_root_port(pdev);
> +	if (!root)
> +		return false;
> +
> +	/* Internal PCIe devices are not tunneled. */
> +	if (!root->external_facing)
> +		return false;
> +
> +	/* Anything directly behind a "usb4-host-interface" is tunneled. */
> +	if (pcie_has_usb4_host_interface(parent))
> +		return true;
> +
> +	/*
> +	 * Check if this is a discrete Thunderbolt/USB4 controller that is
> +	 * directly behind the non-USB4 PCIe Root Port marked as
> +	 * "ExternalFacingPort". Those are not behind a PCIe tunnel.
> +	 */
> +	if (pcie_switch_directly_under(root, pdev))
> +		return false;
> +
> +	/* PCIe devices after the discrete chip are tunneled. */
> +	return true;
> +}
> +
>  #ifdef	CONFIG_PCI_MMCONFIG
>  static int check_segment(u16 seg, struct device *dev, char *estr)
>  {
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b14b9876c030..7e0d6a1e151b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1631,23 +1631,33 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>  
>  static void set_pcie_untrusted(struct pci_dev *dev)
>  {
> -	struct pci_dev *parent;
> +	struct pci_dev *parent = pci_upstream_bridge(dev);
>  
> +	if (!parent)
> +		return;
>  	/*
> -	 * If the upstream bridge is untrusted we treat this device
> +	 * If the upstream bridge is untrusted we treat this device as
>  	 * untrusted as well.
>  	 */
> -	parent = pci_upstream_bridge(dev);
> -	if (parent && (parent->untrusted || parent->external_facing))
> +	if (parent->untrusted) {
> +		dev->untrusted = true;
> +		return;
> +	}
> +
> +	if (arch_pci_dev_is_removable(dev)) {

Looks like this caused a regression: on non-x86, dev->untrusted is never
set to true for any device (so we *never* enforce DMA protection from
externally plugged devices), since set_pcie_untrusted() solely relies on
arch_pci_dev_is_removable() which is implemented on x86 only (on other
archs it is a stub returning false), without checking
parent->external_facing on other archs like it did before this patch.

(I found this by looking at the code, not by testing.)

> +		pci_dbg(dev, "marking as untrusted\n");
>  		dev->untrusted = true;
> +	}
>  }
>  
>  static void pci_set_removable(struct pci_dev *dev)
>  {
>  	struct pci_dev *parent = pci_upstream_bridge(dev);
>  
> +	if (!parent)
> +		return;
>  	/*
> -	 * We (only) consider everything downstream from an external_facing
> +	 * We (only) consider everything tunneled below an external_facing
>  	 * device to be removable by the user. We're mainly concerned with
>  	 * consumer platforms with user accessible thunderbolt ports that are
>  	 * vulnerable to DMA attacks, and we expect those ports to be marked by
> @@ -1657,9 +1667,15 @@ static void pci_set_removable(struct pci_dev *dev)
>  	 * accessible to user / may not be removed by end user, and thus not
>  	 * exposed as "removable" to userspace.
>  	 */
> -	if (parent &&
> -	    (parent->external_facing || dev_is_removable(&parent->dev)))
> +	if (dev_is_removable(&parent->dev)) {
> +		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> +		return;
> +	}
> +
> +	if (arch_pci_dev_is_removable(dev)) {
> +		pci_dbg(dev, "marking as removable\n");
>  		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> +	}
>  }
>  
>  /**
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 9e36b6c1810e..dca19203bc7c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2604,6 +2604,12 @@ pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
>  static inline bool pci_pr3_present(struct pci_dev *pdev) { return false; }
>  #endif
>  
> +#if defined(CONFIG_X86) && defined(CONFIG_ACPI)
> +bool arch_pci_dev_is_removable(struct pci_dev *pdev);
> +#else
> +static inline bool arch_pci_dev_is_removable(struct pci_dev *pdev) { return false; }
> +#endif
> +
>  #ifdef CONFIG_EEH
>  static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
>  {
> 
> ---
> base-commit: 3f386cb8ee9f04ff4be164ca7a1d0ef3f81f7374
> change-id: 20240806-trust-tbt-fix-5f337fd9ec8a
> 
> Best regards,
> -- 
> Esther Shimanovich <eshimanovich@chromium.org>
> 
