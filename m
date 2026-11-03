Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741046;
	b=Xiv17DHOkFJHmMfQI/92yO2Z/r24wGrNSBTZOgTdGe9JcwdlNskPrIgAQ4QfcGwZyAP5
	 QhzvyVOzF9uRr/0bA7MNkCHWt17w9GURpXlazAc5af+HeOF9DhFZnz0fityoSPZMj1gVz
	 4P7srcYBYldRbp1FjJ9Cy3NmjomzVq3PakQUS8z9b2Z57f4vTU+l0MH4aWM44JCerST/2
	 6HBTfK6UAcgni3A7cnZfswhfWtz1MM6XsQ9PIa0sNs51sHuPBzsU8ML/hQuNAS3ChjsPn
	 8/Eova4tXhnE1Rk/6o9pmubcmz7P1Cbld5yNcz7ZPU2pLLdDaMPmMTiD9AHiOpBb1bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741046;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Yh5n57oLP82H40eUHpRLw11WTUDW/t06QuCXZP8MEvA=;
	b=1QGF6Xiv4227UBfDsyU3LvshMu9A31RiD0lFgS73jYmDOzL0TSV0t5KT+/7XZu1Cfcl5
	 eMnkqZYcrRDhis7hjp3xfzXrtbhozBEK1vP81+bTXhUMuj/fJ651knitcY8wO3kMW7kIO
	 sMqcmUJda7EPyFKylOUV6DWahyUbRQAfL7TrFr2qvBPrYOSQNTvss4UdiX5K3yJnD8s6E
	 yHo2zxHQ3JOY8o6abTIvpKxZQZm7VlGVb9/wx5SEJXboJQlqm+S5IdCAoW1jn88LtEvXg
	 NKvuNJL4XrmCErWJp0/oqUpSzbWaseU3kO3laSUXd+b3OcydkVLDhdZtZ3GF20O0kDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ntdO/wzm";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4CD606A31B
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ntdO/wzm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66B11F000C1;
	Tue,  3 Nov 2026 21:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741045;
	bh=Yh5n57oLP82H40eUHpRLw11WTUDW/t06QuCXZP8MEvA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ntdO/wzmpD00u7MuGV6ShWmjksx4uy8lMc0X8q99Fgr3AA7qbSl9Sa+77PaQiQ3uH
	 fBoK1MoFjNI6zpAVD0sTG7CFxRKVsihluTdvvGbwlQLv4zEDfPas/h/CC9IorWEMue
	 oyFx6vxr2tvLcsMggBZZwv3VENamCa7S+/2+ExTC3ua0O4TpNZ2HuiSreqOjRGos1/
	 WOTB7CFy0NMKIMokh/qoTq1U6r9iynLPNGz9jIX4n1tLQA3mt+1Yp2a3SCLUF1aAX2
	 0DXxesvEevgURdmEfQsQd0XiySKhCvfXlUrHENWgE8GG5Iuw3dxnTmeif8ImG437tC
	 WHzF4pl9y7kCA==
Message-ID: <sashiko-outbox-196049@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: iproc-msi: Removed potentially endless loop
 handling MSI events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eugen Hristev" <ehristev@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-iproc-irq-v2-1-dc7223df35fc@kernel.org>
References: <20261103-iproc-irq-v2-1-dc7223df35fc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 21:24:05 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The iProc MSI chained handler rereads the event queue tail after each
> batch and keeps processing until the queue is empty. A continuously fed
> queue can therefore keep the CPU in the handler indefinitely, starving
> other interrupts and causing RCU stalls under heavy Ethernet traffic.
>=20
> To fix this scenario, remove the loop that keeps reading the head and
> the tail until there are no more pending events. Read the head and tail
> only once and process only the events recorded in that snapshot.
> Update the head before returning. Events arriving during processing
> remain queued for a subsequent parent interrupt, allowing other handlers
> to run without imposing an arbitrary event limit.
>=20
> Discovered while testing it with an Ethernet NIC, when too many MSI
> interrupts come in, CPU might get starved:
>=20
> [ ... ]
>=20
> With this one loop approach, IRQ handler will complete and continue
> to serve MSI events on the next handler invocation.
>=20
> Signed-off-by: Eugen Hristev <ehristev@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-iproc-irq-=
v2-1-dc7223df35fc@kernel.org?part=3D1

