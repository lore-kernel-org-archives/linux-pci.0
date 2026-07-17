Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9733C3F56
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280694; cv=none; b=J5uNtAtiB5eAGy1X0swGm4a3KnKII5f/P3BdohB4X4u2pfdxPdMLbGCUb+LJHDM0q4EpV7vy7SowFNGSbYzvrbHnfaXNnILHmwDXPpBrBXuEEFDVaVsgBteynF7cu/thuy20taY2fkXAtaGF7ZMG8/X5LOp2/vFsM3SCqB1JpWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280694; c=relaxed/simple;
	bh=idyDIDnbrWb05N4rusK5NDUWMXuYrFaoFGUInQ0RKUY=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mo6eKW0U8vi+lW5xkFwqGv9el3N6uxZujfSkWm1O/xPf2rTl5TPOYjdM4uMDW4Cu+MV1NXLyuwqPxyYVB7qXuc8p8C9C7pY0ztft/HvOsn+r0mPNGWshX5qk6d9vE5pa/2djPOy8Zd4Q4GPQ0+tMV27fgwURqv3mVccU7DMOD1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAUXZgfE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAUXZgfE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F4A1F0155C
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 09:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784280692;
	bh=idyDIDnbrWb05N4rusK5NDUWMXuYrFaoFGUInQ0RKUY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=ZAUXZgfEt4tJUPjuOKXh+I0aEsTaLTqhZkgFdhoVvk8xTRHOR4YKcor5S3GGiJlmO
	 pzlITU0fec9otfVvrqmikj9/kfhsr5fZWbY9xiL7VYzmhT6LdpHkh0KkDNbvTCBf79
	 xv7R8Cat5Bnw8kG+sJJskivwTirKGtJ/cBbirTrsLdEUJ6LLf+hnKlRUVgSkjVj6Wq
	 8R8iYHllTM/2CdwPwDaXQN09XQ/8AExMoePhilJ+I7tcLCkxsxSneTLscQkPxqyZ2s
	 HxOpiMWhGC5Wj6gsENFFyAwumhJ9McYQt19d0ini49zeHUXw+8MD16qi/rOYlJD/3n
	 VlqciQUZ5L99w==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b021916bd3so6537365e87.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 02:31:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YyufTgbwqHDCDDReGHQmBkKbOuQe73ZJq1oRi52mcuZJ9yxfJwU
	Ue0fDmowmqWi5HhHUD3hwn35K+waS6j8vtV7n9tSDreewfLV0fb+H6n1kXT1kzFx90vf7mPseON
	8/XfH4mL5a+2e/+4pVQeqYKkVwuf6Lp/1/QK0dnN7wg==
X-Received: by 2002:a05:6512:108d:b0:5b0:137f:9467 with SMTP id
 2adb3069b0e04-5b28f9ac5cbmr482378e87.34.1784280690891; Fri, 17 Jul 2026
 02:31:30 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 04:31:29 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 04:31:29 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260716-monza-wireless-v4-7-9b02e6f549d7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com> <20260716-monza-wireless-v4-7-9b02e6f549d7@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 04:31:29 -0500
X-Gmail-Original-Message-ID: <CAMRc=MfmfWs=jMB94uiiE0dUtc5hEiYBdV82mOfLsoZUfOXSSQ@mail.gmail.com>
X-Gm-Features: AUfX_myKUmYFvmwFkx01Fktbv79abVzfk5hHWq1rwGSJURh2ZxpSwF-OnLa0xCk
Message-ID: <CAMRc=MfmfWs=jMB94uiiE0dUtc5hEiYBdV82mOfLsoZUfOXSSQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] Bluetooth: hci_qca: Embed bt_power in struct qca_serdev
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 18:18:24 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> 'bt_power' is allocated dynamically only for a subset of SOC types, using a
> switch on the SOC type that mirrors the one that follows it. This is about
> to become pointless as the power sequencer path (used by M.2 modules) is
> independent of the SOC type and needs 'bt_power' populated for any type.
>
> Embed 'struct qca_power' directly in 'struct qca_serdev' instead of
> allocating it separately. This drops the extra allocation and its dedicated
> SOC-type switch, and removes the need for NULL checks on the pointer.
>
> No functional change intended.
>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
