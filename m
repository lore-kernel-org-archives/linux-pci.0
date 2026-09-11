Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6187244F557
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113164; cv=none; b=siZIKqTtm9euz/7xH/Yt9QtUdBqmuNQjNDIX5o9g5JLNg7aXlvr7oA4kYKIVpzJ4AdB2sQCC8YbTzHfJcy+ftjlK0O1xyer5xHCO+/sevtA6tOCJY3jg9JFbZRc94cEjFk1JkcfZ7cw7At0Vtv+cB04AZdsHpNLVeWzteaPGjNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113164; c=relaxed/simple;
	bh=mAy/mjo9ky8p0zKdUD9C54wYiJlR2G9xib1258FjWlg=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KRAE4+b5JEtISBmUal3M2M9LSTHWwjemq/HOGQgHZjIWt4DJwiShC88+ZUrgyacy2g+OuxpI013/xay1wyQrQ0G2iDVPFuegsPMFpb1+Dhi6UUQGGbDKbnz54RN3HuYeLIoFFc27QeBr+1/7tEezW1HNKtqMcPRIyaP4bH+KNjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBCejXNQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBCejXNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B3E1F0089E
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 07:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789113163;
	bh=mAy/mjo9ky8p0zKdUD9C54wYiJlR2G9xib1258FjWlg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=nBCejXNQsWQR/kbP8ofYrcVfv2aqnR/3tYIIQUNpPeUU/OvtlVDSgmWDJN8kto6zT
	 WjZ7krJVZ75zGCFIpW1Sn03CQhjNWofZQyPD7gvktU7uNfWxymEyLEu4lrwtm5fclM
	 pCpsZM+7a4Hw7C2c4JhTqEDh4s50/Z1V99+0m1tVOFgytvKNW6uLLAinunCFH7QxWt
	 qZINxZfKBI4bD84Qm6jzD8TkEDuXYWMOY2rcSsKIJMS+bRGvsxVIUhPjN8M2CEZxV2
	 DNyJwOF4FWXsAfAX8YuBfhkvM7s3UXYq7qpmOwJ001w5/HVHv7wEp64Zt7VCFhiZ6m
	 6B69oVXtJzFDQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b568dae0e8so624078e87.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 00:52:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxZc5rYVcM067i3qkyTa3GbEhrRxRlUXgURCNQ0epgQIpKurpZrM7mATVOrcVLM3uk1xp+YCQyOA6Y=@vger.kernel.org
X-Gm-Message-State: AFuF++mVolSG2kSH8jMvMjNP5yaLrVLJZExxwuiEPinBWb7qowP5hZI6
	DDd+0NmmWxGxYHpPLwYrw6C9PNy2L0iy37pzPJWYT9MeKQengoTd5lPUlKM5SZNLWhzekAR9yMb
	nq6ltVj8aPNO0e2+/c+g9hPxWwOgonZUAQM/D+H6FwQ==
X-Received: by 2002:a05:651c:43c4:20b0:3a3:7682:49a7 with SMTP id
 38308e7fff4ca-3a5a5291cf0mr2127591fa.28.1789113161739; Fri, 11 Sep 2026
 00:52:41 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Sep 2026 00:52:40 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Sep 2026 00:52:40 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260831-shikra-upstream-v2-4-406661d75afa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com> <20260831-shikra-upstream-v2-4-406661d75afa@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 00:52:40 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mf=s2Q8z165ufJjj70TZPv7TFFF3b8QaTh1Uiz4r-64Og@mail.gmail.com>
X-Gm-Features: AcwNN1WYfbMG0innksiJiNzSA1WdoA4NxNphoNZxr1Iyd160wvFBkOcClMlPLKs
Message-ID: <CAMRc=Mf=s2Q8z165ufJjj70TZPv7TFFF3b8QaTh1Uiz4r-64Og@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] phy: qcom: qmp-pcie: Add QMP PCIe PHY support for Shikra
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Aug 2026 09:26:04 +0200, Sushrut Shree Trivedi
<sushrut.trivedi@oss.qualcomm.com> said:
> Add QMP PCIe PHY Gen2x1 support.
>
> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
