Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0064A485F;
	Mon, 21 Sep 2026 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000943; cv=none; b=ljDXdzBMlwryRn95cAULfH+cIk5f8XpMH28qSPgJHF4FTWzGLyZXwphRN8P1LXQT+lCMeNGbc1SCL0AHV7fmT87a0lhG3FOmPpjSWbHD6QAMXq+STx4EqwFZL00dVmmvixjmwaxOAGgTbupe9zGYf+eej7u4/+ltqaYq19KP5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000943; c=relaxed/simple;
	bh=AUQdMZZFEmXWmUdz7tPM8/DfNRsJrPnjjCG+jsY94d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pY7dY9bas+WYLjFU5YELt58jmTC04iNsuCwFH7NZGrFErjfWItiuwJI5G6fT7R4c0yS3urT9/toGwF8oA+lFNBf3oeAdY52K4Tr+GmwWwQRAW87bs3hiGW8XvKuaniEnh8Z/0G5AR939ysAfrpg4Vj/5atbrrsOUl7LNq4FaWt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9iRD0Iz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9iRD0Iz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28CC1F00893;
	Mon, 21 Sep 2026 14:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000942;
	bh=8yzJ/PKyn3nO+ZYEl64j2VwgYC+Vk7U0Xda7c30jz40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L9iRD0Iz3HLe3yjrwXJRPXJc4xv04URetHGoEL6DIWUX2sUchjRRvt3KEuXkm9Kl+
	 P9HnR+H1tRkNj6KdG3Qs87mWH9zZwlCOXHVO17A1ekMnaY/3m1u4zgJB5wRvpte4V0
	 Fw0gIkDFrmfL7BArVkVHqvAx0ULU4f7F88pDabvGbn++1LbgowExeqfhNs8AXVZ0i/
	 2PD9HXD1iE/1Ii8qBT8Slg+RabTKhfnQHiwGpLhL+0xRun1O7yZYcopA6EqYTZoV9R
	 PgutdDNA+Uo5nqe8+xzW6Utsnt6BiguXpvkQD6JKzShBT4GDXopqIPYezPOJbC9YYj
	 Vo+1XhcJn6oiA==
Date: Mon, 21 Sep 2026 08:29:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Haowen Bai <calvin.bai@ugreen.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: skip FLR after a failed controller reset
Message-ID: <arE_LD-uSB49gU0j@kbusch-mbp>
References: <20260921140732.2942207-1-calvin.bai@ugreen.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921140732.2942207-1-calvin.bai@ugreen.com>

On Mon, Sep 21, 2026 at 10:07:32PM +0800, Haowen Bai wrote:
> nvme_disable_ctrl() already waits up to CAP.TO for CSTS.RDY to clear.
> If that times out, nvme_pci_configure_admin_queue() currently issues a
> PCIe Function Level Reset and retries.
> 
> FLR is performed with PCI config cycles. Those cycles take
> pci_config_lock, a raw spinlock, and wait for the endpoint to complete
> the transaction. A wedged NVMe function can stall that completion.

Shouldn't PCIe CTO have kicked in to fail the transaction? Do you know
which transaction is failing? Is the stall specific to FLR or could any
config access stall in your setup?

> Other CPUs then spin in pci_conf1_read() -- including ACPI PCI config
> from an unrelated device -- and the NMI watchdog reports a hard lockup.
> 
> This was observed on an x86_64 UGREEN DXP4800 (kernel 6.18.15) with two
> ZHITAI Ti600 NVMe devices used as bcache. Each disk independently:

Are you able to fix the device instead? Maybe add your device to the
"quirk_no_flr" list if you can't fix it. This sounds like a pretty nasty
bug on that side that forces driver to remove one of its recovery
options.
 
>   nvme: I/O timeout, reset controller
>   nvme: Device not ready; aborting reset, CSTS=0x1
>   nvme: Device not ready; aborting reset, CSTS=0x1
>   watchdog: Watchdog detected hard LOCKUP
>   RIP: native_queued_spin_lock_slowpath
>   pci_conf1_read -> acpi_pci_set_power_state -> mmc runtime resume
> 
> The two "aborting reset" messages are nvme_wait_ready() timeouts, 128s
> apart, matching (CAP.TO+1)/2. The lockup is ~11s after the second
> timeout, i.e. on the post-FLR cleanup path, not in the wait loop.
> Linux 6.12 has no FLR fallback here; 6.18 and 7.3 still do.
> 
> Skip FLR when the controller is already in NVME_CTRL_RESETTING (I/O
> timeout recovery). Keep the FLR hammer for initial probe, where the
> device may simply have been left enabled by firmware. Reset work then
> marks namespaces dead instead of hard-locking the host.

While I don't see this happen very often, I've seen FLR recover devices
both on first probe and IO timeout, so skipping for RESETTING will miss
recovering when it was possible for some conditions.
