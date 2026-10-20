Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792490442;
	b=l0118ujWBPS4kp7F1SUN/zs8RRwA6FcfBasbkwB8TLk4zH31+D7xy8+w2sQHijRugipO
	 03MWWk5c7veJ65a2Ho7K4PrxsOXiNGXn86Ha/NASoZZPzmSE3E58nG2cDZaeWeFKCMiYY
	 A09pFPb2aLBGzX1p1J2jRXBg7HEnq1vJWLBGj5Py9EaNLJpoSTuLfk+acLVJbZMZk3Och
	 067/Nqs+JvbSO/d1AiPen9dqqM+25bYEQCqD2I1iZruQcydrc3YRTLDHPNqwGGGEqji8t
	 d/gKoQjDjXIBltZ+x9CCstoTq0Vmauj2QwoAtiD3eZlaOjmr9TAs6nNOLbyKbNix0WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490442;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BFOH8qwBmea4L7DqzGq1FXshWs48fm52hLJ/JmLrc6s=;
	b=G/mfjRXfWefSgcVMfr5OyarWLFsP0Eohs9jKzaNY+1yQtaCKfHm1NC5MJEoHKxJSoIWj
	 S8ZEIg+o8D1bGVloSjKFZwKZ81mhZZunmZxlU8FbA+mKv5mKDgK9nr+Ve0BqsShnhB1eF
	 O5/5yLtSenPkYJOO0zvQI32dXezDkev9Laqn6lTDIO+xdx85L6Qx6jJyVp1Fd8uzi3O3X
	 MMIfEqZzDW/6ts6ncoD3drMUnqaExdG3O526Is4YeISI8aPL9VJ9INYSLwaAkzzyiukRw
	 BmNhCH0AcwAaBhpc7jeEddyo4r4S9pzzlFQM4hKrbXAzXxbdniDi5I4fk+WmQYBm8nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGWPrI0F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672EF606A31A
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 10:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGWPrI0F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEAC1F000C4;
	Tue, 20 Oct 2026 10:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792490442;
	bh=BFOH8qwBmea4L7DqzGq1FXshWs48fm52hLJ/JmLrc6s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LGWPrI0FD/H+cKeOIhQ1cl1GoYwPcb6lh4VQ+jWxh5zCRmPUUeGQNoVdsBQHfw612
	 MILD8YS6jQqI0ve1HOHYvx8Q8mpn39qcnyWaF2aScMYyZnG6kxS355FHTs2UPv6stX
	 5cc56UkBXvvWB8Z2PcW8VGdEX0XeV8XIVcSHHP85ALxicHPI0yHDDhJgXMvAetvDdC
	 pDY4M1dYqyfqRp5BMHdmu6wJZfUV6HW4AEnHacx7AXmnZwh938wX8aWfvOVFooey5p
	 1inIyZStxyIYGsTuAKt5CqdE6WFDtdRlg1azkLFAEfv+omL1lYv5Mzd3ylYWL7KAa3
	 70AdqW++6KIjA==
Message-ID: <sashiko-outbox-178784@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/17] arm64: dts: renesas: r8a779h0: Describe the
 PCIe AER interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020031049.969895-18-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-18-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 10:00:41 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The PCIe controller reports Root Port AER notifications through SPI 454,
> separately from the integrated MSI receiver interrupt. Describe this
> interrupt with the "aer" name so the controller driver can use it for
> Root Port error reporting.
>=20
> Append the new interrupt to preserve the existing interrupt indices.
>=20
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020031049.9698=
95-1-den@valinux.co.jp?part=3D17

