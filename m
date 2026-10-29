Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268984;
	b=jCP+B9SrDdIaxoYHcaQStQpCpbsV4OqqXW6Uowd/+aeQ4OZyD2N1gFFg/gRLcTZCpGSq
	 F/irij41Uoj1xd96pfhlUmLeFdgH6UXYIE/voJ9TKBuv1HloMjgkPhdBmor2Qdm5/Qc3h
	 vWtJH01eL0BL3w2A1EyS+5MI6qbSGFxLp7TrnLQs+JPZR3hY6GBVp2DxbJ69FFLWGoC5d
	 CZxRxNjLRY53OqePGOXA23CWN2f6Ffof599j2ZoNTeLRtwcOtPhZFrdBJDEAaIYi4Cqe5
	 mO/r14Y3fsLZZ9nKWfc1FXZ7D71NUgFJ21QHbK0a71ns9s9PA265a3J576wWfCdShMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268984;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TfpwmoqDnkCqRX32XScUXH3MbNJTYj3ZhIeP2zbOTY4=;
	b=cTkCNIEN+2NLKLyytA7OZK5UL8jWVFHyQ1XpgbCOlF4gHIPkuiPP8+CB24ola8YXUk9Z
	 F1jYWa91SVrO++aaQYC2n9O1psFrh3BmBg22jM1JRTioD1bxXbatWPRfUCMbpgqtBB+Fx
	 XnivqNiYo2+TrCm7krNvVtRX/CgNIpaYBWbY6j2PeiazEV8sG7dEpk9NMhNbg8PY25USA
	 RRE+vKKPcUtvIV++a+A/HSTgqKtW8ozHLmqGl44ul2LzPDthJo/UbBOGKEBcHxpbG06Fg
	 IZpVauyBQ525s92sgK1h7vcAZZfaATQS3WI9vmymc44Y8KqNNYoePht61b4Rf1pCW+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vz8V08gK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24417606A326
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vz8V08gK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F0B1F01828;
	Thu, 29 Oct 2026 10:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793268983;
	bh=TfpwmoqDnkCqRX32XScUXH3MbNJTYj3ZhIeP2zbOTY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vz8V08gKbBqDz8T7ZVRBM1X+wkFsH5f103nqg4QmNsE9bL/WhydhxZTso+bLLBAC8
	 poeOHZQ7RiUC8uiYnO8apcqDB5Q0anzEcBTTU4rpzCBBQxlH8cOMyUTW0jmn2swpM9
	 pjkT/DofiCaVP3Xc0TwBQOdzb/EJyYkNYNrgb5i+tRGmjdO9NVImXs6ibfEuC1byKg
	 TEDXp+5T4zulDlbN8u+8CPKarCHP871RfgYt3pHHMeJ5F9SVpN5/7rmQikgZ5K272C
	 tSXUnwlE0CWLUTChN1cCCpoqSTSC0tLJdPdTFHP+aIk0iGFBDagqYnfUlb2L0MNHOW
	 +tLx+Jwef91lA==
Message-ID: <sashiko-outbox-189107@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: arm: qcom: document Radxa Dragon
 Q8B
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xilin Wu" <sophon@radxa.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029-q8b-dts-v4-2-e8e7438f5545@radxa.com>
References: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com>
 <20261029-q8b-dts-v4-2-e8e7438f5545@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 10:16:23 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
> SC8280XP platform.
>=20
> Document its radxa,dragon-q8b compatible.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-q8b-dts-v4=
-0-e8e7438f5545@radxa.com?part=3D2

