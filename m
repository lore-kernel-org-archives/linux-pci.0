Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AE5474258;
	Fri,  7 Aug 2026 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106575; cv=none; b=qWfxtxqLUIMoFstDU1wL5GAoJkH4JHbuitB3nDDVNLXSvmySK/sE8Jbhc8Yg3ZbwXNKO1thrsvaOZZsp0J86rxPFY2/1puTsLAUXJr+V64ptOebudJnaVg+UQ4196Sxna2vwGXuXqPPCpJWyukEi29T12ioAJGLDpXUxk6rXI98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106575; c=relaxed/simple;
	bh=rv+N+KmS+erWImNAYTgK99qUytP8hVEjkmZKEcqAaFg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p4KJ1NIE2qcui/81QsFA6M97ETXC1kdq/tsCuHvbLO6nps2OTm8Os89inFY8r4673MlK1Faiudp5sHOl2FCkQHjOM/ENGct9G11kxLknHeZUx+onMwlS4Yqzmxn0bNbiVDjt5iB1ktKrdy852hcqQdseGT9hND3ZVAanU3UWslI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6xwcCW0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6xwcCW0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666C21F000E9;
	Fri,  7 Aug 2026 12:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786106555;
	bh=rv+N+KmS+erWImNAYTgK99qUytP8hVEjkmZKEcqAaFg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L6xwcCW053buGnlulI0dkUMwQGTuNJt49/yqhWhNxzoIC76yz7lAum7mhAmPOKaJM
	 LWO3MP+WuOCjboYrISydzgGISOt7p+Y9g5VQQK5OtjYPlalLlSW+/kFdfepTGvAtDc
	 FD0nndTJahsNAmP3lVV9rUcoqk7LNaYq5mq5+fm2lfc1vxogwtsNXnXe7YQ6+NUj2P
	 Jri9HNmfGXBCFayFTuYkOU6OS3laC2wcoGmGugpnHbBM40ovDfEppHjO8FZ4PwnK1F
	 rBnSs73PCzKSv4Bz5PggcyJYTykyyR8JtoKmfswoUyJvXCmIDcdz9jX8tGhF6sBz8X
	 T4gq5Bx2SYCqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/2] dt-bindings: PCI: xilinx-versal-cpm: Add PERST#
 and reset support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sai Krishna Musham" <sai.krishna.musham@amd.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260807123507.3418671-2-sai.krishna.musham@amd.com>
References: <20260807123507.3418671-1-sai.krishna.musham@amd.com>
 <20260807123507.3418671-2-sai.krishna.musham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 12:42:34 +0000
Message-Id: <20260807124235.666C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add the optional 'resets' property to manage the PCIe IP reset, and the
> 'reset-gpios' property on the Root Port child node for GPIO-based control
> of the PCIe RP PERST# signal (assert/deassert). Both are optional to keep
> backward compatibility with existing device trees.
>=20
> Update the examples to show the reset controller and PERST# GPIO wiring.
>=20
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807123507.3418=
671-1-sai.krishna.musham@amd.com?part=3D1

