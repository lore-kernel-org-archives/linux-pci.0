Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CAB37A486;
	Wed, 29 Jul 2026 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305456; cv=none; b=EE2ljLZh7wpcnSplT63hrv85yY2OXHA3C3EOlaNgvLyR1lSlcMpYPZ68NQaUYGLa8w5dYIj8787/234xUczrgWQh7sAHw4UabEnMdRMbi9l4e9eX31Xcu+K01LE0teEmS7SRcVETuAbf6ie5weYzLwsLmF2chEZLyxhn1L+Ohvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305456; c=relaxed/simple;
	bh=A2thpwRLdVT5rD+9I19eWlZaEgxFqDAO6v/N6nU+go8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hFHPVuhqusyFzc1ibmbDhwklUIwxNJv6cSR6N8jEop0wDVuyxW+ASonLW3bqiCFv9yS6jrkmiOY3icPIOG5moA/ARWLUbtUl803VLxPoKA36tMKSooDFklXrbqzs8Un9WBthMP6RXat1VjNJ6PLez91Lj4NKRw36bWTEee9O7dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d29gG0r9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d29gG0r9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B1B1F000E9;
	Wed, 29 Jul 2026 06:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785305455;
	bh=A2thpwRLdVT5rD+9I19eWlZaEgxFqDAO6v/N6nU+go8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d29gG0r9r5HRHkxsDn7nbPrscpUAbNbMHa4EcbkW/IefzEuIA3he5Fltrhbui5QRI
	 ie5Lv/bkRWc/Wy7IeJfQlLDcKcWRLM19GqskvLX1J307LnCKwQjjGIpgwEYl/K6Lrp
	 wCKWRM6gL3khMMbcS2+gffKycHM1ealoNZV3RM6/JcqxIvx1txx3UVeF08Zv5Vp8HD
	 BRdEQ35xRbN3FB85Rryw7HivPt0d42sqG3w0nVSHGLYLpxF8gMyehg3k3KmF7IvGUQ
	 nY3rLXBXdQ/CnfIoCWrlbHInjy8OT2CQ4qlxFkz2Y6BvrGOTxkGBTBDmaLltFFtzSP
	 PSWo65IeHEMQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf hisi-ptt: Fix spelling and abbreviation errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260729060220.624250-2-liusizhe5@huawei.com>
References: <20260729060220.624250-1-liusizhe5@huawei.com>
 <20260729060220.624250-2-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 06:10:54 +0000
Message-Id: <20260729061054.B8B1B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Fix spelling and abbreviation errors in the PTT packet decoder:
> - HISI_PTT_FIELD_LENTH -> HISI_PTT_FIELD_LENGTH
> - hisi_ptt_8dw_kpt_desc -> hisi_ptt_8dw_pkt_desc
> - hisi_ptt_4dw_kpt_desc -> hisi_ptt_4dw_pkt_desc
>=20
> Cc: stable@vger.kernel.org
> Fixes: 5e91e57e6809 ("perf auxtrace arm64: Add support for parsing HiSili=
con PCIe Trace packet")
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729060220.6242=
50-1-liusizhe5@huawei.com?part=3D1

