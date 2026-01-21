Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB3533BBAF;
	Wed, 21 Jan 2026 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769017619; cv=none; b=rRa9NU0l0j/4CWGn+u0TOwamltZkVx9FjYYmTPT5jkImAKG2jI/2chyD6eWAt94uwgTENt51fB+ueTPEJBa2pyiwgB/1iSScrWBYguWOXPPZeoIkNSFJVk/EG6RojVo1jwGt/GZKEUZZ6ljuma5sykhP2dZjW0IibcBKVoSrrVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769017619; c=relaxed/simple;
	bh=4BXxCLodi8xzrHDKddtc4ANmQ7H9cq2+1t3nnWw4Y10=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=I7EenNujHGVnssBdA/d8nLk8P8K3Naq3FUtNHFBgFOk8dQovgj9wDHXbTCoAM45hYujq66g8INZ6kkaM6FASEx/bgalxLrQ5lnOIkOzwmnl5FwVqnZItT+ex6JfIo49gbEtaxBXfdymGnlmGDdFpGW4QAgDuYjbrChk+wBCpGpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZkeqJjS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZkeqJjS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92E9C4CEF1;
	Wed, 21 Jan 2026 17:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769017618;
	bh=4BXxCLodi8xzrHDKddtc4ANmQ7H9cq2+1t3nnWw4Y10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PZkeqJjSkvqVeCnKp3+Twx9er9KtJh1wOUVssxaICOGCj/hzaqEwg/rLN+QDTLDma
	 URwqZ8QOm5fSwDgTGRjtjzwiRTiXSqFOiUA062snlhKheN73jt5I6DeP7yGJbwsjjU
	 pxOl7zc1XRwAtgeXcLBqwl5wUNG8smwOUkP0Q2wNu7Tnp5oS74lpW4LjFUQhb5AeBx
	 ncuAOlds9jBTVxArQ8qR95B3tijDS/ICGeykxvz1KDzdwvGoLOvtIZAwYNzcVW6PB4
	 rvpzodpDsgGEXJ3tXOt4BOYdcAAijy4gb7XYqpfMVy3s/WC6/8a5Apzqc15qpwCykr
	 9yv220jXLNAIA==
Date: Wed, 21 Jan 2026 11:46:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: BAR resize rollback fixes
Message-ID: <20260121174656.GA1202731@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260121131417.9582-1-ilpo.jarvinen@linux.intel.com>

On Wed, Jan 21, 2026 at 03:14:15PM +0200, Ilpo Järvinen wrote:
> Hi all,
> 
> This series fixes two issue in BAR resize rollback found by
> Ville Syrjälä <ville.syrjala@linux.intel.com>.
> 
> Ilpo Järvinen (2):
>   PCI: Fix BAR resize rollback path overwriting ret
>   PCI: Fix Resizable BAR restore order
> 
>  drivers/pci/rebar.c     | 18 +-----------------
>  drivers/pci/setup-bus.c | 23 +++++++++++++++++++----
>  2 files changed, 20 insertions(+), 21 deletions(-)

Applied to pci/for-linus for v6.19, thanks, Ilpo.
