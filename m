Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867906;
	b=AfW9XxVPZl3lLvy+XYnJ/jvhOHyvt6drrUqsXKBOzNiuJ7U+wU0kBOx5w+C4X/MB4Q6U
	 yHGl2koUA2ggTIzRQkwCbQTCXV/e70r512CMC/8/UKMYpd6efY4dPjfw9MqDFV/6gYT8q
	 wKrBtkIfdUSncQkdVR/cnhQyeRO+Zw6tIETpBmHpb6d+bwiunlOsP9Dt/2o5vOW6VYLCD
	 CtNmx9iI9PObtcV2Keq7EyTh83vN1FNKrFzmhe0QqCOQkWjrFlzk2lnwT0E7+Ilf+RNt0
	 RMCYWhq7torwSKcfGtkPk6IxZLnKDnELq21veyEQbB641sFgKBdyzIlzSkLHajZ7QXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867906;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/q6GA8Mi1h3a4gNr6nQ6CQcT/8xUsKb6F2pImEUA834=;
	b=vdOgeU7kZ43KWyZADLvpMPeK40NNHxLA+3noBqaWqbNLGKFTmMJJOGDtg3983S0N7EiF
	 G8BZ7Mi9m1z3wfTkEqZ7YDlMovoxWl7LymZNvLoTncJUhir1R5TuwRYVXjmbcAfWK5wzw
	 IPM1wIePYzwON92fKbtnrCBZvGp77fJGlwDBCYpQvwn2ty1pjxriGUZJ4xs+vQc9F0UG1
	 kmQQqpky6F9r7yp+Cp0nPxgXA0XNi/bx4Hp8xawPKsliqVEHCow5qUGzh1hpMu34gp+jv
	 OM4MOdWl5DcG0gKofM3/5iC/n3YGMqtlTkH7PbcRykD2CdkcQmYCENRD8cylLaq3uIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFJh0M7v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83285606A329
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFJh0M7v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3521F000C1;
	Thu,  5 Nov 2026 08:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793867906;
	bh=/q6GA8Mi1h3a4gNr6nQ6CQcT/8xUsKb6F2pImEUA834=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mFJh0M7va1CgH/NebbsD887GT0OyT9a4aHwiehSBK8PzfAPy5fQ/jxZl7mX8kEEyz
	 1y0YHglel4pbgkgp8vM3QMsL2d3MYN7FfkAhKh4UcqrUbrUr0yOF+MWnpPDhu3EdES
	 xBhY33E7fZGs5Ee1ikNGEvXwRO+rzoT84EsTSXN0WqarzYIdFtjYKTSYtSAjfHubwK
	 XvMpaURyrAEFM7z0p8VOQGQGjH+m13lf06UHNJASi/GLKT2duZuFWMhuzU/jom0cH3
	 adn3X/CFNF8GTgneqn8y1Nrt9x7duLMQNnVPpbnZijI751XOUeG/2zKGgtUBoZTvdb
	 vDI+SEk3eyKPg==
Message-ID: <sashiko-outbox-198730@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] power: sequencing: pcie-m2: fix use-after-free
 in pwrseq_pcie_m2_vregs_enable()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-pwrseq-pcie-m2-uaf-v2-1-3e1dd415af9a@oss.qualcomm.com>
References: <20261105-pwrseq-pcie-m2-uaf-v2-0-3e1dd415af9a@oss.qualcomm.com>
 <20261105-pwrseq-pcie-m2-uaf-v2-1-3e1dd415af9a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 08:38:25 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> During device teardown or on the probe error path, a concurrent consumer
> access triggers a use-after-free in pwrseq_pcie_m2_vregs_enable() or
> pwrseq_pcie_m2_vregs_disable() due to a lifetime inversion between
> devm-managed device registration and manual resource cleanup.
>=20
> The driver exposes the power sequencer using devm_pwrseq_device_register(=
),
> meaning the device remains fully registered and accessible on the
> pwrseq_bus until the driver core schedules devm_pwrseq_device_unregister()
> to run after pwrseq_pcie_m2_remove() returns. However, the driver performs
> manual resource teardown within pwrseq_pcie_m2_remove() and the
> pwrseq_pcie_m2_probe() error path, prematurely destroying the backing
> regulator array.
>=20
> This creates a narrow vulnerability window where the globally visible pow=
er
> sequencer is backed by freed memory. If a concurrent consumer invokes
> pwrseq_enable() during this window, execution is routed to the sequencer
> callback and dereferences the destroyed ctx->regs array, resulting in a
> direct use-after-free and a kernel crash.
>=20
> Schedule a devres action for freeing the memory used for the regulator
> array to ensure it runs *after* the pwrseq provider was unregistered.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 3f736aecbdc8 ("power: sequencing: pcie-m2: Create serdev device fo=
r WCN7850 bluetooth")
> Closes: https://sashiko.dev/#/bug/linux-bd17e5b1-a000-4717-b392-0ff0c2a9c=
376
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-pwrseq-pci=
e-m2-uaf-v2-0-3e1dd415af9a@oss.qualcomm.com?part=3D1

