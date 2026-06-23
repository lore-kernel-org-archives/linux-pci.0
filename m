Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AE554774;
	Tue, 23 Jun 2026 05:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782191351; cv=none; b=V41pO/NxjzI7bGk+1qqSk+YuH3xTu2G29W4bsfHjFvMaGBBAfX9ZUizJQjczS/KBNdqvc2t664PPK6YK9pgvH3YnWESAqpUvBg6tNAoWscQQldZnlxobT71WKQ04cFWuu49c3msTM9BIhwvCb+EJowFcWHb6per2KVn+bM/M670=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782191351; c=relaxed/simple;
	bh=F143OFHqQSymrps7LjVoNfHJ1Shs9LeD5ajoub7yT/o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M9OPPgRHoWzMEDPLSr6MSV6vmWA5n/TtI9NYZ5+WjjfRf9f8GHfxrcAZpwH8JOm+QsInRTFNj7Rpq2R1dRAH8G3BztL0W+23k3brLeDS5RFZo0skckiepWvo8XGNyFEeCt5mwM6aKoBOS5QbeX7Frmv7+aKKvA+k/xQ5x2L1zoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGUu0iRW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGUu0iRW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC191F000E9;
	Tue, 23 Jun 2026 05:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782191349;
	bh=F143OFHqQSymrps7LjVoNfHJ1Shs9LeD5ajoub7yT/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jGUu0iRW5d3aoc7YIRjzeUPbKV+aZlFZLzRBguKN67B27CelYACKux2OeeKd+PPIF
	 58IbWr81G+cmky/Va5u2Sf8HG5Zvgs1B0uHM6GQossoma99bYYQJkPG19QzZfIozSl
	 YnMqaAaUE7ihZBfIPhfVBcVz1BCHXZBdXaSuRuklPGYi4z6kFRH8cdoSJ+clx0bBsX
	 GtYdutDLTcPF4U71LnB1k9dWCZcR3ouaoP/eMokkSOyBERJZjqDwk1reZEPaySm4/8
	 DgEzN+TeALMFp0xgVWqFqcUcGeK+EfdGXQM8zEMwS0CP595kBfMvc0zewLJsZUZij1
	 hjX8dJSbJguYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/21] lib: rspdm: Support SPDM get_capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260623045406.2589547-16-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-16-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 05:09:09 +0000
Message-Id: <20260623050909.8EC191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Alistair Francis <alistair@alistair23.me>
>=20
> Support the GET_CAPABILITIES SPDM command.
>=20
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623045406.2589=
547-1-alistair.francis@wdc.com?part=3D15

