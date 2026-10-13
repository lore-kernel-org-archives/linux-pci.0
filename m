Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C71531610
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791915097; cv=pass; b=nN0vGl5iOvz2MC7MH0vwG0c1u2V/gnYOnhcWDCzFvHG2uLQfp0z5w65izLmAhAuogbhfZZOtarYaQxp4ZZ6k8Lcgwhhk9x6G353Y6NxZwErnCNyrVtL4sa7KKq0rxPWf+0bKRdCs/QfuveIJLj4lZ7nMmvlpt5z7xDDvIfopR5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791915097; c=relaxed/simple;
	bh=Nx/Ht7WbeWj9w+mc12q4UZvwSJdIOI1LylC3CvF+snE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFuNoLuuSOkx8KSkHaXgF/lFfAQm5iydWZeCmNV0ctbibIoMbrEBJvI+VR1qEboGZc3wJVeAn2nJOhv/zVFL63TyMlZP36Bd/qYJjQBXsYID++G0ykEBDQ+KgecUrBYu9kF5ClvlS1giwtwH3N8sfryrGyawGgUfI3Il7XCTM3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWkVCbBK; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWkVCbBK"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3a75f960be3so2653981fa.2
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 11:11:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791915092; cv=none;
        d=google.com; s=arc-20260327;
        b=M6rbHVZkKpjJDrWN43hRQlx/kBHYZ4BlLJ9SqSdcPMxS0CF1WTJRM8Rc2LChHg0yVc
         MZGsqaoeT/Qv8p13EaGp4IDhf26lXeKtQL5m+eadLoS8Ktm+vb5V2HGaPaUsFO1N1uUY
         pDIVAv12nHZK/m63ECcgoe1XB0XOD9WIXVshigm3KzOXsZqeuQA8Syn5YRoRilMtifYX
         PCHU05YketWSD2UlC023AlgpAHxaPJo/QA4Os3yfYucuDawkB+QYu5TwyRRB/gfWPNpM
         TendD4Fe1Q9VbGsAtwT5jRmkB1O8yOAZuzd9qZP/9UV7SYqguOfVgs3JDspaEWM2QvKl
         pdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tc1zp/jsWqF51CNIfkZYVDsfG54HgePDR513djZlTcM=;
        fh=R/RDhVG/Jhx1u51XtBb/iPFZbQ2CZhbta9Ievgpva8c=;
        b=Z/3HB8FBRH0KCXs1wKVK70h7xEoXl+v7szrGETZSUX0689VicuTyQPJBR9R7GUsyWQ
         Lz8wwK8NCFD2v0cUrmKJT6ScQkfGiezptdZnGQ2bN7N8Lw3ho2LlXnhx01rDac4tYRvu
         IbtAZzaj/ov6EWKDsVFOmwdrBc5Kj8wuXe+92eIoOOsQ3DmMHk8Bx0YwSe6WOH6T7h4h
         3m9RrBSqffjfazLRxJNtljS0rLLvTz3t8ru5ZXxuFTsYU/pRK+Z4IDNa7bKBQsWXEikI
         25gbtFSJvNaphaI3EqHDJk5SAleBp0JALcJ66V7A/ODD+vjGYhYxY+i9ALDYVzhPPosG
         a0EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791915092; x=1792519892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tc1zp/jsWqF51CNIfkZYVDsfG54HgePDR513djZlTcM=;
        b=FWkVCbBK0jrN4ebBhcwZtp8DtYvZUna0hRejCVerpEUup2Jv545NTBW+Ipzdb3vXoM
         zUOHjJyWMiudlMCV03m3RENYNIS3lQv3OcpoBrAd7sji8h4OoycI3EGNIFzkylb1LvnQ
         SFCnwdKfYBqjphih88JDBP+h2uGOuEfQaxfHTM5v2/fe/yrHo3mIH0kHAp6o9i7FqyUw
         EMfsuKu8k+1b8Wor7PSl83Vsxgq1mdzZJheoh+paZN6el0dsGvYKa45jg3K9zIturQ4n
         wGdF68Jxfe4nlNiFElnBKn5CAJV91LF/KTZiC3keQLEMVm2AaCvQcZIN4DjLT8KMenMj
         bHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791915092; x=1792519892;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tc1zp/jsWqF51CNIfkZYVDsfG54HgePDR513djZlTcM=;
        b=NqU2pW57WsD778aaaVZXKu/CbzNm613rX9v8+cWe7H3lEENkuGmewpA5YtOKADHPuX
         V2z+lnD51VccWcxf9xKwFFlaTl5oZTW/zfABJaU0Ri8NLwIE+Ki5ENeI84Q0evtgfsGG
         uqtEXm1alwwZM0wLj0en+QRMzpH4emibOya9fmC1TXuOc8Dyk9J0H9IY0mr7m87tLG0c
         +54o2cBl1QwMAaRqq+pq3h7Jl/VRtvspd/mv5y8pfrakbYFlXiMvQ+BmXck1dI23KmaX
         QShS0qZnMkyYww5iZ0T/e4nwRogQzHui+oEfsjc7Q/R+xjM5Dc3rQ6Rm7Lg1D70U9jTG
         zUjw==
X-Forwarded-Encrypted: i=1; AKwUvBxBRvH9/iT5z5x+qp9CcFysrkZHMEcxEfMgRlRs9StpAcHAosAqkg9NAeZEwV8tkWoyDv5eCyiN7qE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8HRM5Endq+3z8Nvhn0toHoFMkqPx1EWanAEgue3lCBm6ptqyG
	kEZbqRdZd1CFRvH192ey4s3lr23iK86R2pHp87gF/snchxPt9ibpDB+OHdBmvMH3x2AY+rElqcp
	pKdgwxDAHz1YUV2NOdPQjjDwTmenhkZU=
X-Gm-Gg: AYBFou190yJ2QPD6ymL5Hf1FBH5mALK17M4QThEbnWqyZ9e6KIDLZsS0X70lktP49B5
	0AsBbE2GL+hIkgr7uLhe+ThCbzPq2b4V/8kBzVELvlPWGQ5ZS2FflqgPe0aIxLi0vvOoRCMjqsA
	fnPvijKa3aXYfQE25YmBmoUZVxc65ClU5uIA9ahBR8iQROBZrVBs4qpZZUOHCCQkb7YIHU6t5/n
	WzIplT5Pp046U5DVPmUc4nDCzcneDX7Ya/XVS0WXcZcmXTczk9Qpm+pnYfoXGXDLJtVpW4av3Ru
	PEgG69pLkM3GAywYkdQWmHtg1CGK02A1692elcqw1l9ZwAgsvyL1H2Rx
X-Received: by 2002:a05:651c:1542:b0:3a6:692d:b7ed with SMTP id
 38308e7fff4ca-3a9c539343dmr36125771fa.20.1791915092239; Tue, 13 Oct 2026
 11:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781622998.git.geraldogabriel@gmail.com> <179189927768.12828.5970294502454132706.b4-ty@b4>
In-Reply-To: <179189927768.12828.5970294502454132706.b4-ty@b4>
From: Geraldo Nascimento <geraldogabriel@gmail.com>
Date: Tue, 13 Oct 2026 15:11:20 -0300
X-Gm-Features: AclHuK9xQdtHZz7WlG4Kf2RJqiboP4WJrJZBrkr8E7ZdVfvIdA54iitY7tUbJH4
Message-ID: <CAEsQvctXV4zga6Rn+6=Q1zmEmMjDV-83VTWP-b2gWy4Bfdz_1Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] PCI: rockchip: 5.0 GT/s speed discouraged by Rockchip
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>, 
	linux-rockchip@lists.infradead.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mani,

On Tue, Oct 13, 2026 at 10:48=E2=80=AFAM Manivannan Sadhasivam <mani@kernel=
.org> wrote:
>
>
> On Tue, 16 Jun 2026 12:24:48 -0300, Geraldo Nascimento wrote:
> > PCI: rockchip: 5.0 GT/s speed discouraged by Rockchip
> >
> > Dragan Simic already had warned me of potential issues with 5.0 GT/s
> > speed operation in Rockchip PCIe. However, in recent interactions
> > with Shawn Lin from Rockchip it came to my attention there's grave
> > danger in the unknown errata regarding 5.0 GT/s operational speed
> > of their PCIe core, including data loss.
> >
> > [...]
>
> Applied, thanks!

Thank you Mani, that was an important drop.

It's a little strange I guess to have patches that were Reported-by
and then Reviewed-by the same people. But in this case Dragan
and Shawn deserve all the credit, I'm just the person who dropped
some code.

Regards,
Geraldo Nascimento

>
> [1/3] PCI: rockchip-ep: do not attempt 5.0 GT/s retraining
>       commit: 39f89dde0a76b229df7eb356aaf6f444b4f8a636
> [2/3] PCI: rockchip-host: do not attempt 5.0 GT/s retraining
>       commit: 5988a53f5bf758b2d41cb6e0832c19b9692c76d2
> [3/3] PCI: rockchip: drive at 2.5 GT/s, error other speeds
>       commit: 62843031ca1f11d1b8e90e7f558c1b3c4cd77184
>
> Best regards,
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
>
>
