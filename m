Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795317561;
	b=CtkBnX/Icfp+iNrsgKFgZQPxpV/qogO37iP1ayoNmBnShylQpg7bORlqC7Skx4UwdorA
	 yjf1K3YbMc3HdazuB1pdlYpVlx39E5eigAxGtw0L5BEAvEH6v4OK2hajipf81aXtDas2j
	 yrWYy7ydk3UvFw+7jpbVrGKLDnfKn/M19icnZQkciM8zXUHdWS95hcebDW9L2fKugYoax
	 7N/LyBZViuBKEEAWcBk/d79IGNGS3wn+NYlo/r9RZzxB3+tecHQ8qkfwOnv0MaS13Yo5P
	 1vQr/D7e8NktNLIaCfavK53MCeWlrL3wiBTzbAAED50/sp1XbS33brSgwKU1XC0zIkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795317561;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QQlRNMkIIaaxxq01UvKEdphWcxGway+9Av+1Vc6rCEo=;
	b=nC7l6lkyBP+VHdDa0qqWvAtjHPUofbzbtGR8SXX8XtI5NPurEKEnCPjfKOG7t67poaLz
	 SHXfpAsfc/cTGFWQbk4ZUvG3mB8QluzpzZN9gF1ADYMyF/BPPJTJB7ayGyy7K7VVpOpcY
	 8LmQ4QgEQ2WRKsNnp+5sL6RIWjVQ2aVOpU5L6yeWoFOTjZyc8A93YYkBauIteljCNQ476
	 sW0HHilMCZth4P0HTnwrU0oaSVy+DwYSjnR/bUb3eLjB27+tpmdar1inIovH9XdOad+q7
	 lqch8yO0MOHmgM7sWnGWu8CEIWwyG+cSomVccM4nYqIC14og/PQqS/wgHWyFQdtI61A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UuVO3BpN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DD7606A320
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UuVO3BpN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFE41F000C0;
	Sun, 22 Nov 2026 03:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795317561;
	bh=QQlRNMkIIaaxxq01UvKEdphWcxGway+9Av+1Vc6rCEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UuVO3BpN5ChKROIAFQOTk9b7P34SELFnc1ULAHJOEgceMvd+HTZJ+Y0GnPK91/XA4
	 lKQ26EGvpcrjvmAUgYmK9uaPn5gJ0eeXwSRCpnH4jnjjaahmpM4L/Ol7x/pRkhyDYj
	 UCv3xdP9Z2qvwtj5maGwCbIgdGRtdcyM282sN9TAVW6bJUcbN0Ae7jrSVtRIEPfCVo
	 Fbai9CzXE4w60UiegUTNTY42hvwzpz2g0y0KJ1mgh1+1ORXjoKF/nZabKZuUZTPIws
	 1gTeeQK3aHc6mLEVyB9PKNUXFXUn8+OEup162Lb2YiSLO7/OhLb3wCHByJX5e7iiYG
	 Swmw9OIEqomBA==
Message-ID: <sashiko-outbox-227670@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 00/11] PCI: qcom-ep: Add Nord PCIe Endpoint controller
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
References: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 03:19:20 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 11-patch series:

- Patches 4-7 and 9: no issues found.
- Patch 1 ("PCI: epf-mhi: Pass the actual number of MSI vectors..."): 1
  potential issue (1 Low)
- Patch 2 ("PCI: qcom-ep: Add MSI-X support"): 1 potential issue (1
  High)
- Patch 3 ("PCI: epf-mhi: Add MSI-X support"): 3 potential issues (1
  High, 2 Medium)
- Patch 8 ("PCI: qcom-ep: Add Nord PCIe Endpoint controller support"): 1
  potential issue (1 High)
- Patch 10 ("bus: mhi: host: pci_generic: Add support for Qualcom..."):
  2 potential issues (1 Medium, 1 Low)
- Patch 11 ("arm64: dts: qcom: nord: Add PCIe endpoint nodes"): 6
  potential issues (3 High, 2 Medium, 1 Low)

Detailed reviews have been sent as separate replies to patches 1-3, 8,
10, and 11.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-nord_ep-v1=
-0-6d8839ffa9aa@oss.qualcomm.com
