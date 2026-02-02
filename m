Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E57A2F2918
	for <linux-pci@vger.kernel.org>; Mon,  2 Feb 2026 19:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060225; cv=pass; b=Xuqa0yPNcFUuqQ1Rx8orWRjcKGJc2S4i0MZod1eriH7Erta0IIupe79l8UfIP0zAO2PRKrPGuQWmRhVPKaTkgg8QSlDzqemEiOxRWOQgHs7sIAQW5A/arICkjUXzmvKqeLd6DQJbN1iHPZe+op8WNy+vKFtDSepvPNHqqgFIHwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060225; c=relaxed/simple;
	bh=jnZPteeSHeX5ZpEveHAlWBA4LRcr7W4KJV3rdDt8BuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgQlaO6IfzZCZKI6iro+ien4fyoY73FUbF+ZZgjOHxIDYWcEIPyL1cku24pTgCUR5WovGrg2wafTd3u26yo0IEIxvb3Pfr93r2ubym2ZOtq0Rxdn2wHJ9ltE5NDA9swP6USENbqoEtQw0MgkMh+o0O7V9fFr89J5of8gJITfW+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b1VE665g; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b1VE665g"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64d1ef53cf3so6108072a12.0
        for <linux-pci@vger.kernel.org>; Mon, 02 Feb 2026 11:23:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770060222; cv=none;
        d=google.com; s=arc-20240605;
        b=lZlnJrN0DT4d4sa3Mc6TKDP28IpKhUCa9xvPVImtaPTB4VTYR06Ip2SDbAosISGA0O
         99wirpHx4C+g+UCJZ6cditbEOZsXXh/13gt5767KWwUVtuaXHz3u5OdVYlLzOLGOolzf
         AFxGKTujqBm4QaKvNvXz9vW3893QgHadDfAeeJn+XXjg0q3pGqWbtXvmUHwTPUOcNwKp
         LLbf03y+nvPqJJrHJk3ZMyBFXpnAXomNXAbwylzxqW5YvtYHmXFD9Ll0KalONlKJRwI6
         9AL0ijX9I3XDL5x3oP2HGHRh4U4nynjzLQEn2mPF0beqbAlVP1BpYLCjYQHMeVh23JV2
         +ucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KqNSP8u9FYnKkd4xDRWAuBWQOKd1/6jXqlAv5Huiee8=;
        fh=lNqwcR5Gd+/mN/3y1pf5mySSfiMS7cJrP0eLuRanEV4=;
        b=Sem+mhu8kKJvCZX/lpQ4Ku/erUe+KiIeZRSl7UHdeLwlEUXAbDiLnLlIVSXwC68xmP
         nDa0VklL6JCrVfxxXpsVH7epT3Ok/scTlIYa9b8XRLq4YuGSIjkASjYYS4kPda9JbouH
         8aDz7bc8zeDF2UbDOvBfMZTe9d0trTPVOIs9ZbajgRX65wSnpp10QkC09nC/c0E/5/Jk
         0AEUsD8Ezp+Yp2VWTBDEXwaC5vBQr8iLK4XB7qHdCvn+0OOcdcJijD5GGs5VnoK7kMBS
         EzRjWqKDbRsinQpyamHS/+uYQgvA1jc++GRtGc0l61qE/T9pwObryZ4pZtOTVNXM/NPC
         W54g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770060222; x=1770665022; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KqNSP8u9FYnKkd4xDRWAuBWQOKd1/6jXqlAv5Huiee8=;
        b=b1VE665g2mIi70zs0Ch67rJLvOs9kZjc8Bei+zGR5Y2VndUL3orn87yM8cGbrvoPGt
         J/4/NhetaWO61kFmbmV0lpW14n4LG6kEBeQybPunfb+GFjbhAgLfx9Dguh131c3CiuQB
         ZzSnQgjS/x3d3OMtlJwLJruqxD9RNupiT1Sh7w1dyY+11u18Mvz/BwdRDmyTtDbBdVsf
         S6V3KlGtITaEeMN1wgbgmtKOv+zhCe2xa0XHAcpB2Yli7Adx+pFFqrb9CNqd7v5o1bY4
         hdYXzYou5yRMaBe28s8LOJ+qhK1/vaqSfvfd5oWrO7yEyxJ1MkgTfQ/LGrFjjxk3roKT
         adfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770060222; x=1770665022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqNSP8u9FYnKkd4xDRWAuBWQOKd1/6jXqlAv5Huiee8=;
        b=ChiKWSRRf/gV0P32cJR1h1buW/m5b+Z/VOqoqvXWTEn2NVOzzB8HRWKWRl6w/JdI71
         IJ5czcvvRjiWG3Qc0Yv144+VbkmX5rvQ8JbPAmBTFgR5ggFJlIOZHcfIdr6kV3J5q4Tc
         HSOMepLl2uawc7p+C0mnQ8MMQZGdKHov4RDk0Xap6Fk2bziZAzQf/w7TW0tSdOvyCIE7
         hUy4WhqdBgJyYBWfrMk1GGp3xgKBHf9hjkA+LhPoYn8bymID1o4xF1Fi1YnoYGtNc62P
         BBRNDXw7XHmt4QhROEepwKNS23WTuU2+znQ9uUAZjWD2tAhFUtvRqKJGey49IglEPuMw
         XoUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0lbnjsmcebJQ1bmpeErh12EJToH9ilbMoNIRbZKJD2XC9vy/lYMUwlCX5OiJc5l7gTUkpJsC4TZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5jP2fDtYwmHw4lg8FzIGMg4Zs5MvmCaUmZyZr5NQM74BXYF2V
	8gxWPfve5yvCAL2BS6/xDK4amS1EXRkMQVFdlj9E0tpELLNxxzqj89MnTQGT6K4T2YDpjrMP1q/
	QoQTj3FIHdi8HUjEdMxKnezkKgM6StcLl1H2kgqDC7g==
X-Gm-Gg: AZuq6aJfzJO1TPgx/9g80e7d7EsvC67HaWUumRNuUEm0ziKdeKZ3KPEczTjfLHXPUGP
	h5uzbpPYplI0dxiguAW1nCEy6gT6TZuIYafatuiCN/8u/j/f2HB6bJDoRY+5uDhG8MlsrD6zmdN
	xt1qRaIxby/Ap59zjK6XIMPENSFdojZmCpNYu7FkyYnY90YapMD8t599a2B1YOsHW7tZVjm6rla
	vp6PyjYXZ/8TLS+moXQ/aEHFhYTZGtWc4KNNMYVDydbT5K4m1H4S6SCJUTEDnbI0BOyvTFj3xyL
	sHqOfE1ETxKAkJab/qSVjQ==
X-Received: by 2002:a05:6402:430a:b0:658:cc59:161c with SMTP id
 4fb4d7f45d1cf-658de563dccmr7500568a12.12.1770060221904; Mon, 02 Feb 2026
 11:23:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202151050.1446165-1-vincent.guittot@linaro.org> <aYDiFpGT5hEDDFhV@lizhi-Precision-Tower-5810>
In-Reply-To: <aYDiFpGT5hEDDFhV@lizhi-Precision-Tower-5810>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 2 Feb 2026 20:23:30 +0100
X-Gm-Features: AZwV_Qh1oY-NeA_FmOnmZdDAzImBqngjLBWXIy59t4ga6SGhrkYyYc67DM6knQ4
Message-ID: <CAKfTPtDjad7aowTQ3UJPi5Qqgzf3q8J=kASa-t3YM4zfjUv3-w@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: s32g: Fix ports parsing
To: Frank Li <Frank.li@nxp.com>
Cc: ciprianmarian.costea@oss.nxp.com, s32@nxp.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Feb 2026 at 18:42, Frank Li <Frank.li@nxp.com> wrote:
>
> On Mon, Feb 02, 2026 at 04:10:50PM +0100, Vincent Guittot wrote:
> > No error return is missing after the loop resulting in removing the
> > ports from the list.
> >
> > Fixes: 5cbc7d3e316e ("PCI: s32g: Add NXP S32G PCIe controller driver (RC)")
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >
> > Change since v1:
> > - handle correctly the case when there is no child port
> >
> >  drivers/pci/controller/dwc/pcie-nxp-s32g.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > index 47745749f75c..b3ec38099fa3 100644
> > --- a/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > @@ -282,12 +282,12 @@ static int s32g_pcie_parse_ports(struct device *dev, struct s32g_pcie *s32g_pp)
> >
> >               ret = s32g_pcie_parse_port(s32g_pp, of_port);
> >               if (ret)
> > -                     goto err_port;
> > +                     break;
> >       }
> >
> > -err_port:
> > -     list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
> > -             list_del(&port->list);
>
> break and goto is logical equal here. So only need below if (ret).

Yes it's similar that why I removed it, the goto becomes useless and
make code less readable

>
> Frank
>
> > +     if (ret)
> > +             list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
> > +                     list_del(&port->list);
> >
> >       return ret;
> >  }
> > --
> > 2.43.0
> >
