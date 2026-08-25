Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD97625A640;
	Tue, 25 Aug 2026 02:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787625665; cv=none; b=XaSBYgdrZTDnGAa99KLdh5rPvfrd9/FTYxO9xkKQATmvn3ObLLbuJj9u2V5GDG5jlLgA4Y/mZ+9XdEyAp6vwfF4QJjHHm6DvWrIUqrQ7fAW5jMzTzVjxDSRJfRs0B0P7CED4hInrBW1QVJm/YLQkoeRhqL+kFM0i/p57M5d52pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787625665; c=relaxed/simple;
	bh=Lmg1aMCalItBta9im3uZOeRvs6YULxXiPxNsNip0AUg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E8TBYy4uVvnar1lEdEtXk54zOI4Y/fV1mNBglswvKcZjxmmpqeleMSXVkRZwtJCCMjXk+TGRSoY+7L3IHF7R7MFYWEnduDXLOJmtmWrkKGqz1RWTxXKehQjXJHB/538qpadOA1A7niZ9f7yGplBcCIXvD4HTikqBIE4gJzZJQJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCsigJnA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCsigJnA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004A71F000E9;
	Tue, 25 Aug 2026 02:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787625664;
	bh=Lmg1aMCalItBta9im3uZOeRvs6YULxXiPxNsNip0AUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VCsigJnA47QvjUEcygMaqO6S1hVVuoOfZjxyVFZG+MBc2RWxBLHuqnKaweadXUhv+
	 Ntipx9TMNxLk9e2j/KyCyLo6sz2z8Pfpsn3iLZeWAJ5ZxmKWO9sVdfcQlDNJi1zt8D
	 tkliWDhWqMIgqHmb7V1uhPqRs5d1KV72TzrpvsM/VmpRwDdv6USr9aXpJfovsyRHee
	 22f+0I5FB7bDDCGJ8G3EiHoMC9eRgz8gnCTq8EdZk8CFBa3hWMxpizfrFnZm1rLqPL
	 qafxqjYBzowEGEruBy/kQMn/WgPUG7Ek3G+CvUT307W8qQ9iwWXcbDME6Brv6qKnvz
	 W1wtRT6BL3e1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/13] cxl/core: Collect the regions routed through a
 DPort
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260825022628.3651434-9-fabio.m.de.francesco@linux.intel.com>
References: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
 <20260825022628.3651434-9-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 02:41:03 +0000
Message-Id: <20260825024104.004A71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Disabling the CXL regions ahead of a Secondary Bus Reset needs the set of
> regions with a member endpoint below the Port being reset.
>=20
> Add cxl_sbr_collect_regions() to walk the CXL port that owns the Downstre=
am
> Port and return every region with an endpoint below it, and
> cxl_sbr_put_regions() to release the set.
>=20
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.co=
m>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825022628.3651=
434-1-fabio.m.de.francesco@linux.intel.com?part=3D8

