Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330514E2352
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788785627; cv=none; b=n1Lx/Wg9IrSE8pJQMVTDO9VQTIIBbiCx4LWhgTYpdK8Hnx+rKxU2eCHQvnsOwI+UV9BRdSfivl18R5wb+OF3vXG9aiPMLDOB3IiD0KD2PTnAcfyPkVSkSeXDMXWsiM5tbqCqrSBmYhYcuOt6wCIOigIcSQ2YAwOTZUYooJ9hV0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788785627; c=relaxed/simple;
	bh=uiy09uptT2e9LZolMspGNlsSfu8SbXTRTTrPQHN7vRw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W+kJDbltjrMAFVU2Vdu6syF/Ex8Jut9EGd/Bs+SAxj1p3XjeY6vK/9RICYgWqoLRtD2MnaEev8qL5NjrPPtKdg9ZOgdjabn95H8cvB8fZpG4AdpPUh7Rbg0cSAnaLzGX2radIFqn6elqH4efZwBfHk9d43lxEYvMr//5dqhX22o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNZG7xcv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNZG7xcv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1BA1F00A3E;
	Mon,  7 Sep 2026 12:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788785625;
	bh=uiy09uptT2e9LZolMspGNlsSfu8SbXTRTTrPQHN7vRw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mNZG7xcvus+Ccm4AX4Wx6X+3PQ9ZaCRlN7ME8TYQdrW8XFvNFaF6InkCYxY3TR/Zo
	 fmlOnrOqV0rMUNjUSup/8pkNW7oh966m1Bcoo6ltNn7mE3VRFCp2tCW8SRft02tFjg
	 C7h8uUQEcteXOoYP8oVWPGk/BaF/LDqKts8Sj7G4NoG/u3NoOqdpiRYeZIeN+F3Zms
	 VZST7+GisO/y13RKad3paFpp0sIC7aJ9h0dyuOHbOovO4BORpeYY622eaMCKSTnYnr
	 S/bPV4G4BHfcL/KMcF/aP1rkEaCKiQ7T5q6uzsGKF9AwTfWvgRPL0M7KjSUqV4TRdF
	 2i0uYf9ewkrOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: Stop waiting for link status after config read
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Murashka" <yurypm@arista.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260907123853.1081635-1-yurypm@arista.com>
References: <20260904111318.1063858-1-yurypm@arista.com>
 <20260907123853.1081635-1-yurypm@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 12:53:45 +0000
Message-Id: <20260907125345.7B1BA1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> With a nested PCIe topology with multiple layers of hotplug, a link can go
> down near the bottom of the topology shortly before a link above it goes
> down. In that case, pcie_wait_for_link_status() can wait for the full
> timeout while every read of the link status register fails because the
> device has disappeared.
>=20
> Return immediately when the device is disconnected so event processing can
> continue.
>=20
> Signed-off-by: Yury Murashka <yurypm@arista.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907123853.1081=
635-1-yurypm@arista.com?part=3D1

