Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAD531F99E;
	Thu, 30 Jul 2026 04:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785386407; cv=none; b=evvPLr8XPhchgk63tw/zEmGjvPeSVklO23Ibrc3fTw53lTsHu97jU1WqXz+riDawOHYuLVgy+4SWGKehp9adDnrUdPnJGkI8zME8zsUQl7NJbt1sNbTCxOMGUcZ0KL4IvBXHEaSqkUDMkVyiXyTk2VXHjHdaJXxxixIubbPAuKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785386407; c=relaxed/simple;
	bh=GqCDgv/4G4zGYUrlVQW7+D6Szo7EYIzXaXrzXuCl/X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wu2i6tDxDWCSUdHJnRe6r7UPOTRhXT/nGOKhGXO8io4tttreATzcJWofQgxd5gV/lMVdYKRfOqxzlG2CKFgYK1CPGXpZT3WLX8lE090NoOuh8FnAiCQs90uJRTrCptst2oYVUte1tz9E+KQSoqXyiCbffO7vuY5rJ73Mir1vnAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Et1wXpsO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Et1wXpsO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15EE1F000E9;
	Thu, 30 Jul 2026 04:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785386406;
	bh=lz5TrE7MSYTB6nkBvVIXP6w1cvidDNpiHFoz/0rQoks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Et1wXpsOErZlbzablP0CeZqa1DzvihXfn0aOS5u2Buar/N56k11PKK6J7cHUAq0fk
	 dYVpK3G1Riq1/r8kAryGzteFCjoU0am0GENCuOlwOEX3VmKi4WZb1upLKtyJZpuoll
	 Hb30xiwfqs3ihDHpzx+lmr3DsZV/J5UHBiHdhWxLBwMGQ9h9W8edpFSKegUR1P/i4U
	 Qnm1es4pD/RnL9LN5SRkHcl/lmnEThBBvoNmolqYp4N2be/bRRVouW3DqD0XK8hxLu
	 xbVOk0Rxy1ni0kESjZc5hnT9V2nyeEQYtqN23YADktNJKYK+EKt1NY1DAnE2Y7JJ/h
	 z95xrxKJp4+/Q==
Date: Thu, 30 Jul 2026 06:40:00 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] PCI/ASPM: Use
 pcie_capability_clear_and_set_word() for ASPM disable/restore
Message-ID: <mjyj2cxu2tsevlklhdzxugiyijumnxov5d7xucxywivd4ize4l@cuiit7zl63bk>
References: <20260727-aspm-v6-0-2ebb3ee7ef71@oss.qualcomm.com>
 <20260727-aspm-v6-1-2ebb3ee7ef71@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727-aspm-v6-1-2ebb3ee7ef71@oss.qualcomm.com>

On Mon, Jul 27, 2026 at 07:32:36PM +0530, Krishna Chaitanya Chundru wrote:
> pcie_aspm_cap_init() disables ASPM L0s/L1 on both ends of the Link
> before touching L1SS config, then later restores the LNKCTL state
> that was in effect beforehand. Both steps use raw
> pcie_capability_write_word() calls: the disable step computes the
> new value by hand from a snapshot taken earlier in the function, and
> the restore step writes that same snapshot straight back.
> 
> Switch both steps to pcie_capability_clear_and_set_word(), masked to
> PCI_EXP_LNKCTL_ASPMC, matching the accessor pcie_config_aspm_dev()
> already uses elsewhere in this file for the exact same register. This
> does a live read-modify-write of just the ASPM Control bits instead of
> relying on a stale snapshot for the rest of the word, and is
> consistent with how the rest of the file already touches this
> register. No functional change.
> 
> Fixes: 7447990137bf ("PCI/ASPM: Disable L1 before disabling L1 PM Substates")

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260721143945.86E7D1F000E9@smtp.kernel.org/

> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
