Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795000381;
	b=QRy+xQyNYeHy8xDZepNs5GcbpqA+8Y7fmMelcrsVbyihH8elECKDldIHNxcYKx+8sHdw
	 cfngv/pzbyTmB+vGI3GCEEYUyAidjoEJhZvsLJYmP8XnBlRegGhp/wqPIaGMLNJHsoJTs
	 1Fmn2MRpI/NJlKPOeo3reOXjUDiRgZtaDKxnVYeq2MecRrr6pYMXzVeLce5DpHiQcZQjr
	 QGy+OAE/l2t24P2gUueOPdRS1snHuvbcf2zghEuNs0I52c3JIAFmrqK8lGPS79JfaSA5a
	 bRe99Ot74sF6IH+32nkMUxUN8V3zvf9Om3c9q8LfLXZ2nCZYsF3NizMYr/HKkM0s4ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795000381;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tjukP6mqaXfOaiy3x0UAYEViBlg/yKfZF2V0ebmTdQk=;
	b=0P2yLR0z4CFb+01CMSwXIqTIQTT8IFz1KEuCGyE0iOoNYZE5buVU+O1cG3whlKWZdbqT
	 sfoiSBGzO4HFBIfTQFsuUapPUL1HHWgYPAEf5WgGEPtDFDuTj5wnsIEC+FizP+yCc8g8D
	 KApvYSrg4mZlhqfNoqcIVCKoFnCC1x6ik9sumFnC84wpyOXKGRuczAXAcl92+XbaT/b4Q
	 UYFPHDBbqLzwm5ZkAf9l6ipi6BJwNkv5Ywp2tLBMFJcGUPvh3TlXgPdK/4zLr+sKs/Y4y
	 5X5KkQKF4cPYc5OCvcQGWhbP9CSCJgpY2MZ2a1gkf2oAcoKzBx6RDiPI/FgAUH6phMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wiyo9sB9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12AF606A31C
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wiyo9sB9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A899D1F000C4;
	Wed, 18 Nov 2026 11:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795000380;
	bh=tjukP6mqaXfOaiy3x0UAYEViBlg/yKfZF2V0ebmTdQk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Wiyo9sB9jDHqxmaNPv54mgbHimw/QjgUi5r4H/jUS+5fhbV9t4Rdd5BOat43O7ekd
	 ZgzJmLBNMktbbQ+DSip0vim2kB79MDeVxNb02YcRcfAl7VOIydgrmUrzEYS8R/ct0e
	 oNQvNp7wZS3D1hlleAAUgRlKWMt82fHf/P+8QdJJvY6telo+sMho25JXAUc+GmU6Py
	 c4qa6+clwQJF8zYj1vBHzuBgp0X12lZapQrBbVCIwz+iv4K8/GJGusUIQ7Yd4wQ+0q
	 skYyq3zGq+6+KGRIQGK6c25Eiof0BOeJmxZyTrQuq/4+qrNmuiXvmNuhdgJuzUAUZ0
	 I2qantfyIZOAw==
Message-ID: <sashiko-outbox-220808@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] PCI/AER: Move AER capability check out of
 pcie_aer_is_native()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>, linux-pci@vger.kernel.org
In-Reply-To: <df17268a88d7099c34098e5c3670a493801e9c59.1794997749.git.lukas@wunner.de>
References: <cover.1794997749.git.lukas@wunner.de>
 <df17268a88d7099c34098e5c3670a493801e9c59.1794997749.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 11:13:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> When firmware grants control of Advanced Error Reporting to the operating
> system, that not only encompasses the AER capability, but also error
> enable/status bits in the Device Control and Device Status registers
> (PCI Firmware r3.3 table 4-6 bit 3).
>=20
> PCIe devices without AER capability still support baseline capability
> error reporting through these enable/status bits (PCIe r7.1 sec 6.2.1),
> but the bits must not be modified unless AER control was granted.
>=20
> pcie_aer_is_native() is unsuitable to check for control of AER-incapable
> devices because it implicitly checks for presence of an AER capability.
>=20
> Move that check to its callers (where needed) to allow using the function
> for the imminent baseline capability error reporting.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794997749.gi=
t.lukas@wunner.de?part=3D6

