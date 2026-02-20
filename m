Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85812C11C6
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771601041; cv=none; b=RIbuuj96azWa9o7v5CTid4A5MCQmgop/2wysv/y+LBYuK2MeiU5QF6EZ6B+7+tPvidbTOfxpBHRjUtmZ9mPSVGCOP8Q/DiozKI5g5ajJvDxJUpbN5mRmP8Ps2UKFgL1XJZPJNwyiVZHGeon9aLT5iXXCKVnSrNH1FMk1RRCjiM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771601041; c=relaxed/simple;
	bh=7YOwhDlW9EkRwdiqBCLZ0ak2iNyvJHCfQOsIZkQfVH8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5aEYccIzXo9KGiCBJjDN1KwjSL9H2d6aeEsHx5BSfHHMoxgxHLiPX3xBBfOHYhsrLk3YMYJGmJ/WHCV61G6gRjxyrmVUWNmdPn/lDjginSQvYOKAtiGbSU2QlSaw98LXaf4Uw+ZRXpBM8T4hUNSo8I1FcM6pb8JJt8DT+mm9TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnqN5DP9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnqN5DP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDD5C19425
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 15:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771601041;
	bh=7YOwhDlW9EkRwdiqBCLZ0ak2iNyvJHCfQOsIZkQfVH8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=TnqN5DP9UcSBHkQ6nVer+Bsa9P+smNWHH90HOhcFGqNOhxGxAjiixdh5A6rRq0Vwi
	 i7Rksp2vyOxXi9D+ipPqjoiW3K9fK+FiNWdqqPKR4xjZNhKFz0Wksu5iNgwKeD9Dho
	 Auc8REw6S7c4ERzBjR7GIxS0/s+K/qnt4SIcKK/wj1qlZ8pwq4DxRhQ9u7z4Fa6bj6
	 SCItL+A2HJuvK9ufOxcOeCFb0L7Bb6Z21y7XyT9s0M4Py70l1Txlc4Lw8oVHMxQJP7
	 npgQhXN6bWPugRVKa6jms01gFM1hT81CaIV7B+B+BopbRVbyEV03014dapwqOe2VsW
	 XRov04Fn2+dtg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3870cbd6c40so19879881fa.0
        for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 07:24:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7hwSFejNIBpRHuxuB0GYo01Loi8kyariNANzmBe+GlhBRllw0KAdzBJfxQVZKvqPhksVkQO2Ca28=@vger.kernel.org
X-Gm-Message-State: AOJu0YypczVHTkZssikYxEsgoDpVd3Z6KF3BBggwHiPD5zk/OCwZUCJt
	XcopCHVqUU7AY86Od/SjwT1Z0zcZMlM/oqNsHC3Xi4T4rlcxzy/LixIa5kizQ9Xt4z/WzNH7dwR
	7+RQHFvNP+tb7DkDGP/GTyZlAd4siF0nSdvH00X59KQ==
X-Received: by 2002:a05:651c:1545:b0:382:6067:a239 with SMTP id
 38308e7fff4ca-389a5dd9ac3mr290021fa.30.1771601039935; Fri, 20 Feb 2026
 07:23:59 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Feb 2026 07:23:58 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Feb 2026 07:23:58 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-3-1ad79caa1efa@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-0-1ad79caa1efa@linaro.org>
 <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-3-1ad79caa1efa@linaro.org>
Date: Fri, 20 Feb 2026 07:23:58 -0800
X-Gmail-Original-Message-ID: <CAMRc=MeQ86z0CM93DcZe-28gGRDaKV60rYDt5=xOXRW7EHnM=w@mail.gmail.com>
X-Gm-Features: AaiRm51CvXlxpvRQ8u6gG-xE4xcTEnmGYEsTGXJEfvQXF8ACXrJQJ5VFzMxdldw
Message-ID: <CAMRc=MeQ86z0CM93DcZe-28gGRDaKV60rYDt5=xOXRW7EHnM=w@mail.gmail.com>
Subject: Re: [PATCH v5 3/9] pci: pwrctrl: rename pci-pwrctrl-slot as generic
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Feb 2026 16:04:42 +0100, Neil Armstrong
<neil.armstrong@linaro.org> said:
> The driver is pretty generic and would fit for either
> PCI Slots or endpoints connected to PCI ports, so rename
> the driver and module as pci-pwrctrl-generic.
>
> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
