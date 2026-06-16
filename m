Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C1642883B;
	Tue, 16 Jun 2026 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607101; cv=none; b=Veqv9PTFKy1O0t3t3w/xx1CHzkg8o6iKHQLvfQG6oEtpKmoj+9C3rnajCR3TbB55eLwLz3ZEgBOGdzPoRl/onn5KZ1i+kJxG6uzSkpBD+6/iW+LNqi9iDMsOn7xihS+OD9tH2GMCWnQyZ2hmOCoV7gRaWLbsUj46jsKICoJ0rYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607101; c=relaxed/simple;
	bh=+FL58FYDb5TNb+rvXTcBKkkj6Ga624u8U3+5Wr3xcI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ReJgQTsbKqSphWRGP9E3E8eVzbfdV8QGHicATBA9KtrDYuhwVbZg7FYK7AkxGextzvGjFSwQ6jFx5PwQUKMkEQdEPnXu/M52vICiDhwnp5yJbEPCz4RL8neR7PqMiWUMoZG8OVsXkvm6Xz+WW5cdHOTDyHbGzunhmR9WtZ5nYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2QHNavF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2QHNavF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DC61F00A3A;
	Tue, 16 Jun 2026 10:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781607100;
	bh=+FL58FYDb5TNb+rvXTcBKkkj6Ga624u8U3+5Wr3xcI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F2QHNavFYeNTv2TKE/HyAtMscUXKs14QBMLujiORsYjqg8zm3C/slUlNd1HuZ+hFQ
	 AItHjpmJRdYiuELGXv+5y4EOVy/0XRwq2zi6/3n9LLgd6UucmCRvE0dS3qUTaqlWZ8
	 enT0o0GZd5vw2FiDuN6zVB1eDdEbBopCnunWMbVzJg49GX80sT6FurKHsmjXl0+i+T
	 XeXSUat9tnm0JOxqdPesE3ilzN71YesmHBoig5wrXY5yAyGc3kkuwIlV0OJZjPwJ5X
	 Zd08ARA32bfwEbKM+H8H1MXBFdoGfVBPaD+r3RrTeskv6zg0ZquOr/X8H6kSWdBL+M
	 vMw22qKM9F+Zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 06/12] PCI/TPH: Expose the enabled TPH requester
 type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260616104621.41915-7-fengchengwen@huawei.com>
References: <20260616104621.41915-7-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 10:51:39 +0000
Message-Id: <20260616105140.66DC61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Zhiping Zhang <zhipingz@meta.com>
>=20
> Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> requester mode without reaching into pci_dev internals.
>=20
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616104621.4191=
5-1-fengchengwen@huawei.com?part=3D6

