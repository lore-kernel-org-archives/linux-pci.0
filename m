Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BB24AA01E;
	Mon, 21 Sep 2026 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002429; cv=none; b=Z6QuOZ5al16Frk8QLsVdqHmM5hzhR92oMK8IDZdm/4glXW+f347/WuUcj6kxzQpsj1v+KZxz3PgSwEfdw2Envp8RSreAz+/VI3NSKWjL5vsFw5oERLNiN7GmEnpcRvIE2c2oTHjrsNWCQb6+vWPVGaSQINSkK4Nz8jcnCMyf/RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002429; c=relaxed/simple;
	bh=4Bpri0Hocpd0wbzg2zXh/boalmxJpON/kxjJ8Sj/g2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVPl09EYUS5SNOs7N0fSDagOAi/Rlq6IR+WxCB7K9ZUehHth3OuIqWy39Mwb4NvyVV2BoP80SVy57FHIwIMcBhKU9ZyZCsu6TxQYUHViVEIs6Xax1CsaiVj3S2f/8c7T41/xNtYqyV3cpckBhDnnvhd+cTO/fYW8o6D3cnLEP7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ugreen.com; spf=pass smtp.mailfrom=ugreen.com; dkim=pass (1024-bit key) header.d=ugreen.com header.i=@ugreen.com header.b=LtExIP4F; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ugreen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ugreen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ugreen.com header.i=@ugreen.com header.b="LtExIP4F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
	s=pkvm2402; t=1790002341;
	bh=DDAaa1F91a2uXcvELqYpoY0Uex2flJHewqG438s8Nng=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=LtExIP4F+P4zXZYWE5TxuG1kal4zya5PNys4S4wThu42SZC5yEHDGq1h12hDXEwY/
	 z59qpBImHC3YvZKPqpZ8jR57vYQJVTQK2Cwc/4DOLRD9r4xq3lSEb9xeoA2rOsXGbY
	 zP7V3q9+bqA1Itj+jhhZSqN+XicOCH0kFH1VT0WU=
X-QQ-mid: zesmtpgz4t1790002339t77d810b4
X-QQ-Originating-IP: /1zCkF4r1ByOjBgitBdFmNKv/lSkCl3l6thqO/ytb+Y=
Received: from localhost.localdomain ( [14.153.230.193])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Sep 2026 22:52:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1951430817536170771
EX-QQ-RecipientCnt: 8
From: Haowen Bai <calvin.bai@ugreen.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Haowen Bai <calvin.bai@ugreen.com>
Subject: Re: [PATCH] nvme-pci: skip FLR after a failed controller reset
Date: Mon, 21 Sep 2026 22:52:13 +0800
Message-Id: <20260921145213.3003488-1-calvin.bai@ugreen.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260921140732.2942207-1-calvin.bai@ugreen.com>
References: <20260921140732.2942207-1-calvin.bai@ugreen.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: Nv1Zs1ssfOILGrJCRGOrwrgGuBp5oJ+5Z2QXhccJ9EyqEqj7+8vsMm31
	59wwJIA9coIlFiAKUPmSKqIjMRk6dH9GdzkBb89kJmneVzqHUk/EOb6EXsb9Ul8Vv0F7lhz
	yAh2U+AdGbA3BdwqRyamFipcXfZx0gmGlSnx4vFyTQbd/FhZ43QbUdSbnUTsyFvN860jdav
	2WXWnMKY2nffrsff6o9iBjp0rQnMYbDCnznNapG+CEfM2+zjpq/PsXs8hb9hwS33urUG+QL
	HtInINYe/XFM7aPrKY3xo7f50WCGuTuQgBFgUiPYf73ImzdqboZIV3KYXAs/U1Bezj01p8N
	xmBWsc5rxFSytkxic0XfN9iabWjSSrJHBcbdXku4l/jrB3Y1W5QUKKyk8EpbBIVdXWso4/f
	8dU+E3HwbL9TrPotF9tUEC2K3+C1bI3NQjlf6rl95gOwi3gnfvTnz+bBswGEuxidD+Uqjp7
	6DcmH5kHRz6WJQ1Ue1gCPHtdyeR1fjI946IFVK30PzEaG2iJ1uw8e8KJmRimzWDM0eBKD5I
	wzmSfI0DQ0mrGX4k/NnTNhH+nrcBAIyk7hoi1iiCE3zVk6OxiNThrJMozG8WkDxrUst4FSX
	KHU/f/EWTCkjJpU3cyV5QfRVQ71sWweg6xqp5BKYIv8kj+sxitCxFUwBf5Ty9AYi6z1hXOO
	wPGKG4O/C93VkmTumqWw5iK6Wo83N3kCx09i5F2iHDTS0Mwn8FwwMkVC/En/ez3TjaZQIKH
	cau/wFJGdKQf2HNlMjV3yYfGPsoGE7eGx/hHpWKGqGgcMim9Elz3tsRMYwp0eJe+fK02QvG
	tsJAX5dIBZCGK3CA7CdtIU8hvhzcOqo1+NMZGFxPo5wI/tdkrZF7tR7xTFkTOAfDNY2MaTB
	LSBILtuF8XxhoNrLmFbdctAvxIbZSJdmbrLJuglnCGAE8Gk8/tU3tC5xio+7YKIoy0SsT4p
	IKu+2b7ZWG8/VHBpzRF5SuD/JXwX382ImWErYLusIdGA3zIyPcXWtTd3e2ej8xpUlAvt9q8
	G+TKUs1z5Xi7E9LqKXYF85bo7wG+jFy52jBmkvy08EI50qbHtKOUgm0wvKNgI=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Keith,

Thanks for the review.

The goal on our side is that a dead NVMe function must not hard-lock
the host. Losing the device (and bcache) is acceptable; an NMI
lockup of unrelated PCI users is not. I don't want to take FLR away
from a path that still recovers some devices — I want teardown not to
pin pci_config_lock across a hung config cycle.

> Shouldn't PCIe CTO have kicked in to fail the transaction? Do you
> know which transaction is failing? Is the stall specific to FLR or
> could any config access stall in your setup?

I don't know which config cycle is stuck. There is no vmcore / lock
owner. The NMI captures the waiter (an unrelated eMMC runtime-resume
spinning in pci_conf1_read -> acpi_pci_set_power_state), not the
holder.

What the pstore timestamps do show:

  [t+0]     nvme_wait_ready timeout, CSTS=0x1   (MMIO, first disable)
  [t+128s]  nvme_wait_ready timeout, CSTS=0x1   (second disable after FLR)
  [t+139s]  hard lockup on pci_config_lock

So the 128s gap is CAP.TO on the second nvme_disable_ctrl(), which is
MMIO and does not take pci_config_lock. The lockup is ~11s after that
returns, i.e. on the post-FLR teardown path (pci_free_irq_vectors /
pci_disable_device or a config access still in flight), not inside
nvme_wait_ready().

I cannot prove the stall is unique to the FLR write vs any later
config access to that function. Both events went through
disable-timeout -> FLR -> disable-timeout -> teardown. Linux 6.12 has
no FLR fallback here; the same class of NVMe drop usually only took
the cache offline. That is correlation, not a single-cycle trace.

There is no AER / UR / completion-timeout message in the log. I do
not know whether CTO was disabled, longer than the NMI watchdog
(~10s), or not applicable because the root port never completed. I
won't claim CTO is broken. Even if CTO should have aborted the
cycle, it did not save the machine here.

> Are you able to fix the device instead? Maybe add your device to the
> "quirk_no_flr" list if you can't fix it.

The two ZHITAI Ti600 functions (1e49:0081) each reproduced the same
sequence independently, so I agree this is a nasty device bug. We
are taking them out of the bcache path on the affected machines.

quirk_no_flr would stop nvme from requesting FLR, but it would not
stop pci_disable_device() from touching config on the way out, which
is where the lockup lines up. Pinning host protection to one VID:DID
also misses the next broken device. A bad endpoint should be allowed
to die; it should not be able to stall pci_config_lock and take the
rest of the platform with it. I can add a quirk as a device note if
you want it on record; I don't think it is the host fix.

> I've seen FLR recover devices both on first probe and IO timeout, so
> skipping for RESETTING will miss recovering when it was possible

Agreed — that makes v1 too broad. I'll drop the RESETTING special
case rather than take FLR away from a path that still recovers some
devices.

If a v2 is useful, I think it needs to stop issuing config cycles to
a function that already failed CC.EN and FLR (so teardown cannot
hold pci_config_lock across a hung inl), without skipping FLR on the
reset path. I have not written that patch yet.

Thanks,
Haowen
