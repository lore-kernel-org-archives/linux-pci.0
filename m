Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605283;
	b=Onq/hZXynHQrRaJU3/fPFzsvqojygNsmkYZ2UZgjrgo+lwHpkfjVzph3Ha8tBmE1SmrD
	 64SUxLsh7kSiDkgCdAYsk8rw8NEzdh5XH1fcuUX78gQJhRcaHSJF5bu0gSrTjZ8ZMOnbY
	 G6aAdgzpLNHP9pSk8P6N7w7eHjqS4hFK3KQjo4gRnm5bt8vrwlUI8u7TD0euEvOSM/Yc5
	 f/3GJ1ew4nP0tAcnqRG5A+MnPRU0/gswc5XdQD9lanyRvECepURa9iFgF9Yn/gJ+JACHn
	 msncy5pViWBUYJ29yLgP/9CsaYkX+Nd0cpR15tpppuJFTFddmAMr/QSXWc0Eiy6uCAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type;
	bh=2yhJqGJwsokUrMpl5I41eEFgDlckzi/juni7CRCekDw=;
	b=qyl8AT+A/LG5rmJDfOtQcUYOrQjBjxmgHWqC3rHyBA7VHU83/la0hJQgf8IO5U4HnQQJ
	 3c3fp3XCfaDAkkTOrIztjmoHUGz9is5DSNTJ0EeF+OfEz7lU6Yr2rpxw+koH0rkhjUQM7
	 Nv+itOJe5RdKknK1xM7mXReA4nW60e5sTZCW/MdcsBojf7qou08BbC0cpKmIyMBtro5U/
	 KQVgtsGGDD9/c4ChEUX65sGr8BnD29wyLajIarL4vY/7ASEAsWndSKeue0QFJ+PzlexrP
	 b+kvbyYZw40L1LO2J5vtPBh9hhjqoDXzWtN5Z0Yc6oqi0BkVT6rrYlXk9sc7TJmvmuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lIAJO7o3;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64792606A32C
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 11:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64792606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lIAJO7o3
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4d427836e9so764715966b.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 03:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605282; x=1796210082; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2yhJqGJwsokUrMpl5I41eEFgDlckzi/juni7CRCekDw=;
        b=lIAJO7o3wJbLhm/w72Q8DztSLynxpak7pj+8/V4bXpgg8ofj4SIw5jR/Yp7gSvkrE1
         h6ftOmUwk2EqE1eiwW8Jk3AymfhZHJehtJSIo/8BXHf5zTpSz5yobRhESj+Xxk4vYPzr
         e7ZdYnD5pb1HhyXgQd7pYNMIq8eJAv/Vw8uSCvGguU98Urnx9Ob3KWVsQyIEkH18lsNs
         PiJ5wQWO2GINSQF6y5KWewYIgYpHZTlNFMeU6HBkulCPFrp0qmnBFs2pdXmt4gBWFxem
         cED6bBqyYk9JWcJcYsl+D3IfZLFe4RBsW5iVqLQD5WAGZxQnsmYva3PHOxb5HS1pBqO3
         7zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605282; x=1796210082;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2yhJqGJwsokUrMpl5I41eEFgDlckzi/juni7CRCekDw=;
        b=khCKIo5BB5aA0Qn8KJGhR20StpALl+gCkn+xdSz0dJgfWvOLUz5Z2fsFnThnUU/eyO
         +5beK5bDhdX1rmrvpO6lurKbgsPQy4jFPtByypKHUFd6tkm5B0NknngQ2Xe0hBGV8wrF
         ZqXFEkWmVTjSKqoGri0dsGkwtqB2JHHzqsSsPaCFiHsig3jRDF2xaMpFVhqHWh+4sXwh
         tpacVc6mWipKgt+WXJM/vm57PXJDnftxIhRY0xj4Gj6UOVpFPVwWIt53alAqHU/o4iSI
         Tiv1700D7JgCpg9zspFMowpJ/1TIurkJ+Br3OP84yrBqqg7w22CEYsOTRJPswvzAAE/J
         xElQ==
X-Gm-Message-State: APuU4Z/egn47lugSUEzzTjCn43BA+HKH6JuX0iYchr0yOaIDF2Rm8/jQ
	rkMl72fwE8A/1+kBb3VfubKh0tGTY03k2Z7ZwFqeUyxM4Gb2x8YtEbvC
X-Gm-Gg: AZFdTZeFpZ2f4gEZ+Dck68jXTkxarAdTvzGu7kuKj7ht3jJoNfLtUQEBI4p4VfMJwHX
	Asigv2JAnc47in2IrYo26qdyzFKJE42wJ7VyRIvk1bm/Hdnk8FtsaMkmu5Nhwq1BrA17fTUNrtp
	ff1ymbmB1f4NZIK0Pan6s0r6QM1HyQgO11e7yfaMFedIldFRtQykXqRlkUT+75KxYvOyNn7rt/f
	avCYj2OJWbRPfPo8z04uK7/r3ZvtVzBxujWETiHmWQjMhxkvJ1g+05ueEcqsjmZddBgapDQiC5d
	IYm7h+8d+h+CCDbJeRxTCO7Sh3wJolbrOT1NiRWaRqLo6Bii2kyEs9flozRZhe0b+AW9U5O7xK9
	/JG27ZKZxt3cUqdfuDblvtAVqy6rFGHGoEyIuP4FzvKh59eApj2Uityv8JQtnIDYU+tLBE2fZLz
	mNb6SdkwSZbv+twINjyC+bmg6dvwozpZoZtiy9HBxahk7zLyXrd27z8XucVLNrUeODAcEYcfwpF
	1pwuZwZYM1nPFuV6hrSDikWQpjhS62A6UwJoRgFy8ufgocC72V/Gq+p16e8gb4/tOvTrKLAWJyW
	4X2q+FmzvcWAUJIu6T4njfP1jm7DlH50rnpSelwg2SXymV1xF9OKuKdIfpMp3Mqv4xyU7HO06C5
	9yzJx/9wFzg==
X-Received: by 2002:a17:906:17db:b0:c46:9ca9:f524 with SMTP id a640c23a62f3a-c513ab404cemr1092017666b.32.1795605281488;
        Wed, 25 Nov 2026 03:14:41 -0800 (PST)
Received: from ?IPV6:2001:818:dc1d:c500:21cd:8ec9:48da:59ee? ([2001:818:dc1d:c500:21cd:8ec9:48da:59ee])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c513afec08asm623083566b.73.2026.11.25.03.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:14:40 -0800 (PST)
Message-ID: <174deb71-d920-4355-827c-73237678b82c@gmail.com>
Date: Wed, 25 Nov 2026 11:14:38 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Disable async suspend for AMD rev 0x62 ACP and HD
 Audio
To: David Glushkov <david.glushkov@sntiq.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <5cdc7ef0-e18f-4afc-96b2-ee4e92bc29ee@gmail.com>
 <20261110125025.2753861-1-david.glushkov@sntiq.com>
Content-Language: en-US
From: Diogo Sousa <diogogsousa@gmail.com>
Autocrypt: addr=diogogsousa@gmail.com; keydata=
 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
 hq9XZVX1eRVA
In-Reply-To: <20261110125025.2753861-1-david.glushkov@sntiq.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------BUIOuQif0viBBgLE7Wgu5beq"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------BUIOuQif0viBBgLE7Wgu5beq
Content-Type: multipart/mixed; boundary="------------Kr0y0KJY202boYqvCARElWSq";
 protected-headers="v1"; hp="clear"
Message-ID: <174deb71-d920-4355-827c-73237678b82c@gmail.com>
Date: Wed, 25 Nov 2026 11:14:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Disable async suspend for AMD rev 0x62 ACP and HD
 Audio
To: David Glushkov <david.glushkov@sntiq.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <5cdc7ef0-e18f-4afc-96b2-ee4e92bc29ee@gmail.com>
 <20261110125025.2753861-1-david.glushkov@sntiq.com>
Content-Language: en-US
From: Diogo Sousa <diogogsousa@gmail.com>
Autocrypt: addr=diogogsousa@gmail.com; keydata=
 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
 hq9XZVX1eRVA
In-Reply-To: <20261110125025.2753861-1-david.glushkov@sntiq.com>

--------------Kr0y0KJY202boYqvCARElWSq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8gTWFyaW8sIFZpamVuZGFyLCBCam9ybiwNCg0KZnJpZW5kbHkgcGluZy4gTWFyaW8g
YW5kIFZpamVuZGFyLCBpcyBhbWQgb2sgd2l0aCB3b3JraW5nIGFyb3VuZCB0aGlzDQp3aXRo
IGEgcGNpIHF1aXJrPyBPciB3b3VsZCB5b3UgcmF0aGVyIGZpeCBpdCBpbiB0aGUgYWNwIGRy
aXZlciBvcg0KZmlybXdhcmU/IFRoZSBsYXRlc3QgYXN1cyBhbmQgbXNpIEJJT1MgYXJlIGJv
dGggYWZmZWN0ZWQuIFZpamVuZGFyLCB0aGlzDQpsb29rcyBsaWtlIHRoZSBhY3AvaGQgYXVk
aW8gcG93ZXIgZGVwZW5kZW5jeSB5b3UgZGVzY3JpYmVkIGluDQpkcm0vYW1kIzU1MjkuDQoN
CkJqb3JuLCBpcyB0aGVyZSBhbnl0aGluZyBlbHNlIHlvdSBuZWVkIGZyb20gbWUgZm9yIHRo
aXMgcGF0Y2g/IEl0DQpzdGlsbCBhcHBsaWVzIGNsZWFubHkgdG8gcGNpL25leHQuDQoNClRo
YW5rcywNCkRpb2dvDQoNCg==

--------------Kr0y0KJY202boYqvCARElWSq--

--------------BUIOuQif0viBBgLE7Wgu5beq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE85oHCWXU2i7ehQp93pPwU2yxodUFAmsGwx4FAwAAAAAACgkQ3pPwU2yxodWb
DQ/+IkbkSqeeE8Rp9F+xNfCNMwltb7s+YLccrNd67o32nfPps5MzcrQuqBN18i7Bpg9Nzhnw/5Hc
hXUK3ErBSVtReVTu2EAoc2t9R0kjlWklO/iUhrg8fcELfxlwReljwrRRneBet7XJZOuTsur90Nuc
rljJ4JTDzZENzgk2zntkxxf8p9sXePvJ0VyOdarg1TFSbTYJPsOb242ZrF/g2McQLI8eQD120s70
28t4SDh05y7MpFWoa6cf0oFEQ1MMGnM5u9Gd0weJt5xdGpNAk4ua5thU5WWgfaWCaHAoOz7F+kyx
cOG0mENn4/NQwlNB3neDrJdStTuQiXBNBwMUk78AIO+KlrzivHGwLoE7xF8yCjVIQ/9BiUPAycxi
UJhJxlLEF2YmkAwhxJAjPe+7Bpo9dPTTqzsAGeKOm6u1V1kdHppEgCF2VQfKwNj9/F+fXn+01gvf
TDUZ3jsz/ktRlzrnK2cVNDoDv4HSDCaFMwNeGkKrs3uUgJwbM0s8T3pRaxQOrQqJJD1j0QmY6FeL
js4v3n1cv300iRMo1ciKVaQBGaod3mXUffdNnsIdx3TR5qZxu4pJSK5ewNHnDL0O8+cabyJNg9Xw
zOPla4Y5FDcWohsU7NZOxNr+CQ1Ap1gfppyG9YsLiRN4YsxPCOO7tJBaRl0Ck/IxFl9YPUr5O14T
wJ0=
=haqq
-----END PGP SIGNATURE-----

--------------BUIOuQif0viBBgLE7Wgu5beq--
