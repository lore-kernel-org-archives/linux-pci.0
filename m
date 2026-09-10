Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC762222A9;
	Thu, 10 Sep 2026 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025356; cv=none; b=cFGmkswaTO5uB4QSevNSpoiszq69/XawyHnZlEcB81FiA28qskqAVF3spUSxY9D2lK7yS/QE9ogsqCYWgWjb96n1vOjYPm7uyNczdKDK98QnBLPnduKjFBWGazC8gfIs3JaGEgcrmNVAzPW/2emXisq3/uft0Z4XgSJ5Yu0xXzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025356; c=relaxed/simple;
	bh=SmiOBxHseKSBq4TVeTak4Qr6lJjboLXIe2EUy0k+rX0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jP5OwMscXVVxUn70V7/p//75zXtStNKFxgnSZVdriHvfO86+Z6FS8xBB19RgwFwx6+wgYDywOHnEk72vwyZ+FAk3kxTcBoeO7ncD3DQb1F+K6M24/2g9eJe5qUbXHpoVLgG+eanaWZxzG6Aqf+8XOwmOs2hENns3Ls6+qzbvwCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAZyWhCV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAZyWhCV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11B11F000FF;
	Thu, 10 Sep 2026 07:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789025355;
	bh=SmiOBxHseKSBq4TVeTak4Qr6lJjboLXIe2EUy0k+rX0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YAZyWhCVDURYyJiiCbGmJsGKirOVVrJRNTf+KrwV/5novcx7flxXeA2edO2S70b+K
	 mmVmGrbhhZf/KW96PjV8ilQDSe9I0NOWRHxGRiCHQVgAv4jhd6iYVW+B78n3kuFL4U
	 gV5gGR9AlH0mfKg3RO5IgHAHoDHzlxhdZxq3eegpc//Jd5EyzKPOda1w07hs5pbv7m
	 3jTUruqX/EDSvag2FUpAE+WUnOHMCwwjR6v/w5WsMNkeEJgtAlDVZQF3aZiQ5GBVhi
	 jHLLzO3xaJj1bxolrU9qOz/cgU0HMHT0spFA4WZeTedFj47Yq2YQ6qQP7Wxq2gRxC1
	 s9h4EORkK9bWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 10/12] PCI/CXL: Expose CXL Reset as a PCI reset
 method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260910070808.1444264-11-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
 <20260910070808.1444264-11-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 07:29:14 +0000
Message-Id: <20260910072914.F11B11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add the CXL Reset helper to the PCI reset-method table so userspace can
> select it through the existing reset_method ABI.
>=20
> Advertise the method for Type 2 CXL devices that report CXL Reset and
> CXL Reset Memory Clear support in the CXL Device DVSEC and pass the
> function-scope check. Reset execution requires cached HDM decoder state
> for the target so affected ranges can be validated and HDM programming
> can be restored. If that state is unavailable at reset time, return
> -ENOTTY so PCI can try the next reset method.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910070808.1444=
264-1-smadhavan@nvidia.com?part=3D10

