Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5E348F837
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 20:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047044; cv=none; b=ja3x+eFsNi4Qa8Chiqcz7XaO4bcnFblHUYjzShOTuA7/Mw06Ru9vwEVWZ5gkDdRysa/h1tz5IZRQhQp3IlwvOisvwYgckCWniBCbxfUOxk4GXC9wwM4kyoH4G1jYphopjPKrI1d1GlcjX+9Nu/zljv8vMRw0s5V56LjTAmelJg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047044; c=relaxed/simple;
	bh=8Xg6EDbR410Xqzj+j4p0cBWe+xg7Aq8RBUwwzWXII0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lvO7Zs4l42XSEtAUnd18OSdhLcZIlivN2BGnKRJWOU7dFU826DiIzCeC8MxwcOOHLRxzWCuD4/CFPGJNL1S7BXyjDTa/poAcHFR8iAsTvKsLidKVP0+LxPL1YsvLkTzdovISwjEcTVplQVDwqB6DGff/lugBwHktZEvhXQyltt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QA8V6qbb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QA8V6qbb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939521F00A3A;
	Thu,  6 Aug 2026 20:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786047038;
	bh=8Xg6EDbR410Xqzj+j4p0cBWe+xg7Aq8RBUwwzWXII0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QA8V6qbbmGim+KFhBL1SADzyzmmVLKMNanZxQ+qrIn1l9MKBAYSifSXT/wqc+OpYy
	 egFvp50uB9YveZVNp45ZdtJZnJf1CnMkeI7RQqWiRrO6j/ga7E60JktU3NrxQf3KTQ
	 HGWcllr269lyH9daUjZwro/mUBwPyifwQo1OC1hhBjCNgsTaj+241gF+bh9E8O92gU
	 VAr+lCzpO4Gflzb8w8/UClCjW+A6EGe7VUj0WP3d/E2Az1ddLlih9zUZtgB8qKece1
	 Qe0bLMLMFuoIrucVZ5AU2jiKrlTaZwlLqCVHisFL0rl1thG/vmHQr11LbBsUQl5p3X
	 y5od0YtS4wFaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/8] PCI: vmd: Add vmd_create_bus()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806221351.38592-5-szymon.durawa@linux.intel.com>
References: <20260806221351.38592-1-szymon.durawa@linux.intel.com>
 <20260806221351.38592-5-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 20:10:38 +0000
Message-Id: <20260806201038.939521F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move the VMD bus initialization code to a new helper vmd_create_bus().
> No functional changes.
>=20
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806221351.3859=
2-1-szymon.durawa@linux.intel.com?part=3D4

