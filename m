Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318BD43D4FA;
	Mon, 11 May 2026 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778528287; cv=none; b=Gk7eGzWp7ODvE4TrtCoMTpbChyQITldtfaaj+CBLpivHYPd8kEA+ynptPsaqgNbcmIMQjBaU7JoZLfHTSduCE60PXNC1RExtA8JF8PhTSgGM9K72SOcD/URUrQC7FZXdUk85NPNboXuZHwdgI2kVzrpGxUa2jnNxOS2Rg16IeQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778528287; c=relaxed/simple;
	bh=v3ZaN4VpL9Hl5zsxFJzl0kBDXKiuushsUjMXH2kS3gY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ZReNOgN0fwtiX2QJg3XPcWDoY+6chVCDrgQ+ome7RsKZhvI7CEZTjo4rWgOy2xg+Fnu1OkEJldufVOEGhE7ZaAOaMWeMQSloyqavbclCFqxJoncIn7uVeFQVtFqd6WeGmwYmWLE+1hTFrx3xroQ9R82ixKsg1P2AIL9yZu2s7j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlsSeWZ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlsSeWZ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB69EC2BCB0;
	Mon, 11 May 2026 19:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778528286;
	bh=v3ZaN4VpL9Hl5zsxFJzl0kBDXKiuushsUjMXH2kS3gY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=NlsSeWZ39A92JT+IPpgrVDN8forOFX9Ii2YOYc3OKiFZ2aXkvMP2Mc8d/ZKldK2XL
	 MtYFPteH3Zfepl6bdeD3byk1HgXqrSLiqPNpG+8MPC0CVMUYSHaSI7vkYEU73sbPJi
	 7R0wbX9d1NsdvPYZSASU1LzC0NCdHVEdIME9R888lhamQr6/Rg87lyfFqcigSHuJys
	 3atWaMuB+bTHvH+eCNJyi6jhuYrv0I+lV0tfEN7NUFVJovCQBmDlfr0TMp7SE7h673
	 WKWuWTBBgr90ru53k+HpiUi1xWg57PYjdWsheWg9J1b+2XBKIrqYixQt7BwoQtUrpZ
	 o03baRFxA+pCQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 21:37:59 +0200
Message-Id: <DIG3NO2QSP5U.2A5UCM1DYQ3ZO@kernel.org>
Subject: Re: [PATCH v2 04/25] rust: driver: make Adapter trait
 lifetime-parameterized
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pm@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260506215113.851360-1-dakr@kernel.org>
 <20260506215113.851360-5-dakr@kernel.org>
 <DICFXB4BLACF.3GTAQPRYURQCB@garyguo.net>
In-Reply-To: <DICFXB4BLACF.3GTAQPRYURQCB@garyguo.net>

On Thu May 7, 2026 at 2:24 PM CEST, Gary Guo wrote:
> I applied the following diff and it doesn't require
> additional transmute?

You are correct, this patch isn't needed -- at least it is not needed anymo=
re,
it was at some point during the implementation of this series. I will drop =
it.
