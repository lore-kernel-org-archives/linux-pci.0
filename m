Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9BD4734C6;
	Tue,  1 Sep 2026 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252945; cv=none; b=XRPRyNNhTRZTkp3W+X64rW8RmNlBqUCouOeC6UeOhIUohYE7mpQP76oEr5yW5TM+6ZbNkLxK1ED5gzz4y3sWveDlmXW6wJQtFEG6m4zxwt9/O2ZeJEFpHhNdpGpODxLeIpKWsQzgbqCpdNd2kaeGL2OAO32tgfVGB1QrM/MH688=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252945; c=relaxed/simple;
	bh=ErhXmupPt7A2xSQ140Y/QaiDhmSBsAqA5t9Yk3loy6w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bENAKV03FKsvYZLvmA6CZYVHPKltfzcAzzSqcfurbYgQ38vFu8kSzZBoKPavTnC9ebsL1OsojF+b74x2tp6mA6Y9/Nw0VpY+6qfeKuTpKFoOF777JcElXc6HXIseHk29+dtvCiA03kA6KZVtIXzQLND1GmHb8TN5K9RO6c5zNho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUv5dWZ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUv5dWZ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086671F000E9;
	Tue,  1 Sep 2026 08:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788252943;
	bh=ErhXmupPt7A2xSQ140Y/QaiDhmSBsAqA5t9Yk3loy6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZUv5dWZ5ksL1X8IcavwNQLjcDuZk26Tu4iJ79ONg9PGf3OS8A20e54bk2bv3epnK4
	 fYREmF+25K93fv+BI5pjrOPRrkwuhzgpl6tP6okX2PV8T3sY2y/ryF4d2yxINRPm85
	 +TFKoJH/1TyMqZrsU+leM8piz5cwu2UIlkApS+6EWj0mwcSp9U4K6RGlhYp4Z2oS4e
	 kg+fAoO8FzXnP0KRkapEI0bAMBeHnu25y/R8CNS2UOiGE6eEYtV1NLcoMZbnU9QFDT
	 uFXoXuB/NAMTFoYe7sNeaXbUgzqHoFos1GFoVYi9IEPiOGPbmAXwB26rwcnNRY46/X
	 s8l/PyG9Tedvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: pinctrl: qcom,sc8280xp-tlmm: allow
 gpio-line-names
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xilin Wu" <sophon@radxa.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260901-q8b-dts-v1-5-7de0b6a73d08@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-5-7de0b6a73d08@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:55:42 +0000
Message-Id: <20260901085543.086671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The SC8280XP TLMM GPIO controller exposes 230 GPIO lines. Allow boards to
> provide descriptive names for these lines and constrain the list to the
> number of GPIOs exposed by the controller.
>=20
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-q8b-dts-v1=
-0-7de0b6a73d08@radxa.com?part=3D5

