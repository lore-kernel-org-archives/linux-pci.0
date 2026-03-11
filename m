Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA83A361642
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217062; cv=none; b=YtWCuTOlsnp9BsU9Fkm24sp1gHmOv4IZPUIRqetRTHzlpNzIK43xxavom/Td+9CivyQ194rVuGlx3JgZaEQsRKU2QXpcvuqm2a/dzvyX+1KYAoovBfejf+fatCyhRVmGJj9YUOMqAMOM2ce7fGvUC8J4ZljS2T8KCROHbOlvMLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217062; c=relaxed/simple;
	bh=7aVyH8gC2iAwka4GOoRBYJZUC2V8UwKcglbeRFr/hv4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DE6HVq7i5vIwAOMj6rH+w702Jm1OCREAxldcxA0F9hM/1JzLc1Xmx26dAprdYqeXIAkJXRYURUK4hKFmHPqpOpfv2No9bz1WjgoHWaoCFwxEKfHjutWBxgR9iV+dcrzPP40CiSSoPOFgXsIX6xE0TLkFNQrrAF/tyyhpVa5iuU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4WmvIdV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4WmvIdV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B60C4CEF7
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 08:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773217062;
	bh=7aVyH8gC2iAwka4GOoRBYJZUC2V8UwKcglbeRFr/hv4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=D4WmvIdV70qZooUtYD0GQAKRaPHYl3y1t2MYESRk25Ah/gC+e8nh/iguEwOuKhjQw
	 cXlSdkZYsCS7YsCDWOw6zPdURHlDkIhJ52gTRuuwhifEX9lUM2YT49cjkhTOT5kUIQ
	 kxOlkASTpHvnlKK/GMBMri/vJIbFUQiBeq0290Wb9hfoaZmsPmuffz+r2VpJwgrI6X
	 Wij85BlIT/Bkt8v6s29m1VWnOVLN/OnvBKUBRCiRVfMPw1hS/CACQVi9v6K0nGhBZy
	 Zf3uNd1Z1w9vaA8MEF0V+rYVQ+5k6//kc8SqctnN5g1l8XTBolUzwwzsI28hEKJcYh
	 R1x9+uw43BVkg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a12cc20e71so6237741e87.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 01:17:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/wJPf38XpwZcuJGc8y788TDmIk91vuUzi6TbMZVCvodwQlTeuTCjPk6/FmUKOp963pgtz5ISQ2go=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIwmfkAiJsMwsomFYihXNPlGzhRAYmOsysPrcqtz6DmquGW6EV
	omuRT7EahSztKXXy8ukqcURa3+9KdEjt+NsZj9hCdE5x2Pvq7wMtjC5x4CdSe0pSD/FF/R1WEq4
	3Iu1aomJk0MEkY9RmlU51+Vza6Eymw0IWmQfTB1+oWQ==
X-Received: by 2002:ac2:4bc1:0:b0:5a1:3447:ac38 with SMTP id
 2adb3069b0e04-5a156ba89a2mr541449e87.2.1773217060868; Wed, 11 Mar 2026
 01:17:40 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Mar 2026 01:17:39 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Mar 2026 01:17:39 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260311075223.3303497-4-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311075223.3303497-1-wenst@chromium.org> <20260311075223.3303497-4-wenst@chromium.org>
Date: Wed, 11 Mar 2026 01:17:39 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfqXmq+PcFFaCi8Abc6xDVwy41GRqATZhdpKb79iJTj5w@mail.gmail.com>
X-Gm-Features: AaiRm52ZGd8wfgNcadvnRvKWb5u5DQiXPBmMXTqNTn6MKr5B7mZiuJiWoJMteX8
Message-ID: <CAMRc=MfqXmq+PcFFaCi8Abc6xDVwy41GRqATZhdpKb79iJTj5w@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] PCI: mediatek-gen3: Move controller setup steps
 before PERST# control
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <helgaas@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Mar 2026 08:52:18 +0100, Chen-Yu Tsai <wenst@chromium.org> said:
> Setting up the translation windows and enabling MSI involve only
> configuring the controller, not the device. These can be done before the
> device is enabled.
>
> Move these steps before the existing PERST# control. This provides a
> cleaner separation of controller vs device setup. This also allows the
> later patches that split out PERST# control and add device power
> control to have cleaner teardown.
>
> This change only moves code. No functional change is expected.
>
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Link: https://lore.kernel.org/all/20260309215056.GA603013@bhelgaas/
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
