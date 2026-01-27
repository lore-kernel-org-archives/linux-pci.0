Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDAC1E7C34;
	Tue, 27 Jan 2026 20:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769544594; cv=none; b=pMbTi9rL+TS2rG8PD2y7FJDmFPP+WqrJ9nDiP83coiDlTj1zvaFg5UGjWsya+8U3C51F1aiEHoBkKf0wNiq7rD9ZG2irLRrSpEhpK4Gin8icqoIOuCfpNjwaU57TQkqhOJ9QnTz7rfKz197apU1mAFicNONYccjPu28esowKB+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769544594; c=relaxed/simple;
	bh=li5PgsPeyDOaDUR6nHT6meMbGY+B1SiSJCuUR+pQMJ0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=ADUsDdpGxyS6u1cvMmKS3KxhFmJd/RbS8xF1T5ktCaWSlm3LGSG0wZYgPX6d8Amt+nCn9E07fhz45DGEnQNyi1rOLY0z9rwn8+UXFmC48kHTXNW5/r3dtJqDkdoEEHKCaEBpt/C/ZQFOQTmZoaxr7WSpNvP3n2u/rjfA3FDSFo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsrtyYeg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsrtyYeg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69EAC116C6;
	Tue, 27 Jan 2026 20:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769544593;
	bh=li5PgsPeyDOaDUR6nHT6meMbGY+B1SiSJCuUR+pQMJ0=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=RsrtyYegpZDrntAoBTgmkIO+CYQZRO9exn0Kk1TtUixbVcZHek9bx7jG/IJcmY55J
	 6UprJ4VdqttW0ENoQh1Srd0ZMqLg+pOG6Kp+Fc9yRQI3goNGQzwq2SogruMSY7qiHI
	 2/TMd07fwg58WUBgZUOQqoZ0oyXxzQ31qqRqjWBO32Gg7V7J60nHBWBNXXt+LOXdpJ
	 SD1ycHIocnl+bFKiX6AjlUBoIHADfM23NSkW4Cf0iBhbCnKveiHFuuSPl+ovGTj9eI
	 Z8HBlDvU/xuYxrG0SGnAVefaU9OCi9oiw74hN74Ygrp/3yIPkBs8zoOSCPX+h3KveO
	 67TDPfev1ujoA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 21:09:45 +0100
Message-Id: <DFZN7C8P37RK.3IF24Z1YUVVOX@kernel.org>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: introduce abstractions for fwctl
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <aliceryhl@google.com>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
 <jhubbard@nvidia.com>, <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
References: <20260122204232.15988-1-zhiw@nvidia.com>
 <20260122204232.15988-2-zhiw@nvidia.com>
 <20260126181912.GA2131321@nvidia.com>
 <20260127215744.332380fe.zhiw@nvidia.com>
In-Reply-To: <20260127215744.332380fe.zhiw@nvidia.com>

On Tue Jan 27, 2026 at 8:57 PM CET, Zhi Wang wrote:
> On Mon, 26 Jan 2026 14:19:12 -0400
> Jason Gunthorpe <jgg@nvidia.com> wrote:
>> fwctl_unregister is not safe from any context, it must be called
>> while the Device is still bound.
>>=20
>
> The registration is wrapped in Devres<> in the sample driver, which
> guarantees that drop is called while the Device is still bound.
>
> I agree that the current abstraction itself does not strictly enforce thi=
s
> (e.g., if the object is moved out of Devres). I will investigate an
> approach to enforce this requirement in the next re-spin.

The code is fine, the Registration object can't be moved out of devres safe=
ly.
You just need to update the safety comment accordingly. :)
