Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15B64F4754;
	Wed, 30 Sep 2026 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773846; cv=none; b=cR1sz0SRRzimUjEFHCGoWFacrLerIkcG/PWaO3CR3aFejr//JJmfPiPFDIJPjpK63nLzv7yoaaL31+4gl4dOGmLx3rkyQczHBbq8J5nhcfMf/BpTu3Jtu2M3GRUimW80BDQRLz4WIFdPkaVsKEYeZOBys0iP6HLAgsKDeDwUUQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773846; c=relaxed/simple;
	bh=V/HJ1KrVmX4myFl3XBiFsO/8ZGKvyPexaKChs4eLUzU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K1XSWIFNh/sfQYpkbyYokWLf614pKHnd/rrM1cycwBn2/2MmKxpe/RfmwQt/yhgm3xhWMLUh+ro8YYN7ie5ZLLFhtz8AXWzIuKyN7IZcWBiYsmN65LC99fD9gyMNFTmLffdTIeZf9UkIYxHncVeyl9TIH7idnOkboP2qp13BnEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqOVrbt5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqOVrbt5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563321F000FF;
	Wed, 30 Sep 2026 13:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790773827;
	bh=V/HJ1KrVmX4myFl3XBiFsO/8ZGKvyPexaKChs4eLUzU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nqOVrbt5X8SXnzLUaLioT9QGyKz9qMOQdJnJ1bQGQXvrvOfONThjGFMaDvF+hkU7E
	 SzOFFjUvD1EKwgqySORrzzAJEz+i6tagXFDhm2+vm/XXIz2RERIrF/iA38SnM2Ze6F
	 Xhie4daZTUx6g1fuomX84NnKWBF1lglRjc5XqjwB19RwLlP1I+XCi4hA4W2JMhPudU
	 d5bmVdB+JrPV5V8impebaPpF7GfxTXP7VODvYNh/HzBZZdk8xqI/fRimlkFwNhSSTZ
	 C90juKcrz73jWFXuIbAE93C1/TyboD6duwUr3CLp554HE8muo37JJdbTkxhAM15oe4
	 5fg5YyHC6wtBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v26 2/4] rust: leds: Add Mode trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: lee@kernel.org, linux-pci@vger.kernel.org, ojeda@kernel.org, linux-leds@vger.kernel.org, gary@garyguo.net
In-Reply-To: <20260930-rust_leds-v26-2-83837331020e@posteo.de>
References: <20260930-rust_leds-v26-0-83837331020e@posteo.de>
 <20260930-rust_leds-v26-2-83837331020e@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 13:10:26 +0000
Message-Id: <20260930131027.563321F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add the `led::Mode` trait to allow for other types of led class devices
> in `led::LedOps`.
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-rust_leds-=
v26-0-83837331020e@posteo.de?part=3D2

