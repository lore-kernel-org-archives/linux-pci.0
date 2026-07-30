Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7158934404F
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402234; cv=none; b=g4tJZmWa/POewbpTvfwlFpGlIGwKbWfbvchUEZLJqVUC+NNqQoNWJXhg2eVwBx6UrGbmvTE6sG8tF+NkpqpkmUtCStuA6r1AzpXIeRO/+ue3NfhjyZqqWajzguY9DLgdX7OFpABcH+QUd0nQyjwKfeOdDslAfz/+411O7hBW+SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402234; c=relaxed/simple;
	bh=jBq7bb8gHLcYeyEnNwFXIvaxlK4DgK7bNeb92a/LUKo=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/nVgO79REYwlLmCJR87q0eZWoc1VnLfMdUGA6ehdlE4EuEKK/7eqi5/HPtNLUo3jl08gLGbvlfLXnqrSkSsZBGnUeqT534Wr4e18905YktopkaSBaFIyThAK0ZZm6Z3suqeBSnx0OEePLpnU9XGnDvyPQFpl8M4Jh9nwZ1fbxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wtyltvvw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wtyltvvw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AD31F00A3F
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 09:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785402233;
	bh=9iyxgV8T5RliCmhqHHIlHdNYU/Kn9Kj+MhI6s49Kmwo=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Wtyltvvwqy7g/E/jmsC2UydftGKENxSnaddjk7rDXjDHIER7H/CYoI9yMb3t8FQUm
	 sJeCNNAHjCNI/AIXAUiBZbpgMTo2I+glyZphad+xgbrTB16850gwu9WmFH4sMDPc37
	 4K7P+Cr60Q49SpZMjExQQvtyWCVr1hTOGrdO0FowlBtuUg/LNdXjnV0Qr1zcVwvicw
	 PL8cUic9mP8x9gz54q/Y9vO+ksoT3+CeHBbqrteLEDbTxzxBQsC+FunIphQumDdG64
	 UHIT2W5oicvuBArPSF8pkUf+pD4V9Q7nmdinkKkZF+qURs1XC9j0GDKDfXRLVi1Sqm
	 8Am2/1dFl/6DQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso1732104e87.2
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 02:03:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoJmLBE/amEmXaMKO5WEKeYF+xbwPeKMLexeDb/ydqHFq3VPcD8ZZ5r6CECZ1rMayJaDopWD0k+088=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdVAw0yaNuzlrY83/gXiefiwu39VEmCXyVRR8SDVpxWoVePYBp
	bURI90y8lKWJFnst/bi+3FMnQ35uH6uuvPZoA0d2JYaSwvf5Gb6p7OV9n9eYV6D9Sy7XtA+1P0Y
	FccvBZA0NemzXVXT3dYKXd6XH6MlKqhbLqpa1/OKzCg==
X-Received: by 2002:a05:6512:3b1e:b0:5b1:4c6f:92f9 with SMTP id
 2adb3069b0e04-5b2db3506camr358031e87.20.1785402231798; Thu, 30 Jul 2026
 02:03:51 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 02:03:49 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 02:03:49 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260729-pci-pwrctrl-tc956x-regmap-v1-0-20ce61a3ce12@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729-pci-pwrctrl-tc956x-regmap-v1-0-20ce61a3ce12@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 02:03:49 -0700
X-Gmail-Original-Message-ID: <CAMRc=McNXg3tVQq1JOFAzO5V91Ue_jhBQK-CbbiSXeHzgAyBNA@mail.gmail.com>
X-Gm-Features: AUfX_mxjvHEV5BkvPR1xK1IIDm_NEP7ueO8PoUliTd6b5ytUTs2cBVNu7FSuRxI
Message-ID: <CAMRc=McNXg3tVQq1JOFAzO5V91Ue_jhBQK-CbbiSXeHzgAyBNA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Rely on regmap APIs in tc9563 PCI/pwrctrl driver
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <brgl@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jul 2026 15:34:24 +0200, Lorenzo Bianconi
<lorenzo.bianconi@oss.qualcomm.com> said:
>
> ---
> Lorenzo Bianconi (2):
>       PCI/pwrctrl: tc9563: rely on regmap APIs
>       PCI/pwrctrl: tc9563: use devm-managed I2C dummy device allocation
>
>  drivers/pci/pwrctrl/Kconfig              |   1 +
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 164 +++++++++----------------------
>  2 files changed, 48 insertions(+), 117 deletions(-)
> ---
> base-commit: b9851611bad7cb227c93c1401dca48995a815d94
> change-id: 20260729-pci-pwrctrl-tc956x-regmap-91a0b5ae71f7
>
> Best regards,
> --
> Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
