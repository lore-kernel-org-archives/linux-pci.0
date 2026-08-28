Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0628E3E9F60;
	Fri, 28 Aug 2026 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906974; cv=none; b=feH/dWAPXsBKqbEaYV9sQIjH6+HdKq0HuRvFuZ9MLYiPNDFd29PGULRY92atjhYy3RXFqPdX3tRf1KgX/M7LsIvL3c7Zs0WhZDq2+233irE6gLQIf203rcSc/Hlz2PNUytqJ5c/UXRS7OPwSKtNorVJC87zZmxk7eCXRZndA4Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906974; c=relaxed/simple;
	bh=N/WZfwxHlf3MqIuYmN1yGO9l65CagoSx2/iPktSBTMQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qg2dI0oIqIRYNOnIW5dnEmw75acXhKD/yNlb6XwNH2I4L6BSXzrHqRB7MB8V6LSEmQDnFXSWJJS0LIX+s3XoltyiKr0u8lwECXb/6QAc/p1CfIky8Dfc/H2gn/VmWs9Zu0QRrOlm45JlFxabfhFRC2cjilsk6Qb7JMMbbXWdirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGQDdA6z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGQDdA6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB061F000E9;
	Fri, 28 Aug 2026 08:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787906969;
	bh=N/WZfwxHlf3MqIuYmN1yGO9l65CagoSx2/iPktSBTMQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LGQDdA6zQQpaOJp+m+67hD6PBJ5iFewCqGt41Zcvvgl1amdunLON+7/pg2Y8uea31
	 lr36kx0J273C/H4a2RO9mLeEyK79nJ1huvivASEWgua5qOeFYkM7yyX3zU6zLWrEza
	 4Ib18HW13QStzvs7dxGydII5wt/oDDuWdUKqtxGF8De4R1/dH5Qeu9jWR5lGmIassT
	 oE89nSni7U9dTgqY8kZiqPEvkdmhYI7nS2EzQoR614EVEKvxddQvQZio45Ia/wj0H+
	 RcOCd2tBd4d5teglTTM32CxIrYUa6LTYml311s7QFHVsidEl/5m1DuITtzNndwX1RM
	 BMjSyAd+9el+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: pci: qcom: add Nord PCIe controller
 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, olteanv@gmail.com, linux-pci@vger.kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, linux-phy@lists.infradead.org, robh@kernel.org
In-Reply-To: <20260828-nord-v2-2-18bf59d19d6f@oss.qualcomm.com>
References: <20260828-nord-v2-0-18bf59d19d6f@oss.qualcomm.com>
 <20260828-nord-v2-2-18bf59d19d6f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 08:49:28 +0000
Message-Id: <20260828084929.2FB061F000E9@smtp.kernel.org>
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
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-nord-v2-0-=
18bf59d19d6f@oss.qualcomm.com?part=3D2

