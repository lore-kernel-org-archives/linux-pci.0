Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971040;
	b=Nx6Hkhwm47TCLQNffndSOg9J5PmhV2w5QDaCQs7VmzmeojmgmiZX6bVgW9cPnHZMTzNH
	 XxPDFV93eOn901asyhu2BSUeYBqf2S/OZSEZ+HT4cjbMHS3CpBUFhpsjz4L3EBU4DWnZa
	 QrhEZ3hkrXC42gE+WWxXNtK51vi8p5RoVcr8wzK1aPI7XN7N+GI5Lg9JxA8on/hvm0q3v
	 dVMMlryInrzGwbNLvtu4ZtS7/44Hn2UtMgWkcfy5nuhNZuMR4r9Av3LInKUPGVOxMYGDS
	 RZM0QzzV6jDqWI1Yxasgr3tmucUmgkcuISfK+ZQn1jmnYlVwLjzZXOeX0kxZNjzbu6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971040;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jVU7hGWyNrFwqU2N7fcr+7vM8OlVHFjP4yxuqb8ec18=;
	b=FXR+RohRIahhSWmA0IMjCHWvXQ90UHoRpmm6tYBbaDWYD7ggqWGe2R1NyxZUavDL0pso
	 DATFBiS8t2yxyktTvRIXLpCx4W3obHXD3aU0oe2E6nPgUiLSF8YSVVTItsHA/XLXDkIPd
	 CvmhnEw5e/+/O+UwKSb5nHMSg2mdBFgov7U9nyroi11QEhEsbcNZ/1vKF5djUSZQqvtrP
	 SOrWrUld3+j78v92PpUFw1vEoS/+wwDz+ksZYdKZdYy/qciQ2FRyxCKnuQPXLbsGISvvy
	 uEx4t4MRKmz1Zx8sbACxvlphQ8u/+CHjEmJlT4hUhX8OLJ8QPfB0PAAFh3G0Q9QlJtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EExR185j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B03606A31B
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 23:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EExR185j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74111F01825;
	Sun, 25 Oct 2026 23:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971040;
	bh=jVU7hGWyNrFwqU2N7fcr+7vM8OlVHFjP4yxuqb8ec18=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=EExR185jWdIw7IeLgUmpb58X+CUMOvuSRcnpzIhvlyPVyYkj8ynD+iIhVuTtFq1he
	 5/YczfEwhXzPz347QnTjw9hHRf1uRQ/+UffPojS98vA6vwj5ozOW70hUcHOswLeabq
	 N56VU+gRffCnnUDvC65zPK84tevd2DeLbEo4USWZhKygRZG06Tqpr2qeeIf9EaDpzU
	 HN2sG3mtDMdHzG6Aps+z3TLUdyf2Ds5QyDAB6LbZRqGxtwVzhts9LP9D/+mgNldEkJ
	 EK5XoJulPg1GAPd8DENHJF8Edmj5iYECBbiA03lodYLTcIz0kre8Sd2felUT+RKNRk
	 W40vrTMJZMPdw==
Message-ID: <sashiko-outbox-184522@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] PCI: Disable D3cold for Killer BE200-family WiFi on
 MSI Claw A1M
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>, linux-pci@vger.kernel.org
In-Reply-To: <20261025231813.128649-2-denis.benato@linux.dev>
References: <20261025231813.128649-1-denis.benato@linux.dev>
 <20261025231813.128649-2-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 23:30:39 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> During s2idle the platform removes power from the WiFi slot (D3cold).
> The Killer BE1750 (Intel BE200, 8086:272b) installed in the MSI Claw A1M
> fails to resume from that state: the PCIe link does not retrain
> ("pcieport 0000:00:1c.0: Data Link Layer Link Active not set in
> 100 msec") and every device register reads back as 0xffffffff, so the
> card disappears from the bus and the machine must be power-cycled.
>=20
> Keeping the device in D3hot with the link in L1.2 during system sleep
> makes suspend and resume work reliably: the package still reaches >99%
> S0ix residency and the card survives every cycle (verified over multiple
> suspend/resume tests with an RTC-timed wake).
>=20
> Disable D3cold for the BE200-family device on this board. This mirrors
> the udev-level workaround distributions already ship for the AX200/AX210
> (8086:2725), which suffers from the same class of problem, and moves it
> into the kernel where it belongs.
>=20
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220223
> Signed-off-by: Denis Benato <denis.benato@linux.dev>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025231813.1286=
49-1-denis.benato@linux.dev?part=3D1

