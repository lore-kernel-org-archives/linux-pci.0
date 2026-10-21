Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792592740;
	b=IIRr4aZ/Uy1GtkscJYY4vSkgXx2KOk50D5FhmD1iHteqWew54z+w/D9h4LFN4Tuyr7og
	 a2PQhGIIXZI2Z4K62svIj4nP/D013aJMIX9X+GUYqgQDnK/WbNH5+eXm4yRi6+nKvINxp
	 ynBoF2y2WBWhHFv2jMbvOB6accG8zNR/psE+TBMQnFy6tYJz+QMzKu8d+VH2QADrvkdY5
	 3JFekNqpxO8zyXNofI6QKVZBULGKUqvzomuhI9GLmnpaHe/OANKNjd/8wLs+sMrERG9fO
	 08+Z39Tqx+1TMr+CdHH0TawqSMwCzd/siI6KDr9kStJ8ugy8nohG5RFhagxQYd8jRPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592740;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=L4qLQp+EeajMXHsH+2rm3DjABec4mArcixLHZHtBpE8=;
	b=jUsobpCAxo/E8fLbf8JB7W4fDeQrSspbZuEwLU4u74hHGGrRIQgbYxShbj+tFkZ1wWHl
	 YNtsV0cQBuWmjXjynqNRNadJ+XuZtMp+f6LJeXQBYejPb6vdHwsNrK1EJhIPgK8/Duk7m
	 CF8ewVOJi/CXNY08GdZvU7SP+Kq4FuwPNzcBrn6YTIYsrZd0BzaEbYx5Len2R322wiWLm
	 0eKs969D46/o+YamOUxmVODus3DjlUlYCMZ8fqu2CsNSa73niBH9kbz64gVaIQ9I3ecGV
	 5ZfZO+0EaXEXtZUmyUgbSS8i/Hn0vWheE7xNyFMbRa4102cuLv35B+fKzs6YQ68RS5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0u24M9G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201D5606A31B;
	Wed, 21 Oct 2026 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0u24M9G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF161F000C4;
	Wed, 21 Oct 2026 14:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792592739;
	bh=L4qLQp+EeajMXHsH+2rm3DjABec4mArcixLHZHtBpE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n0u24M9GkemyRmHyNjgMUcIawUT9Uyp5AXNXvcD5yhqmTAk5l2H26YNxXemCx+/uT
	 swILoYKsWF7xEqZ5NWOjoLsF/jOVYEezlS4j5ar8qkX6mATRC5FWt53GMsm5c7k2t4
	 NxChBn1umzIk7Emhg1F7ZapMpOR3wnz0WRtr/j3i9Fi8trA0Tnoxqv4v+rByDX2e6A
	 LUEbsr+WMinThia2BSB3BhbzTuRMbDzARHny2ChFj56/1yzafdM1YByjiE4sR52u5H
	 daNBlyW/8GJ4IqHTiJ5BvCSWkM0qyMhX6PxcsxqxPn7nfb+KRY6fULIu4mEYyEtcem
	 CGoNXnnZ+hyFw==
Date: Wed, 21 Oct 2026 16:25:34 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: mani@kernel.org, kwilczynski@kernel.org, linux-pci@vger.kernel.org,
	kishon@kernel.org, Frank.Li@kernel.org, bhelgaas@google.com,
	den@valinux.co.jp, thierry.reding@kernel.org, jonathanh@nvidia.com,
	vidyas@nvidia.com, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: endpoint: Skip upper halves of 64-bit BARs
 during search
Message-ID: <atjLXvkc-XZNF0oi@ryzen>
References: <20261021080644.1346549-1-mmaddireddy@nvidia.com>
 <atiX5UoJ0qgV0wGN@ryzen>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atiX5UoJ0qgV0wGN@ryzen>

On Wed, Oct 21, 2026 at 12:46:03PM +0200, Niklas Cassel wrote:
> On Wed, Oct 21, 2026 at 01:36:44PM +0530, Manikanta Maddireddy wrote:
> > pci_epc_get_next_free_bar() skips the upper half of a 64-bit BAR only
> > when it is the starting BAR. If the search subsequently passes a
> > reserved or disabled 64-bit BAR, it can return its upper half as an
> > independent BAR because that slot has a default programmable descriptor.
> > 
> > For example, Tegra exposes a programmable 64-bit BAR0 and reserved
> > 64-bit BAR2 and BAR4. A search starting at BAR1 skips BAR1 and BAR2,
> > then incorrectly returns BAR3. The next search can similarly return
> > BAR5, causing the EPF test driver to allocate and program BARs that
> > belong to the reserved hardware windows.
> 

> 12a22fb38cbb ("PCI: tegra194: Expose BAR2 (MSI-X) and BAR4 (DMA) as
> 64-bit BAR_RESERVED").
> 
> 
> I'm fine with this patch, but I think you need to rephrase the kdoc
> to reflect this new reality, because currently the kdoc is confusing/
> not in line with the 'new' meaning of BAR_RESERVED, which can contain
> MSI-X table etc.

To clarify, I can see that you updated the definition in:
27ce1d8ecb9b ("PCI: endpoint: Allow only_64bit on BAR_RESERVED")


But, IMO it is still not super clear.

Perhaps we should have mentioned explicitly that only_64bit is
also allowed on a BAR_RESERVED, if that reserved BAR is 64-bit.
(Since that use case is different from what the kdoc currently
says.)


I also think that this patch needs a Fixes tag with either:
27ce1d8ecb9b ("PCI: endpoint: Allow only_64bit on BAR_RESERVED")
or
12a22fb38cbb ("PCI: tegra194: Expose BAR2 (MSI-X) and BAR4 (DMA) as
64-bit BAR_RESERVED")


Kind regards,
Niklas
