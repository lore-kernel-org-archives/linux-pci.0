Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DF7533D6
	for <linux-pci@vger.kernel.org>; Mon,  2 Feb 2026 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770039442; cv=none; b=Ng3rWmdFQ/bTnjZGf2s27aC2LtbUlj7UENgvKkscREPGD9VRPxaL0pHxoRifhzWlZTdZB5t0KXApc76g2h71Q0yg35Cmz9a/g26OCSaCpVBA6NM2HNWpPzRtyn8b18WPHSaKi3BdMgai6xvL8aY3zriTDbQmf0QZnSch0UDcHIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770039442; c=relaxed/simple;
	bh=V6Tfoe3HRWqS64lmo1MNdCN5YwtOZQCUr/ZQi4ndplk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvrq5/8x4AS4w/bD6252RmuDDKr0uYjkwhAN/b8ScwOKYFcHpzDV355l+ppEIdo8z+K77hqdt3X08QZQYQLhALM2sBnWM2NpTAvHroKWfWbptWyfEbsLuNz/TovYmMO1P5qKJTthzgSn4oTFK6AWF1RMrccyBIlB3Sf5ZqPywZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ph61dp2i; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ph61dp2i"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so4733947f8f.2
        for <linux-pci@vger.kernel.org>; Mon, 02 Feb 2026 05:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770039439; x=1770644239; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sMtwM17CKX/8W2nz2qFNN/9+egceBVoLznQr83mTsDY=;
        b=ph61dp2iWkWGKhXd+HbzxVvu2Kk3eUeNK/GLYVQPLuHYgnQ3cK9XI1BgD3vFsUuoTF
         VG7uVhBWgk2X0KaLmk1vGIM15+rH0959AeBcwox6HryoX0gQEex7IJZYvj9u12P/wZmU
         DZOm/98BZHhtv2YSK5sG6uN33rVsSHfJMtekMe6MtZALja9OOT1wIRE94p1zTkxUOuWt
         gm198EiiDvDdTzgT3mR9sOdEVTjkB4WPjAVgkEJSsZHkETOzagbcnbczaOA6Z57x8/Ch
         uYaQzmNWyISWneMn+bxEAjX6pfEGRXzbD3lw2ERs4124unfIc0mfV5P8dFalfmh8A6fq
         8x6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770039439; x=1770644239;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sMtwM17CKX/8W2nz2qFNN/9+egceBVoLznQr83mTsDY=;
        b=GGCIWWHJ0njdxoGoQS0DElFuy1oYlMWnYpJ8hqRj82Yf66K5hcF7ETVAmO0Ybg8Sgs
         B+csbqOjnNq5MwsmydUTXVHGSrOZcyULsQo4iwWIbevoufgxHkrIiUt3f1BEIC8H6Q1G
         4nHSv9TuNhra7HgMT/WZwmdMFFLzglOhBx0NIuemlGSU+GcWV0jD0kHvn4JNEvh3bVmd
         cidQ1QeZKqyMLJmD1f7cAgISafx7z/c+alWsvHhnhZmechjVZVrZmxcsTXAVyJG0S9ct
         3mfbxzPONMJzq38MiB90s44UbAJK67pf3WOnqRq/VkBejWzqE2KnC+hPwdSj5P2iCHg6
         62BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdnVOlJo/ai4GxbvUyUVRIuzmbq49yoWx6a4xPqFXkdl50cf+K0IodA1KbNCp824zj0evzxgpvDQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmb/xAivB+9lg4liZZyknglPffLF+XSKydWZmOOgvP3aGguhBF
	vM+r5e/47p4ZI6C36jir8IAPo0c/W/dMxeA8sk3Jn2JGpuJ3TTd+OHZJGvh8urXTg4c=
X-Gm-Gg: AZuq6aJiUxnrUuCxPcIwb7POmPEnYUhBr4Hj6v/n+QxkZazA1jmnxMEeLFqHS6wCL6q
	wvarrCKMu5Atelk7wVqv7e+azMpBC4Dqnlh+LjimA1yoDv0FQMcyAB85qs6S3IM+AP/eWp7fgtF
	uFgETgRiBm/Bc7sP9gATuYqOnLxk/se5DwoVNkbtKfj2WjNozPXKGwytjcPXTA6b7pMLDckCp0V
	Ungg0wtdutUZuxCYHhvPkLmYV7xfDgcBHM4dBvcOsYYDmnWwZhElvEM7Fq1ihlUnZVmppOuuUhy
	fG7cwOGP67ZOTw2XkwvdISzcJfT7s/fpW6g5y1n65clXjbF2d8Dg5m7cxTSllhXu6Nl+GJKbxed
	4VXhVNtuyGkGA4qCghUnuSybBi3gUE0zqb1PmGD9tYd+qqk3KaIQQj6qk/e0i9RnOf+v3n8zwBr
	b+qiHYVtLVE/gW9A==
X-Received: by 2002:a5d:5850:0:b0:435:dbe3:c6b1 with SMTP id ffacd0b85a97d-435f3a92b77mr17179529f8f.25.1770039439418;
        Mon, 02 Feb 2026 05:37:19 -0800 (PST)
Received: from vingu-cube ([2a01:e0a:f:6020:7cf3:628:f0e:cd4d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131ce93sm43065097f8f.24.2026.02.02.05.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 05:37:15 -0800 (PST)
Date: Mon, 2 Feb 2026 14:37:14 +0100
From: Vincent Guittot <vincent.guittot@linaro.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: ciprianmarian.costea@oss.nxp.com, s32@nxp.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: s32g: Fix ports parsing
Message-ID: <aYCoiulppKnvvOpp@vingu-cube>
References: <20260202130756.1421488-1-vincent.guittot@linaro.org>
 <scnf5gh3h5pwvnbe4bwtztdlgcpvvtse4fg64bto2jgyotfpwl@sle4k4ky3gtu>
 <CAKfTPtBZCLiq0E-a2QA5X_Bix2PxXiCyuCira1V_wBWZORUS6A@mail.gmail.com>
 <howlzhze3axqiguqvxslssc2tr7ocaa7l2obr4623n3piw5xee@ujnyo5bieril>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <howlzhze3axqiguqvxslssc2tr7ocaa7l2obr4623n3piw5xee@ujnyo5bieril>

Le lundi 02 févr. 2026 à 18:58:34 (+0530), Manivannan Sadhasivam a écrit :
> On Mon, Feb 02, 2026 at 02:23:52PM +0100, Vincent Guittot wrote:
> > On Mon, 2 Feb 2026 at 14:18, Manivannan Sadhasivam <mani@kernel.org> wrote:
> > >
> > > On Mon, Feb 02, 2026 at 02:07:56PM +0100, Vincent Guittot wrote:
> > > > No error return is missing after the loop resulting in removing the
> > > > ports from the list.
> > > >
> > > > Fixes: 5cbc7d3e316e ("PCI: s32g: Add NXP S32G PCIe controller driver (RC)")
> > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-nxp-s32g.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > > > index 47745749f75c..767f5a622441 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > > > @@ -285,6 +285,8 @@ static int s32g_pcie_parse_ports(struct device *dev, struct s32g_pcie *s32g_pp)
> > > >                       goto err_port;
> > > >       }
> > > >
> > > > +     return 0;
> > > > +
> > >
> > > Hmm. So the initial 'ret = -ENOENT' will become redundant and you'll return
> > > success even if there are no Root Ports in DT.
> > 
> > good point.
> > 
> > >
> > > You should do:
> > >
> > >         if (!of_get_available_child_count(dev->of_node))
> > >                 return -ENOENT;
> > 
> > or maybe
> > 
> > +       if (!ret)
> > +               return 0;
> > 
> 
> That'll work too. For some reason, I initially thought it would be ugly, but it
> doesn't :)

In fact this enables more changes and I end up with:

@@ -282,12 +282,12 @@ static int s32g_pcie_parse_ports(struct device *dev, struct s32g_pcie *s32g_pp)
 
 		ret = s32g_pcie_parse_port(s32g_pp, of_port);
 		if (ret)
-			goto err_port;
+			break;
 	}
 
-err_port:
-	list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
-		list_del(&port->list);
+	if (ret)
+		list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
+			list_del(&port->list);
 
 	return ret;
 }
-- 


> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
