Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F0235BDB8;
	Sat, 31 Jan 2026 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869544; cv=none; b=d4ve7z5/SmCtCGj4PsuHKxYiqU9yGTEoYB8UYXUUNMAZXTUg60QzpO68Kkatoa0lYbe4XqhbiL/lm2INK/EyeZq4XigjVNsL4G55JwzhqoX8rCOHShOg/4/4zH3t3F5NDDn79cqkJK9UW2lErBGiUTkcAspBDd29qppTzrPeoQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869544; c=relaxed/simple;
	bh=wVsWvv0IL5XOf6zVy7RcF5hJW8aZ2pYZbyOxNeIcvmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEcpNrY1GCDNvpmDJ6a8och4WDWblwHVJQBhPgXBMIKFiwDSZiAx14zKj9EX8Mfaxc7/BjmFXhD2W0KWtjJLbWOX0f0bdlXAPozvXqIfSyZG5KqghoVd6X2ZAepcagTlYPELsZ4F/Rvgkk9XjQPQlkIBhSe3ks3wYwMhMs7AM0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEiVGPDt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEiVGPDt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4071C4CEF1;
	Sat, 31 Jan 2026 14:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869543;
	bh=wVsWvv0IL5XOf6zVy7RcF5hJW8aZ2pYZbyOxNeIcvmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pEiVGPDtTfcvXGzrM81yaHgKojfCIpjcpmrU2VBVWEzD/405MNOqqSPHBmJwlqM1C
	 ASigzP+jyB4FX7MkWq+JXyLVpi+CEhlF7zcSl5NSs88S6r5Hef92ZoYgoS7OQ3JB22
	 OeuA74wiRergJjvZmDxGNaMIiyI3BhULKtY81uQZ4xnnLMI4uax1ET9UyVet47CBbu
	 t+OWqn/59+Oof+4s54LEnbGImO6Psdg+wyNUZFRC2D/hb4s8TpaZonyuPSojDzv6BJ
	 tCvunJsQgDH5JfGRjWwl5hw1jqkEvHyHQ5NtZ97X+jI5rRrB2WE+kbwbT97EeD7cu5
	 yoDlp5uwnOMCg==
Date: Sat, 31 Jan 2026 15:25:37 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, jingoohan1@gmail.com,
	lpieralisi@kernel.org, robh@kernel.org, Frank.Li@nxp.com,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: dwc: ep: Return after clearing BAR-match
 inbound mapping
Message-ID: <aX4Q4RWMfXt085lL@fedora>
References: <20260131133655.218018-1-den@valinux.co.jp>
 <20260131133655.218018-2-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131133655.218018-2-den@valinux.co.jp>

On Sat, Jan 31, 2026 at 10:36:53PM +0900, Koichiro Den wrote:
> dw_pcie_ep_clear_ib_maps() first checks whether the inbound mapping for
> a BAR is in BAR Match Mode (tracked via ep_func->bar_to_atu[bar]). Once
> found, the iATU region is disabled and the bookkeeping is cleared.
> 
> BAR Match Mode and Address Match Mode mappings are mutually exclusive
> for a given BAR, so there is nothing left for the Address Match Mode
> teardown path to do after the BAR Match Mode mapping has been removed.
> 
> Return early after clearing the BAR Match Mode mapping to avoid running
> the Address Match Mode teardown path. This makes the helper's intention
> explicit and helps detect incorrect use of pci_epc_set_bar().
> 
> Link: https://lore.kernel.org/all/aXtrW7viGZfMNZur@ryzen/
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
