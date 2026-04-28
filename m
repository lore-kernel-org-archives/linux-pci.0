Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F57C44CF44;
	Tue, 28 Apr 2026 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382063; cv=none; b=aTlDwZ7B7ZdU3kIUawrxDZCWryWiXaRfgd7U3LH9gAQb9kknXjfVxHgzymvNDPOA2mXa/05QsDyW1zAUpyhQ9ZAOBf7MxVyydhuXCclm3DQh0SeNSSAENs+teHgjl00ICz2AOQN97p5HswG/b4/W68DImm6W9XaUw4FHMA5aDbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382063; c=relaxed/simple;
	bh=fId8M51eLiEA5R+kZZRBfVGDoJPE40PDpQO/FvKYmkQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=h80yk9H7MgSherj4xsVYKBKss3r9KmRLIgWS6xh7/qHmNc8iZ6WnDbh8B96qgWX9Zpr58yiRmTUeOa/PC5ZLTmq6BCdw6qI6QzUA6w9sokIc/3liXIWaBVlBIsYz55o2VS4n1k8fIJ/8nd0EfV20i5QPEnAzJHOmkdv1Uk6Iur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTPK421+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTPK421+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C30EC2BCAF;
	Tue, 28 Apr 2026 13:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777382063;
	bh=fId8M51eLiEA5R+kZZRBfVGDoJPE40PDpQO/FvKYmkQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=cTPK421+E+jI8HRlmLTMG8MYzB5JhrIJ5tmsueJAozatUgbxEQ4wqkQqYzs7i+IHC
	 w34izlUYoBbQgEcEMyKom24HUQY9fHdzABq2989Sxe6X/lwpUcZ326o3iFd/+tZOjW
	 P7gPxvl6kmrE+CSeTCF46fjiuYeibf9V/NFKdpENecwovgqmVH28T4tUnKjDGl7dvY
	 G/DaprRDa0T9Iirz4kmgWf4Zu7YJZ7cn4eCck005wN5sKyFUWS5YR7Dyrlm/Oe8wWw
	 MmiOLjQmBZp4VkVPbHlaeXHOdW6ostFu7NUVoz47o7en03s+nCR5wMACMQYH5pBA8T
	 PIToYoUajX8hQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 15:14:15 +0200
Message-Id: <DI4TCSCZ215E.16ZCXW7RSXBF@kernel.org>
Subject: Re: [PATCH 03/24] rust: devres: add ForLt support to Devres
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260427221155.2144848-1-dakr@kernel.org>
 <20260427221155.2144848-4-dakr@kernel.org>
In-Reply-To: <20260427221155.2144848-4-dakr@kernel.org>

On Tue Apr 28, 2026 at 12:11 AM CEST, Danilo Krummrich wrote:
> Use ForLt::cast_ref() in Devres access methods, enabling lifetime
> shortening for types that are covariant over their lifetime parameter.
>
> This is a no-op for 'static types, but prepares Devres for use with
> lifetime-parameterized types such as pci::Bar<'_, SIZE>.
>
> Add DevresGuard as a wrapper around RevocableGuard that applies
> ForLt::cast_ref() on deref().
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Please disregard this patch, it does nothing for this patch series.

It sneaked in from a subsequent series I work on which makes device resourc=
e
types, such as pci::Bar, ForLt!() types themselves.

One difficulty is that ForLt!(Bar<'_, SIZE>) fails when SIZE is a generic c=
onst
parameter, as it would require generic_const_exprs.
