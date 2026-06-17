Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C67A391855
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781685198; cv=none; b=FYVXFFR/vWfXNnz94hHhTckewcjw8jpe8UWeATHcyAq3+lKk93IePX697of6Ro8meHyM+eoSCSJtnQw9vGFabLDisIENaRrqLoHw6tLExhvsveEK5bfTcv+cIy2X+wZ7/IicZ6ICfxIA7zH6OWBeTTfLVbsoeEOotcwGuCUgNSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781685198; c=relaxed/simple;
	bh=C0U+32GwJ4K0nGpIroKkA0XQuytFUnwuQ08KdAJjTbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Me4wrM/E9YWTTkVrNs1pI63DxK/JPfghulB595qBghwEto7FnnLJ8+X3pa72mu6PIr7fRX/zZBMc/U35mxG2q2WlJTyTLY5McmwoM1esQwCMiaSK0FwUTLy/zyUiiaxIrIZVBg2RpKcvxhPcT7Bmm3R1uOf5uB9tkEFXGEpd40o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf1f074a12so54842605ad.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 01:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781685196; x=1782289996;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NH6hocZNylot+M4XVVVgASnxnSv/8JW5bdpWIVIZHYU=;
        b=IPf1e8RxRSIEyhqT6BrgDMjqeZ/t+CxBGkxD7nDTk/iKIjk3Iev9nGBgsRgNwZlFg0
         JLIbSt9MMU27nCKcuWDNIaVBCqSvy+PjRXJAiq26g0DRUuY+jHY3YaBz9q6K9nk5wvOc
         i2W1yVbq0I0GaSWAuHnuTdfDzBvAjW2junbQ7ABxlohSv7yQTBKqRQEhAJyBrK/0PEfJ
         PgULulPCwpYZl2Z1ghqmYV60SIF5cICedDr2d/uHJWoQk+bkbZtDIpojS/+c7ybYacr3
         Ey1UIiGnqUXBJfPozqEI9cTsqbEYO8mv2QPgwDYWDl7xc+t4OR443JYGTJmugneDzAMJ
         7FQA==
X-Gm-Message-State: AOJu0YxYkZE9HSzZrm9h3veTdGnY4heWO17nGHs6aPlIL5mrjBZnWWWl
	+WiS15plsd7iLXJ76S1mbSTzmtrKwvVi0UyH3Via7f92fGAJbZMWNsyT/qlriO99
X-Gm-Gg: Acq92OHYUHU2rn/pCCdkoqY9GWoX1KdggfRIXU2iRMZZMriPqNKIIzwJhn0eNZub/oH
	Q0VtocaOuqs2+VBprcTE2ea5W5VUvvrKBdLsu9IeG52INgXdRss5ZAFPCLnYHIQGkXIz31KjHrM
	YytwpIXpKfSj9kAbmeYpgpoenWkCVhOQ6wal1OqbBiXAKnvgJLCZ5hPnM+ZSXWf4avUL+omJkeI
	EDZp2bgxpliuNUGTJAJwpbIqEvgyOa03a1P2nl24cb3hXlRHZG4go1RlkkuoTJNKOUNMP0uXLhr
	YjfK5sAlbkOe5GsXOI4tp0PbG7dQoYLsDyZE698FXQfNN5mg13lfGqKMehBuBd25Al26GKIR5wj
	BUTCp/tNXEhqFS3gZ1iuMBIjDRsscPudMXKWwtXAf+YBjxhiFkdPdwxt+BSbs/jGouppfchAc+k
	6LA80LB17FsCSetoOKsn9dCT5ysLGAhs/xDvJo2twFdw7eJ0bThUI7tw==
X-Received: by 2002:a05:6a21:a85:b0:3b2:8685:1473 with SMTP id adf61e73a8af0-3b8b5b28256mr3335309637.7.1781685196265;
        Wed, 17 Jun 2026 01:33:16 -0700 (PDT)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com. [209.85.214.172])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8665186b53sm13651855a12.20.2026.06.17.01.33.15
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 01:33:16 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf1f074a12so54842405ad.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 01:33:15 -0700 (PDT)
X-Received: by 2002:a05:6102:4b03:b0:632:3bb5:95f1 with SMTP id
 ada2fe7eead31-7246d528766mr1135210137.27.1781684803531; Wed, 17 Jun 2026
 01:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617030008.154449-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260617030008.154449-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Jun 2026 10:26:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU0SJ0q2hcpu+qZCH3eZ5eFDyo8Z964h9DhuSaQ7QdHSg@mail.gmail.com>
X-Gm-Features: AVVi8CfAqddoQorfQ6TrjH19DY2WU_w8lZ69fu1Z-CMFemynEW91v1W75EneBEs
Message-ID: <CAMuHMdU0SJ0q2hcpu+qZCH3eZ5eFDyo8Z964h9DhuSaQ7QdHSg@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: rcar-gen4: Configure AXIINTC if iMSI-RX not used
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Wed, 17 Jun 2026 at 05:00, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> In case MSI are enabled, but DWC built-in iMSI-RX is not in use, the
> MSI are handled via GIC ITS. Configure all controller MSI registers
> fully.
>
> Set or clear MSI capability register MSICAP0 MSI enable MSIE bit and
> PCIe Interrupt Status 0 Enable register PCIEINTSTS0EN MSI interrupt
> enable MSI_CTRL_INT bit according to MSI enable state, set both bits
> if MSI are enabled, clear both bits if MSI are disabled.
>
> If MSI are disabled, or MSI are enabled and iMSI-RX is used, then
> deconfigure AXIINTCADDR and AXIINTCCONT to 0, which disables any
> pass through of MSI TLPs onto the AXI bus and then further into
> GIC ITS translation registers.
>
> If MSI are enabled and iMSI-RX is not used, the configure AXIINTCADDR
> with target address of GIC ITS translation registers, and configure
> AXIINTCCONT to enable MSI TLP pass through onto AXI bus and into the
> GIC ITS. This specific configuration allows handling of MSI via the
> GIC ITS instead of integrated iMSI-RX.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks for your patch!

> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -31,6 +31,10 @@
>  #define DEVICE_TYPE_RC         BIT(4)
>  #define BIFUR_MOD_SET_ON       BIT(0)
>
> +/* MSI Capability */
> +#define MSICAP0                        0x0050
> +#define MSICAP0_MSIE           BIT(16)
> +
>  /* PCIe Interrupt Status 0 */
>  #define PCIEINTSTS0            0x0084
>
> @@ -55,6 +59,16 @@
>  #define APP_HOLD_PHY_RST       BIT(16)
>  #define APP_LTSSM_ENABLE       BIT(0)
>
> +/* INTC address */
> +#define AXIINTCADDR            0x0a00
> +/* GITS GIC ITS translation register */
> +#define AXIINTCADDR_VAL                0xf1050000
> +
> +/* INTC control & mask */
> +#define AXIINTCCONT            0x0a04
> +#define INTC_EN                        BIT(31)
> +#define INTC_MASK              GENMASK(11, 2)
> +
>  /* PCIe Power Management Control */
>  #define PCIEPWRMNGCTRL         0x0070
>  #define APP_CLK_REQ_N          BIT(11)
> @@ -305,6 +319,39 @@ static struct rcar_gen4_pcie *rcar_gen4_pcie_alloc(struct platform_device *pdev)
>         return rcar;
>  }
>
> +static void rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
> +{
> +       struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
> +       struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +       u32 val;
> +
> +       /* Make sure MSICAP0 MSIE is configured. */
> +       val = dw_pcie_readl_dbi(dw, MSICAP0);
> +       if (pci_msi_enabled())
> +               val |= MSICAP0_MSIE;
> +       else
> +               val &= ~MSICAP0_MSIE;
> +       dw_pcie_writel_dbi(dw, MSICAP0, val);
> +
> +       if (!pci_msi_enabled() || pp->use_imsi_rx) {
> +               /* Clear AXIINTC mapping. */
> +               writel(0, rcar->base + AXIINTCADDR);
> +               writel(0, rcar->base + AXIINTCCONT);
> +       } else {
> +               /* Point AXIINTC to GIC ITS and enable. */
> +               writel(AXIINTCADDR_VAL, rcar->base + AXIINTCADDR);
> +               writel(INTC_EN | INTC_MASK, rcar->base + AXIINTCCONT);
> +       }
> +
> +       /* Configure MSI interrupt signal */
> +       val = readl(rcar->base + PCIEINTSTS0EN);
> +       if (pci_msi_enabled())
> +               val |= MSI_CTRL_INT;
> +       else
> +               val &= ~MSI_CTRL_INT;
> +       writel(val, rcar->base + PCIEINTSTS0EN);
> +}
> +
>  static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,

FTR, this has a contextual dependency on "[PATCH v2] PCI: rcar-gen4:
Limit Max_Read_Request_Size and Max_Payload_Size to 256 Bytes"
(https://lore.kernel.org/all/20260519195219.189323-1-marek.vasut+renesas@mailbox.org).

>                                         struct pci_dev *dev)
>  {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
