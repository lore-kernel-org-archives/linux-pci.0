Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0021448E0
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 00:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789517842; cv=fail; b=ohR/8L+ZtYgyxALDFoTgR4+PNanvtbdXmnbmmL5/U9jYSRl5e+aYZNGKgyIGbvBzh/e9ErP/Ol5QIQx8Hm2KnDtXzQY4luK8NuTmuf7zAIxHvhdgEvleCD8wuOOPEVKVp777pvgDTS068SpnwuIGUiwNjfJYzWvju4fdIOy7+NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789517842; c=relaxed/simple;
	bh=5av3QgEhikSP0tSNbBAG2bZkciaGDEOrmy5hau/6dIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLV/xwpivrqzDM4+4r3Wr7AdSHMDEG/8BLrzHi7Ld5cGHqRe0SfnsI7zP4U5U+pR6GareXPevvIrA5Vs8aDaGQy1WE9nJvRm8GxabmFAER4SBOGUVzaSoB9Zm4pxp7P7o1LoqbRbz5hcBqmTlMvlZFMdLWfFRlwpZeWi1TEefj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SV3hPlDn; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SV3hPlDn"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FMOUOM443782
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 17:17:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=y4AfS6tr9HrRnC6D4zpOkbqwXmfmGihLXHO3T
	H7isxM=; b=SV3hPlDnkLVLzLZ5wbnt0LfyWojFDHoTKaL9JlUmAXLtdCh4GpdZ/
	SKD174SCvrUikKcMBYauckYS3JgM+tWicqg6Oj1Bmcs0oYCNvfbaKfuYGlrVLJKf
	r6OwvK9Qe/f4pBy01MEWp1c9CWkCnaxUkeQw8Qd9+jvYiKtQS4cVfUVdETDA7xaZ
	i02VojdTANK3f3sj2LsPaRR7E9gJFNv8lt86XsIF/4fC95eqm/hGduydG7DxeyJK
	pir0xIEvbcfyHKR1q53dV/4//VMrQo9fK9ExB2hkeqKevwM0hhR489OnIDrdaCGJ
	MkoepWkx0zrAKKuQkN2Vqp+EvaVdA5v5g==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gq89qc8ne-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 17:17:19 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-80621978fddso2110659a34.2
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 17:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789517839; cv=none;
        d=google.com; s=arc-20260327;
        b=KUFtfypfAVg2pmNUindznJ4UBXr/Lg2FA2nEWn6vl50FcXDRZdER4uqSR2f2pu+yDo
         jweeRO+rIeEtr7TUb4BcBiLaS+2neIBriZHHjau7pwsqKyt1HohnSvOFusCA834dJjLY
         jh5EqzPupAprAzU3schCEMGV3wFi5ToeWA8AcnGBH1bUK/seBNwd5NHuYpKx2xtd2AAo
         c1LNENlO3L/++YQmUC9V8EA+jeUhaSjMTuWRp7iOfe1RPPXKBUoZgpepZw9pI6u8ZgKo
         FmodfYLgSBcb38XgqcwX7g4oiqmsySJSv5a9bw4PQYV1nL7Yvjj3OeAjzIPchfPKbFVL
         xKEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=Kw8qhFcrPQrG+D+0UL2QgWXn6zGjS5meCnbxBsS+WIw=;
        fh=xn7wiMF+fUHnNiVOQEozzhma9YFbO+pJJf5N11LrVQw=;
        b=XdEAEVfFjfOOAugwq8d9bzrxHp543u++lFOz+MivXaC7udP19n0yrHXVZa4aLgIMio
         eAEEVBgmIBLeMwfNMgwuDkHWRkuzaW5hVyu5mkXGoqT2lIj3X/kUR5ovZ10OaPGVQMEh
         kejS4KdYCb0PQDGg3rdwkHQ0/ctXJ3bP0jEMn3G+JWpRCqo+ycxgOFLbJTaXmQNEjpkA
         T9OSyxMhkMSJqIMBGIxSA48gy0Aa122jGPBDGw4c+EK52DWCo+FPbGXP1ylK4mwlKkz2
         iBIawNsrDKLUctVrFlMDlo04Ajxz7oUcK7UnXa1LFjC43UwM5XRQpeW00m27LTEhbM7S
         ouxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789517839; x=1790122639;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kw8qhFcrPQrG+D+0UL2QgWXn6zGjS5meCnbxBsS+WIw=;
        b=UsCsaxdR1UO85u5t0MJ20OpzCHZHokAGiz9dQtelA8c+nk7DGU1JiQaG/Ip8jF6P6P
         tJmYOXCo9qM3stPsVHy9tAekjx1lZBXgMcMYHytqBtyWsIFlCiHPtFQVQTSo35uwJm5C
         5oRWvENrEYo8dw5YPn/f+F3pxenAfv7mVpUaTvV657xp3Rr9UWf7Zw+3ja2ICEoUXBxt
         trYcpojTVCgf8hkb3Wl5cAhEOmgCWBd2RxPr2wfxUHDwkk0s+biiJC1EKalT6s9OOQ/G
         j1RglMpWNSy8eY0MN6W0aUgSHKuYSWK9fSEQdRGYchQlyuue657C6UB2fQYwIvhC/Ci6
         hiog==
X-Forwarded-Encrypted: i=1; AKwUvBzuf3Sn7Hb5CXC5LwzgUtxoSDFs4cfFI7lGgL334lkRN4t2+XmO3MnhS2EhDoMLvcKJ7Ig+Gqu/zdg=@vger.kernel.org
X-Gm-Message-State: AFuF++lUq6S0xdOmIQoota2hUhYY9zklgCpYrAKz4WacnJRqEowziHAy
	XpiK29MpxDI9wYakesDrrF7e8uWYlRZsuKnMZrDqJJ3p/Ibp2xl6rSCWoFvucQysYeyXH6p0aoE
	L3YIjIXwj5Y5s1lLbi0UAePrvdIxrDO/ADOIFs8fUi6cepb1ezboBeJfV9bcCkeVzUpIEMabIgc
	C1pcxtPwLWIveIeFttWV0skO5XOAdSNiYIIgo=
X-Gm-Gg: AYBFou2+WGHlaFPjYfyZOOKzkUHC1wjit5c35497xzmZQ6I383djXK/zgBKYnJvYM7I
	YbpLdRxOcBkH3x/O3lWXd/enwBWX3uMf9UbYl0ZOczqtWEnfZ1JxHuiIgxpq28+eixZhTzSeUQW
	+2PRU9I75D4oJfkShw3K5e0PZl2ioRAfySnNaLUw2wDq7wH0uAKdH5COlQPU6OkerxojWelpDu
X-Received: by 2002:a05:6830:d0a:b0:7e6:d54e:8fe3 with SMTP id 46e09a7af769-80b2d408fadmr803743a34.9.1789517838946;
        Tue, 15 Sep 2026 17:17:18 -0700 (PDT)
X-Received: by 2002:a05:6830:d0a:b0:7e6:d54e:8fe3 with SMTP id
 46e09a7af769-80b2d408fadmr803625a34.9.1789517837178; Tue, 15 Sep 2026
 17:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com> <CAH3zFs0vQidHOWif_LmS0=65S9iiCo7yGibqLvFT5jadjj8wVA@mail.gmail.com>
 <CAH3zFs2XnH6gT0fO4=WLi4x1SL2+Y0S=Jo45SWkR=unPegQ8Hw@mail.gmail.com>
 <CAH3zFs2X8=x-XMXhwC7_aUZivCCPQOSuyXMy-ryKqxLEFY9u-Q@mail.gmail.com>
 <c0c8dea4-1571-482e-be33-f965c7c357d2@amd.com> <CAH3zFs3=t3rNDDjUsCAekfhEGOJPyx-YXKta7NdHy3kBKU_RHQ@mail.gmail.com>
 <20260915144901.554f905f@shazbot.org>
In-Reply-To: <20260915144901.554f905f@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 15 Sep 2026 17:17:06 -0700
X-Gm-Features: AcwNN1UDllFH7fZheftU62Oc0zcY8368FZvRR7u05GnfBjshQDxnxMnIHm9x8No
Message-ID: <CAH3zFs3MwpxLNL+qK9e-jPBLasjfxeMvudhgz5XzwrtvL1Dz=w@mail.gmail.com>
Subject: Re: [PATCH v13 0/5] vfio/dma-buf: add TPH support for peer-to-peer
 access - ping
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 7y0E0gmNbQ2iPbOXJ9hOSnr5CmPJmKAn
X-Proofpoint-ORIG-GUID: 7y0E0gmNbQ2iPbOXJ9hOSnr5CmPJmKAn
X-Authority-Analysis: v=2.4 cv=Vp22kO2n c=1 sm=1 tr=0 ts=6aa9e00f cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=r1p2_3pzAAAA:8 a=tEdGRIS0mffteslzfD0A:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=gKebqoRLp9LExxC7YDUY:22
 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDAwMiBTYWx0ZWRfX16UYtuf8dFv7
 ABb+9lqPOlXXF73p7kF8oaWxjDSB6u8FKINxHh3Eb6dSKv+N29YxanMNXvFhCrathfMM9IXgAzq
 DiJ+QOycNtFs7utuMOAZFoSNN1kXp8rHgmp4gAcCfbeKB9Vm696Zf9KhNjutONsKo1Hu2JuYC7M
 bYBMDNyUi8qVncf0Wn655Dgr2DLjO9IycIrrcJYyAGqBMrpVUXozqgKzTTtN5LhlG3eSG3BUvSk
 Ihyy6unPAcqbzYLwbqm5XxVP3zLNTJnbJn7npOIsw3b3NfnO0Cn/0feIn/i4GcqLqbZtCbOOe9k
 RjxnXYUqotX47STRU3LY39W+qJEyqrnCX9Ry0hyeigRcrzsZ0lKcZEtgfKCjflIzVxiUV34x7Qr
 LNxSQNNURTFv4jkjU4AgFCjuyYvRWU6F2Q6mq4p8brNDH+aM9sOoO2B/OfyfRC7SZkNRv5HIZxy
 CGVLmeIPwS/6aVQkGRg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDAwMiBTYWx0ZWRfX8gJmmOGdM1A/
 L0tZOBJjJ80gzxiQpY3ffWKZF5DfJqn92TaW5c8lhOmQgFPMBka6b+Qqr2Z+PBQ8ge71LxDK1uy
 4L100MBYdre2aTRL1icxnUK6vMQQ0S4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01

On Tue, Sep 15, 2026 at 1:49=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Mon, 14 Sep 2026 09:44:57 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Thanks Christian -- no worries on the bandwidth, I'll add the Acked-by
> > to patch 3.
> >
> > Hi Alex, Jason, Bjorn,
> >
> > Could you help with reviews on patch 4 (vfio/pci) and patch 5
> > (RDMA/mlx5), plus acks on patches 1-2 (PCI TPH core) so the set can
> > travel whole if it goes through the VFIO tree, which is the route
> > Christian suggests?
> >
> > I've also rebased the set onto 7.3 (base 5225b8eec4c9) and retested on
> > hardware -- PCIe analyzer captures confirming the requested ST and PH
> > on outbound TLPs, no splats.
> >
> > One thing to decide: upstream took 13 for
> > VFIO_DEVICE_FEATURE_ZPCI_ERROR after v13 went out, so
> > VFIO_DEVICE_FEATURE_DMA_BUF_TPH becomes 14 in the respin -- let me
> > know if you'd rather it be something else.
> >
> > I'll post v14 after I hear from you. Delta from v13 is the rebase,
> > that feature-number move, and nothing else functional.
>
> IIRC, we're pretty well settled on the vfio-pci front.  The feature
> number does need to be iterated to the next available.  We still need
> acks from PCI and mlx5, and given the extent of the mlx5 changes I
> expect I need to provide a branch for Jason/Leon once I merge it.
> Thanks,
>
> Alex
>

Thanks Alex, it is great to know the vfio-pci side is settled! Bjorn
acked patches 1 and 2 today, so PCI is covered.

Hi Jason, Leon, could you take a look at patch 5, the RDMA/mlx5 consumer?

https://lore.kernel.org/linux-pci/20260731211601.3033906-6-zhipingz@meta.co=
m/

Thanks,
Zhiping
