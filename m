Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5C15A0AA3;
	Thu, 17 Sep 2026 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656351; cv=none; b=lISB2tJL8brJViodMz03kX7v1Z9GgH12vnM8hpNL/MBLGCVh6H8pWu3joTy8aeHp9p6oE6gXhqtC8zY4L+9/d3NPdQNgjf86Dr0FPzEb4vVVTGEWt9ckkJSbhkkb7YZcqo99vFZPmCLb68d16bp4eTs+RcI9fk1PTH3bPxziJkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656351; c=relaxed/simple;
	bh=OVMVIJn5nMOZzweOgd1xg0Nt+XzwpkYXftf6T3uN2Vk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HYUhyVIQztwipi/KO8kiDL785V97I/j6d+8TPeEpwfKwZV9rRTA4Ha0a2iVHwX0FljMs7hlnpAUBFuiHkMLCFsezAaFlqm1ZPR2oL+Phj+sPO7B9a8zSCEEYxcmEAWcWBtDqpr1/HQt6eDmxdkqYHSMYNRPcvdMIlYAstu9yunk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hObebb6N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hObebb6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6AAB1F000FF;
	Thu, 17 Sep 2026 14:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789656339;
	bh=OVMVIJn5nMOZzweOgd1xg0Nt+XzwpkYXftf6T3uN2Vk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hObebb6Njl+aMQPvDaLBuCCz10f6UsKYlR6VnRmPSt9zIhITEsaEoakBRUGLOeg0h
	 aahh3Aw0pt34976yeOqXvdRCaTv7jAjzA91gG65xSs1QWy1czKhHLU2YSV+8hnoZlr
	 bx7jk39pQIsYRsg3DA1cY5asJXsXQLszE0QKEWLc+v9BsMoVm6e2ULcIR5/gsEcDvV
	 +4uafWI+yAm89CZUGw34CZb6ENpxTGFMslcxdlIkcOFlZbYqy1P7hdtL+JI50ktV+N
	 wFq9b3udFP4rqhchqDecNM6FkXwPeSkAPd1fsvyLn8+FRl2o9LF9RFsYn3w3w5kj5T
	 EykWa0yIU6WFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: Expand flow lists to block lists
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Matyas" <matyasdaniel006@gmail.com>
Cc: vkoul@kernel.org, robh@kernel.org, mfd@lists.linux.dev, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, neil.armstrong@linaro.org, linux-pci@vger.kernel.org, linux-rtc@vger.kernel.org, linux-phy@lists.infradead.org, conor+dt@kernel.org, devicetree@vger.kernel.org, olteanv@gmail.com, linux-watchdog@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-amlogic@lists.infradead.org, lee@kernel.org
In-Reply-To: <20260917144134.459819-1-matyasdaniel006@gmail.com>
References: <20260917144134.459819-1-matyasdaniel006@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:45:38 +0000
Message-Id: <20260917144538.B6AAB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Running dt_bindings_check returned:
> [error] string value is redundantly quoted with any quotes (quoted-string=
s)
>=20
> The files used quotation marks in flow lists because the strings had
> commas and these commas were interpreted as separators. Convert flow
> style lists to block style lists, so that there is no problems with the
> commas.
>=20
> Signed-off-by: Daniel Matyas <matyasdaniel006@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917144134.4598=
19-1-matyasdaniel006@gmail.com?part=3D1

