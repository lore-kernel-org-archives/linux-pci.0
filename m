Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72E51E5B70
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769721405; cv=none; b=NiFO8Kye4dPK883lwy2gvCxMT0L8dEZkeGak8/pLkbWw0W/hR7C4BLUhVNNW828iTW6MT4P0452gICFQlqJtWRaf3Cbd7f/Cb04Vpogk9fXQiqXff9pXdeEn3mPF4VbdWuejkmBu8itqFMte/2ZI7X7/APNk1IoHlWNwpWbMiTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769721405; c=relaxed/simple;
	bh=vpE+nMEzLoj/TFLjIIK0FkWP9n94RH5367GYfFV9nkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7ZARhB9331kz96jc00K3df7cbngnQ6Q0BCFyc0NDh/9gnV2BzoQTNXkfM1UvRyW23GeEdYvnOT6WGd+dJx2NoKwgfNqIi0xI9VMP34Dd2oZaYMdgj2FXfADdV4/w5JP8ORsywjY5pv29/8AHDgzqUqx92LYu8S4NQzsb1816ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9vpu0h1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9vpu0h1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10658C4CEF7;
	Thu, 29 Jan 2026 21:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769721404;
	bh=vpE+nMEzLoj/TFLjIIK0FkWP9n94RH5367GYfFV9nkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n9vpu0h1Xp0Y4UwnBLMKClHy9yrdnTceC+uA8Q63WwfLBiT4h8YkKQhC2uVpOUcBP
	 J+mdrJ/QKE0GvaceDJLNf9TezzBr6U2rxrUEyGoTf8uYHTig0PyH8FR+jjAEk3g6AT
	 NALDCaw8gtTCAgkq4sNzKrAl0DEPNTlMrSeqkdFxihbc+UQfeU4BqSwTem46q9DRZU
	 3FY+6OR/YAMJkOa+S/Cjs3yvQRQLVoQEw7+T2Swkim6EpawmV7C2SsVEjsx67MCfFb
	 0X5u0pqfdsz7oBEo6IAbrMMgWr3gZBC63FNR/9wSmoHOvwnMam0W65yNQ8ILdG+Y3k
	 qrVHcMN3GP5MA==
Date: Thu, 29 Jan 2026 14:16:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	alex@shazbot.org, lukas@wunner.de, dan.j.williams@intel.com,
	guojinhui.liam@bytedance.com, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH] pci: remove slot specific lock/unlock and save/restore
Message-ID: <aXvOOjZQ_EmZDgVs@kbusch-mbp>
References: <20260129160955.2637158-1-kbusch@meta.com>
 <20260129202750.GA476192@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129202750.GA476192@bhelgaas>

On Thu, Jan 29, 2026 at 02:27:50PM -0600, Bjorn Helgaas wrote:
> An alternate path would be to:
> 
>   - keep Jinhui's patch that fixes the pci_slot_trylock() error path
>     (same as your 1/1 patch)
> 
>   - apply your 2/2 patch [1] to fix pci_slot_lock(),
>     pci_slot_unlock(), and pci_slot_trylock() to lock the bridge
>     (after accounting for the mistaken merge)
> 
>   - finally, rebase *this* patch on top to remove the pci_slot_lock(),
>     pci_slot_unlock(), and pci_slot_trylock() that have just been
>     fixed
> 
> The advantage would be that if there's any issue or objection to
> completely removing pci_slot_lock() et al, we could drop or defer that
> while still fixing the locking issues.

Sounds good. Another bonus is we can be more cautious for stable
backports since the first two are clear isolated bug fixes. I'll prepare
a rebased version with the proposed sequence.
