Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443055;
	b=KoUk/HE4wUjr5TVIgs5sLl+n5a33M9Jfad21E2JUJ+R2uiuc0YRqo6eJfzbnQMjvEnGz
	 KQNiXvE0LotKzZiZ+v++yMJLZiMeeCM16GhjCQQC7oRgWlnbCmMIpI5IwXKR33L+L/7dS
	 2sfyEqDd0GYTv3fdkHQ8NZBm84TCKOzOUCOg2o8RIJ4ulB3sZg3oyFvyBSgrcr1N7FhVh
	 2Pbjvw0xAjQ2AbRYnO9XNWSk5W+8gATX2XeJ1nl8B0H0b3lqQifq66wxpKM9Ci8PMwohV
	 vq28lWUoo+U0Tj3ieosN4BCAO1s0KNYykXqaarGXP5kTHhNaKu1b0GH9/zTafAeAU5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443055;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v2lxdYk8DXGClWuInJHK8nzoaVBANXo7fkWlEVhR3XI=;
	b=N7Bu0yL+hCXu5dkASwIM86qmRayGCoTxbAQw6Ns+rxs1oXciedZP+I4BO538Vaihh+P3
	 QIiY7pxLN5I1DXrl3Va1tAF3QiX9nh58gyjY08cJUQhMRI3nvKeMetolUqurosxM1P+6X
	 1AzztfVV1C9Rv5UrMwBjZ2sXdX/n25OmwiGQ8/BEA3wMMjLa0TIysCnfs9xcBPfbtwKpk
	 7ZaxGhPLJbPCM3McaB7W/ncnQpvUD51GTqM4qS1QVitN3/Usaj8V7jC1d/TpIoYypVmFF
	 Sxt5ejlBJGQm0bkhwxjq1G9ccujSdlC2b8YlmVHhP9hwJFMNIIm3WcxrbcwijAAYBTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VL1nUjTx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DE4606A31C
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VL1nUjTx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077551F00A05;
	Thu, 12 Nov 2026 00:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443055;
	bh=v2lxdYk8DXGClWuInJHK8nzoaVBANXo7fkWlEVhR3XI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VL1nUjTxFwQYYeppwgftTEEzk9UmbAg04r0feR6wjQri3xg5VFZbYtbdOZEIOHyEe
	 PcY9RLal/i4jD3yzuoIFAeb60EzeNbBS45sABsoYAcqBeqIj8t+o0R4SioUGKNIhEI
	 mvzs0Dx5pehrHdcuegA3wKmdO33zzT3qLV3EWp9r16ZZgxOeg79Fnxh1JwCPNTWCPS
	 IiSVEVD4fPlyMAA5Z25vyFNjo3IF7hzMwDDHq5lxTU9e4B1TOWYLZ6NSiy8ow24jvi
	 Os0ZfFklcl7A7YDwsqTWH5E20mJuXGKRXBpzqBZ8IRLKfEHED7m34iFroftPEX8a7a
	 pRAR9dilo2zbA==
Message-ID: <sashiko-outbox-209908@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] cpufreq: ondemand: Include <asm/cpu_device_id.h>
 unconditionally
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavel Popov" <pavel.e.popov@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261111234821.4814-5-pavel.e.popov@intel.com>
References: <20261111234821.4814-1-pavel.e.popov@intel.com>
 <20261111234821.4814-5-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:24:14 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> <asm/cpu_device_id.h> now has a generic version, so the #ifdef
> CONFIG_X86 around the include is no longer needed.
>=20
> od_should_io_be_busy() still needs CONFIG_X86 for boot_cpu_data.
>=20
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111234821.4814=
-1-pavel.e.popov@intel.com?part=3D4

