Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94F63E5A38
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 06:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539071; cv=none; b=cMQpC+Hw1WyQefWiQbHd4tLfVUkkl835Qyny8OP6FQgUggEbK8KY6jSwVcZm0hxIS2I1cWuACnCj32OtqhbzEFNg9g0jpLtvMJD/9LosKCDdJy/2OL3m03ev6ds44+ejg/UIRgCnPjWxRyszeMKDYyAsUU5zr6oK8ytyZx4YZZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539071; c=relaxed/simple;
	bh=NCLyW2U7Cg7iRtEr6A2o9YjBvnZgZgctra/PFVpckUA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SiurV1TEfhmUaIS+vW3sre4cnlX8aLII2rjw9gKUtEW3+qyhwofiHPsl8RL71/g07R4nQEG28WemBCy8XFY4RsFSgmacZAT2TM40XhbwW4xM5kU/5dRV8XgzWxlN2N/7oJAdlxFO3MSDHNsMRl7w5Gh2+vjNGsjqV+thmZQPry8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3rv1RDf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3rv1RDf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1121F000FF;
	Wed, 16 Sep 2026 06:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789539069;
	bh=NCLyW2U7Cg7iRtEr6A2o9YjBvnZgZgctra/PFVpckUA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C3rv1RDfeh43O/M5nmjX8g+3W5clExB8IyPiMhC4P4n1YPAJ0tGiXLu0kKruqV0+f
	 W4g6bLuqmePiJmGVJFtE47Kfx06cgYb8T2CoEnsn+7f+JobGTpog+ybcMJYPDYhlzO
	 bgCcHP913cjxe5fDZpuxlrKGN+KMGBQhoCxX3tGb4u+D8AwNLSt70ezcbK01w8pghD
	 mB15k9wL0g40oBKKIpQ1eCF746XpttbX6HLTOON1+BHl3GHIknaBws1uu5tDke5A1S
	 1KmwrCrB7Axa1uJRLhEmnJ17WjkriOarCqY0pt4u9qI2WAp94aUdr6ktbiIMF1+5LP
	 NP7qPG16VMsaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] phy: qcom-qmp-pcie-multiphy: Split phy_ops into
 init/exit/reset/power_on
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiang Yu" <qiang.yu@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, linux-pci@vger.kernel.org, olteanv@gmail.com, vkoul@kernel.org, neil.armstrong@linaro.org
In-Reply-To: <20260915-align_pcie_init_sequence_0916-v1-3-0b2195836f30@oss.qualcomm.com>
References: <20260915-align_pcie_init_sequence_0916-v1-0-0b2195836f30@oss.qualcomm.com>
 <20260915-align_pcie_init_sequence_0916-v1-3-0b2195836f30@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:11:08 +0000
Message-Id: <20260916061109.1F1121F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Per HPG, the controller now calls phy_init() from
> qcom_pcie_host_init() and phy_reset() from inside its own core reset
> assert/deassert. Making that actually happen here needs phy_ops::init
> and phy_ops::reset implemented, and phy_ops::power_on adjusted to
> match. Split the combined phy_ops::power_on/power_off into
> phy_ops::init/exit/reset/power_on to do that.
>=20
> phy_ops::init enables power domains, regulators, and all PHY clocks
> (pipe clock first). phy_ops::reset does the no-CSR reset assert/
> delay/deassert/delay. phy_ops::power_on is left with just the PCS
> status poll. phy_ops::exit mirrors phy_ops::init in reverse;
> phy_ops::power_off is dropped since nothing remains for it to do.
>=20
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-align_pcie=
_init_sequence_0916-v1-0-0b2195836f30@oss.qualcomm.com?part=3D3

