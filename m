Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611662;
	b=QLCzxI+PQ96dKy0P5POa+4oUyDtiT9FKfoGN8A+EpmB0a8oICV+4OhRS41fSJHMWfKvm
	 jcwdkEVwqgZziVVz4hDfCkvpZvZEejkK4vjAaiaumV5QoAXj/U2BUbNjEuNEY0ZCSHlGm
	 kyrpTHldOmldTLGtin9gwD+GbDw3tnTc90acOoHbcacyp8NbmQ2Z34g+OV3KT577vbTeA
	 V54bW5e+Wai4XFerq6LB8lX7r9jvTv2LTb4D9DfhiNOGaQ3GRiavkCTdnmEE7qZg2LB8a
	 KIR1DCA/ceWINI8+QkrmLmKAY9QYkG3EaCmTD14p7OcsAeYXsHFnvgFHQW0KfN4Vw6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611662;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JRbB/d3XhJzqK8l9reAdi4RmKEwkjbEeI5RiQTdCSn4=;
	b=k+vVX3u6lj536tSrkg5JyahZ8eOQHiaKPvkbWOEN9iab+cyAeAxttYrYx9Pglekdtdu0
	 AH1UqXW6hCj885RHb1ug1epKd+Cl9YSHMds8UkEVGmtuBNP7aYOerfdP6Hf4aDQNhkeAS
	 bupYr3u5RMxPxeivNgbdkPxk1eaoXMzf11QjDMJJaZciR4qYPn2DQKNupxqFUS6ccnNOC
	 NBDHO52yDtJH7w73M/PFmlypKodOt/y381N023nVaRrp+J+/kV2PrHSZHTu4jMHsb85px
	 LxA+B2Pz4p4NYqyNmK9nmMY3GmQjVXMv9c/7U75mshZ0dtKhxNtfBZBLRtuAQCHnZ3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yqj5FD8O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E87606A324
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yqj5FD8O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F391F000C1;
	Mon,  2 Nov 2026 09:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793611661;
	bh=JRbB/d3XhJzqK8l9reAdi4RmKEwkjbEeI5RiQTdCSn4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Yqj5FD8Ow39ErKIRLu3JLMotpsNFNo3vtIIszvkKvd4KZ26kVgFLHk5SjmwE6uRrv
	 gUbskLhPiztlfcmfK7wRQNrxoj1G19zJPlVezhDAdA6NkF/ahXoIFYwcDSiFLVxRVL
	 RrY2q7YsgjUrBwVeHdPo44jaQvySIbreV5zNsZzhmOEx+D01vNgce5R2+Og8W9onPw
	 +/b6C6ULBfuEP8cmrM2ybjtxgLtDf545pdKIVz3Ssf46zZ453ZON+sf8EfSb2dEiIu
	 8KDZ+vRouGA66VOntekLx0TXlqq02OP6lKsblJ00Vf0hJVMhaCFz71/wNFnwgT0VEu
	 IY6Ik8IdDjs0w==
Message-ID: <sashiko-outbox-193174@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] PCI: dwc: Consolidate RAS-DES event counter
 fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261102092238.3917883-3-mmaddireddy@nvidia.com>
References: <20261102092238.3917883-1-mmaddireddy@nvidia.com>
 <20261102092238.3917883-3-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 09:27:41 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Use the shared DesignWare RAS-DES event counter register offsets and
> field masks in the common debugfs code instead of carrying duplicate
> private definitions.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102092238.3917=
883-1-mmaddireddy@nvidia.com?part=3D2

