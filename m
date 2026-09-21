Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136C018C933;
	Mon, 21 Sep 2026 05:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969343; cv=none; b=WqCC0RCM6dUrYjiCVLKNOfj9PZdT4ffMCm7gMAxEfSx60Adv4PNba8TNoGEZ8Vsr0fY2HkuFlCnz+yvrC8WyD4MVgPMJ6VxKUY0BIbUYavRHFEBCbXl9z8hQP/CM6TM9harFNOjbuZ3lMhdyB9Wxs4jB8dcdJJARcLZvFNbYD3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969343; c=relaxed/simple;
	bh=ifkfFmu2QBf+jZP1+mBp3c6faJPPhcNCLDks/R2Jucc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZkDB8Xv3L/h38Cu6D50KDoF/OyU8kBcg6XFiWWpdBsRdRijS7+16WHnqG0Nblc/+Qq4sF1k/XxiTvPn7Xi7Sl05Igq0DWrTUYQAozB2nMVFpRXyCO/wAa65neBM0vJ54PM2KU06RDL5o8SDrxUMxvcTlhmfvq7eXKXHh9bYLOfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhfYU5Zw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhfYU5Zw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB5D1F000FF;
	Mon, 21 Sep 2026 05:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969341;
	bh=ifkfFmu2QBf+jZP1+mBp3c6faJPPhcNCLDks/R2Jucc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LhfYU5ZwIYa1GdmZFDrhhbpcLlNU8vPS2+xQK5V4bZ1ZiwBwTtEis7cMNHR8ph9Yi
	 N3Of6+4igEaGkTeTjZKnOtGh3RNbY9ddib+5RPGSUH4wiguw6kot6d9Bl+NJhfYTvc
	 IyQi4o+hQA62DwNBdLbFWE8q7aHP4vCoosIKv5l7PntC8G7DMGMvauz0C00YtX9FBT
	 Rmb8XOVUxuAsv75Sqg7oA3Hs+flM2+qQZtR6kxomOzSKEfGFr50JjILMYZZqCk8f6Y
	 k1N1UU/KYabDjWI8DMiAHzt5OA+a386W6wGXCMGKa09juMU36EH4TOhnsI9Asp7aKY
	 RUKQfEWLD8o5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/6] dt-bindings: pci: qcom: add Nord PCIe controller
 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: conor+dt@kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, vkoul@kernel.org, robh@kernel.org, olteanv@gmail.com, neil.armstrong@linaro.org, linux-pci@vger.kernel.org
In-Reply-To: <20260921-nord-v4-2-ed05c6e09240@oss.qualcomm.com>
References: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
 <20260921-nord-v4-2-ed05c6e09240@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:42:20 +0000
Message-Id: <20260921054221.3FB5D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add the qcom,nord-pcie compatible string to the Qualcomm PCIe
> controller binding.
>=20
> The Nord PCIe controller is compatible with the SA8775P PCIe
> controller implementation and reuses the same binding definition.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Reviewed-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-nord-v4-0-=
ed05c6e09240@oss.qualcomm.com?part=3D2

