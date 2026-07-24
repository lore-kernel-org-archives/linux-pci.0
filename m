Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847A82E8E09;
	Fri, 24 Jul 2026 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909911; cv=none; b=aJriQ3NW+qT9MYTx6z8cmUvqZSKGfUByNgTL9Yl6dfA4eIQay9Fs56TNvaILOUDNF2iH6d0szFP9W7AvkQRv2er+raJfBmXM4llEZZ7TYjJrvQ8THtqOkNBbgfqcjyCL86r2jzgfDRhYYzdQLBWhNtV9x4ohtrrQNIZiHPoQS0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909911; c=relaxed/simple;
	bh=viL+6b5IKN5GgurJrs3Z5xqif8Op6yAGMJQTvBryd58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxeJmdvmRZ+YvSsDrmBcXNq+0eMJOlRMMn2C0hIKuDQBSSnVGcznRwUG98Rbg6K6RvS020mz5cFDzq0f/c1Uqlv0mzVCXGh9Q5tRMaJ/hUxNgcy+MSkCPKzk/TknG+MmQVfZNi8e6PzhLeXF4idIhict+hf64frzaKc3whDMlK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+bubqvk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+bubqvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BEE1F000E9;
	Fri, 24 Jul 2026 16:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784909902;
	bh=UleNxQryAVTzH0j6eohbqhYDCdn7oJgfCKnX6dyoSN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P+bubqvk/wC9PSyidsH9R0qCsz0VoBTYT7Uw93QI/Luy8dAVhUwOPM5dgxAkNHAil
	 WaUTxIwdPhFsSEk01kj+R+byLZNNQn+YTaqjCmwCLliPtr7Rpbg5ysYSQDHyO9ZEAH
	 mBdNyMKK95yQMfjCe8E41RV2ktlcDgrS6jwSSacVz06hXmXIDrH+FJKkPwnvPA3Rjq
	 Jb17iiN8blW3y2alD9pf3PI7atjOz60Q/PAGXASozJWl8613QsvLaSfcygnEWhJtnS
	 o/sJ4j2+UBQu6S0MnLFOCMpiK45PCMkn8wPTlKrrbY9b0VWqybsndKTmZ0ngM4Z0DJ
	 PSohNpJjrU0mQ==
Date: Fri, 24 Jul 2026 18:18:16 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 3/5] PCI: host-common: Add link down handling for Root
 Ports
Message-ID: <vmsvvqw6d7tfxjl4dgjcwicyatvgy7yos3an42qroczq6hri7s@6yuu6lrq43dt>
References: <20260518-pci-port-reset-v8-3-eb5a7d331dfc@oss.qualcomm.com>
 <20260518170537.357DDC2BCB7@smtp.kernel.org>
 <mcdce4u2alwsobdsapnnwjwxofhwrd6gypdu45m3i5wzswhp65@lhrv5tvsvjs7>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mcdce4u2alwsobdsapnnwjwxofhwrd6gypdu45m3i5wzswhp65@lhrv5tvsvjs7>

On Fri, Jul 24, 2026 at 05:02:03PM +0200, Manivannan Sadhasivam wrote:
> On Mon, May 18, 2026 at 05:05:30PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > - [High] Hardware state desynchronization when CONFIG_PCIEAER is disabled.
> > - [Medium] Commit message claims error_detected() callback is triggered for the bridge, but the implementation skips it.
> > --
> > 
> > commit f07cf37e729701c6c67b90c92f65dd76b53b9fec
> > Author: Manivannan Sadhasivam <mani@kernel.org>
> > 
> > PCI: host-common: Add link down handling for Root Ports
> > 
> > This commit introduces a new API, pci_host_handle_link_down(), for host
> > bridge drivers to recover a specific Root Port when a link down event is
> > observed. It utilizes pcie_do_recovery() with AER handling if enabled, or
> > falls back to pci_bus_error_reset() otherwise.
> > 
> > > First, the AER error_detected() callback will be triggered for the bridge and then for the downstream devices.
> > 
> > Is this description accurate regarding the bridge receiving the callback?
> > 
> > Looking at pcie_do_recovery(), it uses pci_walk_bridge() to trigger the
> > recovery callbacks. However, pci_walk_bridge() handles bridges with
> > subordinate buses by iterating over devices on the subordinate bus.
> > 
> > Consequently, the Root Port (the bridge itself) appears to be excluded from
> > the callback walk and might not receive the error_detected() callback.
> > 
> 
> This seems to be a valid concern. portdrv registers the pci_error_handlers() as
> well. So we should be calling them.
> 

Actually, not needed. portdrv is not doing anything useful in its
err_handlers(), so triggering it is not going to do anything useful.

I'll reflect this in the commit message.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
