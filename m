Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7D93976A8;
	Tue,  3 Mar 2026 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568124; cv=none; b=qHhg0fntayIdfZRMi/sBAMvGKYGx+yaW+bOk6KOfGuFvZBWpei3mv9bLWEnMwRKlrVR14mXTof72NNZ9wSN+94tlUOj8ALIxjDk3lQPAZ1ozcdzosCV7PsayELlgAwOvAjN6jBaKOPxV2DkV5k8cZEyJEYNGqTTdiRMmM9SCPKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568124; c=relaxed/simple;
	bh=shEgcgOBYfpeEiDXbrKTQf4CKxOx+4pkYVEOFPfGFBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYei+xlJeQDpSYjLsz3jQ/aleD6HBzFQGyZddM0CzNmQazR7zGsXFn1B45Odkw63PAoECSCDh1KAL0wVeIEiEC0DsAHTP7bX5qgjqv9uU3NGetG14eNpPTo5NYm4gxaouwN//+ZlfV4aSzAWN6cYNtOaIYbWCX/poUeqn2GTpEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRUU+ktS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRUU+ktS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8179DC116C6;
	Tue,  3 Mar 2026 20:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772568124;
	bh=shEgcgOBYfpeEiDXbrKTQf4CKxOx+4pkYVEOFPfGFBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRUU+ktS1UKqkYC+4C+35UICPjC0TdTngmV3lCzPA2xpggqpjkVXy2cNwqVmbxUpO
	 vrSfxgHfnEM5zeAQjXJjTMA0+pwqwW/BgpJltjIMsz8ngt0DyI/rx5FJlZEs0UmNdk
	 d4PKkN4oiCiRbtTSOlrlZAQVKkaDx1py4huMFjecJFUEEnZOZgpWyTX+x8nDlv9c6U
	 JzKi5RVjjMrBX7DgDlF6ACC7bCIbGdI02duZCVhe2BeFiFx29eowsOGmSyMFOlf/jp
	 AIXrZcUOmGkqXW0sABmOvjO0a4O3c5ao6qZJWsq6F9pWBddG/8khfXrpq9oKY7EmTk
	 vRInyonxGfewg==
Date: Tue, 3 Mar 2026 13:02:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
	linux-pci@vger.kernel.org, helgaas@kernel.org, sebott@linux.ibm.com,
	bblock@linux.ibm.com, alifm@linux.ibm.com, julianr@linux.ibm.com,
	dtatulea@nvidia.com, mani@kernel.org, ionut_n2001@yahoo.com,
	sunlightlinux@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] PCI/IOV: Add reentrant locking in
 sriov_add_vfs/sriov_del_vfs for complete serialization
Message-ID: <aac-OfCmrp7tmDed@kbusch-mbp>
References: <20260303080903.28693-1-ionut.nechita@windriver.com>
 <20260303080903.28693-2-ionut.nechita@windriver.com>
 <aacmM9bAPstfDpgY@wunner.de>
 <aac2bUCCX3dZcwo0@wunner.de>
 <286d0488aa72b1741f93f900fd5db5c4334a6f50.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286d0488aa72b1741f93f900fd5db5c4334a6f50.camel@linux.ibm.com>

On Tue, Mar 03, 2026 at 08:56:24PM +0100, Niklas Schnelle wrote:
> On Tue, 2026-03-03 at 20:28 +0100, Lukas Wunner wrote:
> > Actually, scratch this particular comment.  The deadlock in pciehp
> > is actually an AB-BA deadlock, not recursive acquisition.
> 
> Hi Lukas,
> 
> Do you have a link to a report or a lockdep splat for this issue?

https://lore.kernel.org/all/4c882e25194ba8282b78fe963fec8faae7cf23eb.1529173804.git.lukas@wunner.de/
