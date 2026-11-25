Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600009;
	b=hJtlYOF9I+q+TMmqc/IAFa18MlVMdbehPTzHQITarrpo1r+6tdlbGBh/LDJqsDdMxw95
	 8Jl1lr37BzJ32JmWkzFuWanWyFt1R0j55GGoNXj5tLfdkWteB2fB2wzNeGwpMzZZnUmTH
	 w2DKofCD7QIK9EmEoJB0quQ4Uzw4rV+El1tYRd5aj349uhf4vb0equ+AA/DW/pQ8OFMMv
	 ZiOQsH5D+oagCey4qiSvGE//BHx9zyX9TnxakL8tzdQI5AChuSX52K9kzWgYvdheAOj+T
	 a3hfVgXmk+e5kkQW1FCNHlb7kR5zF0uUPOyZek/IL5fYNd0bZeA8153CrtmHP0vFjTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600009;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hKy3F7QflSN4E7miJfAg541iOG4ugoas2g8RFjIklyw=;
	b=AEkNTmxMI3UF/ECjFEOSmWWZdvYvE+4Z7TDMTGd4/0lv7OSwqAK+uoyPEuoriXSGHDQv
	 8O/9VREElgtBEhx4CbkesMH2KONnSCQw3W/rqfVP773AlqwVPBv5Stx93aC2eBU7qF+qi
	 X0Q3Y7M3fsjHpav50xDewPinvwAIPLxTI5vzhR8JFV3+HSxVgegihy5RaLjWu3N/6Bf+H
	 P0JofXPD2i+uw720BwZ4By/Kw2iY4ThVOQ2hO6bQlySv2CkYixvW8txwNaGrWME1zwmii
	 IC6hEXQgTUBxtRJNpfzqimrUUexWcrqjz3/V1nEoPJl1KuikpOsocVuVAgIscjxcBLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ut8NWOhS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC87606A331;
	Wed, 25 Nov 2026 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ut8NWOhS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B981F000D8;
	Wed, 25 Nov 2026 09:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795600009;
	bh=hKy3F7QflSN4E7miJfAg541iOG4ugoas2g8RFjIklyw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ut8NWOhSbjSuEcbpbCEwKZcfcoRsKOyoWG/UmoXvJmrCrtzrlhzuojt9bGnwWSs8a
	 p0cfiZYOFdcQdc3qc4Tsfr8E67HUdv6og1aP9gaMGRRcucFL4PQNSux0GN2xo9F+Z+
	 iRJDZS7tKDBkn9+PDsPF55212BzT6s52IcOcYcU8sUU2FfcVWua2wxvQBtPbNyoHgB
	 57UVzl9HTEQ92PYlyw2lSkCti90ZPKczssobRpDCH2w6iEVU271z0SNdDXzPGqmeJg
	 RVL3BCQhAIOi55xegiNZCBG62yYVJURbSsiJeFperw4Zi3rM4wQS8OiHJGfX+X4aZi
	 01gek9/1TgT0g==
Message-ID: <sashiko-outbox-233071@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 00/33] driver core: Authorize device trust before
 driver binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 09:46:48 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 33-patch series:

- Patches 1-5, 7-15, 17, 18, 20-27, and 29-31: no issues found.
- Patch 6 ("USB: Reject usbfs connect requests for unregistered..."): 1
  potential issue (1 Low)
- Patch 16 ("driver core: Add a compatibility API for manual driv..."):
  1 potential issue (1 Medium)
- Patch 19 ("net: phy: Use the compatibility driver attachment API"): 1
  potential issue (1 Medium)
- Patch 28 ("PCI: Use device trust for platform restrictions"): 1
  potential issue (1 Medium)
- Patch 32 ("USB: Authorize interfaces through device trust"): 1
  potential issue (1 Medium)
- Patch 33 ("USB: Authorize devices through device trust"): 1 potential
  issue (1 Low)

Detailed reviews have been sent as separate replies to patches 6, 16,
19, 28, 32, and 33.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-device-tru=
st-core-v4-0-037eb0d17b1f@nvidia.com
