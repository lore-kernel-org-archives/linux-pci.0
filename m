Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF312367D3
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 01:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772500216; cv=none; b=Ztz4712ppUMCaqN4HJ80b/inz/K5dP1/WxixwB6955vgh+ua48enMA+HHziXUIKn7N/0w7NTKBBrRVXveran7XljXV6MYsmgyGiOFBDymBhGEO/QN+BmDtBAPlQqBC/gOwldBhMBJZlDtfvN53ic9saY2Q/3gX+izU9iElswG7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772500216; c=relaxed/simple;
	bh=XPROp4od7FxcSF90aN2OMpLPQ/4wHzFdEsCUYE7t4ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxKEk96g3oI9czc2uyVgx5UuwGGeVLtynzm3pVEvBxulY55N7ksYdomQZIu6EXIS0zvW7j1Ri64H0WAk0bhsOTGcdemAAhw3eZxl8kN4Wxxn6KW/eb51BeAmsMEiDBSsqB5+gyuzoBtA1EC9NwhvVvd+K/C6la+Wk+I34VEwDqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rm96cBcV; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rm96cBcV"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c70bb8ffb24so1836929a12.1
        for <linux-pci@vger.kernel.org>; Mon, 02 Mar 2026 17:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772500214; x=1773105014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oa3UG2UWazJW8uFAu8JRzxmW0Br+5DlOSKMctnAP3eE=;
        b=Rm96cBcVp5WrhE+dfc1OTlmCTirKaZiWq0yeWrh2TB3n7JfCKk6nIQQqYCEPV7qdZq
         qeDuLNe+ytcCmiqhCXWk4m58MGZaNtg1+GOYV5ig7oyp+2cr19dIsUaRm41/1Iyzp0GG
         YAvgE+m74hgi5bgTyJx3l3vkTcXuSOYkQsozH7WG5HR1kBSoNl8SU8q4XBK15p1FH4wb
         RtpT9ITPFOUFp8kjjdtPLx76LTmsACjVTtGSlPdDECsDNOGZvh8I8TK+xmOvJAal9i2r
         QcxG3xrUd73KeS2iq3hOTfEGG82UWR1tKZWjiZMkY7e3W9F/cDbpQumT0dQtqUcfGPsc
         N/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772500214; x=1773105014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oa3UG2UWazJW8uFAu8JRzxmW0Br+5DlOSKMctnAP3eE=;
        b=SSk120uv6rKFJm3ILUt0o3qPUWWfY2AjykLWaIdTIv9jSUSog9t0mkUe/T4XiPZKKA
         HqTAb5Uhx/8bTf/mlYSYXf4ZpPtU5hai2koWBZoGJWkjt8r4Gsq8VLYWmtB/mWg0h4+C
         avx9E/na6Evk9ZxAcIsQ81xIQp1wgi7Yiu+XUdA+z8iatrawpMoHCM1S372gRpBwJtsj
         gVjlBSDWc20ND2hmKlpGAHhJbJGd9AMz9owIydZjAzfbvAWIMmjhHs/W8qqcPeu2Uqu7
         ToXC2VOI3kl95VBeJ1dmm670Yw5w1pyWieFnr26fa2LT1PCdBDiT4BjoLC9JP1zAvqqY
         yfcg==
X-Gm-Message-State: AOJu0YxEKf7s0uE1fUXVfPXuBRd8SxOQNUAij+21h0+VSz914+D6l7Hj
	SdRIp+KR0QLv1NF6ezgfH3RbSC+CojNeYijQrKmwxMjph9DA3dwwdlBI
X-Gm-Gg: ATEYQzwJzQxUnGP5oHK9rbOzEXWEtY10jXllLgplpPUip8o4jhiFpYL0Dpvef2SMSl2
	h0ZLzq8SxwIbz5zdQHA9muJ3ZIgL15gz1jgA4ErqxQkMVZVjJ3Xe7Ik5EP2Q+ytz3JLNd7a6pGJ
	A3PAVWamrKLO5xrCMFuUpGvIOl0IV1ccMEu+w2UNMyPGU2eh5+6/3z3rBiiuNtH8QUNi6kxpbXg
	q5cDHhrpufRpVPMiKVFDhGgOBD5lP5eFxk/khmvk/Qs92BlgqbaJYDpF86YMM8KREVssOFgA+uR
	mv4jDY78NYmrblGuPWSQ5Rf9D1eTsUFSD6dbOEUBDvkt1g2B+FZbVRkX7ibjKHdGx98u2yPlemG
	fUywZEfwZZ7dL9XYEHLNrBbchZExAUutv9Rk7z36+XIVXeY938SW6W5XZanTr45mya2N8tJr9V6
	erFDGqDmEmb126+lguEfC3iw==
X-Received: by 2002:a17:903:1aad:b0:2aa:ecec:a43d with SMTP id d9443c01a7336-2ae2e401f52mr129790895ad.21.1772500214456;
        Mon, 02 Mar 2026 17:10:14 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fa65sm151455745ad.58.2026.03.02.17.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 17:10:14 -0800 (PST)
Date: Tue, 3 Mar 2026 09:09:46 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Yao Zi <me@ziyao.cc>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Hans Zhang <18255117159@163.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Manikandan K Pillai <mpillai@cadence.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Inochi Amaoto <inochiama@gmail.com>, Han Gao <rabenda.cn@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe
 Root Ports
Message-ID: <aaY0t2BRcABOhdVn@inochi.infowork>
References: <20260227181925.52475-1-me@ziyao.cc>
 <20260227181925.52475-3-me@ziyao.cc>
 <aaHhTNEhY4ytMvAw@pie>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaHhTNEhY4ytMvAw@pie>

On Fri, Feb 27, 2026 at 06:24:12PM +0000, Yao Zi wrote:
> On Fri, Feb 27, 2026 at 06:19:25PM +0000, Yao Zi wrote:
> > Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
> > states for devicetree platforms") force enable ASPM on all device tree
> > platform, the SG2042 root port breaks as it advertises L0s and L1
> > capabilities without supporting it.
> > 
> > Provide a platform-specific initialization hook to override the L0s and
> > L1 support advertised in LNKCAP register of SG2042 Root Ports, so it
> > doesn't try to enable those states.
> > 
> > Fixes: 4e27aca4881a ("riscv: sophgo: dts: add PCIe controllers for SG2042")
> > Co-authored-by: Inochi Amaoto <inochiama@gmail.com>
> 
> Oops, this should be Co-developed-by instead of Co-authored-by, sorry
> for the silly mistake...
> 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> 
> Regards,
> Yao Zi

Thanks, and this patch is LGTM.

With the tag fixed:

Reviewed-by: Inochi Amaoto <inochiama@gmail.com>

Regards,
Inochi
