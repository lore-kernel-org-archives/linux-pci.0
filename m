Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0417240BCDB;
	Tue, 30 Jun 2026 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823208; cv=none; b=oq9FhYdHBeIkXtwcvhliLcmFoJof3beK+0j58moBXAV7kySm+xprGC9cZ3RN7FPWb4sUCqjXKyoYDZpMx4ZzIjLPUUgtr6HQDAJ16kZJIL+vdIqSGMmkSOU3Uy0cReayziNoHou79FEaH8MSAOdgOWz2hLBc7XLQh6opmqJ5HOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823208; c=relaxed/simple;
	bh=Y7vL6cPQzCVsGY2FybrZ7uYv01P7w30akG1DpiqGAKk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YrQVgOrW+uPjhSvc08Oiwrg9bmXRKBYPOAyaV3idyGH/M6XRsot1e1AmuI2wiKVBJ3CsINQ8F/dGQWL8fNnuZg8trN27toVTZvSOOwGFCT+NRVb8H8J9irq/5aWwxcPrBmsvc1GyY6D46QTOkjn5Sd+zUVn5DLaeFzSSYMw0gLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2ro2Mjt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2ro2Mjt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61ACA1F000E9;
	Tue, 30 Jun 2026 12:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782823207;
	bh=Y7vL6cPQzCVsGY2FybrZ7uYv01P7w30akG1DpiqGAKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F2ro2MjtZTVFvIyXN1Gu3ttzs6TkBRfHNvan4HhJIG8xXwgzOcIsm3XBIrcTw6Alt
	 XlsCJTF0BsJ44U1LfKOuZo4+LkPqqUoj5F+UaXdNXF0F2sHRDBC0JDDGU2iNkaHz+I
	 KauWtH26dsKoIaXB/YtXgUCeiSKjNHGZKWbX3ZXprFHQ8euuegY3YH3mnvVyhy4LUo
	 /19/4d7T9w3zdp7RjloL6FIaC92A36bmmcDomgP20V8KfMxFlh0SNm2kJ92hbJniHm
	 jDgCRn90tCpDEO3eaM15BOKI/+YVkzYOMt0gQ65zFzFI1Ee5kPcFP6k3UqHYGd20od
	 S+qhhC9qSfgwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/11] rust: driver: remove `IdTable::id`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, ojeda@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260629-id_info-v2-1-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-1-56fccbe9c5ef@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 12:40:06 +0000
Message-Id: <20260630124007.61ACA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> This is unused.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-id_info-v2=
-0-56fccbe9c5ef@garyguo.net?part=3D1

