Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33F730E85D;
	Mon, 28 Sep 2026 01:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559392; cv=none; b=r5qcIBYkcs4iRSGdXtiefd9gOuFp89fwfGIf5pL3vaN6/ERlA1WSzfn4Je1GoF2hcvwDUKsxBN7IisdwXSlgIBeTqwVQuvBPVBIZ0oFGETH5QC5m0JEQLuN2xlvpbf5jI7G92RV91LUYEURRcEPDU6eDQ/wmrtpWhATVhCWBL1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559392; c=relaxed/simple;
	bh=+v/AG90mzNG8+dWkDFsgKmhDdX36kzsSGGAKnmkbzWM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WegxE5/UDU8iURldSqR5udwnRz7RORQONNycl9DEUZo2ptez0wqbaGLfFo1TyjyCtnD7kvjs98hpPHV987bCg9zasOnr29FIr4EruPGf+vokNfoKpjKOT9CuZdCLYdWjxF85sAlEJMDrWXoh84BZLnN7ynBybn9OTR4b0/lM9/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxLZPqs5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxLZPqs5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD721F00893;
	Mon, 28 Sep 2026 01:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790559391;
	bh=+v/AG90mzNG8+dWkDFsgKmhDdX36kzsSGGAKnmkbzWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oxLZPqs5/dVhH1QmQDffpHxsau7yr3u2FXQqySCNAbRRPvEoxpYhlpDMnMPUjRNNT
	 MtZvthvFdATXjxS7RhNMammOhThsDAi+7KqshH2ebDxM+7x4M1IPFlj9j19jv7YQLV
	 T/Seo55eUt4hyQdpQ5QUH9xevBDjQdGmT5F89wXi34f52cjbRQHNZbrTdbwACKbbqK
	 1cdxi0aWacooCFQZpUmKbJW3610ePNTgXLa1F7hWCm2/PJyW0z9aWXV8kSegxiJki/
	 1HpgkBJ7ZZ5SJv2qfpg57EJDeEscL1E+9dzk0nCnesmUniy6dAOsMDZz0eTs9rOmet
	 BdCs1tpCSvxSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/22] rust: error: impl From<FromBytesWithNulError>
 for Kernel Error
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net, linux-pci@vger.kernel.org
In-Reply-To: <20260928011123.450800-10-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-10-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:36:30 +0000
Message-Id: <20260928013631.3DD721F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Implement From<FromBytesWithNulError> for the Kernel Error type as we
> will use it in a future patch.
>=20
> As this is now generally available we can remove it from the test case
> as well.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D9

