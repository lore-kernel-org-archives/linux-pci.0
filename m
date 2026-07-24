Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7124A3B3BF3
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879989; cv=none; b=qD/IiDnQFA7bFpvUvhve5sOBfS03c415s+GWQ3e5dkBUjNVAuIJ2hwAk3H3oTdfozJ9a38oKRJ3tlNkxTQsJ305XrDmYfOaerbSsbiQ74n0L9rXZNQQzPOgfbS/qLQLC+so0dx7QaPAQBia5mhczj6hrtzEsSYCoVipPwRV/NYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879989; c=relaxed/simple;
	bh=gguC+/stcGzXeWlEBtDdJshd9M9E+gPl/OhO8fGPQPI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbbpFXsgsi/wISy/STJHi47QswjfaeR1/urPS2iPEWqzQVIHAw1YJqEa0Dne30PvceT5NnAgiPJP0P7eXvbgauURTuuZv6lGdDtiW8K818Nz5E+gQxPrJGGWz9JTpxZbzVHiq8Cj3OpzpXQrTvxi3zWUKdmk65j6ClWUM7GQ6SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZfTXROs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZfTXROs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF651F00ADF
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 07:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784879987;
	bh=gguC+/stcGzXeWlEBtDdJshd9M9E+gPl/OhO8fGPQPI=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=LZfTXROs1Jm4p5xUBV67X+EsnN4cwsm/xI8sIqeDH6K3jqE3pl/Fc2BdrIgskrkNX
	 01kF8ELhYWxIy4ulIA5aGeMgoNu6lJGQeNjiVM6cRh5OiMp63mc6nZESDznegmsOlZ
	 0rkV9n7PpZMdqOvIxxGYrTJnUd80VSH8eHaABNJ7w7mh8ApOyI6N12Q4fNV7Gy3v2/
	 dr3l4kSCDSZD8jPFSPITVjRWdMosbgRBM4MJTdVyrNb9U75F+ZgfjJnU01+SO95le/
	 zxKSLZXgGqdRbkDF7Bq8ngBh7oVlDyCYlUITWM02LVINtQM22hhVWAGjQWvJ40Aoos
	 UOWckRm74ubNA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aeb98460c6so150812e87.2
        for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 00:59:47 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx1vlhVQ2qPmoWPa1rM4lfQvhjdyWsTIzgaDn+NqIqvGDgS5QSB
	m01vRFLPVgcJBkmIg9j4JA+/yEpl8zV1wGDgjj8Di7TYO2IhVaU124LbymApcdyX8mY2Yo1ru7k
	carCDGn7MIhtNuNV6uO5piz7zf1y3SWR+lCtqOv56mQ==
X-Received: by 2002:a05:651c:25d0:20b0:39c:7089:8052 with SMTP id
 38308e7fff4ca-39f07eb388amr10114611fa.19.1784879985843; Fri, 24 Jul 2026
 00:59:45 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 00:59:44 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 00:59:44 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260723-hamoa-m2-sub-id-v2-v2-1-f10f95eb9ebf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-hamoa-m2-sub-id-v2-v2-1-f10f95eb9ebf@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 00:59:44 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfH3XrkNopMshkFUoXh8PWCfH_fTpU+CvxzsQbGwZ9d8g@mail.gmail.com>
X-Gm-Features: AUfX_mwhJtgQj9rw5_1Y85Mea9gZMXhy1GlwBwYjgaueBtm7pw6ZEt5ibaDIVyY
Message-ID: <CAMRc=MfH3XrkNopMshkFUoXh8PWCfH_fTpU+CvxzsQbGwZ9d8g@mail.gmail.com>
Subject: Re: [PATCH v2] power: sequencing: pcie-m2: Match WCN6855 and WCN7851
 UART BT variants by subdevice ID
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_chezhou@quicinc.com, 
	cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com, 
	jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com, Manivannan Sadhasivam <mani@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Jul 2026 05:34:24 +0200, Wei Deng <wei.deng@oss.qualcomm.com> sa=
id:
> The WCN6855 and WCN7851 combo chips are available in M.2 card variants
> that differ by their BT interface: some expose BT over UART while others
> expose BT over USB. Both variants use the same PCIe device ID for the
> WiFi interface, distinguished only by their sub-system device ID.
>
> The bare PCI_DEVICE() entries match all sub-system IDs, so both UART and
> USB variants hit the same table entry and trigger UART serdev creation.
> For USB variants this is wrong =E2=80=94 there is no UART BT interface on=
 such
> a card, and the serdev probe will fail.
>
> Narrow the matches to UART variants only by using PCI_DEVICE_SUB with
> their respective sub-system IDs, so USB variants no longer trigger
> UART serdev creation.
>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---

Hi!

I needed to drop a previously queued patch from my tree, can you rebase thi=
s on
top of current pwrseq/for-next and resend?

Thanks
Bart
