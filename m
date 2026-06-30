Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9653E0732
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 18:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843086; cv=none; b=tQay7HOnMHcP2Jp6redcxc6c+RaWA31rV1N+651ujuSAfHFTzROx3FAYD3VTa+Ba/7DFHVvzVibcExjiopCDbaZITCIeyt45BTjuuYPj4+bjMXsDvH/zByHr9eq4iUQ4+8AXBbIe5iy0a3wbbCNUlDnQt8WQu0XaVUk6ChaOTxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843086; c=relaxed/simple;
	bh=OYJNr+fvg0ooEirPKzpg45GmiwT9K/fc8PU+rAViuKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krpTFg4T/pBFjryNK/JB06DX+DFZG8171pcKSD+mswNwMfUhtYvVbFJLVh/guGX5V2BSIZXrMfItjxmUvhN4P5ASml0mZUk8fBDPOnmNNXuSx5VnnRh2Cx5fafeHvHH4eLudAwavBlkOaE/VsgCp+PY43z1FfZ0I6R0HdTq+BJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-49600683bd7so163149b6e.2
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 11:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843084; x=1783447884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCVJ3/YfnMGwAtAU15rL0FQBriNX8zfFDwNu+BCGAtk=;
        b=V14lBcflkAjfgrfKLR0B9os0B/F67w2vktUjsqNypsggUKsj6Mi+gjh7HePm5bABH0
         7Qafc+7OlFqE5Pa0KV9XGrSQbbaXkdbny/QA18ZhanDmwE49bfliAeHgzd0bw9dKKfOL
         Dwy9nJDPcNMDWAeKudMKnGM0hVSEdlnHWOtYvCbB29JANyYDp/7rNCpX8wfYgh5xUtRv
         Ntr7nWxwIdemWBpabex4R0uKDDLL/cCagxDy4YjiL1z/bf2wTF4eeGqvuGdDmoCGiRXe
         NpbSdCc9afE7RqOp0rIoSWij8J7wHKxltq2RUvVeM+2ZBoi+zZ1tKYRmnVWahYuZ/Sqt
         IzXQ==
X-Gm-Message-State: AOJu0YzPr9xouY+qYyeNq/yodJZuKFHbN2f6Pg8dA55emSVsc6WAdeDm
	hkWM7gTkXsKdocdjfMYwrd97Nw3scvF9c6hfdOp/GT+RS9Rz6sE7fjguXL9+cIKuQkY=
X-Gm-Gg: AfdE7cnj6ZoByhDwVkZv2ftGmRGSTRi2TJnO6ymjTdye5Ybgll14hhjHjVdYV6DrV/U
	aXXf5JkImbT5nvpnOmRoj6UpYFifZ6UFezf4lofBE8ZXdT7daXC8XlKV4EzfF3+gPAHAszzlaCQ
	8hlhcRM61PJuF+AwI2TGJB0BlvyjoemJizJ+DdEnVKioieKZFUhZ1yxgVm4e/CMlh8qMRyNh7+Z
	5K9qcrcdCP/lA8vqwolpt1+UsqLaZo9iPVU4bxdsK16KuChwTyHdGg/KDlC51ulDU1ljNj5kSYd
	ht0G4rnKcLZlMwiJLmRFFmu0iWd77nLRa177DGutnJS3ReYm4rGW0NQf37iWTQERMLramR+C2kH
	iVmmpYynJSjr0cmatsNvnga7KftdPjmPG4CPAYmh8joOqJhPi+sTnF1O0iwp1GTK/LB1Kkjx/mW
	DZKRSCMMVbrlFtztWPI++qpo/4c+vgDlLdjw5M13HszgF8intUuA==
X-Received: by 2002:a05:6808:19a7:b0:495:e4fc:c421 with SMTP id 5614622812f47-495ead300dfmr5080314b6e.7.1782843084339;
        Tue, 30 Jun 2026 11:11:24 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4935596b734sm9395314b6e.17.2026.06.30.11.11.23
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 11:11:24 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so731196a34.2
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 11:11:23 -0700 (PDT)
X-Received: by 2002:a05:6102:5805:b0:738:472f:2ca9 with SMTP id
 ada2fe7eead31-73a369ec1bcmr2473065137.7.1782842696311; Tue, 30 Jun 2026
 11:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618220427.14325-1-marek.vasut+renesas@mailbox.org> <20260618220427.14325-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260618220427.14325-2-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jun 2026 20:04:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV3tyZk8ckL-ihdbVcGV9tQumdntPc_nJB6HXEkZLytfw@mail.gmail.com>
X-Gm-Features: AVVi8CcCGeVbbcW5z0757KT0rVC9sZPZEWMHF1Z1kDBEh7vVAiL0IbidDTttqgc
Message-ID: <CAMuHMdV3tyZk8ckL-ihdbVcGV9tQumdntPc_nJB6HXEkZLytfw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PCI: rcar-gen4: Configure AXIINTC if iMSI-RX not used
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pci@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek, Shimoda-san,

On Fri, 19 Jun 2026 at 00:04, Marek Vasut
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

> @@ -305,13 +320,103 @@ static struct rcar_gen4_pcie *rcar_gen4_pcie_alloc(struct platform_device *pdev)
>         return rcar;
>  }
>
> +static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
> +{
> +       struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
> +       struct device_node *msi_node = NULL;
> +       struct device *dev = dw->dev;
> +       struct resource res;
> +       u64 addr;
> +       int ret;
> +
> +       /*
> +        * Either the "msi-parent" or the "msi-map" phandle needs to exist
> +        * to obtain the MSI node.
> +        */
> +       of_msi_xlate(dev, &msi_node, 0);
> +       if (!msi_node)
> +               return -ENODEV;

This is not backwards-compatible with existing DTBs.
I noticed because PCIe is broken on Gray Hawk Single with R-Car V4M
after this series.  Indeed, "[PATCH v2 4/4] arm64: dts: renesas:
r8a779g0: Add GICv3 ITS and update PCIe nodes" only covers R-Car V4H,
but not R-Car S4-8 and R-Car V4M.

> +
> +       /* Check if "msi-parent" or the "msi-map" points to ARM GICv3 ITS. */
> +       if (!of_device_is_compatible(msi_node, "arm,gic-v3-its"))
> +               return dev_err_probe(dev, -ENODEV, "Compatible MSI controller not found\n");
> +
> +       /* Derive GITS_TRANSLATER address from GICv3 */
> +       ret = of_address_to_resource(msi_node, 0, &res);
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "MSI controller resources not obtained\n");
> +
> +       addr = res.start + GITS_TRANSLATER;
> +       if (addr >= SZ_4G)
> +               return dev_err_probe(dev, -EINVAL, "MSI controller address above 32bit range\n");
> +
> +       *msi_addr = addr;
> +       return 0;
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
