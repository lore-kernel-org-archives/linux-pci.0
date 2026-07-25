Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACFA13777E;
	Sat, 25 Jul 2026 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784970264; cv=none; b=nF0ePXcjVoHnV8+Ar27lfhOzMKyqgC8oDDn6J+qZJiOsigHgMcPtckMtMu8dSkpDD6jkZWfFByQw+QwE0Vwea9qHQc+M+bt8SKSvvlqYmB2IhEEbjPtrH8En+KDdvy8b8QxOa0JWp+u3INJNn21pDWHAi7Q5C7l1dZDOyWX8u1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784970264; c=relaxed/simple;
	bh=BlM3GlwXoSl731d/Hmy/ePUaNmBpLpDkm9N43+AEhAc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jTDf+aTevUX6J+oxyCLHsOoPpMXBo8A9HA+j7JGPKgiC3JkMFHUaJDger7fYNJ3odiJP9Ubay1Iwkw3orYPeItG84+XD8tBmrUGiYJjAVouIYA6ftc+ilhb9ZslcIbaf4uJCCL04ehU6jfLP3+FE0BKuSH8ijaZewnmDtyBFX/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH+t0iMH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH+t0iMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A34D1F000E9;
	Sat, 25 Jul 2026 09:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784970263;
	bh=BlM3GlwXoSl731d/Hmy/ePUaNmBpLpDkm9N43+AEhAc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fH+t0iMHLTJEvJlV+FX9tEX9Y00QKlVqR4FNXeYkiULA2VV9PsSC978/o0g//f8y5
	 GrUr2cdcV/tltIR/FdJzfWMoAKjNpUtCY4Q+rwNwGK3L6cq79TOeNQQ/ZX/6phkdop
	 Ni773QXLtCAj3HyF6ljsel9kfZufZX7zGb+XTDFeUVuhp6N2C9MSG6P+uxTnETZ8yB
	 0bOwh5DTp6VRBfHYzyMpmMZ6hyrsJbsoeEeHfGQD3nMu7sAOuIZ2wu4SFgWFcjr2IN
	 Am4IqPVRo0WSbPW+smRog3n48+ss8EPQ4zqqqnBpXdYpK8yP9ZqcEbiq9Bmnfsc9Sg
	 lNeDXEjALz1WQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] PCI/pwrctrl: tc9563: Move Integrated MAC Endpoint
 out of 'tc9563_pwrctrl_ports' enum
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260725-tc9563-fix-v1-6-ec4286e31331@oss.qualcomm.com>
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com>
 <20260725-tc9563-fix-v1-6-ec4286e31331@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 09:04:22 +0000
Message-Id: <20260725090423.5A34D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>=20
> 'tc9563_pwrctrl_ports' is supposed to list only the internal ports of the
> switch. But it currently lists the integrated MAC Endpoint as well, which
> is wrong.
>=20
> Hence, move it to a separate 'ep_cfg' struct and also configure/parse the
> ports and the MAC Endpoint separately.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725-tc9563-fix=
-v1-0-ec4286e31331@oss.qualcomm.com?part=3D6

