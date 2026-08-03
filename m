Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B3834D916;
	Mon,  3 Aug 2026 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796164; cv=none; b=oco7d9TiwdkgtsGgJEilbIky9xUcExq5XqQUdsfe7gMMuHa0/mFvmOKWyCtWI99MyEdRjVaO8IK3/42fdyk8HBOy06RA0/G+zf3VrgAwDsKZaD6kVO5UWcsmKC3XZRoYVjO9iSb37iX0NAn3c4wdZazTVwGNAtVgHzv0DW5PwXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796164; c=relaxed/simple;
	bh=5djZfI6Q7mkbs5bbN6kitMnr4nYfFobdswtd+PfOPDM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rCx6LZ0SSmg9H6jFqI9FnJWO3PTQHS7lD4Ys/4LwpEqWR0hQbjDYv81HQcPqZjBlHhGim1w3RKCfcZ4n2adoVLGksquO9SJgDwjirV8UN8AH3ADC+SjvDatAw5qXvrEbUzfW7td06Nn0QkcaLh0FU159ei9TDZHoQ1cJb2L/Kew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8z2lBvk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8z2lBvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B60E1F00A3D;
	Mon,  3 Aug 2026 22:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785796162;
	bh=5djZfI6Q7mkbs5bbN6kitMnr4nYfFobdswtd+PfOPDM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H8z2lBvkUWOB++bOgAXf4LAwz8B+uoPyribV0mEEt0d+Aw6jqqRiRyHTpvNymtFwC
	 MXUvMReqYMuDb5xD9UuDPUXWXraiYhTgjDh+K8Lu75rrl9FNneNhYUKtGzWjZUDOFk
	 Q/cIKJHu9qXDihe6vUbqepRSWnGT7zz/C+uzHqVyX2JfPcYCl13t5rqLxZaopdP0dK
	 c1o6yK0bHTZNjRemAVubFANna5kktzpu+aLsVNyIVg2Uxo6MzoenSvn10aPHe7f67i
	 Tu27OKK5L0MOQhsyV8cg3axnpmY/1ixvNKELxjQZZS1DQ0cMToSQrG6XpgKHcXH1xJ
	 3W1ZLPxZhF8wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 05/14] cxl: Rename find_cxl_port() to
 find_cxl_port_by_dport()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260803221810.3685703-6-terry.bowman@amd.com>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-6-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 22:29:21 +0000
Message-Id: <20260803222922.3B60E1F00A3D@smtp.kernel.org>
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
> Make the same naming change to static helper __find_cxl_port_by_dport().
>=20
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803221810.3685=
703-1-terry.bowman@amd.com?part=3D5

