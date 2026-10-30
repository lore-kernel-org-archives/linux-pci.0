Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793375143;
	b=gjtbbKWQp4Jf1g9d20ZixsoOrP0t2TZiVo/ZUO8yF8LZxu0g+lElp9Gu9V4aDPB+Az6j
	 05Ul1Wp44f9RkSemvRlJiaFRfuIQcO8vxHQRA8EmiMVo0rKQTDyALNeVlBx1koSZmdwND
	 chojulBx1mY470wjwwDttux2sbdnZ+4zLKPpLrsyRwt4DqiHMBF1GWcoO/6BleixAflM8
	 7gArM3t1Fo6IgrcPZmXELxCq85QXQSXZuHeNFETuGYAGNlHjnjMcEfVhE+RB31vigf8uB
	 xXrpTSZ/dtFAG6Jnuc5FhQTPKyNkxhL+j8zv93Q/6AYWS4NaDs8ACM6nfS78Dun+wjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375143;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lHv9HhlldZWuKGZronz7ae1Yn0K789UC8M0OxQ0mA3o=;
	b=ir/nZOWT/FIRoJRg0K7GLzIb6VXGcmdmv0A0k2hsIB6tm+oaXtnDhlWOA1kjYuxy8Ch2
	 1LQYnF5P0eQ7WDEtpig8HzmlVSTn5qfUPZZjBfkbST8qGHB5IT7CGNtd1fMGrTpQ7gNXB
	 3Mi2x7Uck+uk2D4Kniv7Iypwu+myB2RkrIGwYJ3/DuV+bHQsq1PH6gjIV+ReDWtmZZIeW
	 rEC7eySxHzV1TWzt5zNb9ntw0OycLQmJEBUx6s/p6H5doqFrIEbibxhOH1adjmTWbcroK
	 xtF0f537FaX6TXOvrTrOFXOd7/j+5e7I/Fwh/9iuGqdxuFfTqUeoAv8nYy1TXL9eNpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QyhowpIE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C06606A31A
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QyhowpIE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AD61F000C1;
	Fri, 30 Oct 2026 15:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793375143;
	bh=lHv9HhlldZWuKGZronz7ae1Yn0K789UC8M0OxQ0mA3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QyhowpIEGZ08IeFACarsYJvPZpR0z69q4X8FD/yhYBVFoSI2ogidTajn4WM0wydqr
	 dJEUhAMRni/C/yqR4cHt2jih+KCtbNdVTdLaqqqqc4KIYeu+w80CfRko+ZZAdNrLGC
	 kW1uwrVsAtQw1pZqeiWx8khFeXuOq2QW2NMk4wgvpCVzcIzbOnR4IY+WC49sstZ/Wg
	 9stYzVVg0FAH1cIX2jfdyT4szQ+fT6GDoERjlTm0ziPTPBrA4r/clTcVqJXXOlYLQl
	 o2mZEXlNyrFwqCMss98zuKXhaR5DR1UoUUFT6S7s7kzR8ryG9vbUzZ5fMmX6sqUiiC
	 2gp62fb+cqPaQ==
Message-ID: <sashiko-outbox-191185@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/5] dmaengine: dw-edma: Dynamically append requests
 while running
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261030150742.2586776-5-den@valinux.co.jp>
References: <20261030150742.2586776-1-den@valinux.co.jp>
 <20261030150742.2586776-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:45:42 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Allow issue_pending() to fill free LL entries while the channel is busy,
> then check progress and restart it if it has stopped. Publish requests
> in descriptor order.
>=20
> Multiple descriptors can now have entries in the LL ring. When resetting
> the ring after an abort, mark the other descriptors with pending entries
> as aborted too, so they cannot be replayed.
>=20
> On resume, keep an LL channel BUSY while entries remain published,
> even if dw_edma_start_transfer() publishes nothing new.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Co-developed-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030150742.2586=
776-1-den@valinux.co.jp?part=3D4

