Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791771;
	b=2ExDXO/p9zLKlNATYUl1fagT11CzDPAsHrbLCzJHDHOI9/SZwrRZyNfIPX+CNAr50sTD
	 +WqRhuVylLM+kNIbkpnKVxGzx6Qetiq+zYGx1nExZ1rnAZ+FFFtR2IhCUlKgOSW0JsFqt
	 Ke4TIePIPjMLXlpSvubXFF37XtcB+TL+573ty42nJRe5au6Xgb40xSTcbr5XSllgdwcNJ
	 4QLGGA3XtB2ig0i7aYu8OzJLi0rj/tmCXKEPR57jC8uda3C4SZumPqVgiDwzKP/3s0H0P
	 rHNoU8cYXz6iaaH+/uIRZS79GR/pz/v5ozZcOfNMjDnuT75sSHt8V8hdlkobKkDN+yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791771;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=daTHgLDA889wLj+PYm5dlULDLVuqJdt2HcFnv8D0qGg=;
	b=1gBzavBJkL4k7M5I/UA9wOt27NtZhS20zXFWduubZdUyQp2VWdqamgG/I+gWYiEsbRCI
	 e7iX85A/qE7nZVNiFfuviQdAy2HT9Zj959mk+40CQNazUX39YZomzeglaZ7RaMs1UtVvw
	 qbPA5IxvVwsHBkOKWC8RwEUWfeQ71aUMO/3SYK3wsQqs99XhPLGFAY0X3F25/zZtnVaBz
	 oAgUGtqk+86SUsqb2U8SdMtsEBtn5bQCbt6syFLcLpjOXQVP7BE0gXlprS7Ev+M1Dd5Vg
	 XGgmpmBDRy7kIyCpAEFthSYmZ8NE09bg0G+LIBCB3NfjKp2mxBFh1pFvxskjwW8KxYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abrp4zOS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B7C606A31E
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=abrp4zOS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C281F00897;
	Fri, 27 Nov 2026 15:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791770;
	bh=daTHgLDA889wLj+PYm5dlULDLVuqJdt2HcFnv8D0qGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=abrp4zOS3Wtyo4G4D0C5+17J1rmETxHpPYyX3XNU2wT+5cF0y6BdYcu6ioJFKafpJ
	 Z3vKLt+huuBB8b4Zl5JF+VG15g0+r3HagSafbwzt4SYtPBjtgxFnF2HGC/BwmCL0uL
	 yL39Z5msayK/yUyqRGhlzi4y7c/S8jb86y4VwM7fR+EjbnMFcp4tbezK148+WC9l52
	 Bup1AOVGb3YrCwNXjFMEUHSZlgYoKutbtYBaTmIfh+KBBCrAAV6iBfUkNT3wnCYBi3
	 H6FH00iwYu0ZW56tdwkh9wBLZD3msA9UGI110YyY/GdWQPhpHNUXnIgVmm7XxQMWOm
	 8df/pcZC77LXQ==
Message-ID: <sashiko-outbox-237666@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 0/2] PCI: qcom: Add support for firmware-managed PCIe
 controller recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mrinmay Sarkar" <mrinmay.sarkar@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261127-pcie-controller-reset-v2-0-17467b64f5f5@oss.qualcomm.com>
References: <20261127-pcie-controller-reset-v2-0-17467b64f5f5@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:02:50 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 2-patch series:

- Patch 2: no issues found.
- Patch 1 ("PCI: qcom: Implement .reset_root_port() for firmware..."): 2
  potential issues (2 High)

A detailed review has been sent as a separate reply to patch 1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-pcie-contr=
oller-reset-v2-0-17467b64f5f5@oss.qualcomm.com
