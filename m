Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41FE337BBD
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264345; cv=none; b=UwLwmzdrRcKI+iRBeM4tSDLXHYFG5W49FYS9eMThNgpVWKOs/yezCCgMrd9jyLjp2Ncbv/R6ZiNCoKeQ94Zctzv/aaa7vDPtZoHruNaed0R5aqFgnJYXw9Ftg9pHECMcoYIVVLqvY2RVGcdUX2lAsccDKqi+3di1r/J/SDwtSSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264345; c=relaxed/simple;
	bh=SX18arNH/qTxpgMw9xFDkGTsTcvB1jVfOazjLslA7NI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=tCC4cVVrxPbqwIL6QAuzjAR8aohc+rK668aF+RmtqW/qPcRQgUVqM/RH3X6UsbQr/HjzaUxjY7DuS2P7S27OtLhD6RYg3+9HIUiSIJAJAb9l7eMnOeviAHVz6iX63TjP2z+nAeMHWupPmm3kxzqTdQHONfwgx7MOYmSXJtpXFCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=K9NWIVNs; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="K9NWIVNs"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9159f631656so107258685a.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 04:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781264343; x=1781869143; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVXPrAHp/BWzZQhw02rB+3vghjeNf6PQdvQ4HyaXKb8=;
        b=K9NWIVNsU2wDd1kGPB8EJ6azgu8KKccTAwsPJ6QXvgV+u/n3c2koBVEy9I5QR/Svqs
         v7o9vpCSG8G1ehLW8WzJUpmT6iTAkzTPjotzbXnDE9bG1rZKwH2UcaeLAQU/VbC2zZsJ
         sd3sFeNeUroyDrJZeniejFcdd32drVxzWgHDqfg2wl5m1+1vhxQuehAb+P9WJbK8zfUY
         v51sPt/mrOEyiazj2Y0DViDD4yuV0WFqaJqnWl8tZDas3dt3a6b5duVcfMExp8yf7N25
         2TmFxQTZtlhqyLmTNuzvFvmtd3bS/Vxw+QXykLt0QV4ohUmgivMgiZn7Ks0L9JayEccT
         Splg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781264343; x=1781869143;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jVXPrAHp/BWzZQhw02rB+3vghjeNf6PQdvQ4HyaXKb8=;
        b=DQVE26YZ9n1Qh2/6RZ485l6Xh592H4EQzw/J6ZL/WtdrkNKcYNObhVQctA3JN4sEl0
         cihFJF6POu3sTm2S3H21jiPnPAjkcAF/N3Z4X1xJhevjfdQgBOMuLNjAMgL4PtDyDyGq
         IrlcR4ngiXot8JN+DLZNtgw4uPeJrnWDTmk+iUskU7IJj58BlT8CNuQBgiFOTS7eEh3g
         zkSgxNBOt+53pu33aUTlEIsFZnlWxSMx9fCfTj3+2H2NCfIVXVqrNceuMoD+k9ZhEQXD
         CyR6elX6iEflUHl0XYmt3LlUaXhohhSUkmvVis3zTrRZMgfkBAKpAO9GTrE6WFVl+P6E
         j4rw==
X-Forwarded-Encrypted: i=1; AFNElJ/7ATDJXtxBNDLmVq3poOY0ZaVpJvIEjfTN6v8ecFtFE2mbGIYs/aGAunFXSqWmLoNNjrL3u6ECjFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ZkOJAw3VV6ZQPJreLFL5ktSypssOmcPSkZHsvuaqd6PUGsDg
	ERRDE787EYbFzuaCnuGYMfIQzufKzC5uvVVIo7JzrpCyt1CuaA8rnnzUPXQSyjEaVCs=
X-Gm-Gg: Acq92OE6TKUo66OSSRbIbRvlz0I1qKonVq7gH9bKGCn8WlabOqKK3S8zW+rdE7NkVJt
	FgFVRm987RpvD0n9FyDNgwgWPoatFJ9rb+ZdSpcycGLgf3eCRNLyNg/hxuyIAR/HM4KRrdaFx0I
	hbBLzey7nXLthiE5rEQkIJzrRKN1FkiJNpW3jr5Gn1IVVL+Qt2ReLTibD4fqGpYqaQ4Blwx0Vp7
	53KtSQ16EWthQp3yWduMzeLbUP9wuUzT7RY2XmtsImjNb8Ms8ZV/ubsK1G1WzomIjpahzm9+0vK
	VbZIX7jVZX+GQYWTaDVmfUHQDumg44p8tmI0L9xYcY5BjEr1+sQAswFoMeW/j4PcpENovv4HVZK
	xBWdonOOf/xbY93LoJXA9ig+AgpvIgdSRS7SxB17eUR5HeeUoGtBfoE25qQAYzzirFiYdQEoXGS
	mfzTEZ5b86DGcVa0q3LpeltL0As3nDaKrUb6gn2djteZ30OOdSz2SHdxD1oxzOhWm+BITn31I=
X-Received: by 2002:a05:620a:7e2:b0:915:9931:3a3e with SMTP id af79cd13be357-91619f0170dmr269313085a.27.1781264342749;
        Fri, 12 Jun 2026 04:39:02 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a073548sm182029585a.46.2026.06.12.04.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 04:39:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 02/12] PCI: liveupdate: Track outgoing preserved PCI
 devices
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pranjal Shrivastava <praan@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260522202410.3104264-3-dmatlack@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-3-dmatlack@google.com>
Date: Fri, 12 Jun 2026 11:38:56 +0000
Message-Id: <178126433616.1046400.532221910811070690.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=SX18arNH/qTxpgMw9xFDkGTsTcvB1jVfOazjLslA7NI=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqK+/U8DWh12WkUIvLfnzgjF1Th+7JSF+r0l0bC
 ujbcT2VfT+JAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCaivv1AAKCRC7dyhM23N6
 3vNZD/0XZYuESCSVn19lFpaRZQiMEVxnc34vt0lwHhNqw9psTA8JmMZy5/0xcACkCF6DDLvnBIb
 rPj7XNZFS2EWttEzuKEWmy1wSAzAN+xBV8sv3ggddpviYBAOEYw2v2gNMD2W0nkZvmJxMEYROTz
 bd4Mk82xVHxraSEw4zTpmZiYjjTQXXWvUdUothtsU70yKAR9q7dlxiZHKm8xNM8hKggyyM09vZ6
 AjZN6fA8YA8oHuHgoc4Df3aeZLh91hm9lCKoC3R0kISiHmo96sILH7Pezp+wCiIJNib4pOK5Nwt
 Tm+wJRfpBQeRJzpD4M9wva96f+p9RJUfjfsy4L9CLjgD8KqF1dCLwjlgsh0KGjutoOOlUxHFWMs
 9wd1nVjmbaTJuk4JJF0s9e+17XKlD98vGhPSYUwaZXSXC3KRhxU9tZkUpBkPNiVKzWEBcVZCcQh
 hFVrmlTqixTLle2wMo9MpJIngoeniVvSZpmvnTUXaBGvP4pKuF/jDQTK16DI0vEe9WA6tIBqiK4
 6ZlYtNJipb/KJg7a9YHxB1jSCaO2lSsBPzs7pzkUruWpddbrUjeCGn27IflPmg5p3xf8yv6AWZ8
 R7zHIuQkdX1emMkBhhYohsL03LMG+Xk5QwOCWbAAUqTUXNyMwhtGdfvUgn8ntjx2PLYs02/yNJG
 Pf1CsA12jXbPL8g==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On Fri, 22 May 2026 20:24:00 +0000, David Matlack <dmatlack@google.com> wrote:
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 737e7b9366db..065d5af822f7 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -115,6 +150,138 @@ static struct liveupdate_flb pci_liveupdate_flb = {
> [ ... skip 59 lines ... ]
> +		dev_ser->bdf = pci_dev_id(dev);
> +		dev_ser->refcount = 1;
> +
> +		dev->liveupdate.outgoing = dev_ser;
> +		return 0;
> +	}

This loop is compatible with KHO block iterators, as mentioned in the 
previous email. It should be straightforward to convert to them.

>
> diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> index 6ebcf817fff4..85def616703d 100644
> --- a/include/linux/kho/abi/pci.h
> +++ b/include/linux/kho/abi/pci.h
> @@ -23,19 +23,22 @@
> [ ... skip 16 lines ... ]
>   */
>  struct pci_dev_ser {
>  	u32 domain;
>  	u16 bdf;
> -	u16 padding;
> +	u16 refcount;

Just add refcount to the previous patch, to reduce changes to your own 
code.

Otherwise looks good

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>
