Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491251;
	b=mwXQfByEA18JOvOLeDJpSIRjg2I9z/mQbFNBmErmAhk6+QdN/gQt6EMm+1kPx0hXfsNQ
	 JPOlsp4WMWwwz6NPEFpaAANqEw3CLLLOrwHCwimkTQ6YdkH53oMbDOHN3kX2ZCfWdhp8P
	 xbtb6sdhjKNWh6vLhK4KUf+kRhMZnZbQw45a2aMkf6wJssqbVF59+QaNdNJpncRKQyQTN
	 iZo/7ENz47pnCEb9oViPehofTeoRB/bB+fcuaVF9x22FfUhEgZfEGo0+/20+04Aq6BZ9L
	 OABrD/CFTDss/HAouWk0AVlqFKtYU0/b9fr6ToW4ozUP5tvMbaWwZO6JBirMqhQpiuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491251;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=CVcdyzL91lBGPj/fpgpYYul1GLETbGc5TcBdsUwwYCI=;
	b=A9Fv3aYAehwXjclYvnu0y/qzxdyDodAf8DGtN8+u8NhHJjKZ+KhWoK53MokkBlxzXBcx
	 zGwOOo+fzGq3ozpIFSVCXgk/j+u7n6eZ4o6QE+6XYfmL+PoOb9oCnQI5guFd6kRNqNsrX
	 dFmYE5Vyl2N+I/dFWaHwUzrU+2dJX9HUF0MworMG4rhFGcUEMokNv04U15MHjo77KSVmI
	 hRS5TE543J10sRa92M9aDAxvsB/qJ26ZmUJiWkiCCqpY2PvXveu7kG814Fq4s1Vv05VPe
	 tIj2wztPjLICrZrXicEzUF9F7Yn8n3VzX9BwRZBWxoP6zyJofMcYEMtyXAXJkq34hTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KHJ+VDsM;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59BD606A319;
	Tue, 20 Oct 2026 10:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C59BD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KHJ+VDsM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792491251; x=1824027251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gCu7N3U/7ot6H+daKJ5gqVb7xx1JZknhti2F4byFRzM=;
  b=KHJ+VDsMv+n7Bg2co6VeqXhm2WAtLfhVvjryfz0TnF0lzl8r4IDPZD92
   KKrGsGXtv/q3NKbh/hqCpd7ApUXW9pK9AsqV1GorjufE0ElXsFvB8gxBc
   9AwDIrH/mC/2R+DSjVkeaRDXINZjJpUo9DqkRy/NnuGtl9/XvOU1+0yvT
   nkRqMoscOTXJcrshLTYFxI8mJxm4g9iRaL1yLbT93V5iGQcisr0vzxJ55
   yvIrXr2J/xLvqN7upMP+jULD1lmt73igL+o9TnvoQUnK0tjaPhigdxQWX
   XXaxrq37KD7PZRfH7cVXb4mtpU04dXgUWO403St/msvkpw6PjktCHeGgK
   w==;
X-CSE-ConnectionGUID: BQPYvMRBRQu1y27Ns6wrWA==
X-CSE-MsgGUID: nAfUfI4CQhaEBwhQ+UC2lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1200893"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1200893"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 03:14:10 -0700
X-CSE-ConnectionGUID: N7bpVBtCStCVNe9LeVpt/g==
X-CSE-MsgGUID: yZrYG5JbRMipeyDtPmNuMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3193594"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 20 Oct 2026 03:14:07 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 73BDF9B; Tue, 20 Oct 2026 12:14:06 +0200 (CEST)
Date: Tue, 20 Oct 2026 12:14:06 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Francisco =?utf-8?B?QmVsdHLDoW4gTWlsbGFsw6lu?= <fbeltranmillalen@gmail.com>
Cc: andreas.noever@gmail.com, westeri@kernel.org, YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	helgaas@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	lukas@wunner.de, d@rrell.co
Subject: Re: [PATCH v2] thunderbolt: Call SXFP() on Apple systems with Alpine
 Ridge when suspending
Message-ID: <20261020101406.GB176164@black.igk.intel.com>
References: <20261019202900.39062-1-fbeltranmillalen@gmail.com>
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
In-Reply-To: <20261019202900.39062-1-fbeltranmillalen@gmail.com>

Hi,

On Mon, Oct 19, 2026 at 05:29:00PM -0300, Francisco Beltrán Millalén wrote:
> On Apple systems with Alpine Ridge, suspending to RAM with a device
> connected to a Type-C port leaves the PCIe link to the upstream port of
> the controller down on resume, and the ports are lost until reboot.
> Calling the SXFP(0) ACPI method under the NHI before entering sleep
> avoids that, so do it from suspend_noirq of the software connection
> manager.
> 
> The firmware can set bit 26 of plug events CS_20 when it resumes the
> NHI. While it is set SXFP(0) turns the router off and it does not come
> back on resume, so clear the bit first and skip SXFP(0) if that fails.
> 
> Signed-off-by: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>
> ---
> Thanks for the review, Mika.

Looking good, few more comments see below.

> I am sending this alongside "PCI/PM: Keep the saved config space of an
> inaccessible device":
> https://lore.kernel.org/all/20261019202445.38259-1-fbeltranmillalen@gmail.com/
> 
> SXFP(0) also powers down the xHCI on the side of the controller with
> nothing connected.  The automated review of v1 pointed out that if this
> happens before the xHCI saves its state in its own suspend_noirq,
> pci_save_state() stores all ones today, and resume writes them back.
> I found the same by reading the code.  The xHCI and the NHI suspend
> asynchronously, so their order is not fixed.  In my tests below the
> xHCI always saved first, except when I forced SXFP(0) earlier; then the
> PCI patch kept the previous snapshot and the xHCI came back.
> 
> v2:
> - Call SXFP(0) from tb_suspend_noirq() instead of adding a suspend_late
>   callback.  In v1 I wrote that suspend_noirq was too late.  That was
>   measured from the suspend_noirq of the upstream port of the
>   controller, which runs after the NHI and the other devices below it.
>   From the suspend_noirq of the NHI it works (tests below).
> - Renamed to tb_acpi_apple_force_power().
> - Use tb_switch_is_alpine_ridge(), so all Alpine Ridge variants are
>   covered.
> - Use ACPI_COMPANION() and call SXFP through adev->handle, with
>   acpi_execute_simple_method() since it takes a single integer.
> - Added tb_switch_set_bit26(sw, value) in switch.c, without the read
>   back.  It only writes when the bit has to change.  tb->lock is already
>   held by tb_domain_suspend_noirq().
> - Dropped the !sw and going_away checks and the two warnings, moved the
>   register definitions before TB_PLUG_EVENTS_PCIE_*, and dropped the
>   Assisted-by tag.
> - Kept pm_suspend_via_firmware(), as in the Cactus Ridge quirk
>   (quirk_apple_poweroff_thunderbolt()): the OS does not know how to power
>   the controller back on.  Added pm_suspend_in_progress(), because
>   __nhi_suspend_noirq() also runs from nhi_poweroff_noirq() when entering
>   hibernation, where pm_suspend_via_firmware() is true.  Together they
>   limit the call to suspend-to-RAM via firmware.
> 
> v1: https://lore.kernel.org/all/20261019134851.7496-1-fbeltranmillalen@gmail.com/
> 
> About calling SXFP from _PSx or a power resource: I checked the ACPI
> tables of this machine.  SXFP is defined once under each NHI and
> nothing calls it.  The _PS3 of the NHI is empty.
> 
> Testing:
> I tested it on a MacBookPro14,3 (two Alpine Ridge controllers, software
> connection manager) with 6.18.49 and a backport of this patch, which
> uses &nhi->pdev->dev in place of nhi->dev.  The kernel also carried the
> PCI patch above, and a local change equivalent to the ACPICA fix
> mentioned in v1, without which the firmware does not set bit 26 here.
> The PCI quirk from the earlier version was switched off, except where
> noted.  All cycles were 30 second suspends to RAM.
> 
> - Three cycles with a USB 3 disk on one side or the other.  Both
>   domains came back each time, with both upstream port links at 8 GT/s
>   x4, and the disk could be read.
> - One cycle removing the disk while suspended, and one with nothing
>   connected.  Both domains came back, and the disk worked when plugged
>   in afterwards (on both sides after the first, on one after the
>   second).
> - Three more cycles with the disk attached and the old PCI quirk
>   switched on as well, so that SXFP(0) was called earlier, in the PCI
>   suspend phase, to check the PCI patch.  This patch then calls it a
>   second time.  All three resumed with both domains and the disk
>   working, and the disk also worked when moved afterwards to the side
>   that had been empty.
> 
> Not tested:
> - Real Thunderbolt devices, only the USB 3 disk behind the
>   controller's xHCI.
> - Other Alpine Ridge variants.
> - A suspend aborted after SXFP(0).  With v1 I tried it with pm_test set
>   to "platform", but not with this version.
> - An NHI that is runtime suspended when the system suspends.  Here
>   both NHIs were always active.  If one is runtime suspended, the PM
>   core may skip its suspend_noirq (direct_complete), and then SXFP(0)
>   is not called.
> - Suspend-to-idle and hibernation; the checks above keep the patch out
>   of both.
> 
> As noted in v1, a device plugged in while the system is suspended does
> not wake it.  I measured that with the PCI quirk; this patch makes the
> same call, and I did not repeat it.
> 
>  drivers/thunderbolt/acpi.c    | 46 +++++++++++++++++++++++++++++++++++
>  drivers/thunderbolt/switch.c  | 32 ++++++++++++++++++++++++
>  drivers/thunderbolt/tb.c      |  1 +
>  drivers/thunderbolt/tb.h      |  3 +++
>  drivers/thunderbolt/tb_regs.h |  2 ++
>  5 files changed, 84 insertions(+)
> 
> diff --git a/drivers/thunderbolt/acpi.c b/drivers/thunderbolt/acpi.c
> index 53546bc477a5..7a25f89ba14b 100644
> --- a/drivers/thunderbolt/acpi.c
> +++ b/drivers/thunderbolt/acpi.c
> @@ -7,7 +7,9 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/platform_data/x86/apple.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/suspend.h>
>  
>  #include "tb.h"
>  
> @@ -279,6 +281,50 @@ int tb_acpi_power_off_retimers(struct tb_port *port)
>  	return tb_acpi_retimer_set_power(port, false);
>  }
>  
> +/**
> + * tb_acpi_apple_force_power() - Call SXFP(0) on Apple systems with Alpine Ridge
> + * @tb: Domain that is being suspended
> + *
> + * On Apple systems with Alpine Ridge the PCIe link to the upstream port
> + * of the controller does not come up on resume from system sleep if a
> + * device is connected, unless SXFP(0) ("Sx Force Power") under the NHI
> + * is called before entering it. Bit 26 of plug events CS_20 must be
> + * clear when SXFP(0) is called, otherwise the router is turned off and
> + * does not come back on resume.
> + *
> + * Call only when entering system sleep. Does nothing on other systems.
> + */
> +void tb_acpi_apple_force_power(struct tb *tb)
> +{
> +	struct tb_switch *sw = tb->root_switch;
> +	struct acpi_device *adev;
> +	acpi_status status;
> +
> +	if (!x86_apple_machine || !tb_switch_is_alpine_ridge(sw))

I was thinking about this bit more. We can actually call this function
tb_acpi_force_power() and drop both checks from here. Instead call this
from pci.c where you add nhi_ops for the AR similarly than what we have for
ICL and the related.

So there would be ar_nhi_ops that provides the suspend_noirq hook that then
does:

	if (x86_apple_machine)
		tb_acpi_force_power(dev_get_drvdata(nhi->dev));

> +		return;
> +	/*
> +	 * Only when firmware handles system suspend, as in
> +	 * quirk_apple_poweroff_thunderbolt(): the OS does not know how to
> +	 * power the controller back on. pm_suspend_in_progress() excludes
> +	 * hibernation.
> +	 */
> +	if (!pm_suspend_in_progress() || !pm_suspend_via_firmware())
> +		return;
> +
> +	adev = ACPI_COMPANION(tb->nhi->dev);
> +	if (!adev || !acpi_has_method(adev->handle, "SXFP"))
> +		return;
> +
> +	if (tb_switch_set_bit26(sw, false))
> +		return;
> +
> +	tb_sw_dbg(sw, "ACPI: calling SXFP\n");
> +	status = acpi_execute_simple_method(adev->handle, "SXFP", 0);
> +	if (ACPI_FAILURE(status))
> +		tb_sw_warn(sw, "ACPI: SXFP failed: %s\n",
> +			   acpi_format_exception(status));
> +}
> +
>  static bool tb_acpi_bus_match(struct device *dev)
>  {
>  	return tb_is_switch(dev) || tb_is_usb4_port_device(dev);
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 4b8bcba7bd2f..44141b19c1f2 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -4027,6 +4027,38 @@ int tb_switch_xhci_connect(struct tb_switch *sw)
>  	return 0;
>  }
>  
> +/**
> + * tb_switch_set_bit26() - Set or clear bit 26 of plug events CS_20
> + * @sw: Alpine Ridge router
> + * @value: %true to set the bit, %false to clear it
> + *
> + * On Apple systems the firmware can set this bit when it resumes the
> + * NHI. While it is set, SXFP(0) turns the router off and it does not
> + * come back on resume.
> + *
> + * Return: %0 on success, negative errno otherwise.
> + */
> +int tb_switch_set_bit26(struct tb_switch *sw, bool value)
> +{
> +	unsigned int offset = sw->cap_plug_events + TB_PLUG_EVENTS_CS_20;
> +	u32 val;
> +	int ret;
> +
> +	ret = tb_sw_read(sw, &val, TB_CFG_SWITCH, offset, 1);
> +	if (ret)
> +		return ret;
> +
> +	if (!!(val & TB_PLUG_EVENTS_CS_20_BIT26) == value)
> +		return 0;
> +
> +	if (value)
> +		val |= TB_PLUG_EVENTS_CS_20_BIT26;
> +	else
> +		val &= ~TB_PLUG_EVENTS_CS_20_BIT26;
> +
> +	return tb_sw_write(sw, &val, TB_CFG_SWITCH, offset, 1);
> +}
> +
>  /**
>   * tb_switch_xhci_disconnect() - Disconnect internal xHCI
>   * @sw: Router whose xHCI to disconnect
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index 7e39b067e5ff..dd3da25453fa 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -3099,6 +3099,7 @@ static int tb_suspend_noirq(struct tb *tb)
>  	struct tb_cm *tcm = tb_priv(tb);
>  
>  	tb_dbg(tb, "suspending...\n");
> +	tb_acpi_apple_force_power(tb);
>  	tb_disconnect_and_release_dp(tb);
>  	tb_switch_exit_redrive(tb->root_switch);
>  	tb_switch_suspend(tb->root_switch, false);
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index e86845762e22..472e7fbe1a19 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -1097,6 +1097,7 @@ static inline bool tb_switch_clx_is_enabled(const struct tb_switch *sw,
>  int tb_switch_pcie_l1_enable(struct tb_switch *sw);
>  
>  int tb_switch_xhci_connect(struct tb_switch *sw);
> +int tb_switch_set_bit26(struct tb_switch *sw, bool value);

Please move this after the xhci functions:

>  void tb_switch_xhci_disconnect(struct tb_switch *sw);

int tb_switch_xhci_connect(struct tb_switch *sw);
void tb_switch_xhci_disconnect(struct tb_switch *sw);

int tb_switch_set_bit26(struct tb_switch *sw, bool value);

>  int tb_port_state(struct tb_port *port);
> @@ -1524,6 +1525,7 @@ int tb_acpi_init(void);
>  void tb_acpi_exit(void);
>  int tb_acpi_power_on_retimers(struct tb_port *port);
>  int tb_acpi_power_off_retimers(struct tb_port *port);
> +void tb_acpi_apple_force_power(struct tb *tb);
>  #else
>  static inline bool tb_acpi_add_links(struct tb_nhi *nhi) { return false; }
>  
> @@ -1537,6 +1539,7 @@ static inline int tb_acpi_init(void) { return 0; }
>  static inline void tb_acpi_exit(void) { }
>  static inline int tb_acpi_power_on_retimers(struct tb_port *port) { return 0; }
>  static inline int tb_acpi_power_off_retimers(struct tb_port *port) { return 0; }
> +static inline void tb_acpi_apple_force_power(struct tb *tb) { }
>  #endif
>  
>  #ifdef CONFIG_DEBUG_FS
> diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
> index 92d893634d2b..58c8757882f5 100644
> --- a/drivers/thunderbolt/tb_regs.h
> +++ b/drivers/thunderbolt/tb_regs.h
> @@ -562,6 +562,8 @@ struct tb_regs_hop {
>  #define TB_PLUG_EVENTS_CS_1_DPOUT_DISABLE	BIT(4)
>  #define TB_PLUG_EVENTS_CS_1_LOW_DPIN_DISABLE	BIT(5)
>  #define TB_PLUG_EVENTS_CS_1_HIGH_DPIN_DISABLE	BIT(6)

Empty line here

> +#define TB_PLUG_EVENTS_CS_20			0x14
> +#define TB_PLUG_EVENTS_CS_20_BIT26		BIT(26)
>  
>  #define TB_PLUG_EVENTS_PCIE_WR_DATA		0x1b
>  #define TB_PLUG_EVENTS_PCIE_CMD			0x1c
