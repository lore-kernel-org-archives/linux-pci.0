Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2708B3630BF;
	Tue,  1 Sep 2026 01:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225023; cv=none; b=mAVAym9zbjEkeSa4Appigb5WK+bnKTT3GMJ8eEiDNVnTO6JVxZH41IL51ZKqbJaHzY8oid6O7RV1lTZrZZEEMQe6m5aLz8NVeZCGyZbERReqsxtGp+CMs50/8/B3R7gHT/KKoh3CCOEnsb6uIuu5ZrYfhgDVuGNxBwj5nZXh33I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225023; c=relaxed/simple;
	bh=0qOdDOkd1PcRQ3v36dYDkv0XFLqZ/AKOifKbhRaY6Sk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Uz+tkUIpWRw9RMH53yQAfIYpA89F5FvEQ0Q/pcJEg+Tm9x+/0jWjcPgfeIB9WUeVek90/oG19cLm246ELQw6MClud7ILgraoK1tVEolxwea8Kdb1CStkCBNiOs8ODq8tG9twL5Ro3Pp7yvDMvFUdy2dXL6ljDlH2GdlSr0xAstQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvQY8QzR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvQY8QzR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADAE1F000E9;
	Tue,  1 Sep 2026 01:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225021;
	bh=0qOdDOkd1PcRQ3v36dYDkv0XFLqZ/AKOifKbhRaY6Sk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HvQY8QzR5W5lCaXoMoq+t/FO0JbPHnzViJLHXtJ/VnIQR4VZUf9KVkO3I8CCrHWl9
	 gWldoyxqsps/7xNmN/jKJWHAgSo0QORfCAY2CfVsRjBJSsMSrhKuzYASvAbSrRkoVE
	 AhteQFYY6q8WZIByhEq8Fu0EdbW1U/5RgThZDAS7VkngFBSwlgyvEqOwdhEM08T5iQ
	 SKf6zGsPq5K2a9UMge24RP1ins/VjUAFpUYu3SetkNUYNCfvgqwWSK3FOi/Cj9enzA
	 1bllxsX9WcKhFzvJY16YY3FmGMHpdr5BNy+TX03mZGGZkfkCCZxx0EyD4pMHggCczB
	 A1kg1/HLN0+6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/21] rust: error: impl From<FromBytesWithNulError>
 for Kernel Error
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260901010347.2614656-9-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-9-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:10:21 +0000
Message-Id: <20260901011021.8ADAE1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901010347.2614=
656-1-alistair.francis@wdc.com?part=3D8

