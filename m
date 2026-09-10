Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E794A6898
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062638; cv=none; b=arQwaP32/byI3XTG0xhKpYeLw7NLEzWdHGMBOD+6rK5fqHu4TsnhHUDu1A4FBuO1oNXnyl/2vVWfpxAbUzgUaPvFcOuV/xY5GUD+x61btBZIRKnuq2Fg2XIik477IzZycdT2ELlf3iVNJS1SUUiZ4bCWQptJ4JIYEBTrJOcCLxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062638; c=relaxed/simple;
	bh=OijfDTum282IObmZmkYjg30CWcv6UTwmIIOKaJBcnJI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c71VTbn2pZ629a0YCYwR8a1OBn80SI1Y0oTh+KcfjGUcjzLhQHjsUpJg1YlhEfAps60zlLlxxO/4ZiDSsfnlZ3a85NLigbXGhBT3/6JRjrFGSMgFPG6hAsagO6AWS4PCw+WKyOkPvyglnJGx+pLaVVikoGUI1pnNAAkZe2qwDtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=majBODuM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="majBODuM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C8D1F000FF;
	Thu, 10 Sep 2026 17:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789062629;
	bh=OijfDTum282IObmZmkYjg30CWcv6UTwmIIOKaJBcnJI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=majBODuMMegipcXVJdkkmnvfxQPlsXM/zhK6BVosoqCw1aEkGzVAR3omjIbCnegYp
	 fa6ECKVuLwD+PC4z2n1j+26LUNxLOCDWbxSR+AbfmRJBDxuRTJ9tCkXBUGiFxqADze
	 dtTeQcUUDdD+zj9cwcO80iHQq5XvTc4xU5XkqSB+WCRNTfuHwgOIsVY2jnXfrWop23
	 ajosBE8sS/O0gUGBAjDkFPAo0vlvoSlpY7iZMVzPqXLDrFNpQPUKBTmyWb9ifCrt1J
	 TVv2iH5ur/fUsaR1GaajkXCHSOl7kzOf8lIdBp4CPOSOgNYA4r6qoRQegFC+clK2ad
	 PvKEWn+8Y0hJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/IOV: Make VF config reads match PCIe 7.0 spec
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Odell" <loganodell@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260910173648.1304517-1-loganodell@google.com>
References: <20260910173648.1304517-1-loganodell@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 17:50:29 +0000
Message-Id: <20260910175029.B9C8D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The revision and subsystem ID of the VFs for a given PF do not all have
> to match per 7.5.1.1.5 and 7.5.1.2.3[1]. Read these values from the
> config space instead of using cached values from VF0. Class codes and
> subsystem vendor IDs do need to match per 7.5.1.1.6 and 7.5.1.2.3. Use
> the PF's value instead of reading from the VF config space. Per
> 7.5.1.1.9, the header type for a VF should be 0, so hardcode that
> assignment.
>=20
> [1] https://members.pcisig.com/wg/PCI-SIG/document/previewpdf/22464
>=20
> Fixes: cf0921bea66c ("PCI/IOV: Use VF0 cached config registers for other =
VFs")
> Signed-off-by: Logan Odell <loganodell@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910173648.1304=
517-1-loganodell@google.com?part=3D1

