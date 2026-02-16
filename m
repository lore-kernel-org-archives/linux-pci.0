Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6C8301493;
	Mon, 16 Feb 2026 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771243066; cv=none; b=rk/05XrR1jcaNOH69qWL/zKsZE9+LmiwO418IQx3TtLDOq+I5WWs36wT733ZiwMWxtaGkJGtNAr5hIG5C1Af/dRqHLO5tNqr43ft1MMkFXuh9vbhnCPiCgVi/AhRewQlBk4C76B8Hc4+S0VZ6lG3ZQJj0EfByP2X5fGlbtmlCeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771243066; c=relaxed/simple;
	bh=PIu8mPBAJoeMwO2/sVA8OUXI8GPaq8/JW8r+wKcyloY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ny0FcEbikRN+7FK4vgMJH3V5SsRpvXPL2gDArtNkHHGI8X7gyS2rzHjWrpeY2e7pR2sm6bYjhj28dN8nkQHfrKrpeiAsq6HBt7lGSQpNaSCZXUKtFvstXAtPxl82XHrHbBddoZgY5HlYlERmDnCZ1dDSetz4yCLfXCdKEAbJ+L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7iUezNE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7iUezNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A96C116C6;
	Mon, 16 Feb 2026 11:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771243066;
	bh=PIu8mPBAJoeMwO2/sVA8OUXI8GPaq8/JW8r+wKcyloY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d7iUezNEhgvnYCK9Il9kQLjLcMzYyoA5DoSiyCaCxBfWe8iFv2c3DxqtEehMC5lo+
	 ARVxnC6vpf7gm31hC0Zm0Dyf/Fj4OWgeT3JDG1NMpz3ZW3sXx8Qfb/dD+yUdti8v8G
	 Kh8qV5q3lCtZ7IZFXNzA1IUYobL2yKMj+qcQodJREcJbLYYiDDEOULvs/geEsFe41S
	 FK3w2JW8m1T0ojnZfMRl99FZLj/DBfVo0zJYzyMshDH+UVOt/LjkJHFxRdQBjcAra8
	 /bkAd9+kRM56h6cUyycyYZEFeCKtNK5ZP5PeDQYZYN9BYvAy3Fz8YB3ka+9cdqeObK
	 Fkwyv3MhwyJdw==
Date: Mon, 16 Feb 2026 12:57:41 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
	allenbh@gmail.com, Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH 4/4] PCI: endpoint: pci-ep-msi: Fix error unwind and
 prevent double alloc
Message-ID: <aZMGNed0JChM9GEa@ryzen>
References: <20260215150914.3392479-1-den@valinux.co.jp>
 <20260215150914.3392479-5-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215150914.3392479-5-den@valinux.co.jp>

On Mon, Feb 16, 2026 at 12:09:14AM +0900, Koichiro Den wrote:
> pci_epf_alloc_doorbell() stores the allocated doorbell message array in
> epf->db_msg/epf->num_db before requesting MSI vectors. If MSI allocation
> fails, the array is freed but the EPF state may still point to freed
> memory.
> 
> Clear epf->db_msg and epf->num_db on the MSI allocation failure path so
> that later cleanup cannot double-free the array and callers can retry
> allocation.
> 
> Also return -EBUSY when doorbells have already been allocated to prevent
> leaking or overwriting an existing allocation.
> 
> Fixes: 1c3b002c6bf6 ("PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller")
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
