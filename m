Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AF74734CD
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252784; cv=pass; b=pDjfPNfSyecaX6/Rkr+uersiF6wdJszcgYlvSFY3mdsfytc8cVLMs44NKXt3yplUqu5Reo2mqcqwYPwmXkXVSa3flhL0BXPQvtBldrhPoQwA9+361INE5ZOEHcAQHAAs5dXcHaJGg3ak3CE2AkpxWUikyWj8DEDFt3DB+regdU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252784; c=relaxed/simple;
	bh=9vSyr3e26Qz/fAvJZ42PLSKkIjr0FOmX+AK8aedKEO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGrcOieIg4zdcCDa3nBKa5kxjbm2Y/BJhv50XI/tkLyhsMIp4xKghxgVmZu5NXTSoitlBNt6LGLx85BA9PLj1He4D8+l6ZRkbPleKlCwcd0MQUeYk5UkyVzlSDetQgIcLG0Nnho6lc4z2aZx09fb2UlWIHrbRIV8l3WCeUxUHyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jq0LWYru; arc=pass smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jq0LWYru"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48877902c99so83527f8f.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 05:26:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790252781; cv=none;
        d=google.com; s=arc-20260327;
        b=MDzEuPx6pe4D32ZY92us5BgEYR5lZ1wg8s5gLeErxrztAQ72vyw6AgwMyiCnXm9x3P
         Ua+RBOaAVn4pTsHg56+2dZN/H1yTHaC6dfthuD64IONIV24zmHDD1wVqPtn+ZJxmJeEP
         RnvekiWYUDjXXKWM/OsI93DZcC7EgdNF/KPWfpn33uJPXB5FqBiR3OB9Wu0oidzCd/Ud
         +fuxBKehFq0UCwMwqHs2X7WchMlO8DW+GxstyOAYkPzL/tpCn14cmEKZufaD163D3xtk
         SQW7fMJCC4EhQhBaoodiJnzWHIJiaH/hpKW4JaE8+1NBJ/bdyfqm5/GxBqcuTC2r59XX
         8zHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=44/rB8ZswRc008KoGmaclPt6xvztpmvmKKTq9AsEafQ=;
        fh=bJ2fyqjLgz5xGVrfcQ0ecS1g6vibYXLa9pF86Pd7+Vg=;
        b=kCfmvZZYA7NVZozUDIuKUkOoP0hQ2zBjlqB/owWUr5i9dVCplu1CNClHhWNl+TRXcA
         Hsu0pL+i0RPRpBxesK38YJdYPBH/Wv667j7R+m4at2EETn+7BHIjpJfKJA2f+Q8/0+87
         i3f5+T3OZHt9M5kcXc7R8hMM+Gz5yrj7cl0pSTY5gBBSz7O4MFGPzHtj3C2xJQmthZkk
         AVWdhqBOTs3vPhsmXHnvq3M684NPrpDz0YKPgNevwMkk8cGzTvrHb9R6B8YS4Wo7GMhq
         6sSR9daXBJ21Dlstd0uUEmpgay2NdDMhJCtE7Wek7+MwDn65chAqRR1rpjlCL9WVE56o
         i65A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790252781; x=1790857581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=44/rB8ZswRc008KoGmaclPt6xvztpmvmKKTq9AsEafQ=;
        b=jq0LWYrur3pxZgTwnaZPgTj6hdlIygHkwAAmz4wRVGVxadRYqMhDqvDKbg1fxuzHnU
         rV2FvybfnMZDhNySDh1KOIT1iqRC31HHpLeGcBdqRBAo6R1bX128VKkXJC4lHvu94vnF
         5DZ82qRc9dtzPA71B4oZ7lZ2Dlwjuvke94wvfbiisoEXClVFTC31i6ZMztPYh1uPAWAL
         U3o/8nJ2HT8x23qLmwSNHNM66+7qoTWisyQpyG6h6ppsCsz+e0hEnJ8H0hqJ2h5WlzHt
         1w1Qj9wpXkM5xCGF4vWFt2JkLePh7gkBFsMJQRhI9XgFiebH7uht4Wj4Ha+zIkuNVRrL
         KOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790252781; x=1790857581;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=44/rB8ZswRc008KoGmaclPt6xvztpmvmKKTq9AsEafQ=;
        b=RLFhb+nYEuTFFRZ1JELEq7lXNziFS0Xlp4aH0WGBk7k7xkbWkcv3DOB6Gv7G3su4Bd
         vl0mCkeTeZ59Eeq3+5UV0s5xN0j4zUWcJwVnAMPcxbV0OUUNdJJvjcZibgqCrlaV1Uw1
         H2cePQEOdBji3/agBzc0Bh2triwOzKjexPnZ2sl5CV9itYBVH182awMuNO4y6y1suNRN
         TYzBY7nqREQrZuA6buU53PLl1XIxBwv80SoQjpA6LVXSRVRlyQIOUcC6DGbUmkUFqL5j
         rHx30a2M6ccPQbQyLsy2jUhe3UfO/CJL48K4NuueftKBNJwga65FQXrrstXbbs2Xe27V
         AErA==
X-Forwarded-Encrypted: i=1; AKwUvByCKh2byz18W4deQYtpRkl619Uj41C8cqEM6CYTUJQ1Mi/GuG34MbQzG/9YU9ec1AM+d54BZDWttU8=@vger.kernel.org
X-Gm-Message-State: AFuF++kjWs0iT4g6xHMf0bvdCf0K/KIv1IN9mI9cjW71tbBpOUT99jQ+
	h8ETs+4xaEJhMQaMtcMr8ek7F3hxCJpj4rqmh/07KaD5rHpD4YFcIajjCAHIxPxRf9tF9BtjZbP
	phhO/daEe/rLdbVmGmrluYaIL2z1ekmM=
X-Gm-Gg: AYBFou0C/JR+uV86osMkVV+R6haqlpkG/NdPiVuBReL5DmqX6o51C2R07nXpVFizJTx
	mysK8k11lEidqPTOoaAPLibuCdPLvzMRqR4e3oFh7Xo5t+ESn7lm0WQ1nUOR+D7VPoQByPhCiib
	w6dNu0tL0SjW7AI0x2cbt08IDny/UGcvqBpEMOrKBMiYVGzwkkI52ua5rk5EPrBwK0eOdbzvbGl
	TLmwbzSuiQpxra/nD4tlWrixrQZFc6W1DD5zMOtDnl8DGGT6QVnJjTSeu2bqqUjSSSppjGlITP6
	PWpUQgNgTneGeCyQ34E/ha/6B7AsTW3CiKt9UHToIQwugMYudfsdDuSSdXpkJW1Eyp9h1hBnh59
	mrHAhrH2jYhR6941EFtA5lVcVIeyFGeNAVEZqrlFYsVa0d6iyI8ArNdqa/OPJqTwSixLai6ljgA
	==
X-Received: by 2002:a05:6000:705:b0:487:bef:31cb with SMTP id
 ffacd0b85a97d-488716ca7e9mr3905909f8f.22.1790252780878; Thu, 24 Sep 2026
 05:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922144629.586997-1-claudiu.beznea@kernel.org> <20260922144629.586997-7-claudiu.beznea@kernel.org>
In-Reply-To: <20260922144629.586997-7-claudiu.beznea@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 24 Sep 2026 13:25:53 +0100
X-Gm-Features: AclHuK9gavbB6M7C_1T08SEgonhC2MdBJl0CvHQ9gIdkytsFMiv_mcHbK1pSAfU
Message-ID: <CA+V-a8t=7PGALbP3HMTYZyzB9Vp3w=Rx41yPCc_DHR-Z9+Afig@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] PCI: rzg3s-host: Move IRQ domain setup code
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
> Subsequent patches add support for the event IRQ to handle link
> up/down events. The event IRQ handler will use
> rzg3s_pcie_set_max_link_speed(). In preparation for adding event IRQ
> support, move the IRQ domain initialization code after
> rzg3s_pcie_set_max_link_speed().
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
>  drivers/pci/controller/pcie-rzg3s-host.c | 147 +++++++++++------------
>  1 file changed, 73 insertions(+), 74 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index 40d5ef3e347e..f4b27a77a89d 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1006,80 +1006,6 @@ static const struct irq_domain_ops rzg3s_pcie_intx=
_domain_ops =3D {
>         .xlate =3D irq_domain_xlate_onetwocell,
>  };
>
> -static void rzg3s_pcie_teardown_intx(struct rzg3s_pcie_host *host,
> -                                    int count)
> -{
> -       while (--count >=3D 0) {
> -               irq_set_chained_handler_and_data(host->intx_irqs[count], =
NULL,
> -                                                NULL);
> -       }
> -
> -       if (host->intx_domain)
> -               irq_domain_remove(host->intx_domain);
> -}
> -
> -static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
> -{
> -       struct device *dev =3D host->dev;
> -       struct platform_device *pdev =3D to_platform_device(dev);
> -       int i, ret;
> -
> -       for (i =3D 0; i < PCI_NUM_INTX; i++) {
> -               char irq_name[5] =3D {0};
> -               int irq;
> -
> -               scnprintf(irq_name, ARRAY_SIZE(irq_name), "int%c", 'a' + =
i);
> -
> -               irq =3D platform_get_irq_byname(pdev, irq_name);
> -               if (irq < 0) {
> -                       ret =3D irq;
> -                       dev_err_probe(dev, ret,
> -                                     "Failed to parse and map INT%c IRQ\=
n",
> -                                     'A' + i);
> -                       goto teardown_intx;
> -               }
> -
> -               host->intx_irqs[i] =3D irq;
> -               irq_set_chained_handler_and_data(irq,
> -                                                rzg3s_pcie_intx_irq_hand=
ler,
> -                                                host);
> -       }
> -
> -       host->intx_domain =3D irq_domain_create_linear(dev_fwnode(dev),
> -                                                    PCI_NUM_INTX,
> -                                                    &rzg3s_pcie_intx_dom=
ain_ops,
> -                                                    host);
> -       if (!host->intx_domain) {
> -               ret =3D -EINVAL;
> -               dev_err_probe(dev, ret,
> -                             "Failed to add irq domain for INTx IRQs\n")=
;
> -               goto teardown_intx;
> -       }
> -       irq_domain_update_bus_token(host->intx_domain, DOMAIN_BUS_WIRED);
> -
> -       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -               ret =3D rzg3s_pcie_init_msi(host);
> -
> -               if (ret)
> -                       goto teardown_intx;
> -       }
> -
> -       return 0;
> -
> -teardown_intx:
> -       rzg3s_pcie_teardown_intx(host, i);
> -
> -       return ret;
> -}
> -
> -static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *host)
> -{
> -       if (IS_ENABLED(CONFIG_PCI_MSI))
> -               rzg3s_pcie_teardown_msi(host);
> -
> -       rzg3s_pcie_teardown_intx(host, PCI_NUM_INTX);
> -}
> -
>  static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
>  {
>         u32 remote_supported_link_speeds, max_supported_link_speeds;
> @@ -1169,6 +1095,79 @@ static int rzg3s_pcie_set_max_link_speed(struct rz=
g3s_pcie_host *host)
>         return ret;
>  }
>
> +static void rzg3s_pcie_teardown_intx(struct rzg3s_pcie_host *host, int c=
ount)
> +{
> +       if (host->intx_domain)
> +               irq_domain_remove(host->intx_domain);
> +
> +       while (--count >=3D 0) {
> +               irq_set_chained_handler_and_data(host->intx_irqs[count], =
NULL,
> +                                                NULL);
> +       }
> +}
> +
> +static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
> +{
> +       struct device *dev =3D host->dev;
> +       struct platform_device *pdev =3D to_platform_device(dev);
> +       int i, ret;
> +
> +       for (i =3D 0; i < PCI_NUM_INTX; i++) {
> +               char irq_name[5] =3D {0};
> +               int irq;
> +
> +               scnprintf(irq_name, ARRAY_SIZE(irq_name), "int%c", 'a' + =
i);
> +
> +               irq =3D platform_get_irq_byname(pdev, irq_name);
> +               if (irq < 0) {
> +                       ret =3D irq;
> +                       dev_err_probe(dev, ret,
> +                                     "Failed to parse and map INT%c IRQ\=
n",
> +                                     'A' + i);
> +                       goto teardown_intx;
> +               }
> +
> +               host->intx_irqs[i] =3D irq;
> +               irq_set_chained_handler_and_data(irq,
> +                                                rzg3s_pcie_intx_irq_hand=
ler,
> +                                                host);
> +       }
> +
> +       host->intx_domain =3D irq_domain_create_linear(dev_fwnode(dev),
> +                                                    PCI_NUM_INTX,
> +                                                    &rzg3s_pcie_intx_dom=
ain_ops,
> +                                                    host);
> +       if (!host->intx_domain) {
> +               ret =3D -EINVAL;
> +               dev_err_probe(dev, ret,
> +                             "Failed to add irq domain for INTx IRQs\n")=
;
> +               goto teardown_intx;
> +       }
> +       irq_domain_update_bus_token(host->intx_domain, DOMAIN_BUS_WIRED);
> +
> +       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +               ret =3D rzg3s_pcie_init_msi(host);
> +
> +               if (ret)
> +                       goto teardown_intx;
> +       }
> +
> +       return 0;
> +
> +teardown_intx:
> +       rzg3s_pcie_teardown_intx(host, i);
> +
> +       return ret;
> +}
> +
> +static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *host)
> +{
> +       if (IS_ENABLED(CONFIG_PCI_MSI))
> +               rzg3s_pcie_teardown_msi(host);
> +
> +       rzg3s_pcie_teardown_intx(host, PCI_NUM_INTX);
> +}
> +
>  static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
>  {
>         struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(host=
);
> --
> 2.43.0
>
>
