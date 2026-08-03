Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797813655C9;
	Mon,  3 Aug 2026 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796561; cv=none; b=H2yL0BImacP3EnYyEZOtOCOlACLRDn7zKhVQW3QD86jIkcnYghWKdntCHue5gn1nYRhwpzY6u/x/dlGRE1se/NifBJqJcZnO7lUuql5gc9n4ptWSOccKvD+H89XCOdJ00Dj+eapbIZ7Sen5D1l+JPMvIy8PRZvibmvjt2g1x38Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796561; c=relaxed/simple;
	bh=jy+nXvLCWiA5qkshQApHmQyr6ObRJv40FVwzwWbY7NU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JRE9Xn0n30weJz23Kzu/bx+IXQL/OMJrYSPPG4NBbkj3ORr/al80wSwPOz47cT25lQMMAd3g/P8jgCfte5fRq34sXCUJdYsQzgJesMI4yHOI1O6Jboap8ReaRZHWHX1MJ06dkYajlu1knaVMrhkZVWFNRJzFTe0e3dj6QTdELuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDeVrXT3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDeVrXT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97D51F00A3A;
	Mon,  3 Aug 2026 22:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785796559;
	bh=jy+nXvLCWiA5qkshQApHmQyr6ObRJv40FVwzwWbY7NU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RDeVrXT3IdSGWXPaJfSh495rqfPVOXFUc7tI56zmnMw/+hn4J7jdOQOC1lSz6+GdY
	 2fw0cg37bYZ89MD93Thy43DgAfB02fULZFaeALu07jSrIc51rZdr//13ugdzPPwXDb
	 /SAYsguLuAbRSMykSPskwi1wUasg2Pb5cIWeqZVU/ZWAao8gs89Mm1tF4XbHbJ8cGF
	 8pObf86lIbY3a0+IlcFH5dQq1ikpxFCDPmyfP9FSB9ytY/8KPKpoALAl2g7dHpbnZE
	 cDL6Dd2TNRoHBirmkzPkUOLnEWkjueYi77uTG8iOHc0IdMzX4gH3GlG3/fu91V0Zo8
	 xvAJbUPDytv/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 02/14] cxl/ras: Fix cxl_rch_get_aer_severity() wrong
 severity register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260803221810.3685703-3-terry.bowman@amd.com>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-3-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 22:35:59 +0000
Message-Id: <20260803223559.C97D51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> cxl_rch_get_aer_severity() classifies RCH Downstream Port uncorrectable
> errors as fatal or non-fatal by ANDing uncorrectable status with
> PCI_ERR_ROOT_FATAL_RCV. This is wrong because PCI_ERR_ROOT_FATAL_RCV is a
> Root Error Status register bit (bit 6), not a severity bit. ANDing it
> against uncorrectable status tests a reserved bit and produces incorrect
> severity classification.
>=20
> Fix by ANDing the unmasked uncor_status against uncor_severity. Per
> PCIe Base Spec r6.0 Section 7.8.4.4, each bit in the Uncorrectable
> Error Severity register indicates whether the corresponding error is
> fatal (1) or non-fatal (0).
>=20
> Fixes: 6ac07883dbb5 ("cxl/pci: Add RCH downstream port error logging")
> Cc: stable@vger.kernel.org
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803221810.3685=
703-1-terry.bowman@amd.com?part=3D2

