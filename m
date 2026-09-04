Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E664137B2
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 05:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499968; cv=none; b=ALqu/ZFMS5OsJrwzltGPSF1CC0D+uu7WSg/zwyvJyCzYpgRYR10LuTG8vvobDiO+HlXL6aEGculCVNgJNpzJR4FMKTzgl3DQiMTIFtq/yMUTcZr9AkOnmkW0xRFenix/K7nws3WOeYQfjKRziARnrzUL//fsgMPNXPUnZ1NA86c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499968; c=relaxed/simple;
	bh=4GKibmUz+kbZmK55HgBeEq9DpvNg9Hwgix7II6tHBD4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=km3bd0pNYgY9+3a+2V0sK5yNQ42vQNhLDhUJ+AxMi6Lj26jWKruHk7qFYccqNkqYGBPNBDkJmH2mhmBYbryxNCDk2qN1tr0GpZI2nJ0u0P9mFqEHJ6AQnelAx8MPIdxEhDijSpWV1/4DaQMCM/jTpt4JMxUiYVx+5gJFiUJohV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoxD48g5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoxD48g5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5E71F00A3D;
	Fri,  4 Sep 2026 05:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788499967;
	bh=wDqzPhXodkic74gVfgkbVi7ftrzVL9MY7GTAmovUpFQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AoxD48g55Lh5HYc72f/gPiiG7UNbamEPetDf1yLnRLlm1lfd6mZ5g8BgOPwqTcKW6
	 J0W0qRmfcdOMuJZiCj+RYokwfmzxQmWHqS+BrbLO4ZcSbXaaqYXUUrUpv2YLrbcJ2l
	 t3Y1gByLG+YNWvcnRy4avcowT/0T2iLSnayqeFJUzIzz1h6EtPxrC7Ilptzbw803qu
	 lsLV6yzn947C/EUji0Cc9WaWWcvzjvR+3q1k3wDHRuiMhh+2qnBBOaPgNf2+Xpt7E+
	 lqiVpAzjYRgOPz/pREic+H7JjWeQK4CPuVkecjq/vLFijQ+fFp3jiiV2T37YayrD1U
	 H1RW8aE401Jbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] PCI: Add pcie_get_link_endpoints() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260904-pcie-link-endpoints-v3-1-4b9a91bd4b35@google.com>
References: <20260904-pcie-link-endpoints-v3-0-4b9a91bd4b35@google.com>
 <20260904-pcie-link-endpoints-v3-1-4b9a91bd4b35@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 05:32:46 +0000
Message-Id: <20260904053247.1C5E71F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> In PCIe topologies, physical links are point-to-point connections
> between an Upstream Component (Downstream Port, such as a Root Port
> or Switch Downstream Port) and a Downstream Component (Upstream Port,
> such as an Endpoint or Switch Upstream Port), per PCIe Base Specification
> Revision 7.0 / 6.0 sec 1.3.1.
>=20
> Drivers across drivers/pci/ (such as Lane Margining at Receiver and AER
> recovery) coordinate operations across both ends of a PCIe link:
>   - Lane Margining at Receiver (LMR): requires resolving both link
>     endpoints to establish hierarchical locking and runtime PM pinning.
>   - AER/DPC Recovery: identifies the parent bridge to coordinate link
>     resets and recovery sequences.
>=20
> Introduce pcie_get_link_endpoints() and pcie_put_link_endpoints() in the
> PCI core to provide a standardized, symmetric, and race-safe helper:
> [ ... ]
> Callers release acquired references using pcie_put_link_endpoints().
>=20
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/linux-pci/20260831214631.7CD5E1F000E9@smt=
p.kernel.org/
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-pcie-link-=
endpoints-v3-0-4b9a91bd4b35@google.com?part=3D1

