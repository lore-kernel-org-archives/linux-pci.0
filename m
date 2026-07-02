Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8FC480951;
	Thu,  2 Jul 2026 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996550; cv=none; b=UD8VE+xb71wuG7x9DFS7BhdNToNd3wztSpzX+/uFTTuBJ3DNHB2tK1bXFMKiwlTCUVNovFBXKDtZL6dn8JC5ijKf8OpCeEX9slfFMrr7i/22cdX4yXmC49LrEfBq7NiclOB9GsJ0UAZheGhIARE+0waU/NqwXvX+8xt/YRoYcBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996550; c=relaxed/simple;
	bh=NnTKmcTplTnoc+7OfzBwnyzV6srkwQJaisNW1QnCxHQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sl589veajftb7sWbO5g+qZKC8uPg99Trk+mlcncI72RZXvZSOzBDMQpV7OKxGLDdCsWIpqLmSyfgMoxstBceu0LWuznDTM+b/x+AJLjWnqhUUnCXrHrjNNZQ1skOOX8xhDpmZvFq4D9XBKGgkbJjbh+2PmARSBSPbELatyhKD7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjFw8imY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjFw8imY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F6A1F00A3A;
	Thu,  2 Jul 2026 12:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782996549;
	bh=NnTKmcTplTnoc+7OfzBwnyzV6srkwQJaisNW1QnCxHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EjFw8imYFhPvIGEwWc/aYLnp7/L/hkcSDrdqjEDJgg1mZKpy1nAefUqtrx6mibrxf
	 9x+QL6VejpMEOdFAGrDhbwfW+xElJnQRsTijHXn2ZSleEby3UmlCIjFUG17z+iZfCV
	 IkQuBteMbzvpRJhwecnADP2Ij4uRbHuK55/d9bLYaf+Owz4IdDCgijIiOyzJpftCam
	 HzJvbSEqWCwkPt2rx2gJYhOuzQWTOJ80q4CiXS8fvciLCsY6aZH0DWdrpSQAGTejfE
	 H5ISppURRbN6Y0pq4M4RNZAZs3fpaZQkdWlNYi5yNvJTajdfZsTsp2TdljPnZXo4pD
	 QyBAeoz20TOPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 06/18] PCI/TPH: Expose the enabled TPH requester
 type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260702124224.57168-7-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-7-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 12:49:08 +0000
Message-Id: <20260702124909.47F6A1F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702124224.5716=
8-1-fengchengwen@huawei.com?part=3D6

