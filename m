Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CD730E821;
	Thu, 21 May 2026 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379772; cv=none; b=b1ctjx9EwY0nDWu6XWzPtA4HDVi1HyT/vSHzZTebKi1NmnIbqjAv4ssHeyRb6FYu9BdCmYEa/64N9dzyUjXzjI0w76q1e6ZuHQ2fkHZPiDKYMY+2vvwJwFOjawoLkrqvtyhYZglf7bfxZF8FZcABPQrZEbntVkrxGjKdzE8itxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379772; c=relaxed/simple;
	bh=O9s9/I7OwxbO7QrQbWbQWaQxdrGmGEQtqlmjwpLdnO4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GEW4PhEdEzjerRmwXQFQBEyPW53g2Nkg2Smm9iMKIaK8OJZWs3+TFFDKReBoC8NRC2VRMW5+RAqPWLQF3NukI8Rp+HssS8KFbWmJZM34I91sF/MMajH9i3fmOock1n0/xBT41xQOKa7vdPnXetGBrN3pPvbkqbq1BlyQJp+I4jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ng+fm7ST; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ng+fm7ST"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7B96C1F000E9;
	Thu, 21 May 2026 16:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779379770;
	bh=3ZlnIeFwcGXHSITB9tQg5YfIb8MEBeiZfJz3a6t4RTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Ng+fm7STyJ0OUZYz3TOgZu00uXnjCBWJcrHHFItyBhG0XbbqpydMhwiRWkU6hnveY
	 NTSIAV7/MD8tE/mDMHW7ITJcuqgIEuRLmLWTvGR8tGvyR6yVICRqfDx0r8ZSV390zc
	 Yb+/Z6Vbfhu7QWoHQSWfUpzvWXjJzIVoDjiXNCCReV2Bc0XoQDxePi2JpNs46KHye1
	 eatRDqGyYUbz3aSi2yUNiF5sad4b46FsIe1mG4eHWNS9tsjgHf5QxSqgE/6njbGzIu
	 +8AVx30HIHkjsQhHwmT1ingqfFtxEbOWLxbG5/Tq/q8cskXhi4YM5t0l+/uQQMOgkO
	 aQ6oxS4qU16TA==
Date: Thu, 21 May 2026 11:09:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC Patch] pci: add power management for rtl8116af
Message-ID: <20260521160929.GA164133@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521033827.502-1-javen_xu@realsil.com.cn>

On Thu, May 21, 2026 at 11:38:27AM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> RTL8116af is a multi function card. But due to the hardware design, only
> function 0 and function 1(nic) are exposed to pci system. If the system
> want to enter s0idle or cpu need to enter c10 when suspend, function 2
> to 7 must be set to d3 and enable aspm. Function 5 and 6 are reserved,
> so we skip them.

If the other functions aren't visible, does Linux use them at all?
Can you just put them in D3hot and leave them there indefinitely?

Other than quirk_rtl8168_set_aspm_clkreq() function name,
I can't tell from the code what this does with ASPM.  I'm a little
dubious because (a) ASPM is supposed to be managed by the PCI core,
not by individual drivers and (b) I can't tell whether this conflicts
or races with anything in pci/pcie/aspm.c.

Smells like a device that doesn't make much effort to conform to the
PCI specs.

> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Hi,
> Just as the comments above, function 2 to 7 are hidden to pci system. So
> we have to set d3 and aspm through our private register, which is CSI. I
> have a discussion with netdev maintainer, and he thought this might be a
> question to pci system.

Pointer to that discussion?

> I wonder whether this patch can be accepted here. Any feedback would be
> highly appreciated!

Pay attention to previous history and match style and capitalization
in subject line, commit log, etc.  Match text width in the patch
itself.

> ---
>  drivers/pci/quirks.c | 119 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index caaed1a01dc0..e6538edcdff4 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -35,6 +35,7 @@
>  #include <linux/sizes.h>
>  #include <linux/suspend.h>
>  #include <linux/switchtec.h>
> +#include <linux/iopoll.h>
>  #include "pci.h"
>  
>  static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta)
> @@ -6381,3 +6382,121 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
>  #endif
> +
> +#define RTL_TX_CONFIG			0x40
> +#define RTL_CSIDR			0x64
> +#define RTL_CSIAR			0x68
> +#define RTL_ERIDR			0x70
> +#define RTL_ERIAR			0x74
> +#define RTL_OCPDR			0xb0
> +
> +#define CSIAR_FLAG			0x80000000
> +#define CSIAR_WRITE_CMD			0x80000000
> +#define CSIAR_BYTE_ENABLE		0x0000f000
> +#define CSIAR_ADDR_MASK			0x00000fff
> +
> +#define ERIAR_READ_CMD			0x80000000
> +#define ERIAR_MASK_1111			0x0f000000
> +#define ERIAR_EXGMAC			0
> +#define ERIAR_FLAG			0x80000000
> +
> +static u32 quirk_rtl_csi_read(void __iomem *base, u8 multi_fun_sel_bit, int addr)
> +{
> +	u32 cmd = (addr & CSIAR_ADDR_MASK) | (multi_fun_sel_bit << 16) | CSIAR_BYTE_ENABLE;

Possible opportunity for FIELD_PREP().

> +	u32 val;
> +
> +	writel(cmd, base + RTL_CSIAR);
> +	if (readl_poll_timeout(base + RTL_CSIAR, val, val & CSIAR_FLAG, 10, 1000))
> +		return ~0;
> +	return readl(base + RTL_CSIDR);
> +}
> +
> +static void quirk_rtl_csi_write(void __iomem *base, u8 multi_fun_sel_bit, int addr, int value)
> +{
> +	u32 cmd = CSIAR_WRITE_CMD | (addr & CSIAR_ADDR_MASK) |
> +		  CSIAR_BYTE_ENABLE | (multi_fun_sel_bit << 16);

Ditto.

> +	u32 val;
> +
> +	writel(value, base + RTL_CSIDR);
> +	writel(cmd, base + RTL_CSIAR);
> +	readl_poll_timeout(base + RTL_CSIAR, val, !(val & CSIAR_FLAG), 10, 1000);
> +}
> +
> +static u16 quirk_r8168_mac_ocp_read(void __iomem *base, u32 reg)
> +{
> +	writel(reg << 15, base + RTL_OCPDR);
> +	return (u16)readl(base + RTL_OCPDR);
> +}
> +
> +static void quirk_rtl8168_clear_and_set_csi(void __iomem *base, u8 multi_fun_sel_bit,
> +					    u32 addr, u32 clearmask, u32 setmask)
> +{
> +	u32 val = quirk_rtl_csi_read(base, multi_fun_sel_bit, addr);
> +
> +	if (val != ~0) {
> +		val &= ~clearmask;
> +		val |= setmask;
> +		quirk_rtl_csi_write(base, multi_fun_sel_bit, addr, val);
> +	}
> +}
> +
> +static void quirk_rtl8168_other_fun_pci_setting(void __iomem *base, u32 addr,
> +						u32 clearmask, u32 setmask)
> +{
> +	for (int i = 2; i < 8; i++) {
> +		if (i == 5 || i == 6)
> +			continue;
> +		quirk_rtl8168_clear_and_set_csi(base, i, addr, clearmask, setmask);
> +	}
> +}
> +
> +static void quirk_rtl8168_set_aspm_clkreq(struct pci_dev *pdev)
> +{
> +	void __iomem *base;
> +	u16 pci_command;
> +	int mmio_bar;
> +	u32 txconfig, xid;
> +
> +	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
> +	if (!(pci_command & PCI_COMMAND_MEMORY))
> +		return;
> +
> +	mmio_bar = pci_select_bars(pdev, IORESOURCE_MEM);
> +	if (!mmio_bar)
> +		return;
> +
> +	mmio_bar = ffs(mmio_bar) - 1;
> +	base = pci_iomap(pdev, mmio_bar, 0);
> +	if (!base)
> +		return;
> +
> +	txconfig = readl(base + RTL_TX_CONFIG);
> +	if (txconfig == ~0U) {
> +		pci_iounmap(pdev, base);
> +		return;
> +	}
> +
> +	xid = (txconfig >> 20) & 0xfcf;
> +	if ((xid & 0x7cf) != 0x54b && (xid & 0x7cf) != 0x54a) {
> +		pci_iounmap(pdev, base);
> +		return;
> +	}
> +
> +	if ((quirk_r8168_mac_ocp_read(base, 0xdc00) & 0x0078) != 0x0030 ||
> +	    (quirk_r8168_mac_ocp_read(base, 0xd006) & 0x00ff) != 0x0000) {
> +		pci_iounmap(pdev, base);
> +		return;
> +	}
> +
> +	quirk_rtl8168_other_fun_pci_setting(base, 0x80,
> +					    BIT(0) | BIT(1) | BIT(8),
> +					    BIT(0) | BIT(1) | BIT(8));
> +
> +	quirk_rtl8168_other_fun_pci_setting(base, 0x44,
> +					    0,
> +					    BIT(0) | BIT(1));
> +
> +	pci_iounmap(pdev, base);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, 0x8168, quirk_rtl8168_set_aspm_clkreq);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_REALTEK, 0x8168, quirk_rtl8168_set_aspm_clkreq);
> -- 
> 2.43.0
> 
