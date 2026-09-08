Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D2846A61C;
	Tue,  8 Sep 2026 23:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908523; cv=none; b=k2ZAj7ftueew3RkOzsx0o0+Th4LZkexK4qzmunPOd/EzhdXZhJnAk3ucURr7ocRUUw6imejmT/ToS1a81JoiFDtlDilAfNTSTiIInrX1EqI8iGEERqyfJnoyXlcdBeI9jxxjXj3f9AmwEqd9JFCgOqNt9OIW5lcMZogxbQnreJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908523; c=relaxed/simple;
	bh=qLVm+fSIWjyAB2W8I8Kyp1kL5m36X4yBvFi2GQagBKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frZfhWK7KVc5hl/jgw0T7FRiaRSTs/NlrVmH6LEslAQWoHZSAp4JhpuCdyvJ5I3f0mR4t0epsV+eYXdE9Cpjyz8ZsweGycQUpUMyUrHwJ6D0IS6W/7sp/DPeV1xQxa/jKwlPiCtSMAVj8dxFkX7O/u5EsORn8DSu0K61MMXD2dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFRFxbTT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFRFxbTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96181F00A3A;
	Tue,  8 Sep 2026 23:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788908522;
	bh=Cr7QisnbyrPTLrMRZdqHp9na3t0p/BhYiqKv9pr7wGc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mFRFxbTTfHpMZ0uIYIxIny91ER+mvrAHW/mgPldul9bWX2WWmgYhciQ9a0UW9slmU
	 zGizR7wemBjsgsxGPg8Ja6Tk3r2jov3C2i74agVOMHCNMd/5CffQ3YsYNiBR3YC4mg
	 MKO8IAKjflqlXyz+p+Hm9XCgyak+Oupbtn0X0qgIMt6pcZ20GobZuIY4lPqcObmQP0
	 yjam0gNhx6Hj69O9uou/qOAp6OHUFDBr4NZr5poczjHOfJbidDUWHylCjqbLQtpgkI
	 GxNG1r7MmDIVKLl/pcb7tXtvQA5KdGhvJg8qPVxDcfQX3nglpnNQkwDfwfo+j2Ohfq
	 DZc1LiREUCwJw==
Date: Wed, 9 Sep 2026 00:01:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com, djbw@kernel.org,
 rust-for-linux@vger.kernel.org, lukas@wunner.de, alistair@alistair23.me,
 linux-cxl@vger.kernel.org, bhelgaas@google.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org,
 benno.lossin@proton.me, a.hindborg@kernel.org, wilfred.mallawa@wdc.com,
 tmgross@umich.edu, boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
 alex.gaynor@gmail.com, aliceryhl@google.com, Alistair Francis
 <alistair.francis@wdc.com>
Subject: Re: [PATCH v3 10/21] PCI/TSM: Rename pf0 to host
Message-ID: <20260909000158.78ffa790@jic23-huawei>
In-Reply-To: <20260901010347.2614656-11-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
	<20260901010347.2614656-11-alistair.francis@wdc.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Sep 2026 11:03:36 +1000
alistair23@gmail.com wrote:

> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Rename pci_tsm_pf0 to pci_tsm_host (and rename variables and function
> names from pf0 to host) as part of converting pci_tsm_host
> to be any device that knows how to speak any of CMA, IDE, or
> TDISP.

I'm not against the change, but I would like at least one example of
'what' other type of device you plan to use this for.

vf or something else?

> 
> This commit just renames the functions and provides no functional
> change. That will happen in the next commit.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  drivers/crypto/ccp/sev-dev-tio.h |  4 +-
>  drivers/crypto/ccp/sev-dev-tsm.c | 12 ++---
>  drivers/pci/tsm.c                | 84 ++++++++++++++++----------------
>  include/linux/pci-tsm.h          | 18 ++++---
>  4 files changed, 61 insertions(+), 57 deletions(-)
> 
