Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B15B368293
	for <linux-pci@vger.kernel.org>; Tue,  3 Feb 2026 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770101797; cv=pass; b=W7JYs04i6zTq8iKSCMKWG27WpnXqffk2WTmPGOD/P9ehe3pKwrvPTOoYuICT6zd4gtPAA1ahjcjofMnlpwiltJ7Yp9vKd554nYR9/TWrQBY2uUv4jc7Cy6nTZMp2HjlwP52LrXMHYZSUJl2xTLqAvk7rRg9nMI40gm+/5xsNeFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770101797; c=relaxed/simple;
	bh=P/Ggq90pDvb5xr5Ttkl63HqWY+uM9O4Zm1z7/pblo90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8bTwL0XA2Ihv18QggCkltQkZu9rjndsTym3NBoe5eupTVdhs36wxZFqMxusEkvoVXDqkDaHDIE6/Wk+RciuXtp3JTevSUdg9AJjKyrTBT5/Laa0jaHAI4nit2qNtfQJypnipcwKUtlQf8j47ib0pRJU8Xd/7s2OV3pDiYb1/W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hReoepS8; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hReoepS8"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8871718b05so840312166b.2
        for <linux-pci@vger.kernel.org>; Mon, 02 Feb 2026 22:56:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770101794; cv=none;
        d=google.com; s=arc-20240605;
        b=J8u1BAQ2tIudJ4rHDNPFgEDlNsvCjrH8x4vjhUb+QYUoflVdTBUqlMEjuL9JRjuvEm
         dwDh5aXvsZNJdQhPMEEXLKTce0ViEibdF+zeCNTPORy20iRc30koMT3Xl/BjcDcXQ41P
         Ql+47x+jluxgMtj775pcg+v4FOqyMMlumLNUVYttipNKZ6nCqSJj46MuC8X/TXevUBz+
         55CxGCZtT4NNTCfr6srccNUmwiQkUl7y3FsETuHZquS0R6nZPGcBSPrA+mXctzla8LTf
         0D1d6Tkj59zZRIYrm+EE5OEX8k1Jn3WRRMSJZbhhuJepvDjnrhhA4rNLpuRxrOvkSupe
         K00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hPfG7IVpjEneMOzN4kNdadNHZSe9In0bxUCOtJ3itiY=;
        fh=t73QAtORJacPLrxzAs3OLjo7Ngenm3MxreB3ABes5P8=;
        b=gXbJiNU8zSWVDblWixqlH5U1jHc6OGJ3wZjrKmJ0rhrUBmo1EREULJT58FgWKsVnCD
         YQbl4f3loPpm8787R7RnNe6OMyGaHO8vRIC+R/lezZHIMRMJjV7CgVuwM+KpSTj7nItu
         3l+g5krm1Aq2H2xqleeSt8yivSY0YZ/jyGROEWnYy/mR4kBIqBLMLA0Md3q5p8/lMNAM
         rIa3kMpfWtmnz2yPWh1vBISKxUCBu1aSVDD7x31ZTD4/RsnWw4HnTNPLJZ+PKC8sBSej
         cAteuZ+L8kKN/+ermQ8gsx7mwCO0Xhi+wPMenqk/lAtdj4wNEW1cBpgzVFoKBzpaXTmg
         RvFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770101794; x=1770706594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hPfG7IVpjEneMOzN4kNdadNHZSe9In0bxUCOtJ3itiY=;
        b=hReoepS8g4jIjIWno3x73XY0BMnt3ubf5vF+0zSnmFnLlLNf3hGoghSVDYeSxY5SGH
         AzcfL0LIXLRpfvc+MssfBb0fbEh6Y3nAUooYrtoMyMldnjHC85QjS8zR0otujoaiNGCV
         1jqsFJObsNNhUbx+7Xb1QRz0G8LP2m1y1vztpqase2sWxoWicSFK8wtUWnO0b+UwO/yP
         cKy5/d8X5krrv0rk2RRbgbYijEYWySgvRUkluae1sCrfT6qY9SIR9xcbM7B3Mau8/r44
         PMVsJnZ33ijVH1+6++l0/TpVXbKxk66Yg3d6VF+gB7dZZJGHTNQ3XIkdnpIEqA1CRJUp
         vuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770101794; x=1770706594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPfG7IVpjEneMOzN4kNdadNHZSe9In0bxUCOtJ3itiY=;
        b=Mv1LtFrwOPmRk03KRIplYF7bc/rqKTv9p4ak3d6SpctbccMzw3LmtIpsz1jflp4Ma2
         UqTaMfkEFXOBpGZDEKHtytB4Hw8y458CHvrwPKrv/JSQM0L5PO9HbVgO8V/Vv5KWFtPe
         +ewi2oU/D9WxBYv9SPmV8L34sG5qmNfOVpDVB3egEw9pX+Y9uZWXXphm/7Kf/6RxMDD4
         QS3m5VWsn2ArXlYAOjQLSN/6K4pPo9O34NB7tysW29UcHI1RMArvc0KIcegrIfL9WWf1
         S1zMcxg/CvQseqXukC9JEHJ+xKfe+EZA32P6GNEfLaA+8KVWjQf2mjQnhDn1igl3fIko
         fzyg==
X-Forwarded-Encrypted: i=1; AJvYcCUqvKSD4c6+8ybpBCPkhw77u12rjvG0GvT6A0JMuoKLeDxuH2bE0g25rXUD4eE+/wsrF/fmHRwyXV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwrSWXC+MqEYVfxD2R8+buhmAHflQKSVUJb0745os6df1kfKGg
	M9FqMJf42O33YpkebBIT2KBEPlphjTDFQd4sPcAgBn6aAWmO8Xds76in3YFMZkGCjgsdzP/Ymv+
	zCFbq2EsFAo0tuaULUL4WOUd6XmV0sbG1ssohqZGLnQ==
X-Gm-Gg: AZuq6aLh+CkyvYPYzwGo3lIDEUk6FW9zY96cFNMrZBZkNgq2Z4ZC0of6xQZu0TG3run
	lL9CvROVoLNePodj1gizKyQAxmcncgBo8L45lZIc1jpl369p8Risih0IkQpN/miKBVBPMkejTFz
	4GWGzwYTyQwwheYR2av4H3AflXOPXHKahjiPVi0r2DrNvPkCdaNN+2Y5L6vHg1PYjG8NDk45bkD
	DlvALFlEqy2WxJnaDlXk6JED04vsCDX29b/+gBh+nPrncFVf51e7z7PlRBb1uwK9ewDf6qmwnlm
	Y3At9BLn0LXCMgiUqcyHVw==
X-Received: by 2002:a17:907:94d0:b0:b87:892:f43b with SMTP id
 a640c23a62f3a-b8dff68456emr931355166b.42.1770101794402; Mon, 02 Feb 2026
 22:56:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202151050.1446165-1-vincent.guittot@linaro.org>
 <aYDiFpGT5hEDDFhV@lizhi-Precision-Tower-5810> <CAKfTPtDjad7aowTQ3UJPi5Qqgzf3q8J=kASa-t3YM4zfjUv3-w@mail.gmail.com>
 <aYD+/iTSF8ikTLIY@lizhi-Precision-Tower-5810>
In-Reply-To: <aYD+/iTSF8ikTLIY@lizhi-Precision-Tower-5810>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 3 Feb 2026 07:56:23 +0100
X-Gm-Features: AZwV_Qg5Kwi9KHew4ku1K5fA0TmRsp-hVv0jTdHdOIruFI5le9h55MG348VMg14
Message-ID: <CAKfTPtDcKw0qc3o70AT9_n2omejNrh9fnkwS5NWKQpqjaCnBdg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: s32g: Fix ports parsing
To: Frank Li <Frank.li@nxp.com>
Cc: ciprianmarian.costea@oss.nxp.com, s32@nxp.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Feb 2026 at 20:46, Frank Li <Frank.li@nxp.com> wrote:
>
> On Mon, Feb 02, 2026 at 08:23:30PM +0100, Vincent Guittot wrote:
> > On Mon, 2 Feb 2026 at 18:42, Frank Li <Frank.li@nxp.com> wrote:
> > >
> > > On Mon, Feb 02, 2026 at 04:10:50PM +0100, Vincent Guittot wrote:
> > > > No error return is missing after the loop resulting in removing the
> > > > ports from the list.
> > > >
> > > > Fixes: 5cbc7d3e316e ("PCI: s32g: Add NXP S32G PCIe controller driver (RC)")
> > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > ---
> > > >
> > > > Change since v1:
> > > > - handle correctly the case when there is no child port
> > > >
> > > >  drivers/pci/controller/dwc/pcie-nxp-s32g.c | 8 ++++----
> > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > > > index 47745749f75c..b3ec38099fa3 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > > > @@ -282,12 +282,12 @@ static int s32g_pcie_parse_ports(struct device *dev, struct s32g_pcie *s32g_pp)
> > > >
> > > >               ret = s32g_pcie_parse_port(s32g_pp, of_port);
> > > >               if (ret)
> > > > -                     goto err_port;
> > > > +                     break;
> > > >       }
> > > >
> > > > -err_port:
> > > > -     list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
> > > > -             list_del(&port->list);
> > >
> > > break and goto is logical equal here. So only need below if (ret).
> >
> > Yes it's similar that why I removed it, the goto becomes useless and
> > make code less readable
>
> But don't suggest change in this fixes patch, which should focus on the
> key part.

It's not a suggested change, it's the fix. err_port is now wrong
because it's the path for all cases.

>
> Frank
>
> >
> > >
> > > Frank
> > >
> > > > +     if (ret)
> > > > +             list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
> > > > +                     list_del(&port->list);
> > > >
> > > >       return ret;
> > > >  }
> > > > --
> > > > 2.43.0
> > > >
