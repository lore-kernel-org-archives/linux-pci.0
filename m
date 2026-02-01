Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE6D212554;
	Sun,  1 Feb 2026 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961374; cv=none; b=H8TnQ05Zopnsn7qz2YhLrI5E/RzGj2kWixs9ofShQPW5aXOo0x3nvTJzeW4uQ7Tf9rU7/plC7vL6U+h3eyh5/Or1RIpOY8rDKECTmyKFxlPOV6HNqgLEv+9SUB/X+cBgE5VV8wnuyWC3fm2Gk4iVc0DFrUZSabFE6fqmwKvKYtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961374; c=relaxed/simple;
	bh=KDLPfUtpR9SpdYW53Hdys5opCwN/fG589YVFIBn/KcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmPlRth8gQu2y03FFt/8Oq72VDfMjPxnMOJlZUybdFSuEM5PGplJwkjgk8UVhgpD9/wd6J34iy2bpoMin+mlJDy7MmmTDw/h33jMFgf1yN0DqF+fqHaZ8SJO9PEie0OIrZWlndnBw/6kbHJi6ZGCfwMTIpD5KOIO1eaip6G8fkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=W1zxN2y4; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="W1zxN2y4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=3ci87pZpPsfq06w4REHJfqwej9j/ji4n/RvdOruoy2A=; t=1769961373;
	x=1770393373; b=W1zxN2y4M8y1OqBDYV7nYc6MkTSOTh1YS7Aqq6g+2qSoAughmHQR/TIhcVL4N
	aNQeNfWAKMoCoo+2PzcLh/sbAsfB0jYm2sTj+Pl08GouKXKLMEdTc+ZjXU0/DuvgU3Rw4yUUQYWqe
	kD9Z1FMhaRFj1bs6eliAEB64xagsBcMGdHgRb+vpgnzmNxw1eHkMUMYMQRWVO71ZFeENlwc8OpOwl
	lFpic2327iNdMV9rMIchE1CBZuaybRa0+/DbfBQ3wtnVfYiAR/zaSHXk3qbNeylQFc6k/7W9PgbW+
	QAvEA7EiYN+X0UbmIlZY0zTLKGlhzXfs+yI8kKckvqgi000Kfg==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1vmZo3-00Eu61-0B;
	Sun, 01 Feb 2026 16:56:11 +0100
Message-ID: <efe64761-29e2-4239-8fdc-d1b54fb558b2@leemhuis.info>
Date: Sun, 1 Feb 2026 16:56:10 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] PCI/IOV: Fix deadlock when removing PF with
 enabled SR-IOV
To: Niklas Schnelle <schnelle@linux.ibm.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
 Gerd Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Benjamin Block <bblock@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251216-revert_sriov_lock-v3-0-dac4925a7621@linux.ibm.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20251216-revert_sriov_lock-v3-0-dac4925a7621@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1769961373;efdb129b;
X-HE-SMSGID: 1vmZo3-00Eu61-0B

Lo! Top-posting to facilitate processing.

The issue fixed by these patches is on my list on tracked regressions.
Makes me wonder: Did it fall through the cracks due to the festive
season, was this fixes in a different way, or is this obsolete for some
reason?

Ciao, Thorsten

On 12/16/25 23:14, Niklas Schnelle wrote:
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
> 
> Best regards,

