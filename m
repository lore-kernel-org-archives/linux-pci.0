Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D783D5642;
	Wed,  2 Sep 2026 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335674; cv=none; b=oJ1mzSf1b4WFeCsn/pJ7Tn+3/yNema2kNGZAgmVz/aGjpWZUSLw95mGDCfSHEnQRvqH7i78VJ0U3t53ADINX8cYMZbTVpDP/8NwqFdXw0kajItgmBtqOwIzaQ6Oy1AhyqH/LIT8ZfvGXd+j148fH+BKRHb5iqrdFN/GbXmrXOTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335674; c=relaxed/simple;
	bh=0RmvqGkJP1+kneAz22aeVwNKUAIZ99VxeYvcWP/LM6U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RFJlcp4EfJK89JG794WKvf/zVE4buPZ3SrTusxyZtZQK2g/YTJpgFqnvzy4g8sGiehauZXOhrvhiHZ0qFtBmWXy0mao4d99KBG6cCEX1d48Ua5KQUZ1W8NDYvJlFgachAl9TgOtHlZ6FQL5hR4lxYu7eXNn8Y0P8juL1UUA5LWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcjXiohV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcjXiohV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1786B1F00A3A;
	Wed,  2 Sep 2026 07:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788335673;
	bh=0RmvqGkJP1+kneAz22aeVwNKUAIZ99VxeYvcWP/LM6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hcjXiohVjzMuqI0RM4NBSWS1JRUMkMefdi6iyZMdBGDLBhKwOi2MS6R4CIbJs+snT
	 FTBRiSkJ7X30zYFhB0m3GzXagGzAzOA8h7ArPe+84yNVzL5u/WMDzBjWDQcVxrqRQx
	 NCcbUIEi3ZmNr2QUUyST4HKtyblPLzZ7lLOQr8WXtcciKbkQNilmR0h2npq23WrUWT
	 LBtjJWz+ywY90hZDRdM4ACpKl1FjfiV1gPH+XVtXpIwdKxEUVGcG6zVnzUaX6bS0S2
	 RqZgeOLcvuny1gZPkcQ8IvMAr0qW6nFy9ftaCbwRmiFHsySlb5XOkGZImFxQnNAPCb
	 AxW1IhdnqxyRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 12/12] PCI/CXL: Restore HDM state after CXL bus
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260902072804.665639-13-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
 <20260902072804.665639-13-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 07:54:32 +0000
Message-Id: <20260902075433.1786B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> CXL bus reset can clear HDM global control and decoder programming.
> Restore cached HDM state after a successful cxl_bus reset while the
> IOMMU reset block remains active.
>=20
> Restore PCI config state first so BARs are valid before HDM MMIO access.
> If HDM restore fails, save a disabled PCI command state so later PCI
> restore does not reopen bus mastering over invalid decoder state.
>=20
> Reject cxl_bus reset for multifunction devices, matching cxl_reset.
>=20
> This restores only HDM component decoder state. It does not restore CXL
> Device DVSEC range/control registers.
>=20
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Tested-by: Richard Cheng <icheng@nvidia.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902072804.6656=
39-1-smadhavan@nvidia.com?part=3D12

