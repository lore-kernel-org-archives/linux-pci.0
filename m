Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8148040BCD6;
	Tue, 30 Jun 2026 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823218; cv=none; b=JOwcLXFv5fYnwdHRXYc0b+c9+kwyqHsml6y9jz/ckcGsDJsHShKxWRvDlM1r8g4doaRLcTrToQlLDUIM0sSu9ov15Dqp9PDnTKKNDlBhbE3PBz7K/2Oyzgv0w/Yfwdf40bsHLDZDfizR3R4lUuDEGEVcBXZalNwoFL2BB7E9/9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823218; c=relaxed/simple;
	bh=9tEI3Mf9LgaO7NuUJ1Z1VC6cJGXWaPnICD69M0a8eG8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NeAETEoY32XZ0NeX2hRnyVRg3TuiKG8jq+6n7NZq6bqCSlLxYNBpIFHKbN5s+IWAkBlWfNsqCJmVQ2puT9GL2lJCrrObW8W1/lV/lJWECw8pIIrFgaDfeV+YlnXZm3PINybJBDz9fDfFEoltRANvAccdqHiU7llAuzof22Av0kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gf3ImPiv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gf3ImPiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB16A1F00A3A;
	Tue, 30 Jun 2026 12:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782823217;
	bh=9tEI3Mf9LgaO7NuUJ1Z1VC6cJGXWaPnICD69M0a8eG8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gf3ImPivuT5OL9OMWSwitcdZotgW2kOQeBCdoJjKCz1cOgGJAPNW6E87nQ6/0yA8k
	 y/mjumuJqOB7Pu3vCLWrbNlyQrECaoUSwbdREJ2FWpNtUCHcIIz9wI5JtvBtmBWwjJ
	 O5xhvckdbu22aMB3FGkFlqZPEnn1S8Ij02hIl6OoILSUcq8fDd5ZJzTbKmrZDu346W
	 8UmumK2eZvt86MXsay/p+KZdaNP90y0DSqQ07pVAB7gQh5vOsOvmZABZ2z136WGOzj
	 toYnAx/hAoBgyZsOO432B24c/qB6HbXe6qq3+VQcpkayH3nosFlxzA3eJeJAYjqh9R
	 opdL9O0pXBhlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/11] rust: driver: centralize device ID handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, robh@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260629-id_info-v2-6-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-6-56fccbe9c5ef@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 12:40:16 +0000
Message-Id: <20260630124016.AB16A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move the `IdArray` creation from individual buses to be handled by shared
> code in `device_id.rs`.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-id_info-v2=
-0-56fccbe9c5ef@garyguo.net?part=3D6

