Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7908A2EF652
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011832; cv=none; b=q1JjELFL7gzuwFjTVbscxR5mw8JqEGN5le2BRY+bA1qaZ2ryYDTTTlv1bWG7x7mbBTDNCpsj7nkxTZ8y/VW8ib+W7hYwKuKLJkFMXJXk+8rZb7nqjzNmo8iYoHKL9SmUdocLUJptQRspuaZG4p1PEODgKXaXSk7WHgEwSAN/FuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011832; c=relaxed/simple;
	bh=tgX2ufhVZCTAL1NTg8w1yhGJAh/USfVuKSM7DBjgMR8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJfL63WvY4nLhrmYDl86iGcduR1kaKCzRxv6sqwpt3748JUO9XWyUd+eKfcRQzX2agWFtPe7fXtytG9cX6OfU7EV5Vz0xaLg1Oxqa5cbkfbP8IdcsVKiN5JUB13vor1obmVMSm0KNv1zdB+60NYO1WEcc//gp2vyeXjNuWXvXL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fowSnKKE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fowSnKKE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F0CC2BCB2
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 09:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772011832;
	bh=tgX2ufhVZCTAL1NTg8w1yhGJAh/USfVuKSM7DBjgMR8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=fowSnKKEm4fHikNKB4BabbhKAzxeXI6LGz3TkD3gtKt4g/+3t4B7kQQZy7PHFe5j3
	 tnEk54CGQINMr++1x/Am1zO4PZKaopCaB+vXli98wvnmXItckoiqtfcYB2xazSPPPJ
	 ah9HgyBkiDZHXtPferiMEb9j0yP60q6x3W/UFfC3enjUAASJfsaRZR4cNkYbY86CFt
	 MhLWragdHiz/AqrDFwfk3jeuI3TJ7cFt84QsPnRNlqyOgdKxfpFVXaZ/Lh1qq+g7zn
	 9gDGM0ykTNMeUhBpN0M5HXIbGPjfVqom6BSI9dB8eQc8jjTGMRwZ8hmTrFHbouSFdD
	 amFbz3cT5Mdlg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59dcdf60427so7520119e87.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 01:30:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWH4AkoDR7pvhoDPPOFw2ZBbRvD9DqMBVzInk9m9ZziQuY+Zw0+2ik74evoVBqU7SeTrD69qoyEVCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf9SkO1P8msRyD6becUu534YgS5XSkSfeauwAWvX3hp9B1p4Fi
	eURzQNLJkMqBrLqSe2DnsmMHfvKOydDtaaMntrPHnoFdpJ9Y8JTTgnTKfXLsf8MaCSbTNv8A0xt
	1R2wd1LztuYYESdXB7GYvt0lpmVW8oC0Yid/d4gINfQ==
X-Received: by 2002:a05:6512:3182:b0:59e:465c:3b1e with SMTP id
 2adb3069b0e04-5a0ed9ba9bemr4936252e87.41.1772011830831; Wed, 25 Feb 2026
 01:30:30 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Feb 2026 01:30:29 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Feb 2026 01:30:29 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260225072225.3345307-6-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225072225.3345307-1-wenst@chromium.org> <20260225072225.3345307-6-wenst@chromium.org>
Date: Wed, 25 Feb 2026 01:30:29 -0800
X-Gmail-Original-Message-ID: <CAMRc=MehRxdoip8++NfwU_WEJ+yYuC1=2BRv8Ry9VytU=YvR=Q@mail.gmail.com>
X-Gm-Features: AaiRm51bPAVR6-cFrrbBYu5wRc1Q4V_S6sKtepwE42bww4kXXIDbH_qqtlNCRK8
Message-ID: <CAMRc=MehRxdoip8++NfwU_WEJ+yYuC1=2BRv8Ry9VytU=YvR=Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] PCI: mediatek-gen3: Integrate new pwrctrl API
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang <jianjun.wang@mediatek.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Feb 2026 08:22:22 +0100, Chen-Yu Tsai <wenst@chromium.org> said:
> With the new PCI pwrctrl API and PCI slot binding and power drivers, we
> now have a way to describe and power up WiFi/BT adapters connected
> through a PCIe or M.2 slot, or exploded onto the mainboard itself.
>
> Integrate the PCI pwrctrl API into the PCIe driver, so that power is
> properly enabled before PCIe link training is done, allowing the
> card to successfully be detected.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Thanks, looks small and sweet.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
