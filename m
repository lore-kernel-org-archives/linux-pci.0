Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCCB318B80
	for <linux-pci@vger.kernel.org>; Sat, 24 Jan 2026 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769260268; cv=pass; b=RY4FdAI7nWQ5iyB1UAzr2X94Jug8mhBRiBGk4Zr0LHDrenj/9MmmOddCGQkDRX6eKYp5WmXLm1bm8jNkUgS7inTHJ2o2DXFiHjtwQfmIAloQggl9DV4B69th0IoWSI/T52hzVTiIRKPH1lk/MlQTL6I05KWCpkqY6W+w5NVYxvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769260268; c=relaxed/simple;
	bh=uyHtgLwYzGgHkFD2fBpckJzQVJKhpavHJk6AJPxEQGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tr+qBgHFQAOYHQzqoxPS/zh2YSdSy4AtUOvSnbTMqkKLc+f48+jsyCoGxkhGxKrKEzySJI+ItS4ctb3l6/BtN4XiVHxJ0DNNxW724wdiSTrf656NrwfJUXvWj0PpoZvlJPrCTBzoJP0Xn7MF2q77YcjB/GGxeh8odxlq4Xp41PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/cdE/Vg; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/cdE/Vg"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35305538592so3025543a91.0
        for <linux-pci@vger.kernel.org>; Sat, 24 Jan 2026 05:11:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769260266; cv=none;
        d=google.com; s=arc-20240605;
        b=D+TqiCwn1JbPVds874/kDs/CS6pX+0ypICWFpjVPG8LTq4DHhAdc4dW/ksDmOScwMH
         DxnmSJ+JAynWO6jxtq79MotswduVd/z+3e3k68h4MH4FUNC0/SUe0I3VE6ZtK+KfDmgh
         9uw/0BXe+ySQe+OLxKaW8gckfBYeSAWOa3b2M+6W2DiEUWSMfGF3MVxadwPRP42trf7P
         nScYsX/NrGfWY6cuv+J8zP8/h87+gi0V7YaCjDuzDk4QqMUpl3zz8wEENYZWG4aCuAx0
         AioIA7A8PNALFGnHJT2vwnxiuix5tcEBteBCItl5w8Oj6Q/mzzrkN/h3ihOddeqMXK73
         js5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WScG7iuZQ9eiR9kQ4vhreoRjVXS9H3zvxs3xz4eUmjU=;
        fh=B9n8v3objJspUfVnEnrR6D7uuXV+igfYL1CER7VrEik=;
        b=WY+UAHRq3aVxNJDZFQDylK3FVP+CAZODASb1+8MjxKE/trRpYEWgFuro1eOODM0rf4
         dhMCWKouq4N/vji1VPhWvp1rZWrsZZNAZyXIzaA48RQResOuUe7JSlF3Z3gr6WYT+ncF
         JbXwJBSxVZTmPOEHQPWiNYhH2B/L+Q3Qm081IPN5eHSszzfqH1VIyD90a3aK68yKV1lZ
         wOJS6I6/p0Jcs6i2Z7wRx6y2YXQjfeWaJT3Gn4WFV5ZK4H+/pwc0le/f5YQ9Qwp8xpcp
         A51yri2FB5YNdt6meWuUQvekA2lX4MrNhBu9GSgP4npdNlKmE9uD9KfP60MgqWmvrobl
         M3MA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769260266; x=1769865066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WScG7iuZQ9eiR9kQ4vhreoRjVXS9H3zvxs3xz4eUmjU=;
        b=T/cdE/VgVQzqwINalV4zTzxy5mhfyA23Femcpdh4YwgR7qaBueOEFYCDMzW8fkfbCn
         7r4Bm/QIpJ9cHtH0RmNldMgISUo2n0jG9eUqa7AjeXI+OpXgU3WtwGjtPNeeeSrdisM1
         KM+Y7aMd+hlHv2xT1NKwotrwGJdXmp8FInsRwSmbUJyrVJzkakKV8aBMuwmrjIcuTrg0
         nkDLqXB8A3n+KfSMkWy66f+fiYMGTHAK/AMBv5FQzHyk3Ch/RldJuYT7CSygAmQPPGe2
         rY+ZpYK1VfhtoIp7LXdWlyddy/xqy0ZKt4JYNbfSgXITL9nlhKAhMjdk+BcgBO6Hi7gI
         nP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769260266; x=1769865066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WScG7iuZQ9eiR9kQ4vhreoRjVXS9H3zvxs3xz4eUmjU=;
        b=H7vOaGaS4un/6pdfJWeiGrU9BnFxe9TPREgnSQaNk957ncvHtT+gV/dR/rzL7V/lB9
         4MRdcH7PEdN0NM74itTjScAdE8jngULDfCJz39QG7ZhwxssrdjdD+CKyL9vA48BsgrhZ
         ZCAEDLNAPGWsqQS5Qn/ExQva5NYEBYA2Ykqf6jfUGHngILU0zrBgC1g+CEE0l9dKIz3Q
         ++i3ea1d5QJc2pqgFR3sHjk6dZUDt/BhuM6Ds7ssUrooAvSPbjyWjVqqK0XWWFW5c1+L
         blORqYMXS7notkuz99lnexB6FkDf7D0rFVspVF1IfQgXOrv5M116FMdfaTm/bZcbxcm2
         D/ww==
X-Forwarded-Encrypted: i=1; AJvYcCWM3OZtsJPorOfC9BmpifIRwKdl3HY64MCOqSmqbnORk7j2VxIZwLglq7YwgmU2veZjrlzXc8B7T/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywph7bTEdVd/Zcmq65yssiQDhioZu/XwTlQY0xQLFjHifW+LHbG
	0VgQjnP1h8Xd2TRhHkFQYD2JIpliu6DeCasHGfflpP8hmrSDh4dFBSwgbJtsOYSmuExNRsc7vex
	bNIYkQ+QF4haeq276km9qqnRh9zumvVw=
X-Gm-Gg: AZuq6aIqFUHZp8rbgrEE6P6Q/VZFSEP3HMDF2rDz4WWrIq0H01JSLmPzFhubjLGjhMA
	8OW6VnOcUS/qY2h5Aem9heIuamrbtssUh60wUhchUQQ70OLwKqENTssuDAwhZJYI3fnYs9k0Gfq
	qltAUIU1CVvNQ5c0Gpo+Bn6xGT5c4GLwaZfIrjTqSBKLRvsWPfrFy8ApApP2LNtCgzLUpC2LK1Z
	iDzfBFGXHxjxJ+BGD8d6YMcfdXKcZ0mbIi61A+I3UvTOHw1r/8nfbNO4Hzts1Ezjuok4zI1AeR1
	EXEBPuiPmtZ+TbXL6MfGrrSgcMgdjw==
X-Received: by 2002:a17:90b:560c:b0:343:f509:aa4a with SMTP id
 98e67ed59e1d1-35368f2be10mr5326690a91.36.1769260265480; Sat, 24 Jan 2026
 05:11:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124-pci_imx6-v1-1-6f4379fc5160@gmail.com> <aXPMyYeFVvDjSMhZ@lizhi-Precision-Tower-5810>
In-Reply-To: <aXPMyYeFVvDjSMhZ@lizhi-Precision-Tower-5810>
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 24 Jan 2026 21:10:53 +0800
X-Gm-Features: AZwV_QggnlVdXjeVSFlMBfY0oUjAdJOUKqSfuiS6Rl6oqAQRydYTbQJb8y5wbyo
Message-ID: <CAN4SLj20j8FW_AKAEG3kPBk5GH_hmWMU7fZUQM3TsQfZV7koAA@mail.gmail.com>
Subject: Re: [PATCH] PCI: imx6: Fix device node reference leak in imx_pcie_probe()
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Trent Piepho <tpiepho@impinj.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 24, 2026 at 3:32=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Sat, Jan 24, 2026 at 02:18:49AM +0800, Felix Gu wrote:
> > In imx_pcie_probe, np is obtained by of_parse_phandle() and must
> > be released with of_node_put() when it is no longer needed.
> > Add the missing of_node_put() after of_address_to_resource() to fix the
> > leak.
> >
> > Fixes: 1df82ec46600 ("PCI: imx: Add workaround for e10728, IMX7d PCIe P=
LL failure")
> > Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/contro=
ller/dwc/pci-imx6.c
> > index 1d8677d7de04..3ae02712d3f0 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1675,6 +1675,7 @@ static int imx_pcie_probe(struct platform_device =
*pdev)
> >               struct resource res;
> >
>
> Please use auto cleanup
>
>         struct device_node *np __free(device_node) =3D
>                 of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
>
> Frank
Hi Frank,
Thanks for the review, I will fix it in V2.

Best regards,
Felix Gu
>
> >               ret =3D of_address_to_resource(np, 0, &res);
> > +             of_node_put(np);
> >               if (ret) {
> >                       dev_err(dev, "Unable to map PCIe PHY\n");
> >                       return ret;
> >
> > ---
> > base-commit: a0c666c25aeefd16f4b088c6549a6fb6b65a8a1d
> > change-id: 20260124-pci_imx6-f97d70887dfc
> >
> > Best regards,
> > --
> > Felix Gu <ustc.gu@gmail.com>
> >
