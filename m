Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3AA47A879
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627428; cv=none; b=CcbkwiyHhmygwo+ZBPQyNKkBNqCyGmx0v9SPJSw7NTuH+m6V4EoNecD/NsDdktYmHqQAWnmQr4QbcKJJoheU2Vpt2obE4o3mOUvaNpFZdoL9obLUMf+yrmhpu4i5I6q1PReo2wq8iZ15NxJcmc8V+oSkaE39y728xhMsjuGG1D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627428; c=relaxed/simple;
	bh=OEyzqY1ehWdK4EpMuKknlyHXg5Txx69Ju077+bEeRNA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k31xYkbw54JIyidyOTV90YThdrJrAjSMq9OzAUyAgqNdH/0Z95O/ocn4nn3VZwOXt8KoOAxHMHNmrf4+NVfIPCPq+wPO9iXMSduTyufFoXaIjPyMkG6lHaLsfwHyInrO0P1DXgGmExdpetVzTxmKdx7Py2zJwyvofMtpvvj+Pnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCY/B7d2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCY/B7d2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969181F00ADF
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 13:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786627425;
	bh=OEyzqY1ehWdK4EpMuKknlyHXg5Txx69Ju077+bEeRNA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=mCY/B7d2EVA7uya/uFwelIwP0X0tP0Mf2IGzL5AGHE4pivNrIVFnmXngvxGiTnXoO
	 zaBKGzTAHT2z666GhuGiVBkI35y2tiWosVoebvtsBSWMDg7L2p8ZShZSaV2o5EtFpr
	 xciyo7Ztx+/lT0XCurJFdRDBdyfvKnJWzPHKTZM5TLABM8Wh2WzIW+b/55mZL64g1m
	 wdiHuOJdCAf0PJAiPovK1kfdJDTUEmi+ZWH+w/DyfofuKQUlQu18Gf52Vo2BtBKP5V
	 3RRQ4EilG+uTjNnFe6WIVhRItgR8BQGcqGrX2bR9LbW9zBjJpMbyGGQevBAdDFRNrz
	 B1wRWBmKa6PTQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39faaf1efd3so15479191fa.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 06:23:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YzWCeYnDxabe5UVw2I6X/8WuinBUDNXM3b1/WiJgLTeX58cBV7K
	Y/VdZ5zKoa2K40AbxQNw5+0TWpTLPBR0/o6m0XBBxnyAykzB1aKLJtfRlmEsGU3kDUhlE6WA7jG
	dfzVdc0GgmEB37GOXouKOw8Nc3fRskbyrVG3YR+d5Lg==
X-Received: by 2002:a05:651c:b07:b0:3a1:2b72:b992 with SMTP id
 38308e7fff4ca-3a12b72ba9fmr1886351fa.23.1786627424290; Thu, 13 Aug 2026
 06:23:44 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 06:23:43 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 06:23:43 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260720-monza-wireless-v5-3-69ec6743543c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com> <20260720-monza-wireless-v5-3-69ec6743543c@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 06:23:43 -0700
X-Gmail-Original-Message-ID: <CAMRc=Md6dL8uggf8OJH=tNzCewh7N0AVdVEs5qQreRM3GvcNng@mail.gmail.com>
X-Gm-Features: AUfX_mx61ZVP34DETlpjsRwYgr3TOISCyOvMoQJeDq10_4_GoxNP6u95XH3-RVQ
Message-ID: <CAMRc=Md6dL8uggf8OJH=tNzCewh7N0AVdVEs5qQreRM3GvcNng@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] power: sequencing: Add pwrseq_is_controllable() API
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

On Mon, 20 Jul 2026 10:04:05 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> On some boards a power sequencing target has no host-controllable enable
> for its function, for instance when the enable line is not wired up to a
> GPIO and is hardwired to an always-on level. The pcie-m2 "uart" target is
> one such example: when the M.2 connector does not route the W_DISABLE2#
> signal to a host GPIO, its enable/disable are no-ops and the consumer
> cannot gate the Bluetooth function at all or exclusively.
>
> Add a generic pwrseq_is_controllable() helper. It reports whether the
> target's final unit provides a host-controllable dedicated power actuator.
> The target can implement a new optional is_controllable() callback,
> reporting whether that actuator is effective on this target (for example
> depending on GPIO presence). If the target does not provide the callback,
> it is assumed to be controllable.
>
> Note this only describes the target's own enable actuator. It does not
> imply that a power-off reaches an electrical OFF state, since a target may
> have multiple consumers. It also does not mean that power is uncontrolled
> for the target's dependencies: those may still be gated on their own. And
> it does not restrict consumers from calling pwrseq_power_off() either,
> which remains valid to drop this consumer's vote on the (possibly shared)
> resources and dependencies of the target.
>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

I don't think it'll make v7.3 but:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
