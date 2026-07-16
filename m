Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2923D667F
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784240674; cv=none; b=lnw6NtQV7TTHa9XuOMcC6itGs7XQ+tYl1rT/BSohtQVbUIE3IF6sufroLfpqi32Blrcaw5lL44ppmXi5XQiQ0CGGgQMIVysqr+/8Fyy0YMkdRwuKWRV5hbp4p+lEJd9SnVdYgWABVy68Ac8muNZJs6QpGsNRSeBMel9nEwv8CUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784240674; c=relaxed/simple;
	bh=tY5kO68rCs5HDRAHbRnGR5V/lZbXU+QUuaEDKnD915Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4Zamnm9B96CVqvmasi0xK8p2iPl8Lv2Bg/9Fb5iXRFdzSRIslQ4mz2nGHMuGyrJ2imrpbYNjHzwLnUzu6ii+iZJHNMlNUij2n35plpu1MV3bCO2e+g5VWILmPyLiEDgEpi/gV6Di3EzxbIU4mnWdCrUuxw2G+9ijieZDX3jIVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iE2sVe85; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE2sVe85"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ccdb73f0e1so35849915ad.3
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 15:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784240672; x=1784845472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9PybPTeqqbJDW21nWTn74STz945nRwE+oCCkAETAhAs=;
        b=iE2sVe85QIWzuA7Bqz+2/1r6wdl36yZF/HPmv7gSAZLllO1TDW7Z5uRaYU0SLItRiJ
         icNnpOe78FCF3raiT6cY/wNy/bppJJuOVBZlomI/jCGT7qiKw9+HKZEzAITSHOY3bTzr
         G7LLCXa277HwHFogcTDYa1jw2qW01Ou7i1lQ5FY4z7Vf6hV/8sU0eyH/M6fsilNxhH3+
         dhNqcyqUxEoeQrYwKRp4U6khy3DiVuh29/5ZTM1mNN5tOw1YbG/Nj4kzfX1K8wQH9ogM
         RRnDchl/x/i5f9ftaPQ+xZzzRn5LJjHBNMRnKID4RYwGYXIKn86fTP6zMazRu4ri81Hp
         /I6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784240672; x=1784845472;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9PybPTeqqbJDW21nWTn74STz945nRwE+oCCkAETAhAs=;
        b=nMwJMUDHUJNLX7Zw8qMbjtynZpLcEkDdTTpPiAPxcVrSJQxYCe79s/WenVL2/UF0CR
         wFwYvEqR7twxDHO3SKHqcRrD/g462/kRyJYyA8R5NjMtHXIGV/xW1qJmiu7RrvbxRlkJ
         kRCNUJUb86ofdtr8V3E33ISWL7FLUcb0z2rbNviwqOU6k2zkkpPEDU5Nw1HxqHxmUEJH
         W6dXykNBHL0SaSgnSpBxxR3UpnoiGdPGbpX/NC4MQqgTRbGOiA12TDeMzlKCdF8yQjlM
         oIJ7nsufV+8+lMSTrW6F9VKx0l2DvgafFvTr02ErAw3oVsy7AnwYWC4LSpmv20b9oOjN
         fCaQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro04RsYI+uP4wLT3qMdZKFrNb0+h+cETkgZ9gIQyxClt6GQzuBlr+bBPEOXXCaO5Ba5YzdCTRTztz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKJ8pyqWOqcvNPqS05xt9CECagOU/hkMAT/29sViyN0GyTbxJa
	61BmvN7l24xDISs0BVIRxqWG/X7FbpIDtN/yLo4+XVuwHneEf9jHnwv7
X-Gm-Gg: AfdE7clO6Z9JbvNTeEa2v0Bky2A8OrG8d2fwum9rh7NmSY8cbyT953cJLLwL1xMXlvl
	dtdLdLQ3pMDSgdG3xQPntYu812l3QE8OZQP3uGb7KNJJBwTDRfdE7SlLFtkBUeDFjp2deEIQQo3
	nW2tueHU93MzTI47nmy24XspiZFSXZ8Q17q6Up2j+l2GMGYFkiYsKoF3/EZFcPXRHo2ijzj7+VO
	l2BiJR4mnUpjim/izoTJDv3uM06MH9mRfWidx/RFr4LjDKOy3iby7M53dM6r3Q2UGr/Wf3FYn45
	c1yYAA0Ew67ReKSXxN6hxQ7e0VpTufiR2sA1KnvG+nwHUvEVw+H7SIi1UaID6VsO5iMYzUv4Sys
	b2n95ffl8arSZfoByGsvQ5uHZOUzkzdwDlwEy5kPfgtRpvbIM7hvgng==
X-Received: by 2002:a17:903:3c46:b0:2ca:17a8:cfce with SMTP id d9443c01a7336-2cf2ec27781mr13004505ad.29.1784240672371;
        Thu, 16 Jul 2026 15:24:32 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4341a37sm12337420c88.12.2026.07.16.15.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 15:24:31 -0700 (PDT)
Date: Fri, 17 Jul 2026 06:23:42 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>, 
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yixun Lan <dlan@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "spacemit@lists.linux.dev" <spacemit@lists.linux.dev>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/2] wifi: rtw89: pci: enable 36-bit DMA on spacemit K3
Message-ID: <allZOmTRIvot39Gj@inochi.infowork>
References: <20260715-rtw89-spacemit-k3-v1-0-e577bc63706b@oss.tenstorrent.com>
 <20260715-rtw89-spacemit-k3-v1-2-e577bc63706b@oss.tenstorrent.com>
 <e7a43955e41c4dbdb864e89edc3d9fe6@realtek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7a43955e41c4dbdb864e89edc3d9fe6@realtek.com>

On Thu, Jul 16, 2026 at 09:22:17AM +0000, Ping-Ke Shih wrote:
> Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com> wrote:
> > The Spacemit K3 Pico ITX Board has a RTL8852BE pcie card behind a PCIe
> > root port, but the SoC doesn't have any 32 DMA addreseses which the
> > rtw89 seems to use by default. Enable 36 bit DMA ability that the driver
> > has when this particular root port is detected so that the driver can
> > probe on this SoC.
> > 
> > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> 
> This patch looks good to me:
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> But I wonder how this patchset goes via which tree. I'm happy to merge
> them into rtw tree and then wireless-next tree if people can ack
> patch 1/2.
> 
> 

These IDs are from my patchset.
https://lore.kernel.org/spacemit/20260709040027.958400-1-inochiama@gmail.com/

I think Anirudh can move this ID and add them to the pci_ids.h
directly, And I can adjust my patch to depend on this. It still
needs some improvement to be merged.

Regards,
Inochi


