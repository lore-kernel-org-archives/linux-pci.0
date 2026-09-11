Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB8B4AD7F0;
	Fri, 11 Sep 2026 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154746; cv=none; b=GORMg6D47YquOn8iIQCvsIaNU+9B5xc3oa3PbDj9w+6neV74WVNDOt8NlMFsb2v0M4vX+50CqswOkqXwNPgp7wd/t54w3eJ1AJODBCDO1vaydZsHmGYiVH4Bmi6yhQ8YTPb1wmGFFtrqaf7De7TrbAdaxFtxO42yL+y1/Pirrag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154746; c=relaxed/simple;
	bh=2dckg3XgpMname7ZcyLKqgOk+jyJGU4Vh1UwraiW0aw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DNjnwzSa2mezeug6ObjzMZto2/820RIiPaZ60HA8Pjk1qyzj7g9xuHuSlONFWKVvkn6XE2xtYmyG943Osf02h4oLGhk9phYgVtkRd271Ynqmd+MBMc1pY9XAzLJKERPZVApXDjyPsAUZIlfnpj7a22xD79KAT/IKmym2m+IRoik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwT0Trti; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwT0Trti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9CB1F00893;
	Fri, 11 Sep 2026 19:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789154739;
	bh=2dckg3XgpMname7ZcyLKqgOk+jyJGU4Vh1UwraiW0aw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IwT0TrtiRlESmO+DvJs7VLh+bCC3G1S8HzNcle4lstCvfKDwRdtBggwTg7bjbeJte
	 qtYZD3qqBleeOVDxIkYBGWnsHKzvjfVCLQ9azWNquvOXVl5S5d1MpMBnrn4l3Gml44
	 iFW9q2xaDc2diiz+8mp+dozIGrkKY0FArDnH1MYM2Kpv3EijPi3gWOBlIQyIZct+Kz
	 4+xjqRJNDzmQ95s/e3Nr2XQnl8ZvzKFjiXaTtfgv4FOMuM64LOmvmFl6ch53lAlaOS
	 JaM4IfJLkipjPl4atzIJFbfW66iiiQwG2FFsEpmxUnKgBfnhdRKTge2tbT1TvSHyz1
	 qqaL4zaeQ3mvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (k10temp): Define unshared PCI device IDs
 locally
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-hwmon@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260911191803.1522358-3-mario.limonciello@amd.com>
References: <20260911191803.1522358-1-mario.limonciello@amd.com>
 <20260911191803.1522358-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:25:39 +0000
Message-Id: <20260911192539.AE9CB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Headers (now) only used by k10temp should not be declared in
> global headers.
>=20
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911191803.1522=
358-1-mario.limonciello@amd.com?part=3D2

