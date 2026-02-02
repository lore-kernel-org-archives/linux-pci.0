Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4112367DF;
	Mon,  2 Feb 2026 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770046452; cv=none; b=FdIhzunzkRF444EbxUCe+sxK5BPFdM7FfaJhBfzMrQXPk2Z2xme5OneEmKSOQW2LMe0LpBw/QvvDmgLf/bepBHsEZgDa3kHCEEAboCARclOcj/7q0QtmBdhJdP/yH6/JklvBjJuFhXal06ghWWUYL3sLiLZSfVQJ+kYQiK/oC1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770046452; c=relaxed/simple;
	bh=1npSCeTNEoM34me2Q++55uU4gVNWLQ0D65ty3NvIDlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fESsw17WtVtmyJMaALjWoKz4u3C/MxzEIg0U54GvVo2gcIAcEfCPrkoaUjl6+EggvXqbRH2rXoMzLX3yD5aaB5oObVysaCexnhnbXgE/5m9tueT2Gv3CEVGygJgt1dvoKdBfncSbyvclouYZGVweXfzGCrr7ekHSAvmsIoLIvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2g84pAZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2g84pAZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6846EC116C6;
	Mon,  2 Feb 2026 15:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770046452;
	bh=1npSCeTNEoM34me2Q++55uU4gVNWLQ0D65ty3NvIDlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G2g84pAZ5rVRFgJjJjcTCC7G7yDNQW23698kroWtQtt+6NF/8jJuwlT84cfQ6pL9X
	 NsX7jC5ZOxPjNmm5TWGfbCNEjghWdBtxLTK8L+MkUVwUzSYWi0P5HwXCK6ZN5aRaPm
	 /IbFumYow/k2c8Gw2uQyQ9AAGLpLRQxz2Fk/ICeffiUU/pabQRY+HP7T2sug2pO3Nf
	 QE87uJr2SZ0aL8DlhvbXNscaAkINsURnk2znG+TloeIh12sJeI96yQDpX/4hq1DBMl
	 jOnmrh/RLqQBpG0jvjbntbUeHCxhcpR8BZdSn5wEsYktKcgM5XTKhycRedV/VBBN/+
	 nDOURRyvkVX3A==
Date: Mon, 2 Feb 2026 16:34:06 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, jingoohan1@gmail.com,
	lpieralisi@kernel.org, robh@kernel.org, Frank.Li@nxp.com,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: dwc: ep: Always clear IB maps on BAR update
Message-ID: <aYDD7iA36vp9S88P@ryzen>
References: <20260202145407.503348-1-den@valinux.co.jp>
 <20260202145407.503348-3-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202145407.503348-3-den@valinux.co.jp>

On Mon, Feb 02, 2026 at 11:54:07PM +0900, Koichiro Den wrote:
> dw_pcie_ep_set_bar() currently tears down existing inbound mappings only
> when either the previous or the new struct pci_epf_bar uses submaps
> (num_submap != 0). If both the old and new mappings are BAR Match Mode,
> reprogramming the same ATU index is sufficient, so no explicit teardown
> was needed.
> 
> However, some callers may reuse the same struct pci_epf_bar instance and
> update it in place before calling set_bar() again. In that case
> ep_func->epf_bar[bar] and the passed-in epf_bar can point to the same
> object, so we cannot reliably distinguish BAR Match Mode -> BAR Match Mode
> from Address Match Mode -> BAR Match Mode. As a result, the conditional
> teardown based on num_submap becomes unreliable and existing inbound maps
> may be left active.
> 
> Call dw_pcie_ep_clear_ib_maps() unconditionally before reprogramming the
> BAR so that in-place updates are handled correctly.
> 
> This introduces a behavioral change in a corner case: if a BAR
> reprogramming attempt fails (especially for the long-standing BAR Match
> Mode -> BAR Match Mode update case), the previously programmed inbound
> mapping will already have been torn down. This should be acceptable,
> since the caller observes the error and should not use the BAR for any
> real transactions in that case.
> 
> While at it, document that the existing update parameter check is
> best-effort for in-place updates.
> 
> Fixes: cc839bef7727 ("PCI: dwc: ep: Support BAR subrange inbound mapping via Address Match Mode iATU")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
