Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7782FFFBE;
	Mon, 16 Feb 2026 10:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771238335; cv=none; b=E5nK4dEcOCFhyPMRhMu/exmsDh5HjlA2XcNlOa9734OI8cJyyMzwenjuq1t+sRWlZ4Uag/AMcucgfU7V2IjoOqreeYVlSNj9sYGKHYKIQzpk6CCNgAeKv+TxtZTl6W8BNucVqV2pqtSyNYXooXGJ8FnNFUooSzbyg4xIvZVykxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771238335; c=relaxed/simple;
	bh=hJsthusZ2oYvyFG0d8GVVEGulyXE1T8rWh7oS2DLRak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmK+p1wIscfSLfJalHATEfgzhvYwN4oHKrW+DrhvkqZZZFfxAaHx9Iid8dQiN9kUcJDpC71t9RVwnyd1OcswvR5VVhRjaSuZx939RZl/S0ldYuDoFAeKuVDMVQy+6Le2sAMXcqZ5mlEc9MJ3Hwd7/+jJMOvf7S+LuSFGIb8m5HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQaX1F5d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQaX1F5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A6CC116C6;
	Mon, 16 Feb 2026 10:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771238334;
	bh=hJsthusZ2oYvyFG0d8GVVEGulyXE1T8rWh7oS2DLRak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQaX1F5d5pISlSWv5jEUVnCeQ8SVwBwiBQUS+dgJsuw1l0np28mnI3HxRLsmKDQj6
	 M1y6MzANBBqxI/9WKPL1C/bOyj3G2zhOFIQ1sl2SVLAFNXjEoZZKuHERaiZ1uver+U
	 ukZaV+mJuZVRON7rfaXetb3g7edw+ZsP6OwvsiWEJd3lglGjgKgdplCRkkrUsWYAnR
	 f8gZskhQO5jBPVQZNF8uQqlbnVX2Sr+jpakI4ZpYiEacXkxJqK7R2LNSdCMV87ptqH
	 0Qnrn46VRaWgJT81STUuTP6t2yKt6U+MAJ92R2rM0djkJZpC3usKfzeJeXJI47jRnS
	 dVtU78RQ1B77A==
Date: Mon, 16 Feb 2026 11:38:49 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, shuah@kernel.org, Frank.Li@nxp.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] misc: pci_endpoint_test: Gate doorbell test on
 dynamic inbound mapping
Message-ID: <aZLzubzXAk_c9QqY@ryzen>
References: <20260215150334.3391943-1-den@valinux.co.jp>
 <20260215150334.3391943-3-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215150334.3391943-3-den@valinux.co.jp>

On Mon, Feb 16, 2026 at 12:03:33AM +0900, Koichiro Den wrote:
> The doorbell test relies on the endpoint being able to update inbound
> translations at runtime so the host can reach the doorbell target
> through a BAR mapping.
> 
> If the endpoint does not advertise CAP_DYNAMIC_INBOUND_MAPPING, return
> -EOPNOTSUPP from PCITEST_DOORBELL.
> 
> This avoids confusing failures in user space and kselftests when the
> required capability is not available.
> 
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
