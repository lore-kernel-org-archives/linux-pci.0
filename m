Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA34481FAC;
	Thu,  2 Jul 2026 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996603; cv=none; b=TPvQUOg8Np68Kpb5S6lkDqSVll8OEkvGBGC6LYjGYrUAxFi6CQwQssJSKH361REWy2f1OLeNuNswjmLcCP7i4BpO6Fnhqxm95OZajWqKeeh3LTX+mC9VRiexAK+9C5ImaY5xdSbRy7DeeaiyWcu2H2+66TFojHBWhI/4EXl6O5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996603; c=relaxed/simple;
	bh=IAFjru7ownuTfej9vAzInwxggD/i5oKzuX6B86AWdCM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FjruJXPD92hJe20ZgQu4BAfMebUv8h+p87uveH6U1B7aWoBhkYr1ebNFRPo/DYRdA3BkQ/LxeS4WxQPwvEXSRT5Iyj/NB20JGJC12bWWQ4XUuoj5cMHEEhkWxV2Eb4O7rnqQtkWp5e4vVcc/Az3UvLexg9P7vvsPXjiAC8vYSwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqqxPM/Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqqxPM/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC1F1F00A3D;
	Thu,  2 Jul 2026 12:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782996601;
	bh=WhZvuxQBWRdRkN41c6CDc5HvQO9pwDAv70+iuCX8TIE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PqqxPM/ZE6IJGjEoC6QlWFvTx/ugbKzm+dwvhn9VuyThRsYiVcDzRcS6Nc2SafwNc
	 2f1rKW3ejr5r/eUr+Xyf1Y+eoaOni5t2PZ8AfMI1Ur+YD/7/vWj2evFZltjOMhCedb
	 xHFbXAt7BlQzeBE1mICf6LjrgeeLgOHQRvc9gaZREaEzsq5X4UeaIv08Tpn1ViV8bs
	 2RydWdXtZrBZ4IGyA2S1gUmQFRknn7nfEe9DyK7t1/F8l0CqDVJekNqcCZfhkWcjXl
	 176o6uwKqm2YIPcs1Tbf8HoAPdWQd4uGhXy9SJMl51rCViz9Al+07kolj4h4zPH5Qi
	 sqJO2Y57JBDLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 10/18] vfio/pci: Introduce tph policy parameter for
 staged TPH feature enablement
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260702124224.57168-11-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-11-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 12:50:00 +0000
Message-Id: <20260702125000.EAC1F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a module parameter 'tph' to implement staged TPH feature enabling
> policy. The parameter accepts a value from 0 to 3 to progressively enable
> TPH capabilities:
>=20
> 0 =3D No-ST mode: RESOLVE only returns PH for DMABUF source;
>                 ST programming unavailable
> 1 =3D Add IV mode: RESOLVE only returns PH for DMABUF source;
>                  ST program supports NONE/DMABUF/CPU sources
> 2 =3D Add DS mode: RESOLVE returns PH+ST for DMABUF/CPU sources;
>                  ST program supports NONE/DMABUF/CPU sources
> 3 =3D Add LITERAL: RESOLVE returns PH+ST for DMABUF/CPU sources;
>                  ST program supports NONE/DMABUF/CPU/LITERAL sources
>=20
> This commit only adds parameter plumbing and state storage, no
> functional TPH logic is introduced yet.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702124224.5716=
8-1-fengchengwen@huawei.com?part=3D10

