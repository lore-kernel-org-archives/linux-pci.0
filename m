Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525403DA5B5;
	Tue, 28 Apr 2026 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777371107; cv=none; b=Do7Id1f72BpDebPDOuWQm/EoVBTBzALZUsHnWvy1nbmpgfvsRc51NDL1kt0FOw0Dn5GPVedNlPfiK4edVNQq7HrMyUgXX2tdhlkW6ZbUdRqzcfC3qZ6g9wnRyUn4UURY2QXddwI34ZH5o6y+cULrcytimbQ/QP2jgfpDWDX1kTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777371107; c=relaxed/simple;
	bh=uUVYRe/SWz7CWkhpaj4lEG2QqReNvGmhl1Bi48ffDwE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=LtgqiJRes6xv8na4mXe4D8J9O5aQMhbObwuj/dQ6A/YTwJuvZoWddP82T7enNQOfXJHPXINsv3xgefXys9k+9hWfcKGTOTbjjqFByTtrB9gM7BjZ99RVko+c04xBC6NdKYePn2O54c3Rl8g+nzqwKVcR2bj100stCSBhMB4XKLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYIQSHyp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYIQSHyp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA596C2BCB5;
	Tue, 28 Apr 2026 10:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777371106;
	bh=uUVYRe/SWz7CWkhpaj4lEG2QqReNvGmhl1Bi48ffDwE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=mYIQSHypxmjuY9JVRb3hTHlbE2NTp6Ym1U26aqZZMnLUIYaneKvzVeqo5G9bUcY2j
	 gidiGDIhLUpKl1WZVpicI/s+lm9MNpoRKN2NzvYCfif5yRyMjZkJv7UGAEmf3kNDKu
	 fQAgr0Pe6hNLI8OCaZA1hlZJ7vKOiyXroAoVS8TNLPj+HU4oBRw9YecYWEUHigZ8aZ
	 nr449W5q6W9qjn6Cnc5qBRtuw81R/E/U/p6WbPPD9+suVuFh1+W5NKBaH2ejoSfWRy
	 zSTZ2nCrGHSGaZwbvb1lkhaCYDiMQL4GBvY3I+UbAfHtV+n4aE8kySKH0TtOmmCeVn
	 a9nct9/Dr6mMQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 12:11:39 +0200
Message-Id: <DI4PGYYYTNER.BD7J0XRD0BT9@kernel.org>
Subject: Re: [PATCH 06/24] rust: pci: implement Sync for Device<Bound>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260427221155.2144848-1-dakr@kernel.org>
 <20260427221155.2144848-7-dakr@kernel.org>
 <DI4CB68NZI8P.3RA6M7P8XRII4@garyguo.net>
In-Reply-To: <DI4CB68NZI8P.3RA6M7P8XRII4@garyguo.net>

On Tue Apr 28, 2026 at 1:52 AM CEST, Gary Guo wrote:
> Given that you're now implementing for two ctx marker types, it might wor=
th changing
> the existing one to spell out the `Normal` explicitly (also saves you fro=
m
> having to spell it out in the comment).

I don't think this belongs in this commit and I'm not sure it is worth crea=
ting
new ones for only this purpose.

> It might also make sense to write a comment to say that why it's not the =
case
> for `Device<Core>`.

I think the documentation in [1] explains (or at least implies) it. Where d=
o you
suggest to put such a comment? It seems a bit repretitive to have it for al=
l bus
devices.

[1] https://rust.docs.kernel.org/kernel/device/struct.Core.html
