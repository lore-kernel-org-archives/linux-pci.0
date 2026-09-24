Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A648380FD1
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252617; cv=pass; b=lpgiCM0hhyI8AFsuMQyRkPCXeTiG6JL0DgigCnh2paDSNK6q43MZRoWPqoHNkvlGabVjOnhmjvAcStsNHDxs/PXHU/+8001iMYLXMx+EVTQIwjIQ0KKB3RvohHz4gjzzEi9WWWck/sxEJTxSpo2nxawF+2pmgWVHqSUt37G+ljA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252617; c=relaxed/simple;
	bh=RNjjUPAqj04Zgmf3ERyYj6L+drgEgOadI/eoAl8Rxyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVphmkGXJD0794Soh9WPKnJNjgqmMVR3wZ0kaN9qKr1Cp5HIBcP/LAjw7Y3ZfuBLFXd51wha1RVttNHKnB4e9fT7oqi41tEbZK9ObpXHqCTNhmo6N9VplbkzjV4uOH0gn6UZvXCNmlx/6GpL8do2dWX+Pz6TI3vIpODCGypleYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUtIuKUp; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUtIuKUp"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-486e1a044c5so1630826f8f.3
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 05:23:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790252614; cv=none;
        d=google.com; s=arc-20260327;
        b=byinBMdB0ZUP+fagGjDY8Ap7i9fPwiyRaa4NeROS1HO3+6Rq96SwIH3fFFylP1uaoW
         NWyD3dos4LCT4QFhXzCFs8sKXvNhecKqTbVPKIbeD9c92xKByC+d93T0mj2EY11JHcgI
         Y8Ti9f0i1O5H4WrhLTgWWKEYk63vyaWs8UXy5oDOMR2goTPbJiU2xLF+1AR2twjBMCSE
         YUWz6vJo2EgZDmjh+GvuGHFba0qP56j8Vs6DgL3PWAHmenVkoAK7ru1zAjT/RY8Q/UJw
         uVBNetBBsrpZcFcdIgc866vbATSB3vhsiXZQq95G90OpsA0h+oGTWMHTbf91TOn2Hs2p
         l0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rdRrzn5S9xJBL1cPeQCdlU0zlgaKl3QYL9gnErwMUoA=;
        fh=oMsfI9nKyfjB9pNkdU9RVOY9iJePpS4yaqsRZVdeZmw=;
        b=DaNDXiC21UBAxBruF+4M3IdnFT8BKmYhuzXg/4y3L1Go5TvDHkSocX8mDzIK4kT/5F
         6e/BKd6hUI/O0Dj2/IcxYZnVywLSxkl/tgi/blTv2Hx2l6BHwTQaRpXTs6kgjzCTrrFt
         LnWTecCfurTENyCUa94i3h/o9qX6dFjywVKjplSwJYep1+Kf5Kh05yeYHnMYYbEy47FG
         BtwErrP8d1DHkwKJUV/6YqONuoy6c15W3eTCS45jw2FBMftfYPYtMPud9Cz+tRUAG1FC
         NEm7MwyuEFM+zryLYpa11xPLx7+RimI4lfqivvMbWAHpQq2oGMUJ5uzWBIRWqMQENkQh
         QxEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790252614; x=1790857414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rdRrzn5S9xJBL1cPeQCdlU0zlgaKl3QYL9gnErwMUoA=;
        b=TUtIuKUp287WjjaJ/J5W1Doqa4hIngcO0ksxIaxRuZRwDbiWyRujH4zL8KlOWrED3C
         PJ9DW+ulAF/7H1TwMNpsJ+8LcvQF7R/ak0Zs5nIz7MqNdu/dTMJ/WA99Vq83XfmhYufL
         ktJe0Ll9WAQMi3GBDRKFzM9HxlMjPhYPfFTtIeIOWUxQ8W5l3D7pHmnsLDtngJcIqluA
         R97fD72gY5NRT/AFcd64rU/bVu8GQCKcxs7trNyBxlpgdwiZbStdwF6P0KRsbIXADimv
         tCiWJYgxFNGCZ+U+L+pXdFkKkMD2e3OoIfyUmzRwyZapeAnUb6tGU+a2eMNKlv4GTSD4
         4bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790252614; x=1790857414;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rdRrzn5S9xJBL1cPeQCdlU0zlgaKl3QYL9gnErwMUoA=;
        b=xRLHwv1BSlLaBMFt1anquNXD85okOn8/8q48EBBhuuuRtEB4EXNxmVLgJN5aJ8L+qo
         i+x3T/phuBUne7FnHSpRGYCGIiIxywpwzceKhRNxFwk2INsg9ZpZSI6GSL3kV3xUGzQ2
         5MpYkFFBR5W1wosKUtyuffJZ8CAwFxK3DaHNpfVbUMxBPuOQ3iRD1xHVHpH+q7OsVQ5w
         N3b/HvdBKzl0nNQTOu50XBnxX7pjpSYngyXxPflf5E45/DpuaKrszfqo+puXQnQjtcBs
         UqiyB5Jegi131k2J/2ivBU5Wrspao88YgMgxyw9KjgvHNu8G0X1Q4ZJ1yGXXUIOjyx8q
         0kDA==
X-Forwarded-Encrypted: i=1; AKwUvBwAPR42W47fPxPg+kzWqsxpIGCWxicmSlrsyN57LdP700D8YDkBPypfRx+vbhYceq8k6lfBftB4ja0=@vger.kernel.org
X-Gm-Message-State: AFuF++kbnvJFJ28RBtbf55LSo+kloCF8mCGdotIUpEDhuS+Tj4+6IoA3
	pD100e99PTa84tMkpK7q4GxJA1fz0NGdkNY6gMMbM5pFcFfvsQHnrHnCPbETJGW91IwgWnPP0Ao
	uzHQs/FLPJM7QW9cJdAdCOFfa5ekS8mk=
X-Gm-Gg: AYBFou1wp0Lc3lS5GWw9dGPvJ+LifFmrS71oSN4/tzQcKxjqs9VUC4PI88Vw11nCP5N
	h76PEZX31XMioh3iiy1h65dsz4jOBKbzhLjwE2Dl/OkHmjPUyASRJSNFZe4rwN6ZllG6UIODCzO
	W5OyaXUDUeTc5TgpjFWrk/wFAzdd6haqxBkD8sWS01sMPKKdr/SkvbsE/fSq2HtRG/3OwcYzj4r
	0vNBfmLA6sWTjSIwrPSpufHL6uityv/gTSSSYiQabUoTzcbdMCvhWNyQv8GM0I3U9642GM8vqCh
	KxstiRAeXE8Gu0jh7l/8gjOQPfRODUbScOIi8DCwAa36UhFdAE6pA16CHieIarUkoB6twPgC53K
	+u1eR24g/pVEes0kbGScuX+PSIx39B7A8DAun4AtLQ1g=
X-Received: by 2002:a5d:5f8e:0:b0:486:e737:d94b with SMTP id
 ffacd0b85a97d-48871974c2fmr3738525f8f.51.1790252613801; Thu, 24 Sep 2026
 05:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922144629.586997-1-claudiu.beznea@kernel.org> <20260922144629.586997-6-claudiu.beznea@kernel.org>
In-Reply-To: <20260922144629.586997-6-claudiu.beznea@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 24 Sep 2026 13:23:07 +0100
X-Gm-Features: AclHuK-A9mOEuZHDK0Q_tjNq3JBCpEEYs1c2VB24F6HG3wDPVZfQ5b43QBAhTjs
Message-ID: <CA+V-a8vr--5UVR+TLTWyEkzany3W-nwsteeVZEDv7D-sVqyK4g@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] PCI: rzg3s-host: Move suspend/resume code into
 dedicated functions
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de, 
	claudiu.beznea@tuxon.dev, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 3:56=E2=80=AFPM Claudiu Beznea
<claudiu.beznea@kernel.org> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> In preparation for implementing hotplug using
> pci_host_bridge::reset_root_port(), move the suspend/resume code into
> rzg3s_pcie_host_stop() and rzg3s_pcie_host_start(). These functions
> will later be reused by the hotplug implementation through
> pci_host_bridge::reset_root_port().
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
>  drivers/pci/controller/pcie-rzg3s-host.c | 181 ++++++++++++-----------
>  1 file changed, 96 insertions(+), 85 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index 3ecada238402..40d5ef3e347e 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1742,6 +1742,100 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *hos=
t,
>         return ret;
>  }
>
> +static int rzg3s_pcie_host_stop(struct rzg3s_pcie_host *host)
> +{
> +       const struct rzg3s_pcie_soc_data *data =3D host->data;
> +       struct rzg3s_pcie_port *port =3D &host->port;
> +       struct rzg3s_sysc *sysc =3D host->sysc;
> +       int ret;
> +
> +       clk_disable_unprepare(port->refclk);
> +
> +       /* SoC-specific de-initialization */
> +       ret =3D data->config_deinit(host);
> +       if (ret)
> +               goto refclk_restore;
> +
> +       ret =3D reset_control_bulk_assert(data->num_power_resets,
> +                                       host->power_resets);
> +       if (ret)
> +               goto config_reinit;
> +
> +       /*
> +        * Since the power domain's genpd_suspend_noirq() will disable cl=
ocks,
> +        * there is no need to manually invoke runtime PM API here.
> +        */
> +
> +       ret =3D rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B=
, 0);
> +       if (ret)
> +               goto power_resets_restore;
> +
> +       return 0;
> +
> +       /* Restore the previous state if any error happens */
> +power_resets_restore:
> +       reset_control_bulk_deassert(data->num_power_resets,
> +                                   host->power_resets);
> +config_reinit:
> +       if (data->config_pre_init)
> +               data->config_pre_init(host);
> +       data->config_post_init(host);
> +refclk_restore:
> +       clk_prepare_enable(port->refclk);
> +       return ret;
> +}
> +
> +static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
> +{
> +       const struct rzg3s_pcie_soc_data *data =3D host->data;
> +       struct rzg3s_sysc *sysc =3D host->sysc;
> +       int ret;
> +
> +       ret =3D rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_MODE, 1);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B=
, 1);
> +       if (ret)
> +               return ret;
> +
> +       if (host->num_lanes) {
> +               ret =3D rzg3s_sysc_config_func(host->sysc,
> +                                            RZG3S_SYSC_FUNC_ID_LINK_MAST=
ER,
> +                                            host->num_lanes =3D=3D 2  ?
> +                                            RZG3S_SYSC_LINK_MODE_DUAL_X2=
 :
> +                                            RZG3S_SYSC_LINK_MODE_SINGLE_=
X4);
> +               if (ret)
> +                       goto assert_rst_rsm_b;
> +       }
> +
> +       /*
> +        * Since the power domain's genpd_resume_noirq() will enable cloc=
ks,
> +        * there is no need to manually invoke runtime PM API here.
> +        */
> +
> +       ret =3D rzg3s_pcie_power_resets_deassert(host);
> +       if (ret)
> +               goto assert_rst_rsm_b;
> +
> +       ret =3D rzg3s_pcie_host_setup(host, rzg3s_pcie_msi_hw_setup,
> +                                   rzg3s_pcie_msi_hw_teardown);
> +       if (ret)
> +               goto assert_power_resets;
> +
> +       return 0;
> +
> +       /*
> +        * If any error happens there is no way to recover the IP. Put it=
 in the
> +        * lowest possible power state.
> +        */
> +assert_power_resets:
> +       reset_control_bulk_assert(data->num_power_resets, host->power_res=
ets);
> +assert_rst_rsm_b:
> +       rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
> +       return ret;
> +}
> +
>  static int rzg3s_pcie_get_controller_id(struct rzg3s_pcie_host *host)
>  {
>         struct device_node *np =3D host->dev->of_node;
> @@ -1939,98 +2033,15 @@ static int rzg3s_pcie_probe(struct platform_devic=
e *pdev)
>  static int rzg3s_pcie_suspend_noirq(struct device *dev)
>  {
>         struct rzg3s_pcie_host *host =3D dev_get_drvdata(dev);
> -       const struct rzg3s_pcie_soc_data *data =3D host->data;
> -       struct rzg3s_pcie_port *port =3D &host->port;
> -       struct rzg3s_sysc *sysc =3D host->sysc;
> -       int ret;
> -
> -       clk_disable_unprepare(port->refclk);
> -
> -       /* SoC-specific de-initialization */
> -       ret =3D data->config_deinit(host);
> -       if (ret)
> -               goto refclk_restore;
> -
> -       ret =3D reset_control_bulk_assert(data->num_power_resets,
> -                                       host->power_resets);
> -       if (ret)
> -               goto config_reinit;
> -
> -       /*
> -        * Since the power domain's genpd_suspend_noirq() will disable cl=
ocks,
> -        * there is no need to manually invoke runtime PM API here.
> -        */
> -
> -       ret =3D rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B=
, 0);
> -       if (ret)
> -               goto power_resets_restore;
>
> -       return 0;
> -
> -       /* Restore the previous state if any error happens */
> -power_resets_restore:
> -       reset_control_bulk_deassert(data->num_power_resets,
> -                                   host->power_resets);
> -config_reinit:
> -       if (data->config_pre_init)
> -               data->config_pre_init(host);
> -       data->config_post_init(host);
> -refclk_restore:
> -       clk_prepare_enable(port->refclk);
> -       return ret;
> +       return rzg3s_pcie_host_stop(host);
>  }
>
>  static int rzg3s_pcie_resume_noirq(struct device *dev)
>  {
>         struct rzg3s_pcie_host *host =3D dev_get_drvdata(dev);
> -       const struct rzg3s_pcie_soc_data *data =3D host->data;
> -       struct rzg3s_sysc *sysc =3D host->sysc;
> -       int ret;
>
> -       ret =3D rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_MODE, 1);
> -       if (ret)
> -               return ret;
> -
> -       ret =3D rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B=
, 1);
> -       if (ret)
> -               return ret;
> -
> -       if (host->num_lanes) {
> -               ret =3D rzg3s_sysc_config_func(host->sysc,
> -                                            RZG3S_SYSC_FUNC_ID_LINK_MAST=
ER,
> -                                            host->num_lanes =3D=3D 2  ?
> -                                            RZG3S_SYSC_LINK_MODE_DUAL_X2=
 :
> -                                            RZG3S_SYSC_LINK_MODE_SINGLE_=
X4);
> -               if (ret)
> -                       goto assert_rst_rsm_b;
> -       }
> -
> -       /*
> -        * Since the power domain's genpd_resume_noirq() will enable cloc=
ks,
> -        * there is no need to manually invoke runtime PM API here.
> -        */
> -
> -       ret =3D rzg3s_pcie_power_resets_deassert(host);
> -       if (ret)
> -               goto assert_rst_rsm_b;
> -
> -       ret =3D rzg3s_pcie_host_setup(host, rzg3s_pcie_msi_hw_setup,
> -                                   rzg3s_pcie_msi_hw_teardown);
> -       if (ret)
> -               goto assert_power_resets;
> -
> -       return 0;
> -
> -       /*
> -        * If any error happens there is no way to recover the IP. Put it=
 in the
> -        * lowest possible power state.
> -        */
> -assert_power_resets:
> -       reset_control_bulk_assert(data->num_power_resets,
> -                                 host->power_resets);
> -assert_rst_rsm_b:
> -       rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
> -       return ret;
> +       return rzg3s_pcie_host_start(host);
>  }
>
>  static const struct dev_pm_ops rzg3s_pcie_pm_ops =3D {
> --
> 2.43.0
>
>
