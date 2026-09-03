Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0823329B799;
	Thu,  3 Sep 2026 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422838; cv=none; b=WHgbRN2pU7HF9jm95vZZU09kYOhDlAAtk6OyVUF//d5QAY/3BUW8HIiF8yh55IdBEtceI8narE1Sq8Yyp4ROQf589PffCDH5AtW3oM0ZR3mViwZOv1cPSoImJnTcs7eaHbncYJI1ILDg+9mqxv0JohFclojSo6i8gjj3zF403W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422838; c=relaxed/simple;
	bh=k1KnL4tV3t2ew65+gfanQAgEApLbO+2Gh2s2IMO7Y5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lKyLYuuY3x3jVP1aTqE17NqVbCCwnKrwkjv2VTN34DDwHONIRrZBcuz8yBTgUw8XWQHz3ptfHaPq2gEqgh/FEqVl94tR8EnlllwA2/BrZ/xtTLQulMb3t0K6mXV/y6MI9OIPw+w+qLOmqf/DlPL6Bczy0nF8skzpecirY6uVP98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fq/sCptG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fq/sCptG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4EA1F00A3A;
	Thu,  3 Sep 2026 08:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788422836;
	bh=5AK9UYsCyw/bLdd362buqZ7Z6RDUnQhSTSDnTid+R+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fq/sCptGnZjLp33aDfwGNM0tqZqB6UL8+Ij04cnDqYfkICvHD68AVWu0GwTs7WyWN
	 QLkNA6rhgR8zfaMDR5RL2B0hR0qrA+IgU897p6zwHRga+a8fHEiVS49SlYhBoFckN8
	 BPQz+nWHt2OmIvRra5eelDr6hq0dKrKGRPdtG1yIlMtyKZ3FgzaCHcB4dUMTZ6kV0+
	 ETLa42Aa+niQIaY4E+SVn4gNTJZRyWGRnKzfSK9wUnh9NVlyBYJYluYATWI7kHpw+V
	 WfEb1UjmrbuijCRXSC+dlr+ROsGTK+JktdzpyKVSgpexCdiX8K4rxJCTUFxgHBBszG
	 UbvG5/2jg9BlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] perf hisi-ptt: Add parsing of supported message
 types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260903075241.1445338-6-liusizhe5@huawei.com>
References: <20260903075241.1445338-1-liusizhe5@huawei.com>
 <20260903075241.1445338-6-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:07:16 +0000
Message-Id: <20260903080716.6F4EA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Classify TLP messages by Header DW0 Format field and Type field for
> both 4DW and 8DW formats, according to PCIe r6.4 sec 2.2.1.1 & 2.2.1.2.
>=20
> Parsing packets into:
> - MWr  (Posted Memory Write request)
> - Msg  (Posted Message request)
> - Atom (Non-Posted Atomic request)
> - IO   (Non-Posted IO request)
> - CFG  (Non-Posted Configuration request)
> - CPL  (Completion request)
>=20
> The parsed message type is stored in pkt_buf->pkt_msg_type and will
> be used by subsequent patches to select the correct field layout for
> DW2 and DW3 printing.
>=20
> Reviewed-by: Yushan Wang <wangyushan12@huawei.com>
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903075241.1445=
338-1-liusizhe5@huawei.com?part=3D5

