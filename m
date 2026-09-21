Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8D217B418;
	Mon, 21 Sep 2026 05:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969433; cv=none; b=G3ukJkW8Xe2lS+qYD2TrekgMwnPJe2V8Gtsvq9QL6oz+ZH2Pwn5EYWTQmXYQwg+hCVjQ2JByCJciQMIS+PKzE0lJ8All+k6amKLA9JQG4zqWD6OQmiK7z4FNy1l0DQ45H7/yn1PkuS3+qubEpDfhfJDACDvd0ZAdo2ItbS1ITb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969433; c=relaxed/simple;
	bh=MbuEQemUMUy+vDdofMbQ2ZGdR1u8hCpzF+/No/cZM8k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DeXYkmdkljOr3tZ1lpb60xnCwQ3PLvpUHcLM8z9Lb/uXL/TIXauMx5kOWODrn4oXDweUJ2MtdgxmC2RUwIyMMHgHZlokon+ANJ22PZG7RwZQj+jNKRIZsRjgkJShq4o4bELV73Vv16lTyySt4kT22LQX0vu/xd8JQ+gXrn2i7M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7YZg+kv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7YZg+kv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F921F000FF;
	Mon, 21 Sep 2026 05:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969432;
	bh=MbuEQemUMUy+vDdofMbQ2ZGdR1u8hCpzF+/No/cZM8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m7YZg+kvmg7mR35bnmuiHfKLcA/N4AOjt8shngmVDerUvwFSR0d1l5llH7ni6R5IQ
	 uh23SfXc1NrjYuwNVgexIlgAuBuFtUlKSYNonGQ+AU06IBDa84/5id5HZcJXsfNwUZ
	 biig43l4phx4l9CSVZKTReHFFSqlr9HYZbxoksiAUcTuq9sThuRqxE0VykCD38AJYq
	 cTIX1KMCNXb+vAhaiduPD68gLUSEpP3pFYhkAJPZKV35a2+P0xI09kLZE+z54Zvc/9
	 0nFiz6rq3t3debGYp/6eR1XP6Tk8jrvNVSHbR9qTfobe9WjtHM02j4arUyh4H6Bk8L
	 PkIvse8oiNyqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/6] dt-bindings: phy: qcom: add Nord QMP PCIe PHY
 binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: neil.armstrong@linaro.org, linux-phy@lists.infradead.org, linux-pci@vger.kernel.org, olteanv@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, vkoul@kernel.org
In-Reply-To: <20260921-nord-v4-1-ed05c6e09240@oss.qualcomm.com>
References: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
 <20260921-nord-v4-1-ed05c6e09240@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:43:51 +0000
Message-Id: <20260921054352.15F921F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Document the PCIe PHY found on the Qualcomm Nord platform.
>=20
> Nord has a 32.0 GT/s capable QMP PCIe PHY that can operate in multiple
> lane configurations using four PHY segments (A/B/C/D). The active
> topology is selected by firmware through a TCSR configuration
> register and may be configured as x16, x8+x8, x8+x4+x4, or
> x8+x4+x2+x2.
>=20
> The binding describes the register regions, clocks, resets, power
> domains, regulators, PHY provider interface, clock provider interface,
> and the qcom,link-mode property used by the driver to discover the
> active lane configuration programmed by firmware.
>=20
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-nord-v4-0-=
ed05c6e09240@oss.qualcomm.com?part=3D1

