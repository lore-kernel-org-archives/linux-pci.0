Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2763A451B;
	Mon, 29 Jun 2026 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728434; cv=none; b=AUJd0tq3U9jc0mGcTV0qrKmzb5lEXcTapetDJ8C4tq2OvRB3f/QfWKRuTcR/XrDGwdP1kIe2pn/XRcbL2QwCI74jtYIgKi9dbeJ7XI1+oLicJzy1qcZT3H+wI6oMo38Ng3OotO80aiaE4Wl0NR85twvhYljJwtAB3dHXgK8ZiVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728434; c=relaxed/simple;
	bh=cyfDFe/DLLN4SaT4lKBAYW31HJPeCQSAaNik37VE+fs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=utxdQfzgclfvUSwAXcproZ8tSgm/EiJXEv9LBWZK/QZTW76oF7rYyN+erR8d9R3Yg0Jw5uqRRlGS6GVAeCe8SLBhCQi2nnTJp9L1dgSrFjb2spg+kVfyu7rRPcPketMBbJjktYlcxL0Ss9B920+yykMaAjekP9sYUIWjUlOay8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otGBEeM7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otGBEeM7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032251F00A3A;
	Mon, 29 Jun 2026 10:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782728433;
	bh=cyfDFe/DLLN4SaT4lKBAYW31HJPeCQSAaNik37VE+fs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=otGBEeM7iF9uYA5YPtynRCg0EQqTA2nRoRLojoe+LA86HdhwvbZFTOnvTTIJOsi10
	 JkMtgOQdxKtpXpMJa+fwQ97DqzzRR7VQqI8QFqGbBanysBRK2LEa2fnIJscS1HS2XZ
	 EOTRJ/8GTgfe9Ai1zEDXGXLnY/E7sbRUetQpZGJ71P9EygAnYhFtqr87ABMfA/orvf
	 pqXXiqbW3eZP/GWeYN1Q/vYI5u9F1iF+VQk5JALE1iyh5Uhk7b/Rsn0sRY3EIClHLh
	 c9ggfhwdcmSk2qm86EOEu1Ana6hYsa8pB/3FYMx8P7GtXRGgdmPsoEvqTGxihN8B7Z
	 +GKIPZyntCHuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 2/3] rust: leds: add Mode trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, linux-leds@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260629-rust_leds-v20-2-f493ab053b4f@posteo.de>
References: <20260629-rust_leds-v20-0-f493ab053b4f@posteo.de>
 <20260629-rust_leds-v20-2-f493ab053b4f@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 10:20:32 +0000
Message-Id: <20260629102033.032251F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-rust_leds-=
v20-0-f493ab053b4f@posteo.de?part=3D2

