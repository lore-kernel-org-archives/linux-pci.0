Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792556751;
	b=YiVtSW3wDrZkXuGKoz2QfIoxZdKjZq+2jMtG5UmUfiQ9vjuzmRXwFSB1quZx758K6DYa
	 +4YiYLdIRxQUQfXAXCG/bP99Nf/o7vzugRxconzuLp/k92PDGD8fHT7cEtszFg2n3aRrM
	 iEjUUTG+I1eZi0ZeLSi38d1QWpTDXW+OLGcd5AOHBOT6LydU4eezJNZfdydKcRxkY2pw2
	 8hWhoW3YFRcwMkbKiPxIL6lhancBOlfhESiXAXqdiA7tcG3qJh+jHru0EUPAiFoQmK26R
	 /s/yRbySAPluxUZ6qvl8dFyYWbT6ZgaEqOY+onUJ6nhTuDuq9j/tYcifrrQJ8g8CQjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556751;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MXEd15e61peyJRjuqmG9O01zoAnGXpLE92mclTsxmpw=;
	b=krrxb8uJTvcuVbF6Mkec5jA+pACHjpnVVBj5Aie4desNKF9PqjJCPZFb6cRX8CVz0gDN
	 bO1VeNFRjIv93Fr7j7AB3v01+zUwNuj4tQKb2i90QN1v/y09ITWy4rUuzGHgNBP/D5ecV
	 1tqQfDiZ7bOiu7nqKv7MBsOLwIr+3xOTMch27Ssuv68k3CthU+Js6UTEGquDq87nZGDjR
	 Yuy316TjtaDXsn8/QUlkqhDrQZq7huUouRC30rJXqsoFUVDBlr5x/nEOkopnmfPRBFofI
	 GNCbEuQRGo4pUAAYEGgdgeneKY78vz26YEM35Y74xXyBhSMZclEdWIUh22JLMIfNEdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTPN7K5g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EE2606A31A
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 04:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTPN7K5g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F238D1F000CA;
	Wed, 21 Oct 2026 04:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792556751;
	bh=MXEd15e61peyJRjuqmG9O01zoAnGXpLE92mclTsxmpw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iTPN7K5g+VXTSTn5/7rFK2al+g+Dn70PgubhaHQoL/w5fCGiQTja/C/p1M/VCk+MN
	 B+m4ndN8N/pMSSMrthN4EG4unUfS+nnsBLcMG3hs4xv3+mX4330ulwxtLQ1CwpGxOo
	 RTPPU0mM4Y14HWhHSMIadTVWJm9lRQbfLPP7GZM1OQa+ys0KZymKiknKpRpXj6C/G4
	 eksvTRUncOVuXR44HvR2jGqQpyPdfriumGBrTvRx/PLdKNrM3i9XR7AttYfX6C7fLR
	 2epmbttKo3of1zh/2Tak62f/h301CKgY1ikdtcvOfYsUPYhZLj09as46/OMFF3b0j/
	 FWzmJGkNoiL2g==
Message-ID: <sashiko-outbox-179779@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/10] PCI: endpoint: Add pci-epf-ntb.h for the
 shared NTB control layout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261021042229.2280937-5-den@valinux.co.jp>
References: <20261021042229.2280937-1-den@valinux.co.jp>
 <20261021042229.2280937-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 04:25:50 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Currently, pci-epf-ntb.c and pci-epf-vntb.c each define struct
> epf_ntb_ctrl, and ntb_hw_epf.c mirrors the same layout with hard-coded
> register offsets.
>=20
> Move the shared struct and macros to include/linux/pci-epf-ntb.h. The
> vNTB "reserved" field takes the pci-epf-ntb.c name mw1_offset, which is
> what ntb_hw_epf.c reads at that offset.
>=20
> No functional changes.
>=20
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021042229.2280=
937-1-den@valinux.co.jp?part=3D4

