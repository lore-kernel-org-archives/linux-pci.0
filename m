Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230134;
	b=0P+WtQU6/CAS5PSirqgZtMRtnRe21hIdwJ5io0DnbDkk4Grs4uBLcITI3cz5nkKU9+g6
	 0npYKZIii2MztUp1F5Vfg9So0ctWFBDXvi63dSdPL4ga+0Y1KT8Zry2TMQ7IBt5Wz/nGx
	 HMMefTq0Wa16cYq8FTpGmKP7DH5CpAU+ycaPDLu+RAHkgUVixCxYt5hx4vI6C/FgycQ48
	 OUPpIJr+HaXhDuJk/phLft1S3HX30dLPGaJjgRRAHSjZV2LupijDVAVEvcx7eLXgAs6cw
	 U6bdBWavceO6w3wDTo6NXgnLNSBHtntLV6GLrsiQZp5kZYCxz/ldE6J8mjWgAkyihtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230134;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Vv/HtXaxbLl+44e04dB7LflzMcRbN/aXIaNbunMOR30=;
	b=R8AIS+UPw/O9eAo66omybt0efQmOWBKDRRWvR7sHDMDrI7sCW0DDdI7Tbl2JwebIwjGD
	 k6MybvhWYJxcnvXEp5mUWfm7FDDU3pzIbjtjwOV8u15ohByj70ZBygLHnBPbCjGHPZVqX
	 vDlEYBQEE0SBlRa8Vew3p1nv9doNwl6mHnaOPOAPzF36xEqmlwgvBOhnwtzmDH7dX3ogo
	 kBjRBnRNk0OMWpCc5hetbF4YgiKaLFVkC96GAr+Vzd+M2hPTfFWFY7hAgPrInekVj+ehj
	 ei8ehhcPTOIVMOC4Vh1mA30jMqCbsqMnNdoCxOlsKjUZQ7W0uCJX5l1Sv0N4XybFoJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FKMq0Ei9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF74606A31C
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FKMq0Ei9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AEF1F008A1;
	Mon,  9 Nov 2026 13:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794230134;
	bh=Vv/HtXaxbLl+44e04dB7LflzMcRbN/aXIaNbunMOR30=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FKMq0Ei9j/jF9bnAmRhXZXTcOIXFIljD9gvraVYwmrxjZLWC5/jbO73VNK0ObrpoH
	 biE0jQvoUyXs1p+Z4Fov4B3ciQOaW2waAJApuyHnN5lNsLBORII/yV8Cn12FnlfHSR
	 aQT/1C3e2xqfxeVXakId3HBj+KQelUcX1c+/D6c1H9foJUEa9JHmDt4yAnVgFwQ+TI
	 4EMAug7w18atpvutoFxY4my0XgZ3XJgKEyFIAOo1hEg5Uxg9O2QxzWAXtTXOROUYQ7
	 5IzQ9CEz3nkVG1x0EOiiwvVUn5JKBtOd3m7MlAIvYw7od8hDPek8wFGI1yE9HCU/D8
	 9o0aNHAydhjMA==
Message-ID: <sashiko-outbox-204993@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/xe: Remove driver side resource assignment
 after BAR resize
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261109131011.1815-3-ilpo.jarvinen@linux.intel.com>
References: <20261109131011.1815-1-ilpo.jarvinen@linux.intel.com>
 <20261109131011.1815-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 13:15:33 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_resize_resource() assigns the resized BAR and the other BARs it
> released, or restores the original configuration on failure. Calling
> pci_assign_unassigned_bus_resources() after it is redundant. If that
> call manages to assign more resources in some scenario, the problem
> should be fixed inside pci_resize_resource() instead.
>=20
> Remove the pci_assign_unassigned_bus_resources() call from
> xe_pci_rebar_resize().
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109131011.1815=
-1-ilpo.jarvinen@linux.intel.com?part=3D2

