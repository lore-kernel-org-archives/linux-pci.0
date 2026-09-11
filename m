Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781994718DE
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130430; cv=none; b=gwf7OCXlyNQVcdOxdHmLuRtfpNxbC/6MskeiHCzliE5pDGkNZL8g8cv82sGOiZGiO3UUchUG3I2mS5cyqg4k4NrpaY/Av51OZY42pQmDYKpLyzVXbpH3P8PY6GtYTJlh0mpQfceq4HO4ZR8q4nowbiYbr69eYNHuINBWCflFvEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130430; c=relaxed/simple;
	bh=3ANjtR2iBcTgOZsSH1PjrvcFGE0jvuprXXu6+vl9was=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fzfiyjCREXfZ+/PNXl7QzjWvhvwdSBeTTT6SJZFjFe/5/cSRMBhs2CV+dkbnPH9Zlm3s4ceJJY3rIgoZ5ePL1a0m5FUe0rSiVso0CkBuY9lJpI+eG54Xg+0NktK1j/wjs1eZKiFrJAesk7YyfFK795KeHDS7Wzx9MB0AuvI0cVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8tfgO5M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8tfgO5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BC31F000FF;
	Fri, 11 Sep 2026 12:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789130427;
	bh=3ANjtR2iBcTgOZsSH1PjrvcFGE0jvuprXXu6+vl9was=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g8tfgO5MOMLEuI+zXwG8oiVIWieYvzZG/Ya/9z9W14LwsqIZZzHm3jzaJstQhCBMp
	 e8YT2w9RRb5VS869Hf8EgMehMDgw83vuGxQvYRLw3a/JxItplhk4SuBtlIGjIPjFhz
	 XsQqveMb18I/362npy7G2a+mHmLMEohsPuGx9zcrjqABTX4Syoorzk2OuyUOvXCitF
	 j2RY4nbp6/X1O5ahe6SQ9LuuElrDYiTj8VdHlGDIllhFPt+n/C70M2rFGd2pUEE4y5
	 wqQugkozdWnjAFzhCn2eFxYs2FqYbthO5NGac9w0DGhANj37j7YhrMTm47KpLDjFCv
	 /YvtSuO3pLQGg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/8] PCI/PM: Convert pci_bridge_d3_update()
 recursion to iteration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavol Sakac" <sakacpav@amazon.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911122958.88717-1-sakacpav@amazon.de>
References: <20260911-vfopt-s1-v1-0-693271dc0226@amazon.de>
 <20260911122958.88717-1-sakacpav@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:40:27 +0000
Message-Id: <20260911124027.C0BC31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_bridge_d3_update() propagates a bridge_d3 change to upstream bridges
> by tail recursion: when a bridge's bridge_d3 value changes, the function
> calls itself with that bridge as the new device.
>=20
> Convert the tail recursion into an iterative loop. Each level recomputes
> "remove" and d3cold_ok exactly as the recursive call did for its own
> device, and the early returns become loop exits. No functional change
> intended.
>=20
> An upcoming change serializes this update with a mutex; the iterative
> form lets that mutex be taken once per external call instead of once per
> bridge level.
>=20
> Assisted-by: LLM
> Signed-off-by: Pavol Sakac <sakacpav@amazon.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-vfopt-s1-v=
1-0-693271dc0226@amazon.de?part=3D3

