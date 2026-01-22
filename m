Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134812222C4;
	Thu, 22 Jan 2026 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769115988; cv=none; b=ahE/IaDVOnoT7pNHftcFQhB21DIUjXRw3f3+FKZmkqihu+bHVJluJZofpbHV7e8Gav2k/oPqWvCs4jyWsbkJ6pG5iYt6wD7ijDgEX7oSWNRIO5h1ltRTtSMScphV/ltxWnBM2siAh1bB27b2O1U+a3g65NOnq2+RiGGgQTwU1YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769115988; c=relaxed/simple;
	bh=rdHgfOcQjRRS8mbYC1WVgG9iZCpOuN+X4RQahWI8kU0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=L8wwp5ERKh2bUXoOOdLeQBjywULT2Ct8Q3WEuGef+Rr3VzEeQX5BNA+c1AfXJwLXivJjtmtS0cx2wMHrVgKgkmNUVaQd1eKB2XAic+xtlh7OSNasp/85urtzmPZ0sDwlJQUwveCklcmUafduEkzdYj7sk4+JUBSO6Mcg8XodP4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqvwduNk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqvwduNk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9962C116D0;
	Thu, 22 Jan 2026 21:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769115987;
	bh=rdHgfOcQjRRS8mbYC1WVgG9iZCpOuN+X4RQahWI8kU0=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=VqvwduNkE+Mtt5puiE/NoMzAQQHEFcWc8CF1sP/IlPPyQZSmmVgVuk0LJqxbT0DMv
	 maWGnpvvbhhj8cHr/bZCl1Tpx4qVxhFrAkGO1JnXI88UbAQJwTKLZx7maHCMScrTbV
	 S2GEgoBegmeQU0PB5IJwXlt9NfFq4ZCH40J7u/xj7HrWdELz91H+7ntVHNuQ0xdU89
	 E/ZjK0iMY+wOZvcR4+t/JRumcyxFg+HdDN/8HekQ0rhSe0f1uLilU4V8sUHmvh8h6f
	 uaB7GkKUoFPOemhGSP/fCX6gQ4Lj4Qtac2johX5Kz1fIX8Ty6AqftZtEYbNtoduKEu
	 hC625Fi4tMhEw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 22:06:19 +0100
Message-Id: <DFVF9XC0S46O.V7YN7L3QWB3M@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/2] samples: rust: fwctl: add sample code for fwctl
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <aliceryhl@google.com>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
 <jhubbard@nvidia.com>, <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
To: "Jason Gunthorpe" <jgg@nvidia.com>
References: <20260122204232.15988-1-zhiw@nvidia.com>
 <20260122204232.15988-3-zhiw@nvidia.com>
 <20260122205806.GU1134360@nvidia.com>
In-Reply-To: <20260122205806.GU1134360@nvidia.com>

On Thu Jan 22, 2026 at 9:58 PM CET, Jason Gunthorpe wrote:
> On Thu, Jan 22, 2026 at 10:42:31PM +0200, Zhi Wang wrote:
>> This patch adds a sample Rust driver demonstrating the usage of the fwct=
l
>> Rust abstractions. Add sample code for creating a FwCtl device, getting
>> device info and issuing an RPC.
>>=20
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>> ---
>>  samples/rust/Kconfig              |  11 +++
>>  samples/rust/Makefile             |   1 +
>>  samples/rust/rust_driver_fwctl.rs | 136 ++++++++++++++++++++++++++++++
>>  3 files changed, 148 insertions(+)
>>  create mode 100644 samples/rust/rust_driver_fwctl.rs
>
> Is this normal for Rust? Can we delete it when a real driver is
> merged?
>
> I'm not so keen on sample drivers, I've spent far too much time lately
> touching sample drivers that nobody ever uses :(

I think it is pretty useful for review purposes (at least as long as the fi=
rst
real user is not yet ready) to see how it turns out from a user perspective=
.

It may also be pretty useful for people starting out with Rust in the kerne=
l, as
the samples have a very limited scope compared to real drivers.

But there is no policy or anything, i.e. no need to keep it. There's also n=
o
need to even land it if you prefer not to do so.
