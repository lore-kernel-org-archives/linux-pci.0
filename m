Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107223;
	b=OurcQMS4E1LzrEDBgqj3hV448YYo1/eC4UZyRMGEdp4AguOXQQbu0/MtEsRhIfl5bwv9
	 sgoavSc3xMZKzlW6mCgFST1xLW2LkkAno9SXei5QBK1zXyELhJy6A6OfA+Oz1bitZ9Gfa
	 yQb1+ZyBK/uB1nrz7iE20ZYxPUZQsFE5Go0XQhfnXjoaJvpCM9ANGsyCnEA9p+1ZT/kgy
	 BX0eY/dwDOXW8hB3RdNk6YfnoRuyZI0XV0lCzaswIJG31tjlgK90lxqVhCPBc4Zm3MURa
	 k1lmpHQcsoTpBGvr09z9BT9HDLijsEIck4HgT54EH7wyyNZVpbuKPI2PmNJIEMEXzGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107223;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=o5ro9sxBOzh3u1cTo2kPlByJv2MwyjzC2PC0yLmvz+0=;
	b=f6RD/lrJdQ93oGB6mwchlVlNuEXw4wnO0ra8VrdyPEE/4I1jk1VzCI+900ztwaQm+1C4
	 24QpC0uQXSuLi9+xH2qEMw7KSowKa4gooQXc9k4HBesL3Mz7QLys2OXSv7O349rWudCAq
	 hieTStEQmhWqpV8VFCBrenrrHd+E1Iz3ysM9lia6bMWzPGjigPaT/j5i2bk2g6oj2wroz
	 76JkvUo6vqiVZNziD17dEfM1IGaygKWpCjua6jRzwf8m9h6ijOVSNGqPOFLVzm2tyDkoo
	 89j2aDNxTnY2ZcM2gmraL4LO7Z1m/npcoR5H+Vf+qV00UqUvMwcmFPDe7rgaPI89aGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gz77kTyU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF03606A320;
	Thu, 19 Nov 2026 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gz77kTyU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EEA1F000C4;
	Thu, 19 Nov 2026 16:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795107223;
	bh=o5ro9sxBOzh3u1cTo2kPlByJv2MwyjzC2PC0yLmvz+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Gz77kTyULd22WG+7E9JGS+7bco+ZRwUyrBbK8XV/6pVeRgCOLYLkRxGZ5f5tqtG6i
	 IMe3V9yMjtdkoZWtKIXKdEHEfvp0vWHnNEUDPN7IATtQP+tUc2vIO0JNaqx4n+iq4J
	 0g+wIZ4V3oYX6Y8joNThwzshVQGrJ+o6VJ9hyXMRhrveGpjl4rgj8sAtbgMMlogx7Z
	 YcJAwwOw962JKiRbO9YReGkczcBzceCMj7FzlmJvDa6Dpn1J7/PRytOBKmo0Vocska
	 i48u5z5SggFRqBmF9PqDtXFjdEVroBE7nrGDld4ABknnZLA5DoBhtdbZPaYQ2q+nbi
	 WeVlPmNLgBHlQ==
Date: Thu, 19 Nov 2026 10:53:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Oz Tiram <oz@shift-computing.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>,
	Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
Subject: Re: [PATCH v7 1/3] PCI: Cache bridge firmware secondary bus number
Message-ID: <20261119165341.GA809730@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-vfct-regression-v7-1-69b1e0cf45c2@amd.com>

[+cc Lijo, Reza]

On Thu, Nov 12, 2026 at 03:54:53PM -0600, Mario Limonciello wrote:
> Drivers such as amdgpu and radeon need the bus number firmware assigned
> to a device to match it against firmware tables like VFCT. The PCI core
> may renumber buses (e.g. with pci=realloc), after which the runtime
> number no longer reflects what firmware programmed.
> 
> Record the firmware secondary bus number on the bridge's struct pci_dev
> the first time pci_read_bridge_windows() reads the bridge's bus numbers,
> which happens before any renumbering. Devices behind the bridge can then
> retrieve the original bus number via their upstream bridge.
> 
> Only store the value if it is usable: ignore unconfigured (0) and 0xff
> secondaries. Use a separate "sampled" flag so that later rescans, which
> would read the renumbered runtime value, never overwrite the cached
> number, and a "valid" flag so users can tell whether anything was
> recorded.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/probe.c | 16 ++++++++++++++--
>  include/linux/pci.h |  4 ++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..f20a4b8f7a23b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -505,14 +505,26 @@ static void pci_read_bridge_mmio_pref(struct pci_dev *dev, struct resource *res,
>  static void pci_read_bridge_windows(struct pci_dev *bridge)
>  {
>  	u32 buses;
> +	u8 secondary;
> +	u8 subordinate;
>  	u16 io;
>  	u32 pmem, tmp;
>  	struct resource res;
>  
>  	pci_read_config_dword(bridge, PCI_PRIMARY_BUS, &buses);
>  	res.flags = IORESOURCE_BUS;
> -	res.start = FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
> -	res.end = FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
> +	secondary = FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
> +	subordinate = FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
> +	res.start = secondary;
> +	res.end = subordinate;
> +
> +	if (!bridge->fw_sec_bus_sampled) {
> +		bridge->fw_sec_bus_sampled = true;
> +		if (secondary > 0 && secondary < 0xff) {

A bridge with secondary==subordinate==0xff (with a single bus 0xff
below the bridge) is actually valid, isn't it?

I guess we could check for a config read failure with
PCI_POSSIBLE_ERROR(buses), but that would open the can of worms about
what we should do with the *rest* of this function if it failed.

I'm not sure we need to check "secondary > 0" either; obviously a
bridge with secondary bus 0 is not valid, but if the idea is to match
firmware's idea of a bus number, it seems like we need to capture the
bridge configuration at FW/OS handoff.

IIUC, the sashiko review [1] suggests that neither fw_sec_bus_sampled
nor fw_sec_bus_valid is actually necessary.

[1] https://lore.kernel.org/all/sashiko-outbox-212033@kernel.org

> +			bridge->fw_sec_busnr = secondary;
> +			bridge->fw_sec_bus_valid = true;
> +		}
> +	}
>  	pci_info(bridge, "PCI bridge to %pR%s\n", &res,
>  		 bridge->transparent ? " (subtractive decode)" : "");
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 5ffcf5ce8c966..045157488b8e7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -363,6 +363,8 @@ struct pci_dev {
>  	struct pci_slot	*slot;		/* Physical slot this device is in */
>  
>  	unsigned int	devfn;		/* Encoded device & function index */
> +	/* Firmware secondary bus number saved across bridge scan passes */
> +	unsigned char	fw_sec_busnr;
>  	unsigned short	vendor;
>  	unsigned short	device;
>  	unsigned short	subsystem_vendor;
> @@ -414,6 +416,8 @@ struct pci_dev {
>  	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
>  	unsigned int	pinned:1;	/* Whether this dev is pinned */
>  	unsigned int	config_rrs_sv:1; /* Config RRS software visibility */
> +	unsigned int	fw_sec_bus_valid:1; /* Firmware secondary bus number usable */
> +	unsigned int	fw_sec_bus_sampled:1; /* Firmware secondary bus number captured */
>  	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
>  	unsigned int	d1_support:1;	/* Low power state D1 is supported */
>  	unsigned int	d2_support:1;	/* Low power state D2 is supported */
> 
> -- 
> 2.43.0
> 
