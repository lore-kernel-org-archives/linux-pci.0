Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB818D658;
	Tue,  3 Feb 2026 00:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770079692; cv=none; b=jzZ8ZVm3shM6nxMZF5Rbl2pr7tvGvkL+xl/7NviedpLso+ILDmyqHA+gx7VY/Z5pdKlq1+WtGGW6qatcYGTjpKP8Di4uA2ylBXiDaxu6JAaUVkayS1xmPv9ata6lpk/eiJw7IpgIMfVgBcsdfbmNFWC0jL4a8WEmnqQukdMvlzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770079692; c=relaxed/simple;
	bh=nlNJao5W8EuFJW9iRoYO3ccIbD4RjwH+AiUICRl15Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rMYV8X0GxSvwpvPCul/ezn7QSfXP2gWkoqiXTuIqvK5CeFKeHyWqPk5+ga8dCAciFhb+62v6/bEnjS17Sf5iH32RILtcuEjtyxGgCK3nYH+ZN+OmhCXOh33HuhV/j+x/UTLxVdv1csGHtS3bMo8pmz8AS3U1tWOf3lACA72kciM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/+qn89L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/+qn89L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ACFC116C6;
	Tue,  3 Feb 2026 00:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770079692;
	bh=nlNJao5W8EuFJW9iRoYO3ccIbD4RjwH+AiUICRl15Vs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=d/+qn89LEiLOYdp4QxWteb06ev2K2ZsvK55qKu/gh0WjJx0TsEyQaj+ozRqrCe52V
	 JtiMWvhIo+O9DQIcTSHuA2163rIfHYeZlv9KvM9a8eGTbH54dti4heWWVpVGjL9CG6
	 on5cKk7qDeurbbjbPVHeErFa7C2p1z1YMk6OR8RDAcHjuvfgbfW7UQOl3dyrwe0tkd
	 zvhC5QLifKx+np52DtWqX2HFSZBGVpq8ozoQfsG5KKA6T6H8xXRkvx5o4wLMNxEt6z
	 ppQWHoaIwhikfdQ7aTHPSmYdO+2aPKOgn0k92V/4NeuKsQs+5eXp8PJyTtKuAvYPYl
	 Al7WoCqZY3z1Q==
Date: Mon, 2 Feb 2026 18:48:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI/IOV: Fix deadlock when removing PF with
 enabled SR-IOV
Message-ID: <20260203004810.GA14073@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216-revert_sriov_lock-v3-0-dac4925a7621@linux.ibm.com>

On Tue, Dec 16, 2025 at 11:14:01PM +0100, Niklas Schnelle wrote:
> Hi Bjorn,
> 
> Doing additional testing for a distribution backport of commit
> 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when
> enabling/disabling SR-IOV") Benjamin found a hang with s390's
> recover attribute. Further investigation showed this to be a deadlock by
> recursively trying to take pci_rescan_remove lock when removing a PF
> with enabled SR-IOV.
> 
> The issue can be reproduced on both s390 and x86_64 with:
> 
>     $ echo <NUM> > /sys/bus/pci/devices/<pf>/sriov_numvfs
>     $ echo 1 > /sys/bus/pci/devices/<pf>/remove
> 
> As this seems worse than the original, hard to hit, race fixed by the
> cited commit I think we first want to revert the broken fix.
> 
> Following that patch 2 attempts to fix the original issue by taking the
> PCI rescan/remove lock directly before calling into the driver's
> sriov_configure() callback enforcing the rule that this should only
> be called with the pci_rescan_remove_lock held.
> 
> Thanks,
> Niklas
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Changes in v3:
> - Rebased on v6.19-rc1, also verified issue is still there and the fix
>   still works
> - Added more of the lockdep splat for better context
> - Link to v2: https://lore.kernel.org/r/20251119-revert_sriov_lock-v2-0-ea50eb1e8f96@linux.ibm.com
> 
> Changes in v2:
> - Collected R-b from Benjamin
> - Link to v1: https://lore.kernel.org/r/20251030-revert_sriov_lock-v1-0-70f82ade426f@linux.ibm.com
> 
> ---
> Niklas Schnelle (2):
>       Revert "PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV"
>       PCI/IOV: Fix race between SR-IOV enable/disable and hotplug
> 
>  drivers/pci/iov.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251029-revert_sriov_lock-aef4557f360f

Applied to pci/iov for v6.20, thanks!
