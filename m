Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6043BA253
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 06:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784789200; cv=none; b=YJHy6kpoc66JmLfrnHG3dNhiSQrpXoxJqcBno30s+YJlf7rOQVwFAhJmskXINAa348vZ9R81tE7AC06g4bzk4lvnWZ9tuy4DsC+JFaZ7Z4RViLXK4PH+3BV5FRj9wA7zBPD+FfkMA4Iu6dmkpLggg14+htcW1o+Pvia/sXc5qCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784789200; c=relaxed/simple;
	bh=TNiZewl7viigccDkNZdBSUHgpzbh4bItg/oogvneXnY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k1tyDKxTsOExnbOR7OY+FuWx/Bf/RjJ+MMtiWKcF9iIwn+aSrpdwxQZq7tPeo9X4XbciBe9pJRwC+qr4912Z4CHoiVo6XkUiHg0siwqmJv1Qpj/e1TfZjxKgm66N83OTtwC9sQ3o4T1rdCJTbRJUAAY2C0U0IaDnZqO367vIus0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4IY3CpV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4IY3CpV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CCE1F000E9;
	Thu, 23 Jul 2026 06:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784789198;
	bh=TNiZewl7viigccDkNZdBSUHgpzbh4bItg/oogvneXnY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I4IY3CpV+WA/JezSIRFjs4wjyaizFzUrL1qLMEYVNG5XwO7P9kP2vTFFOdFiewI9w
	 GIyGq3YanycjvNqRyaHfqAMXz28ArZYVfbAf7mlWGD7LM1iDzaVy0EF/29JgAJGOf8
	 k7fvpKy+QJvpNsNwd4umhs/VfqYwXUaLsbyFVW2z//XsswVRI0Kxt6AH3OpiTQFJRv
	 7cP3vfSW7y5uIf+Or3Tups9BvlBSFPWWyHWjVYQZnP52iIeoNmCRBFbyTDLQ7a1mlX
	 gAkOLh+EG0KKrl+mOQbJfLVEFPZZdpkqxvzZtWSSckHLrWdwW510SpPnbXcD4QVhmF
	 ekEjQKK6B5/bA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Fix 32-bit config write in Intel RP MPC ACS quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamad Raizudeen" <raizudeen.kerneldev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260723064300.8081-1-raizudeen.kerneldev@gmail.com>
References: <20260723064300.8081-1-raizudeen.kerneldev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 06:46:36 +0000
Message-Id: <20260723064638.57CCE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The pci_quirk_enable_intel_rp_mpc_acs() reads a 32 bit DWORD from the
> MPC register, sets bit 26 (INTEL_MPC_REG_IRBNCE), but it writes it back
> using pci_write_config_word().
>=20
> Because bit 26 resides in the upper 16 bits of the 32 bit register, a 16
> bit write to offset 0xd8 completely drops the newly set bit. The quirk
> logs that it is enabling IRBNCE, but the hardware never actually
> receives the command.
>=20
> Fix this by using pci_write_config_dword() to ensure the full 32 bit
> value is written back to the hardware.
>=20
> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723064300.8081=
-1-raizudeen.kerneldev@gmail.com?part=3D1

