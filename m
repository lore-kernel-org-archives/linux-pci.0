Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79332285072;
	Fri, 17 Jul 2026 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784327656; cv=none; b=iTkE0ZLyOpLYtuZwM4KFC/9wo1CYPst6g5bn1zSDsnhR/VXeVHQN6UXx0YQz9507gQbXXa30uoOmjk51sHc3gxQzi3x2979XtWW/KUjMi8Qzp4wejwSxCO99PN32/ezeo/LUMqwvPtkcyQ3baPJdZuUiJ3GraDQ55Kfo7J9620g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784327656; c=relaxed/simple;
	bh=9/1Gqwzrm/1bJe4HBS3aJnBHulDSgY4soFcX6gTnQUM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=swS0aY1H5SKfFXb9vcmJTMEEUyChdEfwEt34FejFUnsAaA27JM5kdu+hLd4OKDAhRWlmH9MgFtUx8Ene91zySNqXjHX60izKKiVzCpjeVxXPGg3hb0zy0usCKHsWBZvx/RKmuU6p/sTsuzmm8zBodGjMdHb52iGvDSuywgl0VBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZGpg1o2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZGpg1o2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A56F1F000E9;
	Fri, 17 Jul 2026 22:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784327655;
	bh=9/1Gqwzrm/1bJe4HBS3aJnBHulDSgY4soFcX6gTnQUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gZGpg1o2OSFcPqZsfVLwdaVqEU8Dn+WkGkaOs3M3MKSWKHCxqbXeIzQ4xvTlfLVF4
	 SN/ZRuNCAOT+KTtr0aiheXxq8UizU25gFeltnwwoWonZeZqif8dbyUmWR9s/OHYzTP
	 x0nSAN8eCmMEdKb1oWYi38W8lJoCGs6r2YgyXsFmoqSJSpk9fNZW+Atds7EZXwU3JN
	 WOqkQ4NBeHajDNxVhwVMtpe3Trv5+FtdREazdt+2EDgKeDGSeEa4TMroSHYD28eCKP
	 y8/sTEHgr1jMQzon4VsD81ScZK7Ve0cNKxHQeKo/mXG36g0qSBQS7MOHn18RajShOc
	 ntsuktndLoqpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 04/13] cxl: Rename find_cxl_port() to
 find_cxl_port_by_dport()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260717222706.3540281-5-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-5-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 22:34:14 +0000
Message-Id: <20260717223415.3A56F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Dan Williams <djbw@kernel.org>
>=20
> find_cxl_port() and find_cxl_port_by_uport() are internal port lookup
> functions that search the CXL bus by dport and uport respectively, but
> their names do not make the lookup method clear.
>=20
> Rename find_cxl_port() to find_cxl_port_by_dport() to make the lookup
> method explicit and consistent with find_cxl_port_by_uport(). Both
> functions remain static to port.c; the upcoming patch that adds the
> first cross-file caller will widen their scope.
>=20
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717222706.3540=
281-1-terry.bowman@amd.com?part=3D4

