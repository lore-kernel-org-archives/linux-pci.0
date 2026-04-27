Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0877F3191C8
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328934; cv=none; b=Ajs94yej6ZwkyEqCihyouwdekXweBBCJIRQyJ491WfG2rSb+bWcy6fNL1UahdmtRPXddCu0kFB4kZeBXLoczLdifhYiBxEfZ5VEECMyfAvTVy+ZPudRhaDws2horZP4t3IGSasyyfMkoztTpSHbljWY4ti6WwWyZe5rL7NyiaWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328934; c=relaxed/simple;
	bh=eF4eS/o9dMmTeAe77+LnwkPuxNdSAyiJUht01Qg7hV0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OBhDLobLyGJdclrv/V9EC5ZfN+/z+0SlePfENloluiSP0fM5wEdUqYs3l/FUbexoKNMeK6TM6c8rkIx5h8L90bfSFPhTeb08tPlD43lN4RKihLZyFWwlB2K8Ltr8McpKFEK4zQ54F5g+dQUrn6ud6ak6rOSmXDTt9TJKKCtuNf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3JVIQvT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3JVIQvT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA11C19425;
	Mon, 27 Apr 2026 22:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777328933;
	bh=eF4eS/o9dMmTeAe77+LnwkPuxNdSAyiJUht01Qg7hV0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=r3JVIQvTB26B3gyiE+MIZdP4GMk0P722MuzUizWYVoIuI+kU7qGRa850ukqQ15Ets
	 kB4/fSPP6TCPSue6jpeuqENNopbg3K0zJydXDKoG8IZos5VLbRS39vLZ7HMDSnHJ2m
	 mEt/4iHLAmTQHlg7gORuG7IMQZqJCHG37JIcqATAaUT3Bd4Muip9rWsWbIgfduayGN
	 r7hFd1BUDcMbtmgjFOE0FQYtKhSO2ynHFqQGl3U7x/FUvcAbBKDKj4vvU4pmsxNO+4
	 bmKIc01DTMDDOgcdqaM4cUbCrbcONyHs7crKQ0B0xY+rW5984tnt6QvuZ0ZWuwwrn7
	 BIaa5j6tlsTLQ==
Date: Mon, 27 Apr 2026 17:28:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com
Subject: Re: [PATCH] pci: don't fallback to bus reset after failed slot reset
Message-ID: <20260427222852.GA199990@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aevqGci1hLqZQdOF@kbusch-mbp>

On Fri, Apr 24, 2026 at 04:09:29PM -0600, Keith Busch wrote:
> On Fri, Apr 24, 2026 at 11:11:36AM -0500, Bjorn Helgaas wrote:
> > On Tue, Apr 21, 2026 at 08:06:44AM -0700, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > If a bus has hotplug slots that implement the slot's reset_slot
> > > callback, it is not safe to do the non-slot specific bus reset, so don't
> > > fallback to it. If a slot reset does fail, the subsequent bus reset will
> > > attempt a 2nd link reset on top of previous and fail to handle the
> > > hotplug events.
> > > 
> > > Fixes: 8238cb69c01fe ("PCI: Make reset_subordinate hotplug safe")
> > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > 
> > Applied to pci/reset for v7.2, thanks!  Will be rebased after
> > v7.1-rc1.
> 
> I kind of think this is 7.1 material. If a pciehp slot reset fails
> because of some hardware issue, that means the device is being removed
> after disabling the hotplug "ignore". Falling back to a bus reset walks
> the bus' device list without a lock, so it risks grabbing an invalid
> pointer racing with the removal.

Thanks for the heads-up; I moved this to pci/for-linus for v7.1.
