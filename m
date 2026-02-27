Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DD843E48D;
	Fri, 27 Feb 2026 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206449; cv=none; b=t87q/KplAPNVyGUdhxL7ZUbcIVv3CHMbwJRYgJyHr1ordtTLHepJInkQGkLsBzDbEUYFlXsorD9ZvzIrBuEUUU2wDZ+T1JzX0gjS4+mU6dEopmYKMd+Fx81+BiOGiANbn6f8UI6L+LY0Uajuu4MhIKEcqIGkeBOkS1zZOWMskAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206449; c=relaxed/simple;
	bh=xA4eq1B4WHkeDiKdaYvOGPnwQRl6UE44kUbEbocjO44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3kflO1s1PzUoggaSQVtFURdsncfwQSRP4UlKHVr8P57/mOYDz9AKyCcYqCkPXLA70lD1iSmBJtLeHns3xNYorluHKRflj6kA12eLvMNFt5FPmEEkP5+X3GRQvJytp2vVCWBVUBrLJ6f15A0/p9BnJLHIjp3LDft5aIywPwctfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMiFut1A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMiFut1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304ACC116C6;
	Fri, 27 Feb 2026 15:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772206448;
	bh=xA4eq1B4WHkeDiKdaYvOGPnwQRl6UE44kUbEbocjO44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BMiFut1AAajy3447HZ0FGatLcDBQjA21nQ/vmhIP1fZ8/bW0gH6pUI3zBKGlKTbuM
	 5uNhYBTuVsGtIjVf8itVzx42ISHdXLvJkYEN9zbmWgcvVM4BIYHWqrKT5UgeptieSy
	 j3yBRAcvRl3JYEhgkR6H2s6kVL9tz9stZKlluFCeJmv6ETXqBOFmV8vY7qB7aIvKJg
	 F5S/RqTRGK4Nniyfe+anUtc0HvftdQZtrBvgT9Z3f0SOZovdLPW4GWKFFZSKw+HFHR
	 XyfUO7GTYVqenFvDZiSXD5MBPTFKxi7JuDXxkGSIE1VnD42DyafIEXIrO4ZwgLWqs0
	 Q6AhV8s5bMwWg==
Date: Fri, 27 Feb 2026 16:34:02 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	kishon@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com,
	allenbh@gmail.com, Frank.Li@nxp.com, shinichiro.kawasaki@wdc.com,
	christian.bruel@foss.st.com, mmaddireddy@nvidia.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v9 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <aaG5asXVV5sxRbnQ@ryzen>
References: <20260219081318.4156901-1-den@valinux.co.jp>
 <20260219081318.4156901-8-den@valinux.co.jp>
 <u5q2ntwbjlqweodsipkkxcdtyt4zikfbyvriygsi3a3asbujc5@rgpblec4nwa2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u5q2ntwbjlqweodsipkkxcdtyt4zikfbyvriygsi3a3asbujc5@rgpblec4nwa2>

On Sat, Feb 21, 2026 at 02:42:35AM +0900, Koichiro Den wrote:
> On second thought, I'm wondering whether it makes sense to handle the case where
> the embedded doorbell target resides behind an IOMMU in this series.
> 
> In v9, we simply expose the raw physical address without establishing an IOMMU
> mapping. When the EPC parent device is attached to an IOMMU domain, a Host->EP
> MMIO write through the BAR window may result in an IOMMU fault.
> 
> Initially, I planned to submit IOMMU support separately as a follow-up series
> once this series is accepted, to avoid making this series too large [1].
>
> Niklas, any comments would be appreciated.

These patches are for NTB/vNTB:

> [1] Supporting such an IOMMU-backed case would likely require additional
>     patches for vNTB + ntb_transport to demonstrate usability, such as:
>     https://lore.kernel.org/all/20260118135440.1958279-12-den@valinux.co.jp/
>     https://lore.kernel.org/all/20260118135440.1958279-16-den@valinux.co.jp/
>     https://lore.kernel.org/all/20260118135440.1958279-19-den@valinux.co.jp/

If the diff you pasted above is all you need for pci-epf-test to pass the
doorbell test case when running against a PCI endpoint with IOMMU enabled,
then I suggest you just send a v10 with those changes included, without
any additional dependencies.

I understand that you would need additional dependencies for vNTB to be able
to use eDMA doorbell on a PCI endpoint with IOMMU enabled.

Perhaps, drop the vNTB changes from this series, focus only on pci-epf-test,
get this series merged, and then submit an follow up series that adds eDMA
doorbells with IOMMU support for vNTB?


Kind regards,
Niklas
