Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E433115AF
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 08:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772007554; cv=none; b=Qa54wHOW/14AStjbu1xoNPo6L4sqIovODpO5WCZg91m73DVLhU+OmfMrwEUV60pISpsSoyed6aJcneN0N0/BbZWbb0A4xiCWxVsPLL7MfZpC3tOThxKMOhLRjUHqX/ANDZvCBe36QWl4wRiY3P2ZZmWVAahtcCgYQcKNP27NqQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772007554; c=relaxed/simple;
	bh=i767YM81rg16oZZHvqRpOQjd5YhsJg23jCgSi88ETAE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5neqAln8t/BbNeTc6CXuT0tAOM2dHRVlhNXG1cszRBWBBdD+I2gSeMDpEygjl79CJF7DNPKuFkJ0g9e1tfP9zYa1uwylqzwzO85tFuNrBTvEffTttByNgIRsS8u3mEsg4xEQo9e++ypxVBsPfWyh7kZWJg0m2KpdGLiD0+VCNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PE/031w3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PE/031w3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF213C2BCB3
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 08:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772007554;
	bh=i767YM81rg16oZZHvqRpOQjd5YhsJg23jCgSi88ETAE=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=PE/031w3TCmHk2/ZTjXByk1qeS6I3FasFWDv2s2MOAWENiJn6ix1wQl/t6CPZhNyf
	 VenoA9RjuJ7H8AJ3ADE8Pl8Bc/ZLdxN/u2oxOxtMg9rSV1ZMFx0GQKD9CoRqmpVmXY
	 G+aIA3bC8PN6wIUOL3nQXBjvAyi6U8srufTTu3HkFn6fJZFnxlaHFUxNm7XowTdl7z
	 qSG5/hHIMpZDTDrxxCeuFZrnjwhCYnyhsSwBZ49VCJ2r5GDbuTEutiRNLNDqHxfq8z
	 0eVAq5TfVdjGvPAcm0tjoEeswn7HRyQ1ARkQH7aFnUMO1Php1VQfcmkoIh1vHQ60WC
	 QxULt71pjeQkw==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3871a08189aso53954821fa.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 00:19:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRrwKS6ewHewTqPZfiXd3wecRCQx0ChkbxN18oGQzrGriXU7r006+wm44Shis9s84tGQUk9ZIJzr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwvZiE4MgKSH+3B798DzZbn6UNfIf9K78LEeibgRCfrCLO8dDj
	qN+27qPofYNbAHdaZb2Kmn5CAMitj2rqjH4XVX4btLAyo2phR7iVu48Pp5Mgo7mLJsTXL2sip9h
	G0ajyi1pQrhYXSq0GCt/axIyVBI8VnmEkFDoQs+rK+A==
X-Received: by 2002:a05:6512:1252:b0:59f:8993:df7d with SMTP id
 2adb3069b0e04-5a0ed8a2429mr4956665e87.26.1772007552569; Wed, 25 Feb 2026
 00:19:12 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Feb 2026 00:19:10 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Feb 2026 00:19:10 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260225072225.3345307-3-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225072225.3345307-1-wenst@chromium.org> <20260225072225.3345307-3-wenst@chromium.org>
Date: Wed, 25 Feb 2026 00:19:10 -0800
X-Gmail-Original-Message-ID: <CAMRc=MefvP2bxdGqhw+Sn_MDqVcA2fPefCBygP=ZdFLnkPcHUA@mail.gmail.com>
X-Gm-Features: AaiRm52W52XmwIgwxtOACerr-UA7gcczLgZWX36auM-UC97DyKrwy0k9pm1Y2nk
Message-ID: <CAMRc=MefvP2bxdGqhw+Sn_MDqVcA2fPefCBygP=ZdFLnkPcHUA@mail.gmail.com>
Subject: Re: [PATCH 2/7] PCI: mediatek-gen3: Add error path for probe and
 resume driver callbacks
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

On Wed, 25 Feb 2026 08:22:19 +0100, Chen-Yu Tsai <wenst@chromium.org> said:
> The probe and resume callbacks currently do teardown in the conditional
> block directly. This is going to get ugly when the pwrctrl calls are
> added.
>
> Move the teardown to proper error cleanup paths.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
