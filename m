Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E0648097E;
	Mon,  5 Oct 2026 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791223468; cv=none; b=hZzASZQAXgxCqJh27WsxbG9wfNOLrDxJzDzEzHRP/inI7ro+3X52XWeFBXNgUn4WPS7dlK5AxlZVoSeYc5ky3lKYYa5fgb3ywaXZJ7eJy13CWGJvpXk8gIUQ2s/DV0wDN0hMmCzhudDBZ5cn2WEHHLmW0klieBPa/0AE5lk0P1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791223468; c=relaxed/simple;
	bh=h/CtaGN11E0t8u67h1ojFVZ6txNrQpPjPFLOVlAhaAw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uQ6GXsQ4vJG4UlxbxiPzNZDbc80n7TthwqSBdnDaDi4FCSXSErWEwLYZK3410zzyZWlnDk1prdz4iSYYgKGDABCmpgDk8dCZaVg3Z1BCvZfy7uLo8hprmvPi0ax6tD12y/ef/I5E5adlytkzBygkP1fNLHrJmDVJdgEqIk1ZN8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4mw0icx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4mw0icx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791223466; x=1822759466;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=h/CtaGN11E0t8u67h1ojFVZ6txNrQpPjPFLOVlAhaAw=;
  b=m4mw0icx8ccFTEO6caopBnRBS2uP7v73Vww+cQbbqXanCK8sHOxiTqao
   gKks/ZSlaWqj7no7+u2gu6Qz0O2I6VCbfFFw69cVLqRwLN81D3tffaxsR
   2mqFiMXuSm7hZdpFc+DY9R58pkAvdpxjw3t/NEJh8DqeFJ5CYTy5zG7mb
   fPDaILnPqfJJ+Qd2xVriCFeuDmaK9hsMd37M7Lwyjgx6bnHyoJ2l6Azo7
   BCV+Cvi0Hb5ZposmA5SHr4UjH8jBbNGScz4k9B99TWdjfnqwWRZymm3QD
   VGs5O5BZR49ZqgYOgihCwsVNPUkMc7fw5yFuyr/tTyzD4470T46qYAZDW
   w==;
X-CSE-ConnectionGUID: FFRqdM5rSNaGQkR6gQ12kg==
X-CSE-MsgGUID: eZG9amjkTeGxg7NREU4MnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="102572820"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="102572820"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 11:04:25 -0700
X-CSE-ConnectionGUID: ZbI86zzuTv2F+PtGYO9lvQ==
X-CSE-MsgGUID: aN3h9SmsRSqs7dIlnRhkXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="941975"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 11:04:25 -0700
Message-ID: <f8a4a8f1-f2c6-46d2-ba5f-370f12b73afd@linux.intel.com>
Date: Mon, 5 Oct 2026 11:04:25 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 4/4] PCI: Centralize pci_aer_available() checking
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org, lukas@wunner.de,
 terry.bowman@amd.com, kanie@linux.alibaba.com, olof@lixom.net
References: <20261002211828.1293177-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261002211828.1293177-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20261002211828.1293177-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bjorn,

On 10/2/2026 2:18 PM, Kuppuswamy Sathyanarayanan wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> "pci=noaer" tells us not to use AER.  pci_aer_available() reports that,
> and it also reports the other cases where the OS cannot use AER at all,
> namely CONFIG_PCIEAER=n and MSI being unavailable.
> 
> Set host_bridge->native_aer from pci_aer_available() when we initialize
> the host bridge, so callers only have to look at native_aer and we do not
> have to test pci_aer_available() separately in each of them.
> 
> Do this in pci_init_host_bridge() rather than in acpi_pci_root_create()
> so it also covers host bridges that are not described by ACPI and never
> reach acpi_pci_root_create().
> 
> This subsumes the CONFIG_PCIEPORTBUS check for native_aer, since
> pci_aer_available() is false when CONFIG_PCIEAER=n and PCIEAER depends on
> PCIEPORTBUS.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---

Sashiko's comment [1] looks valid to me. quirk_disable_all_msi() calls
pci_no_msi() during pci_bus_add_devices(), after native_aer has been
set. That leaves native_aer stale. At boot, pcie_aer_init() checks
pci_aer_available() again, so the AER driver still won't register. But
other native_aer users see the stale value.

The patch below clears native_aer in pci_no_msi(). Would you like a v16
with it before this patch, or would you rather fold it in?

[1] https://lore.kernel.org/linux-pci/20261003013359.A38F61F00898@smtp.kernel.org/

Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Mon Oct 5 10:29:19 2026 -0700

    PCI/AER: Clear native_aer when MSI is disabled after host bridge init

    pci_aer_available() reports that AER is unusable when MSI is disabled.
    A quirk such as quirk_disable_all_msi() can call pci_no_msi() during
    enumeration, after pci_init_host_bridge() and the _OSC negotiation have
    already set host_bridge->native_aer. In that case native_aer stays set
    even though the OS can no longer use AER.

    Clear native_aer on all registered host bridges when MSI is disabled.
    Host bridges added later start with native_aer cleared because
    pci_aer_available() is already false. _OSC negotiation and
    "pcie_ports=native" can only clear native_aer, so they cannot set it
    again.

    This keeps native_aer accurate so callers can rely on it instead of
    checking pci_aer_available() separately.

    Reported-by: sashiko-bot@kernel.org
    Closes: https://lore.kernel.org/linux-pci/20261003013359.A38F61F00898@smtp.kernel.org/
    Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 80a9db417dc8..911e61fbda31 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -995,4 +995,5 @@ EXPORT_SYMBOL(msi_desc_to_pci_dev);
 void pci_no_msi(void)
 {
        pci_msi_enable = false;
+       pci_aer_no_msi();
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..11f47d5fda21 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1331,6 +1331,7 @@ static inline void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge

 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
+void pci_aer_no_msi(void);
 void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
@@ -1342,6 +1343,7 @@ void pci_save_aer_state(struct pci_dev *dev);
 void pci_restore_aer_state(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
+static inline void pci_aer_no_msi(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e84dd686582a..494fdd20798d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -154,6 +154,19 @@ bool pci_aer_available(void)
        return !pcie_aer_disable && pci_msi_enabled();
 }

+/*
+ * AER depends on MSI (see pci_aer_available()).  If MSI is disabled after
+ * host bridges have been initialized, e.g., by a quirk, the OS can no
+ * longer use AER on them.
+ */
+void pci_aer_no_msi(void)
+{
+       struct pci_bus *bus = NULL;
+
+       while ((bus = pci_find_next_bus(bus)))
+               pci_find_host_bridge(bus)->native_aer = 0;
+}
+
 #ifdef CONFIG_PCIE_ECRC

 #define ECRC_POLICY_DEFAULT 0          /* ECRC set by BIOS */


> Changes since v14
> 
>  * No change.
> 
> v14 posting
> https://lore.kernel.org/r/20260922204548.3884906-1-sathyanarayanan.kuppuswamy@linux.intel.com
> 
> Changes since v13
> 
>  * No change.
> 
> v13 posting
> https://lore.kernel.org/r/20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com
> 
>  drivers/pci/pcie/portdrv.c | 3 +--
>  drivers/pci/probe.c        | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 32fc623dd410..9f8c6dd434c5 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -239,8 +239,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  #ifdef CONFIG_PCIEAER
>  	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>               pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
> -	    dev->aer_cap && pci_aer_available() &&
> -	    host->native_aer)
> +	    dev->aer_cap && host->native_aer)
>  		services |= PCIE_PORT_SERVICE_AER;
>  #endif
>  
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 1e487a213eb0..e1ca8096bcd5 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -670,7 +670,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  	 * may implement its own AER handling and use _OSC to prevent the
>  	 * OS from interfering.
>  	 */
> -	bridge->native_aer = port_services;
> +	bridge->native_aer = pci_aer_available();
>  	bridge->native_pcie_hotplug = port_services;
>  	bridge->native_shpc_hotplug = 1;
>  	bridge->native_pme = port_services;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

