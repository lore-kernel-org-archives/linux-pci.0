Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD955540B9;
	Tue,  8 Sep 2026 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877017; cv=none; b=u6Y+7mLdQAitdRR7lBi1OLxBrv+uZT3Sp7fAoBam80TlxCxLq6d0rBfr8uPB13NmZP8ZCb/cR0UcIog40TnISfX2/nczXVn+L4xhnvHMK7KfYu7+Zu4z9AxakEg1ctZIPy1RAXlY5i12ZMBsquOWX6NJ/P4FXymJP8RvTrHMywQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877017; c=relaxed/simple;
	bh=oeWcf3DxUbbdwZiGXUGnM4pMNJuOWS920c+uCfSYaSM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nngt0ye/co9ckWkNQX+bXgz7GpdD/V/H+aVX6s2Lze1vny3xsObuuw5VQDpQT2/v0icNMUvQJe/iG7/EVdwVTA3fo+F3vkcM3V25GAlMN9SAUKm1fglT15AnbDZlG2jJycPr5Z8etNUm5sXAQ7GsaFF8mzilDqityOd3I38TgJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jr/33qF5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jr/33qF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A4E1F00A3D;
	Tue,  8 Sep 2026 14:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788877005;
	bh=IrEhf5FSgYDb9LzSRS4d8b0I6BEc9gLPPdm8Ooj1h+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jr/33qF5gVsdhHl2QtNI1Xkx0qTz0nVdBZiXEPgNnz3jkI1G86/IMEa28mJgkrVa0
	 kwUwxT63eT3/09r/EAeNYVHTAEmRrOpoiufAi7BuMPX4psX8pabw3Y7uR9NCg4Bbl0
	 G3ueM/L3hnc2pyGvcM+WixQzYhncYw72V3JUu665JGW42Qf+/eaTmMIRH4v53xDwKq
	 yTioPZ+7iU4ORWwOeu5SFc3Je60OZ7Dx95VFzNQQ0uPnK6W+nm8voi2PWLwWGmPOZ1
	 FZtguUTnaUIjKlAJ7GRAu6V2qcmI+UPECFtTDHIO8d2XezHC+FhH6lM3GB+Fg77DtT
	 Fu/38gKGuYWhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/8] perf hisi-ptt: Add parsing of supported message
 types and proto length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260908140509.2485649-6-liusizhe5@huawei.com>
References: <20260908140509.2485649-1-liusizhe5@huawei.com>
 <20260908140509.2485649-6-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:16:45 +0000
Message-Id: <20260908141645.87A4E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Classify TLP messages by Header DW0 Format field and Type field for
> both 4DW and 8DW formats, according to PCIe r6.4 sec 2.2.1.1 & 2.2.1.2.
>=20
> Parsing packets into:
> - MRd  (Non-posted Memory Read request)
> - MWr  (Posted Memory Write request)
> - DMWr (Posted Deferrable Memory write request)
> - Msg  (Posted Message request)
> - Atom (Non-Posted AtomicOP request)
> - IO   (Non-Posted IO request)
> - CFG  (Non-Posted Configuration request)
> - CPL  (Completion request)
>=20
> The parsed message type is stored in pkt_buf->pkt_msg_type and will
> be used by subsequent patches to select the correct field layout for
> DW1, DW2 and DW3 printing.
>=20
> Classify protocol defined header length by Format field, according to PCIe
> r6.4 sec 2.2.1.1.
>=20
> Reviewed-by: Yushan Wang <wangyushan12@huawei.com>
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908140509.2485=
649-1-liusizhe5@huawei.com?part=3D5

