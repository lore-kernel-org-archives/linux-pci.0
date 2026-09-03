Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9924034D382;
	Thu,  3 Sep 2026 21:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469314; cv=none; b=WqVd0LNE4nRdCun1rS6uVKox89eSlmp+MPkQCqvveBW56dfB2cjIiNB6s//cDBxkTNWdvVpqnUNdvTwAVAvDHwLXYUQEg2+Bff4g38S7mpncejSKADC0fHYW5HOGhUkbVXjBN1ZSufwOgUl1vKV0DCAaSONPE/Eu+NGlBJo9RPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469314; c=relaxed/simple;
	bh=sBg6FP52a9+rFTrccZ0TFN6TTjDqWgkyTxfAJ7k+bJw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tzQpKipMQ+UXBZXhXBFnHj2sNgBafYjhxPaklV4axDXp1AnL5FectYr1S88wPferHkSqUAvQly4QwpDFebEM//QhX/X7F17PU2gTMvK1yr+Ko83c3UcVYKmr4Sem3Qh4kVWq5GPFmU0FVLoPP1DvHhIEdJJ77tRQlfiLH6xwGog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2i5l65K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2i5l65K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE621F00A3D;
	Thu,  3 Sep 2026 21:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788469302;
	bh=sBg6FP52a9+rFTrccZ0TFN6TTjDqWgkyTxfAJ7k+bJw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h2i5l65KgGDK18+qGg2XS3h6EZNxtPcpU/cCazsnMISTCRrnih2Oci7C7siSHh7gl
	 VDq+UinYHsWPU6mdB7FM7lLqOHTfchgfgqsyfAf8xphJXRiszp8r8tqAp9kPHN4M1h
	 hYiwzkuDMOaXvOB2Y1j9vSXmUuGYsQsDQ/48QJH5NeZH6smQIke+nEzTTId6Usu2Wy
	 98SYAq1+Fp1OHV2PKJntAIH8VrDOPFUqZ/VC6qMeruE3gDgQHuK9jOjDT+yFVnWKVt
	 k7ckxYJdRVPVpIxEBrW50TiPr/AQ4cnCmUAhO1uNM9g54WIqP9HxWxmfkNv8u8M1bx
	 gNsObtDpCbUOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] arm64: dts: renesas: r8a779g0: Add PCIe
 Application/Local register reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260903205153.283553-5-marek.vasut+renesas@mailbox.org>
References: <20260903205153.283553-1-marek.vasut+renesas@mailbox.org>
 <20260903205153.283553-5-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 21:01:41 +0000
Message-Id: <20260903210141.CAE621F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Renesas R-Car V4H documentation R19UH0186EJ0140 Rev.1.40 , Aug. 7, 2026
> attachment R-CarV4H_UM_009_SRCRn_FSRCHKRAn_FSRCHKRBn_r1p40.xlsx rows 410
> and 411 describe PCIEC ch1/ch0 Application/Local register reset. Add the
> matching reset into both RC and EP DT nodes of both PCIe controllers.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903205153.2835=
53-1-marek.vasut+renesas@mailbox.org?part=3D5

