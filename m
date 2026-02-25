Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62E038F93A;
	Wed, 25 Feb 2026 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044370; cv=none; b=Txemhyw3+wbtHhSAsYLbjEvAiHakIGG2pFzmnshrtTYN3MSkBJCh3x7VocZGAX5RIxqgiR7QHRG+8uVrQVQrTDVV51yFHJAl2IaiDUtfGqBy0qsb3g0Es6cz9vEMz/CUvTbIGEeyxgLunGh4tQL9ayCs+F178ApLJ0Z+3gSpsAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044370; c=relaxed/simple;
	bh=tEEcp9NZ0ucQIPlXL9/32lwBBjSaoxQxrzOMnZPTktg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pEfeVW2mvpG3RhiGt2nYfiPPe1S42sgPQ7ysmHoUAohTzJKl7nK6ED6ZMlVbR9TsNF/cp7mLF3ht19aMyvFXWQCCCrr8XWhLKPWj84/oQASjabIcVM8714eaGum4RRK2OmMEAFxoO3zyply6XcWGKzkglaPhKXi0vVNTwRbBE0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClTfZ64d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClTfZ64d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F871C116D0;
	Wed, 25 Feb 2026 18:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772044370;
	bh=tEEcp9NZ0ucQIPlXL9/32lwBBjSaoxQxrzOMnZPTktg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ClTfZ64dxTyayNuYxh8PoDJP8oEEnqhAKKw8mLmccKTNTgCwmS2gYTjJp/Aj5xlZP
	 0ZRyn//qusY8vgM7BQoea0XG4O0SXXBEyH+pOGBKo+QZovGWIQHhbIhEPXo/cVSTjz
	 r5KyBCnLZnqYtEkigokH6s72qK36cGcxt+jh4zR9vGqrilKb2MJ8lhO+UzGHShNpQK
	 /jaC1QnUepvDGrKvDGHmuAC9UrzfQLM3ZBUw9j16ueoQjqCckdZ49MPFNbRjcrqkao
	 I1qv59OjyEwYSoT+vO72n4MW7DxgQs7LnTBNp9m7rbcDt8l/29lRga8UwfkGtT0nAC
	 Takc8ExUqTa5Q==
Date: Wed, 25 Feb 2026 12:32:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Benjamin Block <bblock@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	"Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: Re: [PATCH v3 0/2] PCI/IOV: Fix deadlock when removing PF with
 enabled SR-IOV
Message-ID: <20260225183248.GA3781019@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a02222aa-64a2-43b9-86f3-a31b4668206c@nvidia.com>

On Wed, Feb 25, 2026 at 03:59:49PM +0100, Dragos Tatulea wrote:
> On 23.02.26 19:34, Dragos Tatulea wrote:
> > On 23.02.26 18:33, Benjamin Block wrote:
> >> On Mon, Feb 23, 2026 at 03:10:35PM +0100, Dragos Tatulea wrote:
> >>> After pulling in these commits in our internal tree we can see the
> >>> lockdep splat from below in many internal tests. We are still trying to
> >>> find an easy repro for this. We had to internally revert both of them.
> >>>
> >>> I noticed some similar discussion in another thread [1] but there it
> >>> seems that these changes are actually fixing the issue which is not
> >>> the case for us.
> >>>
> >>> ------------[ cut here ]------------
> >>> WARNING: drivers/pci/remove.c:130 at pci_stop_and_remove_bus_device+0x39/0x40, CPU#2: modprobe/12956
> >>> Modules linked in: mlx5_core(-) act_tunnel_key vxlan dummy act_mirred act_gact cls_flower act_police act_ct nf_flow_table [...]
> >>> CPU: 2 UID: 0 PID: 12956 Comm: modprobe Not tainted 6.19.0net_next_e834b5e #1 PREEMPT 
> >>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> >>> RIP: 0010:pci_stop_and_remove_bus_device+0x39/0x40
> >>> Code: [...]
> >>> RSP: 0018:ffff888164c9fd10 EFLAGS: 00010246
> >>> RAX: 0000000000000000 RBX: ffff888188ff2000 RCX: 0000000000000001
> >>> RDX: 0000000000000046 RSI: ffffffff8307e068 RDI: ffff88816bf4c9c0
> >>> RBP: ffff888188ff2000 R08: 00000000000000f4 R09: ffff88816bf4c080
> >>> R10: 0000000000000001 R11: 0000000000000003 R12: 0000000000000000
> >>> R13: ffff888164c9fd27 R14: 0000000000000002 R15: 0000000000000000
> >>> FS:  00007f52364bd740(0000) GS:ffff8885a9019000(0000) knlGS:0000000000000000
> >>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> CR2: 00005622dbf749d8 CR3: 0000000169132004 CR4: 0000000000372eb0
> >>> Call Trace:
> >>>  <TASK>
> >>>  pci_iov_remove_virtfn+0xbd/0x120
> >>>  sriov_disable+0x30/0xe0
> >>>  mlx5_sriov_disable+0x50/0xa0 [mlx5_core]
> >>>  remove_one+0x68/0xe0 [mlx5_core]
> >>>  pci_device_remove+0x39/0xa0
> >>>  device_release_driver_internal+0x1e4/0x240
> >>>  driver_detach+0x47/0x90
> >>>  bus_remove_driver+0x84/0x110
> >>>  pci_unregister_driver+0x3b/0x90
> >>
> >> This looks pretty much like what Ionut is trying to fix in
> >> v1: https://lore.kernel.org/linux-pci/20260214193235.262219-3-ionut.nechita@windriver.com/T/
> >> v2: https://lore.kernel.org/linux-pci/20260219212648.82606-1-ionut.nechita@windriver.com/T/
> >>
> >> Maybe try giving those patches a spin. I think one easy way to hit this sort
> >> of thing is to try unbinding a PF that has 1 or more VFs attached to it from
> >> some device driver. The "trick" is that SR-IOV has to be active.
> > Thanks or the pointer. Will try it.
> > 
> Took the v2 and it did the trick. Thanks!
> Is it worth a Tested-by tag from me?

Definitely, I always like to include a Tested-by, both to acknowledge
your effort in testing and to able to include you if we trip over
similar issues in the future.

If you respond to the patch you tested and include "Tested-by", the
tools will pick it up automatically.
