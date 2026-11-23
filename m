Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466519;
	b=JEMm8J27edb6LOZQlqD5Pk5nQHB1pjb3g85yxdxLKiqZH8i8+MayiqscWqnNqetY1jXy
	 AxyKIIHsjm4eVHzUZ6yiG9DRlMs45NN7+dZV7lV9C1NWJTYg2fs9vQniYITAbaKQOIU5J
	 TewmE2Iig7NrHP34CWKHLi9GwHaUy029HbYYNm+kCxi7VOHjOoREKwqLvSuMTRvy4MlhN
	 e47DNQ+lUuSlNskCdMt71+gx6YO9iWYuSLhN80oYvD9RX2jU5gGO2xPWbwO8GF98jvh88
	 9GnwyUSnT8aS2ic/OcP4UpmgPN01RmLhf4derlhIz/OnlRsx/0RQ2amisBq07hVZkAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466519;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TF0CZsU9JDMTcQ7hywuaDNncVk6uWvyskuZ2hpNLRR8=;
	b=C7iW0AEhad+UrH2YzR8NDAXt9P9sVWJdBZwhreMz1BuXSpA9Ra/blcWF2nd4x0nst76i
	 STrx9H44Ssnqs3/GqwOFt2m9sL1rDhxwOAFvbRCEm+92+xfGqmKNmZe//pgYLM/3mXKuw
	 uE6MRYrMJHoUq3oDZGvwC7Gvpo31CO9I9a9EMhBzpAgY3qM7M4x0yOK5vxiZgNr2Id3CD
	 CCw3Q5oHESTaPFP7TB3HOPI26T7p5Vjvg7bAvvmWyVo55/eep+4DBGKhbcOibrIUvq8hx
	 4yapLB8Q4G2iuYBK22+oket4dN/iYakTFraRnZV3WTKHlAkRrbnrJI7/9f3UM8oYSew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AK76a6pf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A61D606A321
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AK76a6pf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0581F000CF;
	Mon, 23 Nov 2026 20:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795466519;
	bh=TF0CZsU9JDMTcQ7hywuaDNncVk6uWvyskuZ2hpNLRR8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AK76a6pfc5OTlUqGnfyYAxakF0/cXDEQ12YXRkoRvR1AA0uhgIEd9/NJQnbdAmZb9
	 /MRPtpIzDNWhVuyUMEOiyoNCNWLdKaYOAgDVV0qSgQe+i8qA+upARrchoO6ewzM+AN
	 EXn0iJZPFAcxf1qcJgZV4e1F43lGRhORdIqdG+8do+/oPdhLY6ogAJI53dyWRFLVK0
	 Ycrki/QyX4dEu9iyEtsK1K6iUnHHaw0KMRWpKDu3ZRqK4dBDRhi0T0i4ZbYz3BAc11
	 KYpqrLmgJVVvqtXmTLx8XiLzxXCbfq4/HHlzz3Ds6flGQK3KTcB3m9E4CBVnDsxbD0
	 F3ltj7RaI5SjA==
Message-ID: <sashiko-outbox-230015@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 0/8] soc: cortina: Add CS7542 PCIe control, SerDes
 and host support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261123-b4-cs7542-pcie-v2-0-f589a9cd0bef@gmail.com>
References: <20261123-b4-cs7542-pcie-v2-0-f589a9cd0bef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 20:41:58 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 8-patch series:

- Patches 1-7: no issues found.
- Patch 8: skipped (not reviewed).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-b4-cs7542-=
pcie-v2-0-f589a9cd0bef@gmail.com
