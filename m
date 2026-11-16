Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843914;
	b=D8ZU37xiAgoc8LskCkSxoolk6e9pao6TZ+TXRS9wq2QAxTeZrlxen772KE0mIobbPWRI
	 01t7tftiz2sCtjOxBtkZQHyObHo2O03/EYZm5i9Sfgzp7BEyOLpZ9gITDCuSrMuPC0g/Q
	 FEfNT9yypOEfOlnV63sc1t2Dt+O8axBSYIXIS9G3wynBrr81ftZ2aePhqpmnlWaMI3fNV
	 YAyPwhgLSpLIhW3aiIu4E5Mq1vA2BLboYWrqIok7HtvvO1csT8UrIIrWGydp3Y2VudN6H
	 q8fEisESJfreYW47pQtXFsxHb134IbViav/dPJeYV+XE2k09CzA0x3/bptZDbKYCG9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843914;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pDlO8cWhG6zI5yaC2Wr5JrA/d8a8XQHIqkGXqj6nTw0=;
	b=rkO/RK4RATKJMB6SYL78KE/nS7YCPzGwoN9sf5d5lVhYEtnzD1dnla5wp1KO44hUMbiX
	 1gfUEQcBOOIZlpsN3xIO7HJSzCD6AcWyZvv7H3u+pP9rybbV9IrtJoUOO1hXK013ZaKJA
	 j1e6AI4J8jnOaCCYQv0gWNkf23mXQc+NUmFk8qNHtpUdHrWKYBRCwRe16mg4GoI2vZqET
	 /hJibALQxkyGFzuvQjyn33qZ9FU+P4TkHgv/zH441ho8ug8502tAKjk+yt5zK0ZMAZqTc
	 NYUGvwe978gWAtnDdgKAceVKASoq85OLP2WZaISlkmYe81jkbSQmBjqaYDow6WSx72A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="df50oCz/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B478606A329
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=df50oCz/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61FB1F000C4;
	Mon, 16 Nov 2026 15:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794843914;
	bh=pDlO8cWhG6zI5yaC2Wr5JrA/d8a8XQHIqkGXqj6nTw0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=df50oCz/9iKs7HdoEwj2/7kJ6m+muUxWiejtWM56vYoyHIoQpaSJSd9ZAaVLoUDM5
	 zvJB/IqFnm/+AZ72DNUTSThoTU8XoUtW7Pl7ZarHmyh2+X6VXkzME41nwud1W/zLVX
	 xoWv9guikR38kNWPcOxHHlJRWGhPBXWQP7JGy50VQc/esTGful/Qoe9nsRSQqTKT9B
	 XkNO8oG7A1WlSKm96Z/8xx5A8v3wG2/I2U5tp+HevDSgHirwH+TsyaiBgr03guwSb7
	 FMo1cQpnuUZ+qN9Qjo+3LfE6238bjcDZACkE+ApAQhWBWzjN6fay12sGSCHVAVKZU4
	 lG0lcPX85PIog==
Message-ID: <sashiko-outbox-217314@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/13] parisc/PCI: Convert to
 pci_assign_unassigned_bus_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261116152403.2672-10-ilpo.jarvinen@linux.intel.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-10-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:45:13 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The Dino PCI bus driver performs assignment of resource using
> pci_bus_assign_resources(). That function makes bridge window sizing
> disjoint from the assignment phase and is going to be removed.
>=20
> Convert pci_bus_assign_resources() to
> pci_assign_unassigned_bus_resources(). If no other bridges are involved,
> the extra sizing should be no-op.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116152403.2672=
-1-ilpo.jarvinen@linux.intel.com?part=3D9

