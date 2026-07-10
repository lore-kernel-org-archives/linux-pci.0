Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C116372073
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783719398; cv=none; b=Tf1GxjZLCfC4ei2wTZRU7Js/0rdAGkBZgw7kXF6+k/00RfLewXBNQhzA4zTNcf8tbVN3ZW1Gq9C+MUNDBYNHhjEwYgb2lYmZ54NeEL08XvKtTbTROJ113HOQtI0KIgZtHk4Xd3PnKH8muT+sP66ezVTlFxKHIpmoEXipHEddYhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783719398; c=relaxed/simple;
	bh=cV2yQPbBhHiVgDKe+SOVy6OsD7fniQa5sbLn9AYwFx8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iaiIFilrAjraq69zEvHqKM8ks+OPxdebqJvJVxrcfAeg4U0ZUgYFvIt+Q9fj4h6pFXkIQ33eGOi4pdzdGA91ucK0VWa34Jom+AOkONXUNOZ6G+N/GvjJYOeouQn6KJ6nStkpjTJWeRoyOGKsdiPtsFdel7TMAaQO8q9LX0vS3R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsOQRsNM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsOQRsNM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974301F000E9;
	Fri, 10 Jul 2026 21:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783719396;
	bh=cV2yQPbBhHiVgDKe+SOVy6OsD7fniQa5sbLn9AYwFx8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BsOQRsNMRJfRc191xRfjPbdtEQ3AGmQFyCGOfCDD7mdLByoI+pZ80jOzMr63XupOE
	 vxvfYH+aL+UwW43YwGRVxO6C1LIIF7fJYMRWfgdmM0sBcJueb84OQ0m4g/IWHXsR8g
	 NVhgX38xBsAktb+GCBvMiwJeE85VyYWy5mF8FvQISsjlau4nipVdOZYYNLA+v+7Owv
	 oEy5T8W6vW+0JsXbcbZA66VTiCr8on2KaAhRa6J1fRIospCDZMKj27cxVQdhHFx2wD
	 I+f4OYcZiiS0tolMAczisOIy1dcx9QRFwii/ckYcqsXx6RtQRp3sBw4K0G3LUGU5K/
	 SNnnHSBxJ3Hgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/12] PCI: liveupdate: Set up FLB handler for the
 PCI core
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260710212616.1351130-2-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-2-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 21:36:36 +0000
Message-Id: <20260710213636.974301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
> it to participate in the preservation of PCI devices across Live Update.
> Essentially, this commit enables the PCI core to allocate a struct
> (struct pci_ser) and preserve it across a Live Update whenever at least
> one device is preserved.
>=20
> Preserving PCI devices across Live Update is built on top of the Live
> Update Orchestrator's (LUO) support for file preservation. Drivers are
> expected to expose a file to userspace to represent a single PCI device
> and support preservation of that file. This is intended primarily to
> support preservation of PCI devices bound to VFIO drivers.
>=20
> This commit enables drivers to register their liveupdate_file_handler
> with the PCI core so that the PCI core can do its own tracking and
> enforcement of which devices are preserved.
> [ ... ]
> assumed to return true. If KHO was not enabled then Live Update would
> not be enabled and these routines would never run.
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710212616.1351=
130-1-dmatlack@google.com?part=3D1

