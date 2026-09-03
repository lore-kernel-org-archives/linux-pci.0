Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33B82E0B71
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449537; cv=none; b=DJWu3linpSv2xbDAzhRjlqWblDmak7U8e+VFUD3yI1ZC6l9WiPITPYtk7NL17Feob1hL0yAOKN1HBFcXeNxKB1WUSeIyl2TO0y74Kmrars07tUDnPaNeLmc1aag/VTAniWJewVLSGijjI2tJKDtV45pmDClDpJvloikj5JvCYzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449537; c=relaxed/simple;
	bh=ExNl+FukFqy1rN7N2zPL9sZ0q1gZ5e7QZC7RycA/QTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1CUNN2QrEBZPQpM0Gitfnxrca1SN25KWbLnHByCWhrJD3f69+34639JjZ91W4eBsoyetvDS8CvFOsS4VvqLXAWRNeLRVNKlBAAl+KxzxgEy8xQoHBiECjISaKcbKaoPxuDHeImhDYfnX4U7fG1M+b/zLIJdAGIK4FV6yZ7utxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jzoa9xC6; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jzoa9xC6"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-398b3d66515so3198814a91.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 08:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788449535; x=1789054335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mtKAnkMlbAEzfViPsH8OxGe1C1IurvV/p7tdYhcgQzI=;
        b=Jzoa9xC6/1ol7MsAg9sLkKu2j4n2spDJ398Wi6ae0+QTSIxuSWDpKLcdS1mmGbT5+g
         9uka4BdJNEaMITttnt3YaD45tG60/EoZS2N4EM7H1Cdr1mb4ES9aYz2vFhAWugEqYxsN
         ZywYhd4fDPPuuheVUFB8stTTUSgXXnrpKGS4n6j9TZlyiGgEZYtNb02C6891PZt/jsHl
         G+XD+pWGELL291kS/9ixTQ12idRO3/JbCuarPzlta+oBTfJLCw9s6Tspf1L+pm/CrPaG
         E6SGXtNqWjrYwD5iHBh8CBimKLO40+1I3EI821YTiXZaaoIv+GmcvORJ3pp2gfbZLgM7
         zckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788449535; x=1789054335;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mtKAnkMlbAEzfViPsH8OxGe1C1IurvV/p7tdYhcgQzI=;
        b=O5D03R3ZXjUwQdbHwczbvB4IzinlcBFxr8ltxU6Fj5OdBLO+xPCF5XfgMRmMtdL1Mg
         oOWwhacN/0JthMWLS4Kx11ou5W2Hujgf0c+tuQov/VajXMOtRSnv9GE5aE2FzGlEA8c0
         T384iFwdOjQZg5BskkM0EAB/jl7sdnK2ddD3f29a7u6KQeYGsmqaI5Ibfu1JmZ+BZUH2
         iube5FV0UKJ5Pl/IFCmEqlloft/QDfCfAPz7YtTKJOy15B+lI6yl0QDL71EXlyny3NCQ
         1Pt/6LQg7Fl10eCC95IwkrOvozb+NzN3EYlkCRCj9X5BGmwvUR0asAMEHCT1c2WpBdcE
         dogg==
X-Forwarded-Encrypted: i=1; AKwUvBycoWTZ9GtnbiwXwYnNIVHT/XpEJwrw1co6vXZCSD6rfYTsWgT2IX65d8hjdRsM2u62YVdGnHB4GHQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kQkcB3iOxDDFVkYX2dCsSKVGWb6n8IJLCKkGutcTZcBzELP+6c
	ubDgn4sTQo+gZVZvVXYEHB2G2AmhrSzeVeXYSilQu3WWjY89Pl0ZDado
X-Gm-Gg: AYBFou2ggKtCIqKqyPymeSh2hTv5jdTlEneNHPZLvJFFCXmjTl8M1MUvyfQuHGcegJ4
	xWudlOvzuagrpOPM/+bwnSTrUIW2aeM125vJ8bBNrtXBrHVNZMnBTU5jDu3R85Ly2VyBoVtd4WL
	xutPuCFqCPt+657cunk8tXG67ESE+bluIsW3yykDpiFz6e4CF4OH9cEUee7Ot1C3405zlxCWCtH
	9mK12sAW3MfkdH/LdGeXJug/51Or/2cIGQZcKJd4Apr75VyHvP3Mv/Xx8FajSAZy3Rjhu6C9JUb
	mUTpDyfDOVSQUFuOxgVSWNue0qDG/ItkiDMeEeYQJBSfhgbRWsj+MViEVEAp/BZ3EnTXXPTtHZ2
	hko5F/1znbOz4kUSjb6P4uUHEYeXBGKB9Mv1eQsVigl0eQ2Px2TEBPcERURUMbNoSc7UWjdQbYR
	CbkvQtTW1hdTsCiragtgmH9BJOVZ8gj3Q8xjMu39odVE+c4bXnCWiM+Rmz68rVaow8Zs1FbiUCV
	t4oogYJT5uWASgeiQ==
X-Received: by 2002:a17:90b:17c3:b0:398:dcef:c040 with SMTP id 98e67ed59e1d1-39aee1d6bf3mr17931236a91.19.1788449534662;
        Thu, 03 Sep 2026 08:32:14 -0700 (PDT)
Received: from kernel ([45.251.35.126])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435648esm355669c88.5.2026.09.03.08.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:32:14 -0700 (PDT)
Date: Thu, 3 Sep 2026 21:02:08 +0530
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: Alex Williamson <alex@shazbot.org>
Cc: bhelgaas@google.com, skhan@linuxfoundation.org, jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: quirks: Fix out-of-bounds MMIO read in
 nvme_disable_and_flr()
Message-ID: <apmS-K35HCY0usrZ@kernel>
References: <20260903040049.5460-1-raizudeen.kerneldev@gmail.com>
 <20260903083443.400dfdc9@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903083443.400dfdc9@shazbot.org>

On Thu, Sep 03, 2026 at 08:34:43AM -0600, Alex Williamson wrote:
> On Thu,  3 Sep 2026 09:30:49 +0530
> Mohamad Raizudeen <raizudeen.kerneldev@gmail.com> wrote:
> 
> > In nvme_disable_and_flr(), the PCI bar is mapped using
> > NVME_REG_CC + sizeof(cfg) which is (0x14 + 4 = 0x18 bytes)
> > 
> > However, the function later reads the controller status from
> > NVME_REG_CSTS - offset 0x1C, which is outside the mapped 0x18 byte
> > boundary. Reading past the mapped MMIO region is undefined behavior and
> > can return invalid data.
> 
> "Undefined behavior" still seems an overstatement.  The code violates
> the API contract, it should be fixed, but it's effectively harmless
> afaict.
>  
> > Fix this by increasing the mapping size to include NVME_REG_CSTS.
> > 
> > Fixes: ffb0863426eb9 ("PCI: Disable Samsung SM961/PM961 NVMe before
> > FLR") Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> > ---
> > Changes in v2:
> > - Changed the commit message to avoid overstating the risk as pointed
> >   out by Alex Williamson, to be more accurate about the actual
> > behavior.
> > 
> >  drivers/pci/quirks.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index b09f27f7846f..ed03892cc960 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4090,7 +4090,7 @@ static int nvme_disable_and_flr(struct pci_dev
> > *dev, bool probe) if (probe)
> >  		return 0;
> >  
> > -	bar = pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
> > +	bar = pci_iomap(dev, 0, NVME_REG_CSTS + sizeof(cfg));
> >  	if (!bar)
> >  		return -ENOTTY;
> >  
> 
> The cfg variable is no longer related to the mapping size now, it
> happens to be the same size, but this should be sizeof(u32) to avoid
> confusion.  Thanks,
> 
> Alex

Hi Alex,

I will make that change and update the commit message for v3.

Thanks,
Mohamad Raizudeen
