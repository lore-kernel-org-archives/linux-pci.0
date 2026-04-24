Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF4835F5ED;
	Fri, 24 Apr 2026 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777034523; cv=none; b=AU1tEtwMIuOwxDCBUUZk1X4RbbanljU33rhJnfhPSf8seYB/gX9ZC0jXjcjSf5w34ICFNlaUXJoC6j+BEow/Qq7Xu4koQrmYi6s8zYfwMvyLzHo7gZAIfC1R16y5J7VtdR3YZUrLrv23Xa2TXETXVHQzPK/oDhBOE/sNd1Q/8d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777034523; c=relaxed/simple;
	bh=t/Tps5bQrQ/STr7dbi97w6/FCKOkiYBJ9dzPh2A63Ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAuIH9U1NAPBMLuqCjm6SSWVTClxzXpYGIO+2ppe7g+3i9YpOmZTsvMnlgGcmjCPG4AtC/9eVkR1VZ8wYfze7eqCPsh51txKwAprebL4A0LJflU9STfJeFpcDI4eNgBfi+CXCBXoIk0J5+f9hXMyfAEeNgQX+3esUNEXD/0j3Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKIgIXg9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKIgIXg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFC4C19425;
	Fri, 24 Apr 2026 12:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777034523;
	bh=t/Tps5bQrQ/STr7dbi97w6/FCKOkiYBJ9dzPh2A63Ks=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pKIgIXg9vjHTamM6H/eqZUdo8ZkhcN3KEaekEIiDqKY+lu9LAKW1gKFmrqBmIYvO8
	 OjyMP8k08Vh08EymgbCXesT/tyNXt/7rt1e8xwvJhqlVn5mPRjOgGzmCNU52u5UB4s
	 3lEbFmtgwO5vEaXDrz1p/HC6cjsAzn6nIPLYkT9UuaAWNnNiq+iqI1Y9EggSzRu2jl
	 IVUaq1uv2m7YcFyGIVTmdiQUXZv6Rp+CdLB7JlLTvE8N0HNKNnSOjrEp2z0awh/jQ7
	 Q/hsfpcXULJDUI3dgM5gvpNGvlhm7u2kUM7+MRGZet73tFSp5y/lIwXrjUsecsyV/7
	 Lh9hcE3XyRXJg==
Message-ID: <11154ecc-d49d-40cb-8437-a4e6af1420de@kernel.org>
Date: Fri, 24 Apr 2026 07:42:00 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] PCI: altera: fix resource leaks on probe failure
Content-Language: en-US
To: Mahesh Vaidya <mahesh.vaidya@altera.com>, joyce.ooi@intel.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, subhransu.sekhar.prusty@altera.com
References: <20260424094913.522123-1-mahesh.vaidya@altera.com>
 <20260424094913.522123-3-mahesh.vaidya@altera.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20260424094913.522123-3-mahesh.vaidya@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mahesh,

On 4/24/26 04:49, Mahesh Vaidya wrote:
> The chained IRQ handler is installed in altera_pcie_parse_dt() but
> never unregistered on probe failure. If any subsequent step in
> altera_pcie_probe() fails, devm frees the pcie struct while the
> handler still references it. A subsequent interrupt would trigger
> a use-after-free.
> 
> The INTx IRQ domain created in altera_pcie_init_irq_domain() is
> similarly leaked on probe failure, since the existing cleanup via
> altera_pcie_irq_teardown() is only invoked from the remove path.
> 
> Move the handler installation from altera_pcie_parse_dt() into
> altera_pcie_probe() after the IRQ domain is created, and add a
> goto-based error path so altera_pcie_irq_teardown() is called on
> any failure after handler installation.
> 
> Fixes: 60f2ee5f1472 ("PCI: altera: Add Agilex support")
> Signed-off-by: Mahesh Vaidya <mahesh.vaidya@altera.com>
> ---
>   drivers/pci/controller/pcie-altera.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
I think you should decouple this patch from this series.

Dinh
