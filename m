Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1449CA945;
	Sat, 24 Jan 2026 00:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769213540; cv=none; b=bLlhFaxXlGPX2cCjOw3nWAez6ZRVQJy1sfhpvZCut6Svy6ZSJt8l/kB8aBKMDvu2uu8agDlP1LwmLCjMuljjXgJGnvpjxE71L6sGVl/Rh+SuaB3YK1fFvQNu76AZWSJzruwsAj3FmSlyKmI5OZZMVYSh+p6/e9Hhz3Zec7ss+h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769213540; c=relaxed/simple;
	bh=sR2xU+K38VRTqI0uBsvMdcRLFa2KPS3benyAPIGquhQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=dRpBuZ93xKYzJGNH0iZ/yi3c3yhp5C7Jqunf2uLxpV6Q7uOKUTa82eYhar+9QQAYH+rOQLnqsSdFzo283vCPZMBabQygg9BLmWSjLumvbKUhB0aZ+FLrEh4DU62JhUTawrbw2vN7lwltr2Z22uj++W0tkR1eLnG2/i0kHk5mAaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIWJ337h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIWJ337h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73085C4CEF1;
	Sat, 24 Jan 2026 00:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769213539;
	bh=sR2xU+K38VRTqI0uBsvMdcRLFa2KPS3benyAPIGquhQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=iIWJ337hfZ7SmGzBYb7LQEyjDQjyiT6W2mfpPxPIRu/8JPnGydJMWXry8RuwzPMJI
	 FIb2BvP+6bG2bKS9c6/CnMB8v5g1qxF/s0KB7rzZP6WXj/BF9AyEzsWFOTML9kM8tZ
	 VNV22M7D7EdZPb0fLTWPkqpGc2Jq9w9IwxiYklsQgDiCQVElI6GuvHCOs7E9h1R9oq
	 qXoqhZEzKQYxaWtsyz49t3pwmc5rcECCo+/dkfdR4ZXrwwoA8TM1/Nvo+sCXpym5RM
	 PksHZXdAGYW9fiJMoAV/yBdZK5u2BkC/lrBYh+NzfYCqqk4Q0YPjcaIGN0NbKmJiCk
	 7QTXtaBr9Vljg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 24 Jan 2026 01:12:12 +0100
Message-Id: <DFWDUSJI10R4.1V6ZTFNA4T8MW@kernel.org>
Subject: Re: [PATCH v12 0/5] rust: pci: add config space read/write support
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260121202212.4438-1-zhiw@nvidia.com>
In-Reply-To: <20260121202212.4438-1-zhiw@nvidia.com>

On Wed Jan 21, 2026 at 9:22 PM CET, Zhi Wang wrote:
> Zhi Wang (5):
>   rust: devres: style for imports
>   rust: io: separate generic I/O helpers from MMIO implementation

    [ Add #[expect(unused)] to define_{read,write}!(). - Danilo ]

>   rust: io: factor out MMIO read/write macros
>   rust: pci: add config space read/write support

    [ Applied the diff from [1], considering subsequent comment; remove
      #[expect(unused)] from define_{read,write}!(). - Danilo ]

>   sample: rust: pci: add tests for config space routines

Applied to driver-core-testing, thanks!
