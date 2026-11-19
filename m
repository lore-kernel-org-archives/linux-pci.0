Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795068300;
	b=J2vC1d/Lsyjx2vk1ZjKsKrWjpTydwbJumKFhCvCtOS5R4+oIsgtrN2YuOWhKT8oCF6xh
	 exGIv7cBaCvfmpy13TLg/znQe6bG+XdExdA1aXKg96yHXw/PmuozZDw8fJ1+4ELLhcBOc
	 bZDO7PR++o82wiFhhXt6InnG9ruBpR2Jbw5EMPhZhaBTJAbFCvJA/yR98YiySruHEZAga
	 Rbq8xjyAj8bDiOFZQ0g25VwMrqcl72YrB3Xl9lhFodFyQ1vRQvtkhToqQzzhXUUe+/S2W
	 RjiTp7ns2Z/vQLiMHKe2RIbIi3eVawxpIo/Yr/KxDGocwsD4apL/WHEisWmR20dfQqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795068300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=g7tiKu6iToFwXv5ORc/C2e3umAfzd5HxlGVwlZD9DEQ=;
	b=XccnrEPlapkkZKXIhyQ8ePBudUNbwQbdwyElVykkPTu9ultY9x+8ypUUGxD/vX5tr0uT
	 WBxIftrjwJA045RcUXi5WwJVQz3fWFT9FAfEQ1v1C/GjmUkq5tzijglQv/jbjJ+wuJe86
	 m9KnDex7IwPNOonkKx3lM0yBTsbajGsHuhrAi0phrUJQWVrouxg4udtPUeqy8RLvffXG/
	 9rWwO4omMMuyUPTqnbE/wyatXlYhpRoXOtdxSijJmC/O8DR/ahH8IcYynLmkc2QWqSkhw
	 kqSRj39OHjYcgN33Zq3V7Esowxtyn1sWSQQZA/8DY0uCKY0NWaAK+/lHJutVpNPEN/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Srhn8kN1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A09C606A320
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 06:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A09C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Srhn8kN1
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c511cdd5a82so167133666b.3
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 22:05:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795068299; cv=none;
        d=google.com; s=arc-20260327;
        b=kbqRSfxZG14Kwd1p4ptmOeS5iwK3b9VfKbwbEc/u8xVY86KxOFrId3H+8SfwDViDhH
         I+rxcSp45n0h5RbTfq+4+EJUgZKPqrg1oLEEwVi0gt/DbBM2WVq7BISne9bY+6rrLKJf
         wddmn1LdpbK5dLlgf3jxGvcmLvcbCKO+KNKW8G/CkJ5MMfufoLow0cAXJuPQy4QIszPd
         eNiWcs57MUo5au4WmpLHslIJ+ybok/WtUMQ/x/KehKPzkIHh2GJJBByhf7TihmcjYqiI
         EXHKBdCVFVAN9MegAfgiyDyk8nq5GyHlBpjzSFLjJGSg/jcRaBtQKZ18j8c/bbSBcaDY
         l33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=g7tiKu6iToFwXv5ORc/C2e3umAfzd5HxlGVwlZD9DEQ=;
        fh=4ZnnK0+WZJ8gANZ8T1unYJAlB2CcLUd77vlo58Q7ncQ=;
        b=JjviQbQjN1b/RjasackiZHpJxpgfehlTzS4imteFdui9RdHQwd6OQ3w0j98qSNQilu
         L6I5jSCxzePstAccW5RAY6lrGqjl96NFQFUm3Wf1jVKJ3pmhKEGFjS7W1DZ/wW2SwEf2
         XnxlLwAft/X8ol8/5SDyFXJnn7MMbPtWzjRjotf/EHSABa0lekWga+ZyJGKf6XKJK7fv
         mhblNFvsUHMqhHbggBgMdNNIM7P29rxOc/HRjyEIqda+ItX7+3dpNEeLcTPVTo7lI+ry
         vyy8SwIJPu3aXiF72rBwCa/6+TzI9YScPGj/S28CjkuDLOf6ey7IkpCXUpGqHNoDnSdh
         phBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795068299; x=1795673099; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g7tiKu6iToFwXv5ORc/C2e3umAfzd5HxlGVwlZD9DEQ=;
        b=Srhn8kN12nw+CtlFdussih8FNlkzw7xSWmlWQS3NXEt1CeYxD0zgzhfwQuOG8/RnnW
         qN9wkngaExKG0jk0yITi3/m6RXrq6yRQ3+EO8AGWh/fb/a1AJ2ELlnTZc2QE9H2XyS3r
         AMUC+WgI3TSGOgqTiVjwFST8sobzRjZbjioDbBvkMZC+rSKzX0Uen4dG3iAljyBAE09q
         9xXzO4qhuNeiWW/B8MPzwGI/0CM1/APkA0bn5r5qwKXaP5ivHTVipuF3sfBpf6CZfIMx
         JP0vz2eHw6rE9zmIPzRLvw8HjdLRNElAjs2OVsloF+a+SXdVvg12+OBJKjQg3ZlIOmQZ
         4fhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795068299; x=1795673099;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g7tiKu6iToFwXv5ORc/C2e3umAfzd5HxlGVwlZD9DEQ=;
        b=f1wfEWIy+p82XnvEa+Avax7R50q/dLpku7+rN/n8we9gvyf+0bELLLIoVtSWF5eLok
         xCdcvHHgVcbbAmTdl5y+T74WFlsaX2hMctfBBAOObl1JTdLo/+cvmsJQSAwsk7OinEvj
         5C4vlBPFQDJ52UL5sviEBnCtf4YVhet/1GC0N2Kp69zldl7dkvAIp4rOCIsGzNvSsWPA
         sIFD8iMOSwSuJ049XMpt4LBpGZPPuZteUAhRwzF2XWk8KtSFqItK/WP5UaH9sTLH/DZe
         cqGhHAA0TBW4velAOcGZm1Q3O4XGBwsDffgRx7DQ6JoUQuHECed29TaOqFgL2563oWSX
         0GJg==
X-Forwarded-Encrypted: i=1; AL+hErFyFGz+OQ5uue7jQ/rKdtHAfCM71tUeYzgavDbvCZ2EnTadeGAjgJQbFieqrCYEBt6Qm1WEdOY8gD0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QK28/0KtOMSjVdgKcPW4f/0+NQqkLNxpJw+NV69PfL9x9F8RQ
	XftN3M8FzeK6t8N+7Nk17Jb6bJi1Wog+ia5l1yndNXgOa7fTjPKmST5HCzPJ5uPv94UzsOflnes
	zphpxB10xswCWBQVqJxmNXmfNPxKhsnQ=
X-Gm-Gg: AYBFou2JatRR1A0VNzqrJLy9HsH2dIC3MXJOCTg9FaZB6LWX4WHOOW8nqbXlpRG6YUl
	ZKqpoPhg1ho4K03KIjixXJ+UcUHAD8UiNgbTuiRWhv5Y1nYDj1mCYpGvl8sqkugzvmr0SYx1olm
	c9NhnYQPWLj2taiasRU1m/VIcxAdIH0XbUMSXMqugu5JPoEWE/xgovsxpK8EwsK5eY14To51Ede
	nwib5aSwUu5TJQlhJrUHQq0gWlQfM/tEUoin2DyQhiZK5SNSiOjON4IOBV0ve2w5KPQTj4AGG3Z
	dquojx8gyUPQMTVxz8i7eOxv2DPqq1lHATzfeZ2XkAWrJwoScaj8XL4asL93k52N+5t7jpbj4q1
	Mtoiwg/C1s/XdnQ9zIeUbZ/x2Dzv5Bd4gkvQ=
X-Received: by 2002:a17:906:c104:b0:c4d:28ba:f221 with SMTP id
 a640c23a62f3a-c510e5903demr427620066b.42.1795068298655; Wed, 18 Nov 2026
 22:04:58 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119-b4-rockchip-pcie-hib-v1-1-05df24cc77e6@iav.lv>
In-Reply-To: <20261119-b4-rockchip-pcie-hib-v1-1-05df24cc77e6@iav.lv>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 19 Nov 2026 11:34:40 +0530
X-Gm-Features: AclHuK-yj0qp-k9YYA6fs3KiQog3XEeJOKWZ7G7ZFB-glkWEk6yaKExA1sPwYKk
Message-ID: <CANAwSgRaHubdh8o5Zd3k5Sa_jf5fWuEuCXqbQu7gGL71MwC+8g@mail.gmail.com>
Subject: Re: [PATCH] PCI: rockchip-host: Support hibernation with endpoints in D0
To: iav@iav.lv
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Igor,


On Thu, 19 Nov 2026 at 06:42, Igor Velkov via B4 Relay
<devnull+iav.iav.lv@kernel.org> wrote:
>
> From: Igor Velkov <iav@iav.lv>
>
> The driver runs its suspend callback on every system sleep transition,
> including hibernation freeze and the quiesce step of the kernel that
> loads the image. The PCI core leaves the endpoints in D0 there, the
> link does not enter L2 after PME_Turn_Off, and hibernation aborts:
>
>   rockchip-pcie f8000000.pcie: PCIe link enter L2 timeout!
>   rockchip-pcie f8000000.pcie: PM: failed to freeze noirq: error -110
>
> Keep the link up across freeze and thaw. On restore, power the port
> down and bring it up as on resume, because the kernel that loaded the
> image may have left it in any state. The port may already be down if
> poweroff_noirq ran, so track that state.
>
It looks like we aren't disabling all the PCIe regulators (0.9V, 1.8V,
3.3V, and 12V)
during suspend and re-enabling them during resume.
Shouldn't we power down all of them on suspend and bring them back up on resume?

Thanks
-Anand

> Signed-off-by: Igor Velkov <iav@iav.lv>
> ---
> Tested on v7.4-rc3 with this patch, ROCK Pi 4A with a WD SN770 NVMe:
> 5 of 5 hibernation cycles restored, the NVMe readable after each.
> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 33 +++++++++++++++++++++++++++--
>  drivers/pci/controller/pcie-rockchip.h      |  1 +
>  2 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index 1e1556e436b8..df4b9b3ec031 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -863,6 +863,8 @@ static int rockchip_pcie_suspend_noirq(struct device *dev)
>
>         regulator_disable(rockchip->vpcie0v9);
>
> +       rockchip->powered_down = true;
> +
>         return ret;
>  }
>
> @@ -893,6 +895,8 @@ static int rockchip_pcie_resume_noirq(struct device *dev)
>         rockchip_pcie_update_txcredit_mui(rockchip);
>         rockchip_pcie_enable_interrupts(rockchip);
>
> +       rockchip->powered_down = false;
> +
>         return 0;
>
>  err_err_deinit_port:
> @@ -904,6 +908,25 @@ static int rockchip_pcie_resume_noirq(struct device *dev)
>         return err;
>  }
>
> +static int rockchip_pcie_restore_noirq(struct device *dev)
> +{
> +       struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
> +
> +       /*
> +        * The boot kernel may have left the port in any state, while the image
> +        * holds the enable counts of a running port. Power it down so that
> +        * resume brings it up from scratch.
> +        */
> +       if (!rockchip->powered_down) {
> +               rockchip_pcie_deinit_phys(rockchip);
> +               rockchip_pcie_disable_clocks(rockchip);
> +               regulator_disable(rockchip->vpcie0v9);
> +               rockchip->powered_down = true;
> +       }
> +
> +       return rockchip_pcie_resume_noirq(dev);
> +}
> +
>  static int rockchip_pcie_probe(struct platform_device *pdev)
>  {
>         struct rockchip_pcie *rockchip;
> @@ -1011,9 +1034,15 @@ static void rockchip_pcie_remove(struct platform_device *pdev)
>         regulator_disable(rockchip->vpcie0v9);
>  }
>
> +/*
> + * Freeze leaves the endpoints in D0 and the link does not reach L2 then,
> + * so keep the link up across freeze and thaw; restore re-inits the port.
> + */
>  static const struct dev_pm_ops rockchip_pcie_pm_ops = {
> -       NOIRQ_SYSTEM_SLEEP_PM_OPS(rockchip_pcie_suspend_noirq,
> -                                 rockchip_pcie_resume_noirq)
> +       .suspend_noirq = pm_sleep_ptr(rockchip_pcie_suspend_noirq),
> +       .resume_noirq = pm_sleep_ptr(rockchip_pcie_resume_noirq),
> +       .poweroff_noirq = pm_sleep_ptr(rockchip_pcie_suspend_noirq),
> +       .restore_noirq = pm_sleep_ptr(rockchip_pcie_restore_noirq),
>  };
>
>  static const struct of_device_id rockchip_pcie_of_match[] = {
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index b5da15601b58..51877678d3df 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -324,6 +324,7 @@ struct rockchip_pcie {
>         void    __iomem *msg_region;
>         phys_addr_t msg_bus_addr;
>         bool is_rc;
> +       bool powered_down;
>         struct resource *mem_res;
>  };
>
>
> ---
> base-commit: 35f800669ce835aa77364a2ab5b61be19b778d3c
> change-id: 20261119-b4-rockchip-pcie-hib-004e1adc4042
>
> Best regards,
> --
> Igor Velkov <iav@iav.lv>
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
