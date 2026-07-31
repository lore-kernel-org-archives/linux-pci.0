Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC2B351C04;
	Fri, 31 Jul 2026 21:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534062; cv=none; b=OPcLHpOrWrEdjlws/GqjoRNaERKNGtix08tKSKyt054+N9L06QRSCk9/zRaiRqE2JSocJGSzeOwZ2HjUWwFHLMBGSWf8TReB/BEzFOYv+8pjVul5M5jGGeiKobeSsl00Dmjh94UXA8qH14cpK9JALlU3uNGqIjur3vegQlYkVmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534062; c=relaxed/simple;
	bh=MEWFrheIN6k186IUD78pOxPlxUQ+UO+gos5RGjxkkd0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cow/y95BfcXGdcMNxTByS6usAepUS7pkntDbJiPgWdwsBmBaVxF+UzP5ozmdRwIuPN39WxYZ2S0WEsoPz3FpFbYgso/ypFrxpaYF0lBHkL+X/y1Y7jLb2o6Wd3ORFuDia0tY+6ZtdN/hi111bnXyQphA1ezkc4zqOn8qzvvZSDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVNe4e67; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVNe4e67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB391F00AC4;
	Fri, 31 Jul 2026 21:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785534060;
	bh=MEWFrheIN6k186IUD78pOxPlxUQ+UO+gos5RGjxkkd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lVNe4e67vIJl4fwT8LmY8QSKyBopiKaipmsa4UiWS8L3Bpz98KeAtpbNXg2RxdnVl
	 YngWU2yYmB1VyqtHqxZFvIDeimaKPB2hiYdlGOfQhcs6Hn38PyCXTCCEQXeZ6FKLjO
	 5227aFFxreYLm83nK52YFIujKLKVzVem628chGcZOk6htp7Syfb5INS8QqnP2+McVb
	 dtpDnd2K8HzmSHluXIhhgmsq5oYIv7kxtaaKq4ffm8ADXz3AvvEKwuftv9nnBn7onl
	 NbV0pgFid9ONsDZcoT9rrfWvC0/GvrdaGcDiSLXxV3V7mEg0f87jvchbqNu0tDUFCo
	 rOaYudFgV526w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 2/5] PCI/TPH: Add requester/completer type helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: dri-devel@lists.freedesktop.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260731211601.3033906-3-zhipingz@meta.com>
References: <20260731211601.3033906-1-zhipingz@meta.com>
 <20260731211601.3033906-3-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 21:40:59 +0000
Message-Id: <20260731214100.5AB391F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> requester mode without reaching into pci_dev internals.
>=20
> Add pcie_tph_completer_type() so drivers that publish TPH metadata for a
> device acting as a completer can gate on the "TPH Completer Supported"
> field of Device Capabilities 2 (bits 13:12, PCI_EXP_DEVCAP2_TPH_COMP_MASK)
> rather than reusing requester-side state. It applies the same reserved-
> encoding fold as get_rp_completer_type(), inlined, so the reserved 0b10
> value never reaches callers.
>=20
> This keeps pci_dev::tph_req_type and the completer-capability decode
> inside the PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for callers.
>=20
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731211601.3033=
906-1-zhipingz@meta.com?part=3D2

