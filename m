Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF3D52B1FF;
	Wed,  9 Sep 2026 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954867; cv=none; b=M0uBQXPWSG9K0JL+fWDPBHQV3HrOO2zts7lmHLCtjGb7z/Fho/oT37iD6ReLPLZKqBvrz9gCJpwhkcph585PS24HbgIEKKynVewmFjP8Qg9ooDujBe63kyxQPWJNftKbKfj7a8NWMVlg1xzVGlYt0pQ2E5CgBzF/90Oi6Z1Lg4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954867; c=relaxed/simple;
	bh=0sSM5tGta9YKYIHJMpKBGcXZ/flhD7hOb/68yT6eR00=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NgiTo5t0hA1lYDRbS4lBdevmVedFSP6iGyxmI+ChN4A/ZToJf33RD7VLUQ9c5IiVfESN5vfxpjONbqU1nKDz0c424zyX5Ecb7L4roRvnaLescp/ILU61WjilddAN5UWfDgc0iZodSISB28+wR5/eMLCOBqaNIO/Hp5P1tMwW3bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaYnstPj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaYnstPj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A201F00A3A;
	Wed,  9 Sep 2026 11:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954866;
	bh=0sSM5tGta9YKYIHJMpKBGcXZ/flhD7hOb/68yT6eR00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HaYnstPjPhPHVf8gK4Rlu91dbrPlQdsnJEjytqf1Auxug8z3EG1GIy/aL3f3Kes+N
	 b/4odyoHOyKCM6VWvbrB0iOwQoQ73rxzT5vfCQFoqlEQR2DfphKN0igp1P3icO8aQX
	 efFpHUiyyaDG1CJjuPoNtSjPQ9thnIFNLnoPa0xjqmpyY2u/sPPJJ8K4B/h6tBCVu3
	 zVfOTTCUgRir2bgvnKEH9OAmTXwezkn60K5jkmH4nsfo1F/oSh7mk68L2FmNsnvH/z
	 jFMGw6+C0ZT0moC3bCm24/8V2yqS4c4Fr6n0f69jmreADr5pOpjvADaC9XZHHAN81k
	 zaWImeJ10wZ1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] PCI: qcom: Add CGC disable workaround for Nord
 PCIe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: robh@kernel.org, vkoul@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260909-nord-v3-3-b0a82721c547@oss.qualcomm.com>
References: <20260909-nord-v3-0-b0a82721c547@oss.qualcomm.com>
 <20260909-nord-v3-3-b0a82721c547@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 11:54:25 +0000
Message-Id: <20260909115426.17A201F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Nord requires a workaround to address a timing convergence issue in the
> PCIe power domain. To avoid the issue, set the CORE_CLK_CGC_DIS and
> AUX_PWR_DET bits in PARF_SYS_CTRL after controller initialization.
>=20
> The SLV_ACLK_CGC_DIS bit is already configured by hardware reset. This
> change adds the remaining required settings as documented in
> QCTDD11972446.
>=20
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-nord-v3-0-=
b0a82721c547@oss.qualcomm.com?part=3D3

