Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F0131F99E
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 22:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785538770; cv=pass; b=Cmyhx1Hyyxy4wKVSGIErHMxtDIYwyb9l0jUvIQEC93QSJvULrwonhzY/LjOXiPdUGFI4Mw9TYYvz74JRUWyVWe0FstFJrDQfycFNRxScBhnpkZbGv8tkGmPwVC9QkXoNvtJCfSYVOw4tzfKyHTMHPAUPFNyjqJw2EjRPdAaV4XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785538770; c=relaxed/simple;
	bh=TWcPtjAG4u7chlP5TyRDKKWblA7wU+NlX2Ibp3AWBks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkFOXoU2Wv8rv+JSd9l9/qPiWFtlIfNQdHVqB2twk1x6hRXrdrz9ixu6EwH61coOaujq8flfj3ql/8hbKDIF+4Yal4KjLZ4luQOsdS+7trj7OubaecdDE3fsNQ2OG6SeeyCVc+uYB+PLw45YwXTuEpJKmJjYhcti4mk+ggJ9jUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FUF2N0Ff; arc=pass smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FUF2N0Ff"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66VMWJFh2237498
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 15:59:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=sXFksAHvqmB7jfoZlHKXAtLMdf8uLXt8quqrA
	vj0i34=; b=FUF2N0Ff8bRoI+Jm4n4FqP0UEtfp2ZafABB+ZLlVHxt3/n4mCu9ji
	tmyxKNmYnX02kKgIzt0D6oWqHsCR/pV7Siysc8tevnCjpRyn3Gaj8zpE3MTkzEpi
	JbkNSKFBfbAdcskM38ush7GML4ZLCte0uuKQsbFLbGQfF/KeHa0erD/zloXr2ROI
	2AcS8a6XIy80Em87RsUtY6SWr0zB5JnmeGRZ6C7E8olWq6tpJQAZIvP+Snodglwa
	rjz8oiOujIhbDetPlVi+T3Bdit9GkMDR66Mb5drzUvjTtoqwuDn76UsltmTSxKdb
	FzgJ1fIASoS+LL01Ez+/4cm54Jds0ENhw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by m0089730.ppops.net (PPS) with ESMTPS id 4fqrme05vh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 15:59:27 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e9e54e9cf5so1880263a34.0
        for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 15:59:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785538767; cv=none;
        d=google.com; s=arc-20260327;
        b=HzyQIJtjS2pfyMdnS7ndRC1+8uFCtA+r15ZX/TtoTPSRpjUTaoy3vVpMBEEAM3ti3U
         NXflIT9awYh8YRpN4HmygX8wIalG2xHlvfaZcd1AeL87WcKFiML6E6QCmeIPLtAg5DIN
         oq+S5BxIw9pmtlNKs60MfUytfeNzPJpJBNsZmIPkT06U8+1ahG3oDJ03m9QL00TB15PN
         dfaPgrhyxhN1Q3chQtU5ho3s31fvlT5MVku8iUaG8AjCTrlMTFrLoG/iYr98T9X45Bsg
         12sigYckGuUlXwJ6+0q68IQ3U1c+zEzI5n/K43ww4TP27ehFN1kyIobhHb/kDJXQSpK8
         dwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=sXFksAHvqmB7jfoZlHKXAtLMdf8uLXt8quqrAvj0i34=;
        fh=sImXpcRDPx5U58yDC/2Ri7tG8zC0m2k+SZgE0QR0TMU=;
        b=e7J/IbJR0h3kf8YIVMlY0Ly5taanJSm0s4lsh+GBnb8Nb8DqzjcxCoZHWKbMQJjGIz
         j38LjpHY+ivdM/OUdUWTuNVlPNplGX7QkhSbQ1tEAxvnyhEOTnJiv02P+ZaZHc/22EZw
         M5K3EN1hZ70pOCvx51V6Dr+sGDXfwpXbzt6jQT5u0B1kWolpZqAPNRVBsYZ9OKvyr3kK
         W4gEie+vItObPMimcQTZqTCku5fLa5N+eWyXjVIp2QqkZ9LxmXkF8Sp45op8AnUI2HOK
         Yas9ScWc64yciql9leR1ClXTE0zInQWDM3mU7sDkEh8WlW6o3oNm4pBy77hQChmbNA7w
         xviA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785538767; x=1786143567;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sXFksAHvqmB7jfoZlHKXAtLMdf8uLXt8quqrAvj0i34=;
        b=FnJ0tMghJlaPm5h72c4F6l+/viC1uJsLBuWzjl9ECDSpxYgXJGSzzKvt2w02NFzPG0
         iihK77Nud2f/pAyQf9Rh6uHJLVAq9QTIYZQpTkjBDMSByLmaQWOj2EIqgLPWp+BkNfsl
         rYDEPuMFrwHx5t2vkpQNBJdI94qSEPQFwooXQ+vm1UQ8xi12PQm0dLk3gzL0yqKg5Yfx
         lPFx20jENJAN/0ZG7HhB4jNDHLxwlCTvgfp0ZcP3DQn1M4f6MJuWYHFQ6U1RuQJ4EwDx
         ri5uAVLdD9FaEf4fbBDEegX87XzcUPwJjkyGK/49Vxsbl7EWi2YparEqfCwAv1Cgl/bq
         w14g==
X-Gm-Message-State: AOJu0YwkmNBBfnw8ofXAkZNtGYyf2+YooZHgGYhaeS1O+WuHKyMWe+RK
	D6C+znp1LhF471I893pPPtGD+vxw17lkV1EoOi5qB2q8cclO6/FjCrE1CK81lHeTsWvBQ/6OiH2
	D0WjW0/vEkd7S3QQsmuw4TIxKheY0kM6J7d+3+qHYJ95DdlXZubEwVhU7G13ql+xUwWGLLYu2mh
	YMw8+n8koJWQ8V6IXT2wGh8pBRyBidoEI+Fc8igNEMM5fbnw==
X-Gm-Gg: AR+sD11ZY/WhbDLcJyoTHRVMnYFRBJyx9K5HWN4N2bcDhlsIzAgUDyJdhCZsmSqJvsS
	9GCAz69oKQ6EaGkah6dXyBDpp2rlj1BCLcBiQ/RgizsL6oywsVIbNFcRtkh9e3NHWWZI8qw/Ri3
	kUQPIJtMi8LuRbF6zqwGeZ8FoL6pHOiyUsr/egcJ6BJCpLmKuGpp9Xve82bAWLJxSMW4vqHviy
X-Received: by 2002:a05:6830:67da:b0:7e7:5e4:ee11 with SMTP id 46e09a7af769-7f196f48db7mr3826370a34.16.1785538766992;
        Fri, 31 Jul 2026 15:59:26 -0700 (PDT)
X-Received: by 2002:a05:6830:67da:b0:7e7:5e4:ee11 with SMTP id
 46e09a7af769-7f196f48db7mr3826328a34.16.1785538766468; Fri, 31 Jul 2026
 15:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com> <20260731211601.3033906-6-zhipingz@meta.com>
 <20260731214821.2A9AA1F00AC4@smtp.kernel.org>
In-Reply-To: <20260731214821.2A9AA1F00AC4@smtp.kernel.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Fri, 31 Jul 2026 15:59:15 -0700
X-Gm-Features: AUfX_myHxlkqFnSLC9MVeO-2eucc1qmrR-J0Lg2UWhuCZpzuHdreSVtFADd0gQo
Message-ID: <CAH3zFs1Nhp2vWnoyDT6RpePRM3=JV9JeMuWz4jZwbnSTx=6PaQ@mail.gmail.com>
Subject: Re: [PATCH v13 5/5] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE3MiBTYWx0ZWRfXzbimbWKQ0Hfj
 dMoQ50dWE0mvzAcdajm6e/jSfmqIl8zrjy1cDTTIlvokW44KxzNPi3mGsxjhTsySDf6QLl4uhcO
 6RHdEryY4CYZ6VYjBou8IotA3b4rsBU=
X-Proofpoint-GUID: d6Sc96SR3UN8zZ9YN4CPtUlov7CUcclW
X-Authority-Analysis: v=2.4 cv=YK6vDxGx c=1 sm=1 tr=0 ts=6a6d28cf cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=VwQbUJbxAAAA:8 a=So9IXvp4ApBoCZzCt-gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: d6Sc96SR3UN8zZ9YN4CPtUlov7CUcclW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE3MiBTYWx0ZWRfX1tC08952Z77W
 tn6Zg9zTiPvcAzJqI6d8AfRXJZBbH1qXnYlZLE4+taayACkIEJGY5ihm8BCMi6TxEUuHDCf4UXS
 iMX9BKsurYPXvHiIoUiAbq3v0NMH7p8S6qFoi6FLqJXhFKpily792OBOr2bhre9AOLLA6qprKQH
 y+HEMpu5t6UMi/8IekuWGTWFCwn7RTJeWa+ho5R4gz+MUVo7J2JYDU1mtyTG9Zm7PuW/33ootik
 30p3VSnSrhrTw7Q6ucsTfBbWCMwbx43Mei245CLEcibZJIagzYxiSyWRTN0E8RQWM48RhsdVAq9
 83geFl1wQ7Je4oSe96NLKt0V6A1jw/jf8wpBH8ccggxT1xZ6xC7Q5WY8Nrzqt4xwJWTTd1PaJuo
 rJsogALbNJl+GDbC2d5PRPxfPZX+eFstZRl0N7Ig/EhnoJlfNJdbbe7Qyno9Hb+LIPJFh5mYy0d
 V8DEPPOEtNANjiEqB9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01

On Fri, Jul 31, 2026 at 2:48=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
...
> [Severity: High]
> This is a pre-existing issue, but this patch introduces a new, heavily-ex=
ercised
> reachable path for it.
>
> Does mlx5_st_dealloc_index() leak the mlx5_st_idx_data struct when erasin=
g it
> from the xarray?
>
> When a steering tag's reference count drops to zero, the entry is removed=
 via
> xa_erase():
>
> drivers/net/ethernet/mellanox/mlx5/core/lib/st.c:mlx5_st_dealloc_index() =
{
>     ...
>         if (refcount_dec_and_test(&idx_data->usecount)) {
>                 xa_erase(&st->idx_xa, st_index);
>                 /* We leave PCI config space as was before, no mkey will =
refer to it */
>         }
>     ...
> }
>
> However, the underlying idx_data pointer is not freed with kfree(idx_data=
).
>
> Because the next time the same tag is requested, a new struct is allocate=
d via
> kzalloc_obj() in mlx5_st_alloc_index_by_tag(), won't repeated allocations=
 and
> deallocations lead to an unbounded kernel memory leak?
>

This is the leak fixed by "net/mlx5: free mlx5_st_idx_data on final
dealloc" (df6134b527a8). Sashiko appears to have applied the series to
a tree predating that commit.
