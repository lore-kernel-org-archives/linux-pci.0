Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F702D2382
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771601105; cv=none; b=h17mmhOOzabTPpJzAClk1O5bgvgmbTFGane/wGMsKFQA6elJeLBvMps99bnpW8dWDsqF7gXrBwwxPYHoiCcwpFthnSSRY1ygftJ3eJL7zsRfePLmJ0e59uxNTKJxjdvlbOvaFF2yVXkx2GhPKklJAR+5wdvMyAUHDThefX9H17U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771601105; c=relaxed/simple;
	bh=lKVxjqNxF857pAdRUQYqyfaci6ru2qb/KBUUw7NA2lM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOr0bdH9PBesamRptES/xfkpOaEe5Jvsoxd8Jy6anaHyjomTxwd+M8cOcgcVXxkHL/lq2kibGHhfzmUXDyfMxe6MyIE5xo27HSn/mE8cuvBGP2DQZm2pQqr7qAZnz+ug3M9oh+a+FPvHYQ+JDEf5mHb1JeskVhsklv0anvSqOTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWfoKbps; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWfoKbps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A88C2BC86
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 15:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771601105;
	bh=lKVxjqNxF857pAdRUQYqyfaci6ru2qb/KBUUw7NA2lM=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=pWfoKbpsXan5D/t3nFJaa0vDMqgj4sAtyDMS/0ulQ0jye0eYCQ4aKNDvSq0Py8D76
	 qsUuQggJ+7YA6rX56BsvSBM2uM5fSyGsnYahPujNnWv5sRqmWjvcEgVOVyLzpesu3B
	 JJTzqh6fEs6TnIQFfPRc5EsG7W8QbcsgOBzyUnwKh2hLRlP2uC/ZK461yJe1lyukor
	 xddrZs86oQfWjztM6rhcusQqLmK9ZIDccqZGWJGeEAn3HIBt9oWAWz+XfAYX3EQDle
	 isTGu4JVq0KheCVyC7wI0vvwiiLoUTnaIrJSMGoHSXm56f6EtYNU3K19UWccLfi4gX
	 k/RlkEjEjO8dg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38704f70ea3so19938581fa.2
        for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 07:25:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4qJiASKx+nP6ODIBUywjQClVh+zpe0tdhyNyN+bGLGw35gYXchZc7PbiUtpt03d4Aj12mWXJn9I8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkVUqbDEESB28wfytavWOwZXw4Aa7YSnJEQcYXiWeCZ612g6mD
	ch9lpbOqaLbB9U+6MMSIVAkTJNt1S0iPEO4/zmRvPr2ro+5V3D5I9F5AbUq9cdAyI86QHas3NWX
	eRmUiddtLtyUQFIIUquvPUMs6Cw8e4v4SIddRPQvXIg==
X-Received: by 2002:a05:651c:198c:b0:385:dd91:a6ce with SMTP id
 38308e7fff4ca-389a5c4c7a0mr483661fa.38.1771601104331; Fri, 20 Feb 2026
 07:25:04 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Feb 2026 07:25:02 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Feb 2026 07:25:02 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-9-1ad79caa1efa@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-0-1ad79caa1efa@linaro.org>
 <20260220-topic-sm8650-ayaneo-pocket-s2-base-v5-9-1ad79caa1efa@linaro.org>
Date: Fri, 20 Feb 2026 07:25:02 -0800
X-Gmail-Original-Message-ID: <CAMRc=Md1xjJNFdL5nxYwxNwvbOXkUWC8U=T+EzrRsBX0FBKL6A@mail.gmail.com>
X-Gm-Features: AaiRm51Nhl9KxWCs3gI3CqS9MKsh2wHc0CQSKdKPuOuRAl0wbHi5oLezOZ6XOMI
Message-ID: <CAMRc=Md1xjJNFdL5nxYwxNwvbOXkUWC8U=T+EzrRsBX0FBKL6A@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] arm64: dts: qcom: add basic devicetree for Ayaneo
 Pocket S2 gaming console
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	KancyJoe <kancy2333@outlook.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Feb 2026 16:04:48 +0100, Neil Armstrong
<neil.armstrong@linaro.org> said:
> From: KancyJoe <kancy2333@outlook.com>
>
> Add initial Device Tree for the Ayaneo Pocket S2 gaming console based
> on the Qualcomm Snapdragon 8 Gen 3 platform.
>
> The design is similar to a phone without the modem, the game control
> is handled via a standalone controller connected to a PCIe USB
> controller.
>
> Display panel support will be added in a second time.
>
> Signed-off-by: KancyJoe <kancy2333@outlook.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
