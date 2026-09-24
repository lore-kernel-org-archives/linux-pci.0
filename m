Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E093B2FFE
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252564; cv=pass; b=RJKCNW6IqAQ5K/hvzyTFbQdyFaeuLwazrQi+N0lTUIUQ2bOHiHOL+ho9WlWE/QAiXtvo6DOKIrFTOftylTgG7hq1CMJXxQDtDHi8q8KdJiJqraH2fOwjqlOOMwIH0P2FBH/Goa73Xj7Hqq3Qs+rLUiL8eZXkZ/+HdGVgEh7c5MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252564; c=relaxed/simple;
	bh=Cw52wVNlkGTq00Bvj/+O0eoMgNOz8HZxwrEIpbKSa2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bh5VRglBXmuPJOxB6SVc7VtnGSOoGRfkVRApgjh8v/yzh8gmXW20fmFM142mZPxz0YNaNhizXJm7PxKA4HzsykvqEpl4GXNVJ1amkpoWL0MFaaRu3g8qJsXZYx1clPv6KXd4WHdSvyqqLpMgA9J4tBEa11b8goFFqgDqkKeHuBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pH9HTrWF; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pH9HTrWF"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b24c3so1321464f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 05:22:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790252560; cv=none;
        d=google.com; s=arc-20260327;
        b=P7sH+ZsvMVq/kjqM5WEiQxN0Y3FhwZ/4+sK9t94fDI4xriuXNv23n9Trt1HgNfZ+1N
         rV4+jTUvR6fyoilEEBOp+ZsPWUkOSj+3HNIjzt/2YSAO4k2TFe36HalQcZlmluSBXSsu
         MK1QXMJWHir93cjxLU7pYGIvh3Omf+RkrNmolkI3Wt+a1SpIYOkdcEQPPfZ7TgaliqjG
         hZSn0A5chD4pQiNRjH+6zshd0uwJFs/0FxqU8q2r98FYPPDLiFtd06OV5YVM+Mb+gJGf
         oh5DGikW9q7JIGcyg3ikqbZOUF/7snseOTWfBcN65xvjHvltN3Jsnrs4XwKdQigM6EHB
         btFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V7FuowMiVTc3wvrK4MWYuFA0l317MjW0sMi25vpCRZw=;
        fh=NB8ET/KynPgrC+eTVOlDzU6ECegRPC5RXHeTu7OvvDA=;
        b=DKeoFnpd5kj2u1cO6Q6sZwn416KdJ6mZsqT5Sj6aeE2PqUOJzXB7B4VqFbgkh9K4+X
         XaldfFglpgEwla7Bu8j2n1+iBFUbvYbVsQJIFAEhJLKSW8gCN6wq4+Ql7AhfTy+rxVyu
         mceZHAkYy7amCLOmv3+EN3Lskrzm1+GCjBt+i653ehkID/8KIsVL86hnY1Ro4hGueRTO
         xdXDmC6p2TrTXjjxRRCB74ceYT2c4eYJ7xNIN12GjUlelLPuTyjT9+GpgvVbeFcYondl
         3HcjhE5jPrNp0dWtBGDDC2f6JvIH6neO7Qs7prh1KsM8iQPycfqGSzhUrKAxMFdHV1CE
         SOHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790252560; x=1790857360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V7FuowMiVTc3wvrK4MWYuFA0l317MjW0sMi25vpCRZw=;
        b=pH9HTrWFvaq65uQCf54vDK+emV9XafQdNRg4VME0ywIAwzYN4KkcN/3ExtPLS5ypCl
         HfQ5DXqQN/h6fwESIGDON1k2JFaho7YuA61hm8onHiQhUEoYSqNDPT4jCw7PFzlfRv20
         eS6e3E0bs4ceAfIwfXnLkQ8qtVm3sFE7JwHT4A7pH8GLkiIS3fROQMcwT0gccJ6mpeuz
         3tiTU020T3AeqjOrc2j/u4J4CKLE7D4B3s7uo3+pCwXZBhVf4lgsZXMZb6Vt3S7strDp
         utIWBdNDckzvgQ7IoUAUKgsJECPWAYzAVZjMF4fjjNpmaprwHErpqd+/KN6Tgjhy5nxe
         qUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790252560; x=1790857360;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V7FuowMiVTc3wvrK4MWYuFA0l317MjW0sMi25vpCRZw=;
        b=cGgG1MMV7fFFDf+uU1qtmSusItw+4xxBR/Q3ON2LntyxB2A5Vi0zPW97I9xbxbv54n
         GVPtdk4ZUwSn2i3tNj38b0iIiGUMXE914L1yVL5EDC1ukGYi7JemRyaFzzHbxIhojIrL
         045GilBG0OHV9WEjjKj7LzChAZwMkmC2IDfNxbzxq3QOUEv92wQ4Xk/Bth81uPMOo0Z6
         kmFY0xeIGl1HfvSAaBaPv5JACZlY4YzugOK9E7z/dZRoqUgt0QOzkYGcqhNA2ORklQ9v
         QCNneHhrvWukcAj3pqf0mmpK6uOCUSzKNFxIezgyf9vqk+7BklwZ61xpif5MMz3rYDeN
         GX8g==
X-Forwarded-Encrypted: i=1; AKwUvBzaYJ2MQG4QlHjnXxTnFhH1jHeGq1Z8DgXHPapwn0bPc28wNJ41ZoBrDr1bijF6GY6tBo2ouL0dv8M=@vger.kernel.org
X-Gm-Message-State: AFuF++kes4at+JrZj2eCCFdhzqTH8l5Nhy/E2y+5Ba2O7xXkhjGn8gO1
	Jy9MGhi2QKEXA9iWrotcm6wW4FnBhjbNIaFb25wBYsdVPKzN0HaceldK8S6l3NMdAYNQzkmiDjh
	xZDV+993GxkrWJQfvjkF8Hor+RnNo/jM=
X-Gm-Gg: AYBFou2XV2345lkLQ3Qd5V0yCaIa/c9biTbXQLE0P4cKZbgGZAqOke8rAxvNLpwJUzm
	2bFF3iYcLqpteJj32wWTbwM0JpF4KrMXrV457mjVafAy/LQ8EwCu7ZOD63t5npZ+2tn1ocs8XRR
	3vjxaeulNSzVHYLuoftChvXZHxR1EMjSwTbZFuwLpcjpOlmDdafxWIW3ROgfbB9FddDS/wwz+uf
	SSGmz3crTzUtzneOBtxZ+hnAZ1W3TDXgOUDAwKq4n8Si4uV1eC6ACQ6Skncwog/v3f9JPvqrr2O
	BuieIUEmHEA4EtUtIGCelD6dnAdH1gPpSNOFPbu4U1KiacwVGR/kEGL1XVOPCSGd2z9dzASoPB4
	A6FDv/UumJF+6xiL8LFmJYR3qiU263mbpXtaykYBEi1E=
X-Received: by 2002:a05:6000:2f81:b0:487:24cc:8bb3 with SMTP id
 ffacd0b85a97d-488716f4191mr3751864f8f.29.1790252559866; Thu, 24 Sep 2026
 05:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922144629.586997-1-claudiu.beznea@kernel.org> <20260922144629.586997-5-claudiu.beznea@kernel.org>
In-Reply-To: <20260922144629.586997-5-claudiu.beznea@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 24 Sep 2026 13:22:13 +0100
X-Gm-Features: AclHuK80ZnuVKuOmssganhJ27DYMScJQRQGFgo2UOVE_0RqUnU9MRUwMu6QlG68
Message-ID: <CA+V-a8tczmMXBoh_bp5i9cQ+YWatqsA9oM6eg_PBEC0bA+sbTA@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] PCI: rzg3s-host: Move host configuration code together
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de, 
	claudiu.beznea@tuxon.dev, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 3:54=E2=80=AFPM Claudiu Beznea
<claudiu.beznea@kernel.org> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Move host configuration code together to have it grouped. This prepares f=
or
> the addition of hotplug support.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v4:
> - none
>
> Changes in v3:
> - none, this patch is new
>
>  drivers/pci/controller/pcie-rzg3s-host.c | 230 +++++++++++------------
>  1 file changed, 115 insertions(+), 115 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index 362aa923978f..3ecada238402 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1356,121 +1356,6 @@ static int rzg3s_pcie_resets_prepare_and_get(stru=
ct rzg3s_pcie_host *host)
>                                                               host->cfg_r=
esets);
>  }
>
> -static int rzg3s_pcie_host_parse_port(struct rzg3s_pcie_host *host)
> -{
> -       struct device_node *of_port __free(device_node) =3D
> -               of_get_next_child(host->dev->of_node, NULL);
> -       struct rzg3s_pcie_port *port =3D &host->port;
> -       int ret;
> -
> -       ret =3D of_property_read_u32(of_port, "vendor-id", &port->vendor_=
id);
> -       if (ret)
> -               return ret;
> -
> -       ret =3D of_property_read_u32(of_port, "device-id", &port->device_=
id);
> -       if (ret)
> -               return ret;
> -
> -       port->refclk =3D of_clk_get_by_name(of_port, "ref");
> -       if (IS_ERR(port->refclk))
> -               return PTR_ERR(port->refclk);
> -
> -       return 0;
> -}
> -
> -static int rzg3s_pcie_host_init_port(struct rzg3s_pcie_host *host)
> -{
> -       struct rzg3s_pcie_port *port =3D &host->port;
> -       struct device *dev =3D host->dev;
> -       int ret;
> -
> -       /* Enable access control to the CFGU */
> -       writel_relaxed(RZG3S_PCI_PERM_CFG_HWINIT_EN,
> -                      host->axi + RZG3S_PCI_PERM);
> -
> -       /* Update vendor ID and device ID */
> -       writew_relaxed(port->vendor_id, host->pcie + PCI_VENDOR_ID);
> -       writew_relaxed(port->device_id, host->pcie + PCI_DEVICE_ID);
> -
> -       /* Disable access control to the CFGU */
> -       writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
> -
> -       ret =3D clk_prepare_enable(port->refclk);
> -       if (ret)
> -               return dev_err_probe(dev, ret, "Failed to enable refclk!\=
n");
> -
> -       /* Set the PHY, if any */
> -       if (host->data->init_phy) {
> -               ret =3D host->data->init_phy(host);
> -               if (ret) {
> -                       dev_err_probe(dev, ret, "Failed to set the PHY!\n=
");
> -                       goto refclk_disable;
> -               }
> -       }
> -
> -       return 0;
> -
> -refclk_disable:
> -       clk_disable_unprepare(port->refclk);
> -       return ret;
> -}
> -
> -static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
> -{
> -       u32 val;
> -       int ret;
> -
> -       /* SoC-specific pre-configuration */
> -       if (host->data->config_pre_init)
> -               host->data->config_pre_init(host);
> -
> -       /* Initialize the PCIe related registers */
> -       ret =3D rzg3s_pcie_config_init(host);
> -       if (ret)
> -               goto config_deinit;
> -
> -       ret =3D rzg3s_pcie_host_init_port(host);
> -       if (ret)
> -               goto config_deinit;
> -
> -       /* Enable ASPM L1 transition for SoCs that use it */
> -       ret =3D rzg3s_sysc_config_func(host->sysc,
> -                                    RZG3S_SYSC_FUNC_ID_L1_ALLOW, 1);
> -       if (ret)
> -               goto config_deinit_and_refclk;
> -
> -       /* Initialize the interrupts */
> -       rzg3s_pcie_irq_init(host);
> -
> -       /* SoC-specific post-configuration */
> -       ret =3D host->data->config_post_init(host);
> -       if (ret)
> -               goto config_deinit_and_refclk;
> -
> -       /* Wait for link up */
> -       ret =3D readl_poll_timeout(host->axi + RZG3S_PCI_PCSTAT1, val,
> -                                !(val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS),
> -                                PCIE_LINK_WAIT_SLEEP_MS * MILLI,
> -                                PCIE_LINK_WAIT_SLEEP_MS * MILLI *
> -                                PCIE_LINK_WAIT_MAX_RETRIES);
> -       if (ret)
> -               goto config_deinit_post;
> -
> -       val =3D readl_relaxed(host->axi + RZG3S_PCI_PCSTAT2);
> -       dev_info(host->dev, "PCIe link status [0x%x]\n", val);
> -
> -       return 0;
> -
> -config_deinit_post:
> -       host->data->config_deinit(host);
> -config_deinit_and_refclk:
> -       clk_disable_unprepare(host->port.refclk);
> -config_deinit:
> -       if (host->data->config_pre_init)
> -               host->data->config_deinit(host);
> -       return ret;
> -}
> -
>  static void rzg3s_pcie_set_inbound_window(struct rzg3s_pcie_host *host,
>                                           u64 cpu_addr, u64 pci_addr, u64=
 size,
>                                           int id)
> @@ -1698,6 +1583,121 @@ static int rzg3s_soc_pcie_init_phy(struct rzg3s_p=
cie_host *host)
>         return 0;
>  }
>
> +static int rzg3s_pcie_host_parse_port(struct rzg3s_pcie_host *host)
> +{
> +       struct device_node *of_port __free(device_node) =3D
> +               of_get_next_child(host->dev->of_node, NULL);
> +       struct rzg3s_pcie_port *port =3D &host->port;
> +       int ret;
> +
> +       ret =3D of_property_read_u32(of_port, "vendor-id", &port->vendor_=
id);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D of_property_read_u32(of_port, "device-id", &port->device_=
id);
> +       if (ret)
> +               return ret;
> +
> +       port->refclk =3D of_clk_get_by_name(of_port, "ref");
> +       if (IS_ERR(port->refclk))
> +               return PTR_ERR(port->refclk);
> +
> +       return 0;
> +}
> +
> +static int rzg3s_pcie_host_init_port(struct rzg3s_pcie_host *host)
> +{
> +       struct rzg3s_pcie_port *port =3D &host->port;
> +       struct device *dev =3D host->dev;
> +       int ret;
> +
> +       /* Enable access control to the CFGU */
> +       writel_relaxed(RZG3S_PCI_PERM_CFG_HWINIT_EN,
> +                      host->axi + RZG3S_PCI_PERM);
> +
> +       /* Update vendor ID and device ID */
> +       writew_relaxed(port->vendor_id, host->pcie + PCI_VENDOR_ID);
> +       writew_relaxed(port->device_id, host->pcie + PCI_DEVICE_ID);
> +
> +       /* Disable access control to the CFGU */
> +       writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
> +
> +       ret =3D clk_prepare_enable(port->refclk);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to enable refclk!\=
n");
> +
> +       /* Set the PHY, if any */
> +       if (host->data->init_phy) {
> +               ret =3D host->data->init_phy(host);
> +               if (ret) {
> +                       dev_err_probe(dev, ret, "Failed to set the PHY!\n=
");
> +                       goto refclk_disable;
> +               }
> +       }
> +
> +       return 0;
> +
> +refclk_disable:
> +       clk_disable_unprepare(port->refclk);
> +       return ret;
> +}
> +
> +static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
> +{
> +       u32 val;
> +       int ret;
> +
> +       /* SoC-specific pre-configuration */
> +       if (host->data->config_pre_init)
> +               host->data->config_pre_init(host);
> +
> +       /* Initialize the PCIe related registers */
> +       ret =3D rzg3s_pcie_config_init(host);
> +       if (ret)
> +               goto config_deinit;
> +
> +       ret =3D rzg3s_pcie_host_init_port(host);
> +       if (ret)
> +               goto config_deinit;
> +
> +       /* Enable ASPM L1 transition for SoCs that use it */
> +       ret =3D rzg3s_sysc_config_func(host->sysc,
> +                                    RZG3S_SYSC_FUNC_ID_L1_ALLOW, 1);
> +       if (ret)
> +               goto config_deinit_and_refclk;
> +
> +       /* Initialize the interrupts */
> +       rzg3s_pcie_irq_init(host);
> +
> +       /* SoC-specific post-configuration */
> +       ret =3D host->data->config_post_init(host);
> +       if (ret)
> +               goto config_deinit_and_refclk;
> +
> +       /* Wait for link up */
> +       ret =3D readl_poll_timeout(host->axi + RZG3S_PCI_PCSTAT1, val,
> +                                !(val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS),
> +                                PCIE_LINK_WAIT_SLEEP_MS * MILLI,
> +                                PCIE_LINK_WAIT_SLEEP_MS * MILLI *
> +                                PCIE_LINK_WAIT_MAX_RETRIES);
> +       if (ret)
> +               goto config_deinit_post;
> +
> +       val =3D readl_relaxed(host->axi + RZG3S_PCI_PCSTAT2);
> +       dev_info(host->dev, "PCIe link status [0x%x]\n", val);
> +
> +       return 0;
> +
> +config_deinit_post:
> +       host->data->config_deinit(host);
> +config_deinit_and_refclk:
> +       clk_disable_unprepare(host->port.refclk);
> +config_deinit:
> +       if (host->data->config_pre_init)
> +               host->data->config_deinit(host);
> +       return ret;
> +}
> +
>  static int
>  rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
>                       int (*init_irqdomain)(struct rzg3s_pcie_host *host)=
,
> --
> 2.43.0
>
>
