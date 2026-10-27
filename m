Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117747;
	b=aQlqBGtZCPHoGUYOj9cfbu4RsnXDyCsbVvjgtBG+MOGZjVk7C3Nkysf90tfo/ndC9qMb
	 Yszu5XUGkNb8hhE++kCHZ0I3jXzyplOZVteT1wuEfygow6voeETceuPgHY5af+HFKI+XG
	 5SR2+0KRgqM8yzNT/eQj+CSeM1707D05xITdYC/IM4eiS6b4Ta5m18cEi9Vr604tCXh8l
	 LpHu1cKyyqU5dCj+Jni9Oy3YJMUp9SiSrwBSlbcOHVWaV26YwUjx56ify+e/OpT+qDs3K
	 yUIPkXynp77D7cD/WzpNSKZRSNJTIVGmUhINY9pwCDcWTQRjyTULLEB2sPuxe3jmASQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117747;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gGy8DQdyZimehMjbGC0hmq0lwwsFZv5NHBT7UmiP+qc=;
	b=ncKm/31E57e43mKvXUu1PRFIGsYZFwQQQowN9u7vmY5nt1B9HaLbz2YMUpDkJjtfDglb
	 1Dci7goQutCcHz0TZ9h61V3cNH48H2J1Xv5jfv9X9jFaDZHHt3H9RK3qNUksJusHnvbPv
	 QpQNY5f+cAQj2VSGZZZveC6QAdgTWgHaHL62w2IjCFIhjQCn8COePuyuC3KFCoU9RQ1Wo
	 EhVhuqaYIyftXgvC7WECisD3a/rMfwmhGXrJDnevkDUOJj3c97YDffiLUjJfmBhdcyNOF
	 vQoJqnf8sdL+60PlsXy0K9jyM55YciuPjvob+1j7Hc+HhgBG+9lgq1QZcF7TMkw1yXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SHVRtY/i";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA672606A321
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHVRtY/i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621F81F031E1;
	Tue, 27 Oct 2026 16:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793117746;
	bh=gGy8DQdyZimehMjbGC0hmq0lwwsFZv5NHBT7UmiP+qc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SHVRtY/iXX2zjV4pRZerkwfwKQDtjsFJJhoKRFRV2R5eRzoNPmrLwUd84Tx9crujM
	 VLWYu/WKOAn60i6lvrV0wjBHrO72ZKsGbD0XEvaJGQkqkJik2GnrT4HmjJCepd6NXt
	 dq4p0SJ5BbR5KOmq9BtlWQk8gUtY2yfB7wWiu1VgNs+Ejo4QVxt1UBuBYajcFyF0Vj
	 xC6ofCweFlNNrO69vqp/+NizbZGmiAO1HlUIw01Qwf/cqbgtryGy9bD3dRbGuEHq+A
	 Sxw0DzPbJB9brZKTUCF9vOpjDHvYPgu5d1vwmp1hJd2018W4NhPqaNFO/G7ZQIo/vK
	 S9ggloE5on2hg==
Message-ID: <sashiko-outbox-186890@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/13] PCI/TSM: Use generic VF iterators
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261027160446.858300-10-lukasz.laguna@intel.com>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
 <20261027160446.858300-10-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 16:15:45 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_tsm_walk_fns() and pci_tsm_walk_fns_reverse() implement their own VF
> iteration logic. Replace it with for_each_pci_vf() and
> for_each_pci_vf_reverse().
>=20
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027160446.8583=
00-1-lukasz.laguna@intel.com?part=3D9

