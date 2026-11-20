Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182948;
	b=h67uUj6tCuBvwa0C+DmbnFOpxTYgPHt2kBUdlJFUi/eGce13JLNo6Krh7rcsE8q1elAU
	 gtQYvV6vXnpCIo/qsvq7HlP3AbkZCOhJpcHBkxSeV6iD58/A+/ef1BBHufrDA/GRLxKXo
	 GOuv5ixsz3uW9pH3qYezh1rpDr4L3gCh6Pt28YTa5b2kVoJdsqDK74en72epGgGsBigNP
	 yUvLQhcvDZZ7ovNRuIz4RZBGBH8Sbir2CnPzmUuRqCIFIuwsdGMBP9Ayd1nsNMuYTjpMS
	 ZCwm+FV9aDd40YKTYEa4ZCjUIDouAxCdAaIrVohYnBGktu/XcG5K2Z/ObWRAaeZ5Wnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182948;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uDBvxiyj+eBF3wNoBWVL9RTi7KuafzzRJZJe4u9BuE0=;
	b=xitE3jTm8OXOYAqU1BmvdyFiKM1cHB1e7etBvhRzNf7X1LOew8z7zo5fvZToemSkyLxy
	 e/xGhTJCuYlV6u67lglrIB5+wi8ltecXvs+zzp68VLIv2Q80T1U5RrEZzz0qNmr7Dbd2X
	 gtGJIFJggg4gRF7Kl7iuwLHGFdnX7AyAPQ5c6BPnU/jIqUc74Hky7HonjsbP/oIAM6zgP
	 CW8cwSPPgjGnP+j5QQl3//V41Er1K950M3jD20FdGNnu2AA+V748uZ6hk7bl6iwCzI/lJ
	 R5k24k+0hvzJRt+I4LeJOut/0MqWb3jKobPxBTT/JQUoD43QBnOXgCO+LT9IfJvQTAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVSR1WSZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C584606A325
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVSR1WSZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE801F000ED;
	Fri, 20 Nov 2026 13:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182948;
	bh=uDBvxiyj+eBF3wNoBWVL9RTi7KuafzzRJZJe4u9BuE0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=GVSR1WSZdddj9kxHId6+3Cs8UQwrwvENfsPianAcD885XZ/V7BnUXjRuhAb6PIAxF
	 xTVBbPJh7NVKtYtXcwNvR1LouXNWuP3+P0heOfvr3PmRYda+k2sYfx7X4au5wKD5XQ
	 UEwco/e1cDOGe5oQgJWWNsGfuJLfYFQoWF0Na989tlKg1vp3UPVKn0o96xkRvXw5h+
	 H1zYjgUn8jLXK/RrksQjLiL4NuMR+qc8LMQeJVNj92Fyw6eMWPiabTC3rd4sGvrn4Z
	 4ybmveT2bJpgNNPbVUUcqHD/6tvxuuulND73uNtVq3/oBnvib63fSb+eov5nH5ES4h
	 BGIdQYaxlt3kw==
Message-ID: <sashiko-outbox-225298@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/16] PCI: Remove pci_bus_assign_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261120134716.3027-17-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
 <20261120134716.3027-17-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:55:46 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The pci_bus_assign_resources() interface is problematic because it makes
> bridge window sizing disjoint from the assignment phase.
>=20
> pci_bus_assign_resources() is now unused so remove it.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120134716.3027=
-1-ilpo.jarvinen@linux.intel.com?part=3D16

