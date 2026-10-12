Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7106946D2DA
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811117; cv=none; b=VYIKnaBgComr5eW1jaRjtS+KKJabibiHTTSNyw9w7Dt0m+zOzzSwbARdFhESrv0vaut//Xy3zLD+e4YVFVvwDoLYkeLVVwS2pxL4hQYzRK6SlgmeN0Nw0ivMNp5iUla3univ4NvyRdKHbL9a4PvNQKuB1coeoHgU924dCQU3JqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811117; c=relaxed/simple;
	bh=I5WteieSDGmrwuzIxgRA3tnSU+AY3qgswoWfe7dHp8M=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Z6PP4gJLhSV8BFI+MvaHwt5fITrA28Lx2/m2SXU2k7gpkIP4bGRnNDlCGJ0YrlxfDRjdQltm9rQ3a2kGIAWeX25rufMFkB3EGY33h4hTpNfCvOEQIvRm+SWU5fDuEUdRCZpZLaZpN/0BiayfvJcKfoAvd3siJeN8i3FpCYQQRzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwMy6tPP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwMy6tPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374FF1F0089B;
	Mon, 12 Oct 2026 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791811116;
	bh=I5WteieSDGmrwuzIxgRA3tnSU+AY3qgswoWfe7dHp8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RwMy6tPPVFxmSPRedUPEi13pavqi3i/S2uaLVnbg9Z3JgHKr4OtORcMRaV6ybz7SX
	 nC59Khj9vtkDTUq8jcaBheMc9fo4aaD++IaCEj1BTbWhLLGt5HECZpnEJwRPVDtl07
	 42Q3clWkAW6Hd0JfRg8deHxLNO/ZOQuwm0qBnL2EB13v6CvzhWn91VwJrb7+WWODj0
	 VJwilep6YVgUnVAexrfwt8oVyO8rp0YBbmvSoYRd9R37em7G6iVLICUYo8I/FLE21x
	 oBZUAi+H8gUZALcnD4QKQ07zkcMlGwboCfvJ83g/er37nErEcZyBVMusBBWtcJLuLX
	 kyVg1Ym+v/Hqw==
Message-ID: <sashiko-outbox-168162@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: qcom: Power the controller down when
 hibernating
Reply-To: sashiko-reviews@lists.linux.dev
To: "Birk Skyum" <birk.skyum@pm.me>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <179181074907.22199.10556821368232442334@pm.me>
References: <179181074907.22199.10556821368232442334@pm.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:18:35 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> qcom_pcie_suspend_noirq() leaves the controller powered when a device
> below it cannot go to D3cold, and qcom_pcie_resume_noirq() then carries
> on with the controller as it was.
>=20
> That is fine for suspend. The same two functions also run as
> freeze_noirq and restore_noirq for hibernation. Devices are normally
> still in D0 at freeze, so a controller with a device behind it is left
> powered and the image records it as running. That image is resumed
> after a power cycle, by a kernel that may never have brought the
> controller up.
>=20
> On a Lenovo Yoga Slim 7x (X1E80100) this resets the machine on every
> resume from hibernation. The Wi-Fi card is behind pcie4, whose link
> only comes up once the power sequencing drivers have been loaded from
> the root file system. The kernel that loads the image resumes before
> [ ... ]
> dw_pcie_resume_noirq(), like after any other loss of power. Suspend and
> the poweroff phase of hibernation keep the D3cold check.
>=20
> Suggested-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Signed-off-by: Birk Skyum <birk.skyum@pm.me>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179181074907.22199.=
10556821368232442334@pm.me?part=3D1

