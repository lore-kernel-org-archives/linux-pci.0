Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794995112;
	b=JcyunrITwxR2ANSMtj944xBGgxSnojSyABooyr6lAidqfLHauvQwtxrXm1gmWs8TORMN
	 ugIDLZvU9oXT+jxoydwTdOeaxtqxYyxEuHNUB0L9ny9LAdlbRIklbb1v9amKFkAVmMfao
	 wBfXe2i6utsmxl+dYZhZoeNGx2YWsVa2OCZxFnQ3r9HQ1Q9JGQ6qNdQ7tR2dLrREHwgHQ
	 2HTmAnkV+DnXbQjW4AY9F/7SZS94ze9KUyNBZeD337UDgqlPLhRCjWMQSvykrcVZ15+0L
	 oQ58VGdyyaUhmUa6YpCy2JSHKzunGDKbrMwh2wVGO7D13bpiL7hDDBXgUoxXY2SvleQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995112;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bRPjc2JjigNH9mRfPvHc2N8bOlbagcNyL25ktTVYLPU=;
	b=wJ95NryHpmc6qqMLU6nWR+Q4V8g91jsQa+w8qNga7jHEJ4YbI5/5E5hQu+vaf01I/6sx
	 XE0nCVr0hwFkVLZDjq52+OoP+8AwBJ0ooNryXOmzwrd6KpAVy+W7EIHalr2KyH7hveSiH
	 +XbK497zzXA9W0hFSlxrfjiwTkNnN0JiqhcSjwNbSrIHGnPUyRLdtPk+tNBEHMHdi/Yax
	 1kvrlHPtyHFZiyZ6QJ6D/vXNqt8fLHLywe+23ofX+PbEGHyFso8bCBz/mbDaDZOmSNns1
	 ze820BKEAbEXCzAxUVD9otwQTJ7rBBY9tVm+YTkNQTx0omlp3cuALoNP96mi3UNzehQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9+KXl6B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17A2606A31C
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9+KXl6B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF201F000C4;
	Wed, 18 Nov 2026 09:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794995112;
	bh=bRPjc2JjigNH9mRfPvHc2N8bOlbagcNyL25ktTVYLPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U9+KXl6BuPQhw/QR6kEMU/9fIZrbXzyHbQ5cz+NMziMeKvkn3D6RkAoVBv+cjz7av
	 U10Rc3VCy0w45wW4LbD07RvlnADiw/r71D5X3Dra6E4aSwUvteV7+nrlJpZK8wl5Fg
	 wDXmC9fegn4ZeDREE9ugc3Fx9rqH1WZRcpZe3JqrR/H8MEjnG18vySMX4HdATpYpGm
	 YQwFzr/l4GlhAMOXm+7rdAKlL8uKE50ZWrjWrIGOWbZjgfUDbsVYARyBaCIsDzeVgL
	 DoiUaGkMklvBiU7ewsTMu2f/cLLbRBlfn+OJtTKMwnKlrrWmWGvkbJFi7KsIwYnGHd
	 uBiUnV8Lpr9eA==
Message-ID: <sashiko-outbox-220620@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: mobiveil: Drop unnecessary msi-parent check in
 ls_g4_pcie_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vishal Satle" <vishalsatleit24@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261118093731.43980-1-vishalsatleit24@gmail.com>
References: <20261027094427.143733-1-vishalsatleit24@gmail.com>
 <20261118093731.43980-1-vishalsatleit24@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 09:45:11 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI: mobiveil: missing Fixes trailer for device_node leak in
  ls_g4_pcie_probe()
--

commit f42a1868186c1406c426daa13adc92dc71419de8
Author: Vishal Satle <vishalsatleit24@gmail.com>

> PCI: mobiveil: Drop unnecessary msi-parent check in ls_g4_pcie_probe()
>
> ls_g4_pcie_probe() calls of_parse_phandle(np, "msi-parent", 0) solely as
> a boolean existence check without releasing the returned device_node via
> of_node_put(), leaking a reference count on probe.
>
> Instead of keeping the check with of_node_put(), drop the check
> altogether. The driver does not use the phandle directly (the irqchip
> layer handles it), other PCI controller drivers do not enforce this
> check, and without "msi-parent" INTx still works even though MSIs will
> not, so probing does not need to fail.
>
> Also remove the now-unused local variable np.
>
> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Vishal Satle <vishalsatleit24@gmail.com>

[Severity: Low]
Since this fixes the device_node reference count leak in
ls_g4_pcie_probe(), should this include:

  Fixes: d29ad70a813b ("PCI: mobiveil: Add PCIe Gen4 RC driver for Layersca=
pe SoCs")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118093731.4398=
0-1-vishalsatleit24@gmail.com?part=3D1
