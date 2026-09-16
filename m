Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9304EE873
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562716; cv=none; b=lLfwQgiTxkHCrXOQtjgUxNQ9SMEB0TgINRpe83GWbgssPx4HlmLM8ARuFvjoP9jTvOlur10Qy86cfOlEb9iJg9ZCdDJ6rX6B+MHmqXWZr3UvJtKI63nCs/hi7UFTJ46cXEx1YDpctR+rQK+ihpxiimqougLgVcPappAzI+VqQfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562716; c=relaxed/simple;
	bh=eb7iXZP92U+EwXgtjBRQPHDjoxuEPDz1gjyS7C+KhOE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LlC5P8D/NvvFmEDqyBSlPdGLQde9mFjMy5zrcj00BG9zog+YIpiXuevalpAhdMe09MfWmqpKnuw2JXcgwpwISyUGZTEzp0/czxn+FEs/FSs6E2DvJ8JKwy1PJn9NBopQ1IJ9io+dBhaBQ3PdTOHFsr+BL4Tb5RVpkcp5PqB5t9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uph+o4YA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uph+o4YA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD8A1F000FF;
	Wed, 16 Sep 2026 12:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789562713;
	bh=eb7iXZP92U+EwXgtjBRQPHDjoxuEPDz1gjyS7C+KhOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uph+o4YAX0bRoP3M78LCZAFzzOmRnemVV1daQlPlb3ntpthlPaTI7K0XrZaQA5nnI
	 T5UGLhHNGi/ZZSRm9UR4gEdDbUdMqJo/h3ZaY7klZosxoVeo4R3xiQp7zdCgvFnvWL
	 mbm1EYu0Da7oL4b1NlRwExMU/FyvfyU/0lMloZhwgv2R1Ps421iK8KZxgECKrzbaOO
	 vE4QIPy5+z+lCH9ghsFFdrKTOKNd9SCg3H0z54I2ja9lsLlQLVzleWcuXgutH/VQ35
	 xsPSAi47AixN7tc3Gw73oLxV040+jrk5CtIUicOa3rQPc1z1Io8JHN1Escjt3RWZsU
	 jymZ9ngviCc2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: qcom: Ignore -ENODEV after Root Port reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260916-topic-pcie_portrec_enodev-v1-1-5dc7bde39552@oss.qualcomm.com>
References: <20260916-topic-pcie_portrec_enodev-v1-1-5dc7bde39552@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:45:13 +0000
Message-Id: <20260916124513.BBD8A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Root Port recovery may race with a device hot-unplug. In that case,
> dw_pcie_wait_for_link() returns -ENODEV because no device is detected
> after the controller has been successfully reset.
>=20
> This is a valid outcome and should not cause Root Port recovery to
> fail. Ignore -ENODEV while continuing to propagate other link-training
> errors.
>=20
> Assisted-by: LLM
> Fixes: 4d88cb82a6d9 ("PCI: qcom: Implement .reset_root_port() and use for=
 link down")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-topic-pcie=
_portrec_enodev-v1-1-5dc7bde39552@oss.qualcomm.com?part=3D1

