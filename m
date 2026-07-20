Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B183D0938
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537846; cv=none; b=SSgB+Z7ojKQuenVWQY0f7o8/727JtifqAfACTS1zzyA6g6xgvhSr6nNV6UO6qfSHSKAqfYIRMHl/ouj+JG882PowzW/1q8CuVqXZ4WeIhzVXg+KBztPDqnfRdo5JLUZYSOqbrnkxf48tsIf5XDtC8+tmOW5d7BVPeVgJk5/65bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537846; c=relaxed/simple;
	bh=NZ02+BQAqzNHY4SwvwZ4UamduKQUNaBA0/dG4qHPQns=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWZS4RH0t5lpJNIwX6ue12G0XAETTZkTn85BP3wGLZ33YCuc2MqrkCcqujsu6LFEJQdYBI4fdyBNue3gbwg3TLGcg9eKd55uUv6uiPSwWLWQy+BPA5znglK7pvciobhHDNmi/kfbRVSaNB/KR5fmzKXxbGChVZe8eovEC8ntl4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULm43OCm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULm43OCm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5641F01559
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 08:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784537845;
	bh=NZ02+BQAqzNHY4SwvwZ4UamduKQUNaBA0/dG4qHPQns=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=ULm43OCm/frGFDpDD1nQWeMvj35UtZX6rJbqiSgNNtfmYglNhG7pvNk+HTf9m4UEX
	 9HMrxsmoz4yOViWJloXAZolERWG5ccssxYEhJSg7R2jxtdEjahIrMSW2/NjAn3Rvl7
	 xltV+OWahVYmqQT1V+Ueil0vbPxrcIdA2m7P2PHSfFUMNq7vwUIqkUz9cwaufPevH5
	 Q8vP+lMVR2zAhYQYJTYk35vK3PMY+1WeaWBTGykl7Rmj2W6AlflxNU2JMIwUpCMtaJ
	 9NswRBi/G3cEFIx0U9LrgsEx2STu62GnaLSrFjCSE1exEyZzYdRdwoKq/QQdjnXwqq
	 idRDZpg4kHxNA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39b3931e259so87432591fa.2
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 01:57:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YxQzETYbcOodAHOyezFPDTa8dsGqZ+cuApe98kKnrqeFvGGx4pu
	icbzKORVwZSkLyaeO9MnrE1hgJZonEVDAU/YJpHA49TxnoKxyF5UjfhSDtGUjnv7AyInFs+56WL
	duAhyfmXJsbD74uLtslFc2yjBx2vkdCRqYwcr/T7d9Q==
X-Received: by 2002:a2e:3c07:0:b0:39c:92b8:dd99 with SMTP id
 38308e7fff4ca-39eb28000a8mr19914901fa.16.1784537843808; Mon, 20 Jul 2026
 01:57:23 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jul 2026 01:57:21 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jul 2026 01:57:21 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260720-monza-wireless-v5-6-69ec6743543c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com> <20260720-monza-wireless-v5-6-69ec6743543c@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 01:57:21 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeyAm80LyBNu276eizP=2oTVpM4VYNKm7rjYmLQkud-QA@mail.gmail.com>
X-Gm-Features: AUfX_mwdChPxhMGn2U7SGE7eh8292Q9AF9MLuZJY7v1GTzSFRbD0b7SBWOQKzaA
Message-ID: <CAMRc=MeyAm80LyBNu276eizP=2oTVpM4VYNKm7rjYmLQkud-QA@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] Bluetooth: hci_qca: Set 'bt_en_available' based
 on pwrseq power controllability
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

On Mon, 20 Jul 2026 10:04:08 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> A Bluetooth device only needs the non-persistent setup if the host can
> gate its power, so that it is actually reset on the next power-on. When the
> power is controlled by a power sequencer, whether the host can gate it
> depends on the hardware wiring, e.g. the presence of the BT_EN or
> W_DISABLE2# line.
>
> Query the generic pwrseq_is_controllable() helper whenever the BT power
> comes from a sequencer, regardless of which provider it is (M2, WCN, ...).
> If the power is not controllable, clear 'bt_en_available' so that
> HCI_QUIRK_NON_PERSISTENT_SETUP is not set.
>
> This is based on Manivannan's original patch that keyed the decision off
> the W_DISABLE2# device tree property, it now uses the generic pwrseq helper
> and handles the always-on case.
>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
