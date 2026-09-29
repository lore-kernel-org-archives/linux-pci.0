Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D7F47426A;
	Tue, 29 Sep 2026 08:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670932; cv=none; b=jX7B53ld1IV34IyiOhrA0pfZplqY87lc1RU2+BTjljf3k6vOhrU4g9xKIUAP/7A4mYfUM+oB+XmvRXw5U2VGz0cWO3WQ2e/vUjDb4p1osazkBBAEUklBYBX2crz0Zm/85L70KXuKvmCLAfUJeEzBxQzCaCwnJSwOlTo863GWyXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670932; c=relaxed/simple;
	bh=zWsAUVxS6IC7UQoZKlA5AV282S3k/x4HBKVqn3Hm9MU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=lZiPqQnLXt05O7ZWLb0TzHzqEh/ALUwBlhAnw/jsxpq6VJW5eEsw7D1kOgrcMq09dEf4iLXjPR1Vlsd3x/jSRBofCV1TtUnhDG+CLOOQMJvo7BGh7OMxt1hYppqOkDOwxuwVotvZ54Ni4/Gx2lMqASft38ecE8j/BEEW9tN2YDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJ/0Z4ND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJ/0Z4ND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F001F00898;
	Tue, 29 Sep 2026 08:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790670929;
	bh=zWsAUVxS6IC7UQoZKlA5AV282S3k/x4HBKVqn3Hm9MU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=nJ/0Z4NDNgnNleHbA9rKoVBCzxXcAUpz3bEGdN/TItaNIN0GhIbJKEc1Yl3iynEeP
	 AXFu+MvvV5noc5YHU7XZZDayEOiPQbnOR9aYVq37me4v3G2uurVBP0XOyBGqC/dALF
	 j9dbXAp0kg6IFeEDXTzZH1pGsyZCtM52zCH1CIq1TrLLmpbs3wWmyeS2xCnDj93Mhp
	 Qv1znmI6ZvPIsNevsfEsYFB6zKVP1Fek7ow7lSEWHj55Wvd2BWQxCCWlerS2GowTfy
	 vPa/kaH/fC+JpaJBEWCkVqcZEVOKHtbwL4Jy3ABo1/dx0wBffAY8rMydbryprDa1Oe
	 adOYDoDEkzWsg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 10:35:23 +0200
Message-Id: <DLRNV5LR40HD.1RM1ZAQQ4R6BA@kernel.org>
Subject: Re: [PATCH v2 7/8] rust: pci: add typed SR-IOV PF registration data
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <acourbot@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <jgg@nvidia.com>, <alex@shazbot.org>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260924190556.1620886-1-zhiw@nvidia.com>
 <20260924190556.1620886-8-zhiw@nvidia.com>
 <DLR7ZIHFTUWF.160C4AKB6W3II@kernel.org> <20260929102733.3e0429b8@inno-dell>
In-Reply-To: <20260929102733.3e0429b8@inno-dell>

On Tue Sep 29, 2026 at 9:27 AM CEST, Zhi Wang wrote:
> On Mon, 28 Sep 2026 22:08:46 +0200
> "Danilo Krummrich" <dakr@kernel.org> wrote:
>> The published thing seems unnecessary, am I missing something?
>
> I was thinking of PF drivers that only need to enable SR-IOV and do
> not need to share any data or services with their VF drivers.
>
> If we rely on VfRegistration to disable SR-IOV on PF removal, would
> those drivers also need to keep a VfRegistration with () as its data,
> solely for the teardown guarantee?

For this case we could either build a new guard type on top, or just add a
separate one to avoid returning an impl PinInit. But I'd wait until we have=
 a
use-case for this.

As for the existing 'published' logic in this patch, I'm still confused. It
can't ever be false to begin with, so it seems it doesn't do anything?
