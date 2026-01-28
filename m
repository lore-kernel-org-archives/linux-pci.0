Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D9731E0F0;
	Wed, 28 Jan 2026 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622029; cv=none; b=iSgzM7JjWfYEvKTRMAsR6vn/fzIju2yZlOPJgnogHGcuX4nFWionRLDetDLfMdnW661P6p+/L1Cx5VQvdnAuASiqo8GzTBvNVxYLTfgTC5T/dK0AkbAdC/eNA65PrM3PtZWb9MCBsZt4EdA1vWSMCBry9TV4f2Rj5SP1s14r3ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622029; c=relaxed/simple;
	bh=fs7KfRgUYE33Y5OCMQeQCkUyZVHSnpAgkJipqC4hxsE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=SKXSbVWr8a71ido2kX4dl7GbtSiA9zY1Yt7I22QmLmE6MBbNgXrZMKquFDxNKkIteUCWQmnmgwwm4H3eELBw/n1qhjdpF/FWQwkD0xtN++vrFk5DwqDO6BAa4cOzR1cWAeU95JIk9DPfij0n9oJNjx+VVbUn7mQ0jf1Ctx3+p30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuuQNG0c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuuQNG0c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2730FC2BC86;
	Wed, 28 Jan 2026 17:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769622029;
	bh=fs7KfRgUYE33Y5OCMQeQCkUyZVHSnpAgkJipqC4hxsE=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=TuuQNG0cirvni8MhMOmQFa8K1WBRrYBCwQOZZLGKBjoWCSbHSFNQHxlcWWIpOBbx/
	 +LwPEB5BzUS6rqUvHPdNlhjNniGXSx+hpU/toHwmlYP2DlTKrHmAQfze8BWZM17bA2
	 Jmqh9//AwLQ6R6z4nvVMHBB5kCPLnLMfhstD2rvdWv67XjMyNgYMCGZ//wABUoHN5s
	 /l8s2MQ2fz3KWrmZViCmQzOg8f1FRupFnbXp5cxCfzuMqD4ix+8pY/c9WJwpQGYqUP
	 5NiHcBnjel8+bciNXmkZ0AQIExdU5gT/Qh5MBL0nHuls523VBnGFP3tDfGu9QayTnQ
	 cP5DXbmg31OLA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Jan 2026 18:40:21 +0100
Message-Id: <DG0ENHNJE4X4.14T1ENBL0SOSE@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: introduce abstractions for fwctlg
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
To: "Zhi Wang" <zhiw@nvidia.com>
References: <20260122204232.15988-2-zhiw@nvidia.com>
 <20260126181912.GA2131321@nvidia.com>
 <20260127215744.332380fe.zhiw@nvidia.com>
 <DFZN5P8G6MQG.2DYXNFSRIL450@kernel.org>
 <20260128000410.GT1134360@nvidia.com>
 <DFZTU4ZFFCM0.3N8LJ8XBN3DF@kernel.org>
 <20260128132029.GX1134360@nvidia.com>
 <DG09ZUY530SW.K62KDIT4LIXN@kernel.org>
 <20260128145906.GZ1134360@nvidia.com>
 <DG0CABK2DQE8.1TDN35GOJ0DYI@kernel.org>
 <20260128155646.GB1134360@nvidia.com>
 <DG0D9I9P5BO9.6Q9H2BQN5AWU@kernel.org>
 <20260128193011.3294f41e.zhiw@nvidia.com>
In-Reply-To: <20260128193011.3294f41e.zhiw@nvidia.com>

On Wed Jan 28, 2026 at 6:30 PM CET, Zhi Wang wrote:
> On Wed, 28 Jan 2026 17:35:04 +0100
> "Danilo Krummrich" <dakr@kernel.org> wrote:
>
>> On Wed Jan 28, 2026 at 4:56 PM CET, Jason Gunthorpe wrote:
>> > On Wed, Jan 28, 2026 at 04:49:07PM +0100, Danilo Krummrich wrote:
>
> snip
>
>> > Or is it needed to add the typestate?
>>=20
>> This is something we should consider when a fwctl::Device would have
>> different states it can be in, where calling certain methods of a
>> fwctl::Device is only valid for a certain state and would cause
>> undefined behavior if called from the wrong state.
>
> Are you saying we should define typestate like Device<Bound/Core> also fo=
r
> fwctl device? I haven't thought about this and some design consideration
> would be helpful, as the rust PCI subsystem has it, while some of other
> abstractions don't have it. I could start to picture about this if this
> is necessary.

No, I don't see a need for a type state for fwctl::Device.

The DeviceContext type states, such as Core, Bound, etc. are type states fo=
r bus
devices only. If you find other device structures that don't have this, the=
n
those are not bus devices, but class devices (such as {pwm,drm,fwctl}::Devi=
ce).
