Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B856730FF26
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770765952; cv=none; b=GUBJwvGR2skgp5sMJjQSDFYJer9dml86CLjdJR04LqRIcTFtAbZwX2f5ZPbSGtUokVhijFCbsz2TAPDsYhzV5oPl1hKrw1wwoaqqxvVogU6eZDbqEIz5XrL1CByrBo5/gfX+f/zOExEvVUIc5FUbvtIApCh3ldkFllg6aSbLsjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770765952; c=relaxed/simple;
	bh=izE7hKd3sQdni3EKG4xfokeT1nv5H2vt3WHH3UEL2P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZi6LQmOA3IJPtlZNcLh/b9ZbVSURtxlhWizsvIwPpEwt6yn+ZRo+yTx78qBNR6/+en0mZbyTi9NsUd1j8pp0H8zsfOf6JZvrxMebfoj2cdpjhSs9dQEcPpGVTNO8+q/BNy8bj/Y+KoH+ke4tBER6S821ZpZyYOlHZ0He/OPh6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQ+hDBeD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQ+hDBeD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91BAC116C6;
	Tue, 10 Feb 2026 23:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770765952;
	bh=izE7hKd3sQdni3EKG4xfokeT1nv5H2vt3WHH3UEL2P4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQ+hDBeDAu4o2enUrDQ8V/kYZ6jDh5F/VedJk2TqM6nQMkE1MGTAlQgLZmwntnnoL
	 FFtHBJOll2FbRuzQB5ZoqRWTjqG4VI1a9k4Jl+VzH6cwvQrkWin4fsvNzVv/GNHzY7
	 wxr30S5x5vwNJG7BvekCuWdWJhIpruol8nEz8hIPF8blMwoP8pl4hT5/6Y/gyePliR
	 d3VbX2t0lyUfn158HbYrTPlgPQySzttxjXDtMhWgCGfl0/Z2KqOIsbTCD/2OqAs4/p
	 DrHRIUwwtKpE/JWD04zKmM8psO3JfTTXOAfJvwIRY4FBbbqtcmn9R1ghCbB87RsPx1
	 fnUCwPsynY4CA==
Date: Tue, 10 Feb 2026 16:25:50 -0700
From: Keith Busch <kbusch@kernel.org>
To: dan.j.williams@intel.com
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	helgaas@kernel.org, alex@shazbot.org, lukas@wunner.de,
	guojinhui.liam@bytedance.com, ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCHv3 3/4] pci: remove slot specific lock/unlock and
 save/restore
Message-ID: <aYu-fk1AIXtG-YnF@kbusch-mbp>
References: <20260205212533.1512153-1-kbusch@meta.com>
 <20260205212533.1512153-4-kbusch@meta.com>
 <698bab4a7cf16_2e57100bc@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <698bab4a7cf16_2e57100bc@dwillia2-mobl4.notmuch>

On Tue, Feb 10, 2026 at 02:03:54PM -0800, dan.j.williams@intel.com wrote:
> Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The Linux pci driver resolves a "slot" to the "D" in the B:D.f (see
> > PCI_SLOT()). A pcie "slot reset" is a secondary bus reset, which affects
> 
> Maybe change "pci" and "pcie" to "pciehp" above to make it clear this problem is
> specific to the native PCIe hotplug driver?

Good point, and given that, should I just drop this patch? The previous
one fixes up this slot assignment issue for pciehp, so we could consider
taking either "2" or "3", but not necessarily both. I included both in
this series because I'm not sure if there is a preference. My best
reasoning to take both is if we want to proactively handle the entire
bus for all platforms requesting a slot reset, but also leave us an easy
revert if it causes a problem.
