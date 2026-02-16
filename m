Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8203002A0;
	Mon, 16 Feb 2026 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771238359; cv=none; b=pUzoJTmCWR94B9kcAjsWSkImhshon4zEqV1K+PAN4UOr3Xkl8h4o2+0NCE0+Y2NzSXTJC5M2slPW8/N858ICXTYE6BalT705HB3HBH20oYpWdhji2AliFRaf0ay5kA6fIafcrxRHIMXtmb249jE63PFVO+s9FRO+Str7s01vXwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771238359; c=relaxed/simple;
	bh=OIjHWG5WMAW4/bTUMutWVBi0ACVtvjt4Rj1BSpy/D+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9dvwZp5ufg0MFpB3h5pumMWuWB1m5YAHqYn1oR/jKWq0kP98mFksqZBgcTtK9slyAzOGpCBvFadR/XSqMzjfgZ5SDZU1GUbSDXUOsoL8uRf4+5iHF4ql3Da5Cvkmc2niXW4xCCY3qGSDfzqU6m5zdIPSGzsb0y0wffTxos0uCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoNst6DC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoNst6DC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E62C116C6;
	Mon, 16 Feb 2026 10:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771238359;
	bh=OIjHWG5WMAW4/bTUMutWVBi0ACVtvjt4Rj1BSpy/D+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NoNst6DCN3hR/REaDCB8Na6OvCc2waC/l/aPuNDY6QzzcDACapJjML30wVV/pO+v9
	 NytARsoB2SFx2/7bbQqDBx8ZYIctiQzklueLLdEmpjWUnCWYf1jJAgUbdZaB/egyHS
	 1ExvJCEYv2K2WS/07NBsooXv6KZnK1YoontMzyr6AVyULD2LKlQBI2e973A73DAEcd
	 4P15QqWiOSeAAONvYyBULsaPzt8hmjA+5JAUleiCKARdDSsZTKiete3VlDCJf2mWuu
	 I2B4gPKRdPXQiiFi96ZZr70aXhvupQpgLA+x6BQwyRb6LzhQmvT2sQclrekNWPC3bI
	 ckxo+5n3hkS9g==
Date: Mon, 16 Feb 2026 11:39:14 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, shuah@kernel.org, Frank.Li@nxp.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: pci_endpoint: Skip doorbell test when
 unsupported
Message-ID: <aZLz0pq6rJlDn-D3@ryzen>
References: <20260215150334.3391943-1-den@valinux.co.jp>
 <20260215150334.3391943-4-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215150334.3391943-4-den@valinux.co.jp>

On Mon, Feb 16, 2026 at 12:03:34AM +0900, Koichiro Den wrote:
> PCITEST_DOORBELL may return -EOPNOTSUPP when the endpoint does not
> advertise CAP_DYNAMIC_INBOUND_MAPPING.
> 
> Treat this like other optional capabilities and skip the doorbell test
> instead of reporting a failure.
> 
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>


Thank you for doing this work!
