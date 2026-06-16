Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A9435CBD7;
	Tue, 16 Jun 2026 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614631; cv=none; b=aU2oKmxXt51bOuksrXNVPlGxGfeQCMcqga8aUR6kk6NGvhjpvMJNtVQXlXjt8eVwFkFNvEM4KijcRpUtVfgTxcl5FrFxjB7/Uwpf3gGcRLOU8p+5/u6UjuRqTBAZcA3I8ZfexknbWsZ2nELgXVYN5qBCjYZjM1P7GUinGCt/520=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614631; c=relaxed/simple;
	bh=yIWEZ6Mwe3B+5GKAj721Up1Y7xM5BlEWCxTchsqZOIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TInWugxSOICMNouTkwLQ42LK6TL+9bOL3+jtE2x+HglQ8l7mCpUGVW82YdUobnW6CB/2dS51D73onpAVeb5uhvz/N7O3uKlZQ7j5IIwpqKkrrqqkm9UBA2vFJ3+pamR9WvHdyucyF2+YcI0f8zvjxH9H8xLEvXo5HaTSu0QlCEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7vkxDU4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7vkxDU4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B47F1F000E9;
	Tue, 16 Jun 2026 12:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781614630;
	bh=Amsf7byLU6TUTGoZquZNNTh0rzHsPl14KFh90IgFwH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j7vkxDU4hGGSROpH1MXuuJT7/P3tgm6yyooLwsL9ewWx/awd9RgCk+eQP3GV3Wpj6
	 Mr8T8nI6HHEL8M5fQINsCgKSfVIXp9M8vWVOAN/uJ0NSiON2+HVnRWspD0Ix2GOoyB
	 UAXbj+XT0QYx5tzvwceWaZI64gV3UIG6XR5PzVe8TYr/YrfWzggWbgDAU4GbNuwfTN
	 uEcLWku1E+tWSrIMxEk5GUToFzgN2DFHC05fLeolsa5ArA24L8+l1jMzUew2BGHKJw
	 +0Bs4CD7OXlHLagesEfTuBnq26bietWKsnAcPdr0i3Hgug3wqjWK0jb8z5efon0b9G
	 IqCx+8UtzAqEw==
Date: Tue, 16 Jun 2026 13:57:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Dan Williams <djbw@kernel.org>, Ashish Kalra <ashish.kalra@amd.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, Vivaik Balasubrawmanian
 <vivaik.balasubrawmanian@intel.com>, John Allen <john.allen@amd.com>, Bjorn
 Helgaas <helgaas@kernel.org>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Yilun Xu <yilun.xu@linux.intel.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Alexey Kardashevskiy <aik@amd.com>
Subject: Re: [PATCH] PCI/TSM: Resume device to D0 for CMA-SPDM operation
Message-ID: <20260616135700.2b2b9056@jic23-huawei>
In-Reply-To: <7bdfaf14d7e5a466f3f650150c688a60e947a7a9.1781527060.git.lukas@wunner.de>
References: <7bdfaf14d7e5a466f3f650150c688a60e947a7a9.1781527060.git.lukas@wunner.de>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 15:19:30 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> Per PCIe r7.0 sec 6.31.3, CMA-SPDM operation in non-D0 states is optional.
> The spec does not define a way to determine if it's supported, so resume
> to D0 unconditionally for the duration of a CMA-SPDM exchange.  Vivaik has
> talked to Windows engineers and they said that Windows does the same.
> 
> Note that for plain DOE operation, it is sufficient for the device to be
> in D3hot and its parents in D0 because config space remains accessible in
> D3hot.  So CMA-SPDM goes beyond the requirements of plain DOE and hence
> resuming to D0 needs to (only) be done in code paths which use DOE
> specifically for CMA-SPDM.
> 
> The pattern used herein for runtime resume is the best practice introduced
> by commit ef8057b07c72 ("PM: runtime: Wrapper macros for ACQUIRE()/
> ACQUIRE_ERR()").
> 
> Fixes: 3225f52cde56 ("PCI/TSM: Establish Secure Sessions and Link Encryption")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.19+
> Cc: Vivaik Balasubrawmanian <vivaik.balasubrawmanian@intel.com>
Seems reasonable to me and your replies to sashiko stuff seem to have that well
covered.  So FWIW

Reviewed-by: Jonathan Cameron <jic23@kernel.org>
