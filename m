Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C714DB56F;
	Tue, 19 May 2026 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194213; cv=none; b=Ky1s5hU6ok38e0xPPgLrLKeVufLIqnfnmEkwi0XIXKwHyrRTlLdjQWpH49qX/XNX+pecgpBMvSjAaJEU2bwmCPYNV2PEPx/j/CxaZwTUn9b57Hgc+4UcB89+yRTAecd5J1b3oYn/mD6IDy7cMY9M1bn/l5HFkev19KXdEzzyrUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194213; c=relaxed/simple;
	bh=nJYV/ap6zHLvQFCShv1/uTv1aMCcDLeKnHs+8n4ntjw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=DJSC2ek+nldA5j07utobbTCppzre+8OdTyaorVacTeaR98Wv0vec8nz2GhdqjAYETbFOJ75S99bTSx7ezgIYQuR92w76/0h2bpZ2cht0A8JI1lWi1XaY0B7iAKy7ZcBFQBVPvH2clGd647h5kwjWnIg9VUe05uROVcJj8/7ylIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXdkD0ON; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXdkD0ON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF43C2BCB3;
	Tue, 19 May 2026 12:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779194213;
	bh=nJYV/ap6zHLvQFCShv1/uTv1aMCcDLeKnHs+8n4ntjw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=pXdkD0ON+gTtqAfmHdV2+ZlJJdoHdFQI0lWKl2u+WYWQMoLn7gbY7EPrs2eSe3szw
	 vH7vAu76tm5kEIjgDVABxnCGJvcXk+cVx4atcbY/dRM/247u+aecXZaa6Ey2m/Gieh
	 P7bQjNQ6dC/7ynOZAhCNBPXQZ6WrIWJ1gj/JZbRN7ldklXmjrDeTvn2c+agudMk79N
	 nuNRqoZPfbqjZtKbwa/pNSs/WGEuBxKzFkxN9GrEJIbK9pYHMFlYLNDncJMiOn8nQm
	 jM7ds8QSjCecf0syRnMwaKhimwaXpklCU7tLUKZr2im5PUaSwqJHwobZwDenbDOHdE
	 F95Qt0z7yLb5Q==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 14:36:44 +0200
Message-Id: <DIMNPI2H382T.2U2OH39B7C2B4@kernel.org>
Subject: Re: [PATCH v3 10/27] rust: pci: make Driver trait
 lifetime-parameterized
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-11-dakr@kernel.org>
 <DIMDU2XL6PKO.RUXA0XPFT94R@nvidia.com>
 <DIML7T3R6BXP.2WSFVG2VY63LP@kernel.org>
 <DIMMO6Q6WKOY.1DKWK8IBAP0W9@garyguo.net>
In-Reply-To: <DIMMO6Q6WKOY.1DKWK8IBAP0W9@garyguo.net>

On Tue May 19, 2026 at 1:48 PM CEST, Gary Guo wrote:
> the callback should have `Pin<&Self::Data<'bound>>` instead (the outer
> lifetime should be callback-scoped)`. Did you forget to make the change?

Yes, I thought I had that staged already, but forgot about it; good catch,
thanks!
