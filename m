Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B909C3164A9
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783366287; cv=pass; b=ow0ULmHnUCfd+EW5Sx0fk6o5m9tJFqSpDWUVcLg34zii+Qz38gPKnLs5+a+CXSekDG60TRQzZBmHO5AYEWBUWBRQDPYVX5lrSiNE60N+bJ3u5nmOls+qpxmCapASyGkWfYDjZyJHHDfg/OophAdTY6UGxthmBTlHKn3uY8KT6Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783366287; c=relaxed/simple;
	bh=ZqWVpOj6fMq4bOzwenk+eFayci0sBP705y2M1gKjVSc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnbptAHLY6IfA3osImIVmQpTwtlutZNAC+YWk3//D/5AbbyMc/uuxYzyvrNYcqJcJ0FkCJ8ANxSHb8UjJd7lkiOYNsvQ7zHse8gV10E+MPcZtHMZY51NkFXD99RiZnaT47IBOzAciI100wq5PvhgQ9x7sGiTEJ5zhWuc9p9m79k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HgpMkLyQ; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HgpMkLyQ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cace7da66eso31953255ad.0
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 12:31:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783366284; cv=none;
        d=google.com; s=arc-20260327;
        b=iDe5pDHIXet/J/XbeIqCAU0aG5X9zogvwQ+iCYyUTdlOhX7IpbPAMia7XMaZgj/Pv5
         s1ryEtVvf612l7ffH8ox5y7iLsIBHszxiuFkIIj4nHyJj9wkER8GHg+dv7kIZHa1pHqU
         nAI91ynjrb5L2NJV4Z94JKj5kWiv6FXP8tET1V5a2NSFIW7CRi3yiZLwptt42VU38Rrr
         30ZLVCdA69lMBWm40r7Mk2gyYslFY4NZVBrJM2nf21kHXOTpe3A8ZJ3/x32tUMR0cEUk
         mskcrG7K8oj+nkMxBkQ+xwo6wqpWB7SAjxb8sBEqTiiMNl+Ps4Ex5rkzrTKRBWMfZUtn
         n8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=5sBbN6AQhjUw4Kzr8zci20KvZDn+C3bKKaEIfQEAul4=;
        fh=VI43HhwvxqQA3+E6t0SG3pKM/NWy8UqLiUef4J5TiCc=;
        b=ITf3OvFn91ehxxmpJQFc8a3duj8XosgQQ8CjHbs5I850ZTHeF5c0hFwVh/ZC44wfrO
         I4J3IUgIqVi8gCAgOE4w1IZCOguelOgXDQL7U7Dgb286KY0Jho3tvdM+JcaEJ4oLkz13
         ANzAMIIvUVHxm3RGfISWxsd6SNAd9xzXgG7wkh6nRyG2YS4EE7dUbXgNoxBhJxHyxkJd
         4yd2gf275XrST5JYxWr/27nqHvX784RXUwa5IRiRgCLjotCMgtATFU+zg6P4jryQt2hu
         A/VOmTcjLeMQfRVc+AIRvtGD91hcaQsKgXGBuCrPVXVrV9khfqIYJUc76ysMvfQLy8Qh
         91LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783366284; x=1783971084; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5sBbN6AQhjUw4Kzr8zci20KvZDn+C3bKKaEIfQEAul4=;
        b=HgpMkLyQAbE7kiJuX4f6XG1jTKmgl19svI3zJrxw8juY5eUe3UqNSc9v6DCrpqymwK
         NYlqycL4tEDwLieSg0lvkjx7W3eUWYUEUvBmRWH2CYz+IaWFQAK4HIg6Xdjjosk/c43Z
         7YurBFzAF/pP4hIildyYQ+5o9RgeImGuW8GhSE84Yben2mJxS2YfdV3hrettSEjZtKlH
         8lYzaJgYxtVJ54D6EiheLqcxADgOGMyrL8v+/adVp1dtADSzqqRU4ZRsFw2wzKwB2d5+
         gveZlqJFeTCXIsyGMItRjyW++fLwtd2q4CdHCh7r+1iM5XI39thkjAj18wt7JDCGFZ3N
         cfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783366284; x=1783971084;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5sBbN6AQhjUw4Kzr8zci20KvZDn+C3bKKaEIfQEAul4=;
        b=gES2YOg8eqqHbS44daHNZlKHicosTl4rX012v3k+HeDnTD1KkD2KOAQtiEkKphGOce
         vLgAxgLbbVn/CsBXJb61K7Wt2VmaowEdmPhzkbxnej7FUPY/pG0lrH8iAMbItuLgRjfg
         36tp/5XC/Z9ivMwVIGVoGQz0kuxxF9bl5Cc46BLLHjHdXDl3ZZJO4gpw6vTk+zkVtXsn
         LdgzbBeD4PKneU2dNO/aOOFg50YmZTVZSmx68l+CiEDlppe7/FaFGV1i3ZoSUODSh/YM
         Jcg2ouDfMBF3Oh+IrCFhlor1iwNQHqrVCaHsbrM9Y9i4BhBSKuQmPohchWpKsQUa1H2g
         zCMQ==
X-Forwarded-Encrypted: i=1; AHgh+RpUGJC0bvtMOBbWTpw/4DYBpnVhwXWGHXdiz8OATdK0jfCXfIoog78VwBwuGfwmMqRyBRXtLDFnsDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfzcxbXKRSqDeo0covN3zdhx6G1FkhRL2Ju20yer+90RNvBcn/
	bQ2kumcFpyJND9adVu+bULuqCVU+Bask8dQZEQ8Gvs01zpsfXZoaH8ufywQIXXkQH1WKZsgXBwc
	0oF8B8hj0f2jWhefdRaPLHHyoQAYQUPoEH7uef/pY
X-Gm-Gg: AfdE7cmzlDUkq9qReqdmP3D/FNH7bU871nO7NiVS3BijaoBvcwU99+Tp7sG5928nlKm
	B9UAtdSLCacKEYHegAuENFhYgSjJ/e8Wr7iBk3ftBgj9BNRTiiJNgAKVVz+hoHNK1JFE03rBPoo
	kPcSSJYKhJGwOSxtWVvoEui9S3NunLn4FjL9NkU6iP+lRsLww8KRfTT+HO9v7N51wxjULUcxhyx
	rPdT5/n7FPPwlU5DtzTHjMUIMIfqP1tNgsZmJXB7sZ2dcOg4KlUXmhvsZJNty8upaJGAIzhpVbP
	ptKfbm/eMPOoZqv6xi71LnRZSMvW4AOSBvJiHy2OBHKGd4WXPiRxVl/H4/A=
X-Received: by 2002:a17:902:eccd:b0:2ca:a284:a136 with SMTP id
 d9443c01a7336-2ccbf188823mr18530635ad.42.1783366283312; Mon, 06 Jul 2026
 12:31:23 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 12:31:22 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 12:31:22 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260327160132.2946114-27-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com> <20260327160132.2946114-27-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 Jul 2026 12:31:22 -0700
X-Gm-Features: AVVi8Cc5ZxA9qF5433WWwdnaZDh9j1Ge4U5yFtnsyhw7BB1GFtQumPojoRxoK00
Message-ID: <CAEvNRgE4fbMWpTJTMLru-8QW9bJyUEan=K1GYWxvpXY8+LUBrw@mail.gmail.com>
Subject: Re: [PATCH v2 26/31] mm: Add __free() support for __free_page()
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev, 
	linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com, 
	yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org, 
	xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Xu Yilun <yilun.xu@linux.intel.com> writes:

> Allow for the declaration of struct page * variables that trigger
> __free_page() when they go out of scope.
>
> A example usage would be in the following patch:
>
>   static struct pci_tsm *tdx_tsm_link_pf0_probe(...)
>   {
> 	...
>
> 	struct page *in_msg_page __free(__free_page) =
> 		alloc_page(GFP_KERNEL | __GFP_ZERO);
> 	if (!in_msg_page)
> 		return NULL;
>
> 	struct page *out_msg_page __free(__free_page) =
> 		alloc_page(GFP_KERNEL | __GFP_ZERO);
> 	if (!out_msg_page)
> 		return NULL;
>
> 	...
>
> 	tlink->in_msg = no_free_ptr(in_msg_page);
> 	tlink->out_msg = no_free_ptr(out_msg_page);
>
> 	...
>   }
>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>  include/linux/gfp.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 51ef13ed756e..d37e5564234e 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -391,6 +391,7 @@ extern void free_pages_nolock(struct page *page, unsigned int order);
>  extern void free_pages(unsigned long addr, unsigned int order);
>
>  #define __free_page(page) __free_pages((page), 0)
> +DEFINE_FREE(__free_page, struct page *, if (_T) __free_page(_T))
>  #define free_page(addr) free_pages((addr), 0)
>
>  void page_alloc_init_cpuhp(void);
> --
> 2.25.1

This is nice to have, independent of this series. Perhaps it should be
sent separately, and some existing function could be refactored to use
this, maybe __tdx_td_init?

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
