Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343866;
	b=rJ8Xi9loFiUFG2fNCjYtjP6UR5Hc41my791udLtJWYm7ap+/R+C13YS1gb8pV0eE7oEp
	 sqJZNDs7NSY7IM32VBFrPqxK8eKqROI6j3Kg6LHjbcthrieewP9NAEJYqxqYL65tfhreF
	 ylnz70uwBMTSH3hgYChuG93CiX9eA7oAN6razUhmuRM1zZ/GQbfv9E7B8ruhtVtUo/T3a
	 kuLHSSvHiglA8Z/M9Trp7Lr7uJFdjeydelT35lBi5hArrj8YWnq6hVjr06JBo5lP2S7Z7
	 oCNn0jSCN6FatECLqOTPBjC+TzKafcTi5BnLn8F5RzL3RN5QAeuawyefcSNUjrZWYFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343866;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qJ3vRhaiV7nJiIqX7hOEGL/Il4zEJiQ7etoERkgxZPw=;
	b=b4LUKkFb5iOToq0FGgNO6fp+xN5/koY9fC3BYusLFV1tOvQsTT0ZiwJgfBy45YsawEBW
	 YiPj/Mri3WZBK9nYaPGqysCSPFMbwf2+33SKvb14+sUBoWrt0mXo0wcPAdnCtJhUQwGmU
	 HfnpdlaFggZ0S6Q3BfrPhjAvYeXecMrn64z+zSRXLFoHlpiIpO2gm9jyl5MEREsYt1hjn
	 xw341b0TCIwadMGMXBS1gE0PTzp/F+tcYU6nuiueFX4tIaHXX0duW9PR9QV5VCccPvt+I
	 Jwz4qyd/tSZMAkpVaZ5x2zYEESKFNpF2IWoEqb2n1xdOYSGwZ3H9UsFX3Rs92R182qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NP/HhVlq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB9F606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NP/HhVlq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966AB1F00937;
	Tue, 10 Nov 2026 20:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343865;
	bh=qJ3vRhaiV7nJiIqX7hOEGL/Il4zEJiQ7etoERkgxZPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NP/HhVlqf09SMjyMw8zTpdzpi9im+kZUBVdZIZEG6x9MZGAICalXWL64RoTaebAUA
	 XcgueG+sO7ZPPTSASKhvssdr20UJw8puEMJztKOE4mImlUbxfQUAABIdNg9+eLq9+q
	 HO+d9H5F5JMJpscI5nRfBtwTTKMWSIHOKGARJNvzOagESZj5hgo2r/Wp6OUbSGJAVM
	 xN/iXEvt2p4IIfoUjWHj/CqHTEBNUwP+PdZaw/0nldJ4a0CAOTKecSHeQrYR6bdQwu
	 ng1Ge+eLafNz/rcSlPwOlXrX4dL++MwP+IHDcc1ucHLarZCsYKdQ2bHyOE1eb2NLlw
	 Wm7+eGZq0uVQQ==
Message-ID: <sashiko-outbox-207732@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI/PM: Disable bridge D3 on Lenovo ThinkCentre
 M90n-1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <superm1@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110-superm1-kbz-222179-v2-1-5605e6ce6454@kernel.org>
References: <20261110-superm1-kbz-222179-v2-0-5605e6ce6454@kernel.org>
 <20261110-superm1-kbz-222179-v2-1-5605e6ce6454@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 20:51:05 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> On the Lenovo ThinkCentre M90n-1 (board 314D), suspending the empty
> Root Port 9 turns off a clock needed by the onboard RTL8168 behind
> Root Port 12.  The NIC becomes inaccessible and r8169 fails to probe
> with "Unable to change power state from D3cold to D0".
>=20
> The RP09.PXP_._OFF method gates PCH SRC clock 1, which also supplies
> the NIC behind Root Port 12.  Keeping Root Port 9 in D0 preserves
> that clock and allows the NIC to probe.  Commit 4d4c10f763d7 ("PCI:
> Explicitly put devices into D0 when initializing") exposed the firmware
> bug on every boot by ensuring that the first runtime suspend executes
> the power resource's _OFF method.
>=20
> Add the board to bridge_d3_blacklist to prevent bridge D3 transitions.
> Check the blacklist before platform_pci_bridge_d3(), since ACPI allows
> D3 on the affected hotplug port and would otherwise bypass the quirk.
>=20
> Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializi=
ng")
> Reported-by: Joshua Perry <josh@6bit.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222179
> Cc: stable@vger.kernel.org
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Signed-off-by: Mario Limonciello <superm1@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-superm1-kb=
z-222179-v2-0-5605e6ce6454@kernel.org?part=3D1

