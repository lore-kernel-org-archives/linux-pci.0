Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73DC2BDC0E;
	Wed,  2 Sep 2026 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357108; cv=none; b=WrKCj+/aa/rguVA+ke5ecJ5atxqu7oHav6j0VGjaC42sw6IWEzmJ7iQWr+sP3krp88N9QLuJzCwyCtKCtBYjgJzbUBcslxl6oPL4YnEkYcWFvD7tE/y/AYAEglsGhDYNWMuwVobtPYGhdH4hIPzMqJ33QI/omGgwcVkLI6pOAgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357108; c=relaxed/simple;
	bh=mXMaDycfGQWc4o3RG93CUeUC9z8UjYDdgWQ3638zv3o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i/PElb4nkZuowMu+aFoJjGZS0MZ0Gn3uZbvMdIfOKSRR2twDca1LwZNpGatuzkJIQ3liqPVhI3B4bqiOzddjUmBfd754odDja8UwKrEdZFbU4ui2Z71sJf51pBBQGgOYIZlhCobp5+4zFncEk0m9qN4iLp8ua7uKsIJXl6cAmXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uk43IQ8e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uk43IQ8e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7141F000E9;
	Wed,  2 Sep 2026 13:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357107;
	bh=mXMaDycfGQWc4o3RG93CUeUC9z8UjYDdgWQ3638zv3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uk43IQ8etjtisN9DE/UIG04l7E0m700PgKGr7myN/6meDDFP9AwlubYw2HHal0yAL
	 s1tkrH5aJHugg7nfdy9r1lRbgA61A0aWRoeIkrAFWL4mPBH1Up4kwSi2YiwPqjuHVf
	 p5q371011RA/FjQq1Hl1Xu+cqgKew2YG/ClYeKzQpZxIKv00w3qZWoYCBobjb1y5ro
	 b0f/luA26gSvrBsCRBypXrrdQvaOhUvXIWe5CwgmHBVzrYsTiEDqJHcGAYENGKagJ8
	 s7X23ydp8+cbO1fjDelXpinBu8BjB1TOxeYdW+sfdQUH7Z/gYmjIMx2fqzwXhxB/XV
	 MuPzEJQaBxVFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 4/9] cxl/pci: Thread port and dport through RAS
 handling helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260902133933.2992457-5-terry.bowman@amd.com>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-5-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 13:51:47 +0000
Message-Id: <20260902135147.7A7141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Dan Williams <djbw@kernel.org>
>=20
> The callers of cxl_handle_ras() and cxl_handle_cor_ras() already hold
> a struct cxl_port * and optionally a struct cxl_dport * for the device
> being handled. Passing a generic struct device * requires is_cxl_memdev()
> to distinguish Endpoints from Ports at trace emission time. Threading
> Port and Downstream Port directly enables is_cxl_endpoint() and explicit
> dport/port branching for cleaner trace dispatch.
>=20
> Refactor cxl_handle_ras() and cxl_handle_cor_ras() to accept struct
> cxl_port * and struct cxl_dport * directly. The CXL RAS trace event
> emission logic is split into three branches: Endpoint events are
> identified via is_cxl_endpoint() and emit with the memdev, dport events
> emit with dport->dport_dev, and Upstream Port events fall back to
> port->uport_dev. This branching is transitional: the follow-on patch
> [ ... ]
> device types.
>=20
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902133933.2992=
457-1-terry.bowman@amd.com?part=3D4

