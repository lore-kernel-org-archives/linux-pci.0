Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977595;
	b=nEVIU73xfiyAUKMCxMsmoBJBAeeslePczr4pG/dk8xAP/PyvbIQNtRGEBkRPkE1Yl1w+
	 8JvQYaQQMTgK3MIftO+XlAtNCu3e7+C2PZY0b89t+mQtLiZuAxYuLqEgoluqb99FNYnxD
	 buP8iaZMWGOzGM+vbf12h57hc5wbmlRxeK6cLFuP5z274kFV68OhUhDRbfVVYjLWEWwi3
	 LwGNgt4OwYULNgCGjF4mgv+r7hm4I5kAp8iOBGg432J+BSnOk2/bbPWC9/3RSDZlfAZIS
	 GbfDsoIS/Qx0HRNaU+f6u8/nRaHYOnNB8hMGwgWsandaQ6yGdKPu0nLrqFbDJyIhF+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977595;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XFtMloUDE+rhl3oDSVe53q4FFJ1kZP7/dmmqoWxp4hI=;
	b=t/aksFdw870xiJOMnyGyCWy51+fHiwgM5+c5Rz0kQeTrtNJlhkhAULanejZ+oDqcG3kE
	 BRSTReZruSrxmeSkS3/8ovrY8jTRO7ks8fQhWbB+sw6ChWpA474yCMMbxs/dct2169lsg
	 GnezowIQWacbEXc/UHzDEemoyygmhxXep7uGbNCH7TxKlSuFF8qGl0vuh9QOnyZrs3tOG
	 gbLndhKdWyG4kLTWtfMc/IPcfX9CMuMG9lkqcKTScg+m9XZeEV6uK2t4ocxxWHdymh5Vi
	 Hovf5CX0ci8eplfYPuoz0UON6V765JKtRbYbVyxMq1abHFn9HgmiWOlQcJsDRTuuqTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QKVRYXzK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7AD606A32D
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QKVRYXzK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AC21F0089F;
	Fri,  6 Nov 2026 15:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793977594;
	bh=XFtMloUDE+rhl3oDSVe53q4FFJ1kZP7/dmmqoWxp4hI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=QKVRYXzK1b6GLBhfRx9TbKJFSvYYjz/6EWRhMACn5iqYOOO1YdyONtyS2GAcCO3qi
	 1YyohiCOQLjnr3F+CfAguHvdG10UG7npVCYpL00PWQ0bUulBU67850fIOc61TkO2lK
	 wHNvq03TK+bOUJOBB3FvsuqivHW1of3Xj30Jp1E4REY5WQvP/lPMsqy9Z3meYZEkOK
	 dy9iAyfPf/hGGhk1RgnqB7G407+VNzv655vDIaAmCTNDdWlftTU8e8aKh4QBRXK5DI
	 ZyW7h8E/pjPWYu7Mfx8JnlmfMWdi3aM5VtOY/jsBkUg56nVEsVKAogzEvfqHtEKlHT
	 jiuCgLyfsdlYw==
Message-ID: <sashiko-outbox-201642@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/14] PCI: Calculate bridge window with optional
 sizes from scratch
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261106134341.39493-12-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
 <20261106134341.39493-12-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:06:33 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pbus_size_mem() calls __pbus_size_mem() to calculate minimum head
> alignment and size the bridge window. A single pass in
> __pbus_size_mem() attempts to calculate both size with only mandatory
> resources and also with optional size using add_align and
> children_add_size.
>=20
> The discovered resource sizes are passed to calculate_head_align() but
> that only makes one calculation with mandatory resources in mind. That
> means the alignment requirement for the case with optional resources is
> determined from the maximum alignment, not from the required minimum
> alignment.
>=20
> To make the calculation more consistent, remove add_align and
> children_add_size parameters, and make the caller decide if optional
> resources should be included or not. Then, pbus_size_mem() can just
> make a second call to __pbus_size_mem() to recalculate the alignment
> and size with optional sizes.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106134341.3949=
3-1-ilpo.jarvinen@linux.intel.com?part=3D11

