Received: from outbound.mr.icloud.com (mr-2006l-snip4-5.eps.apple.com [57.103.70.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226A134CFDE
	for <linux-pci@vger.kernel.org>; Thu,  1 Oct 2026 07:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.70.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790839575; cv=none; b=LxbsXkbymhu//PqwyU+02h1GSHwzITyZnMYhkOrgpwOKjOFUdGS55upn3xDzogu3aMHqu2DzjsPjGyUp7ZQCrh0zyQMjYn0tftRA0sjc2x0kp46DCC9dfiv8qEn1QPYJQPov/CYtG7uunovnhQs6mTTzDM85FkxUOIzs+I7GkPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790839575; c=relaxed/simple;
	bh=EiSC9xCqKnvIAKuOiBjEh0p6NdZjrdQ2HK8256nJ+EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXezmbqnmCwouo1/aUuZAGl1ZMNrEnAd4aioQOPbYwQIjb40s2LIH25gi3hd/9QT7bUvPEVooaQLwSN/YNYqij1UrI0KJJvioUvjP3xDD3T/3YSDHEmGjFHBSu56hRQx0lN1hbIvztHYYwioQ+EINqAF18rcjBfSDmUktNtddq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com; spf=pass smtp.mailfrom=mac.com; dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b=WpOSdqKE; arc=none smtp.client-ip=57.103.70.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mac.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mac.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="WpOSdqKE"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id 7C3B618000BB;
	Thu, 01 Oct 2026 07:26:02 +0000 (UTC)
X-ICL-RepId: 01a0f65b-20c5-720c-9417-a0d824ca1830
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQhPC0MGXAZeCEwFQwVfEhVdRVAERRJdHnkVUg4ZCF0dGR5XUFoKUV5aF15NRQgPRRkQVgFYVl0FTRpcGFkPHB1LVloOWwRHFBcbXAAXG0YCBCMCXwBFAl4JVgEwFw9WTVQZUENUBF9QVBFXUAtZAkIPSQNdBlsFQgxNBkMFUwtCD00eXBoIWwJAF10tWgpRXloXXlMXH0sAXEVaDlsERxQ=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai; t=1790839563; x=1793431563; bh=6G4eOMZqZQmDkWR3Ncw9dFDoql/yjkD69ChFvHs0U5Y=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=WpOSdqKEN+ofS2qQAyi/cs0U2ZFwRulbqlStX4AYzMvsbJFDukvwUAsCHQY9p2URqz8HamdHtgXcFiCxvLl7c6JNfieevWQDur0/3JtrJhHJKC91O7fkMTh055f6R5O25x6AC2WJtgQyzcF2XubUKhvtJG+b/MjtNNcCbDykh3e/ARlH6+EkVhdA2iG0FNZ3CYT+ghffhGoSv5i+4fAStHZMEaDXKRlh/+s0wv7XgiTZ06rP/BqH7ovI2qbXNs2Cs5P+lN26j+RlQ1IlBuf1T2zZOokf1eYzcQahdZiUdAyKezgNwlxTAyJMmWzz9R82IENKMgGQ8aquLi45UXgTGg==
Received: from telchar.scorpion-armadillo.ts.net (unknown [17.156.200.36])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id CF1F0180013E;
	Thu, 01 Oct 2026 07:26:00 +0000 (UTC)
From: Christian Hedin <ciryon@mac.com>
To: torsten.hilbrich@secunet.com
Cc: bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: fix use-after-free in pci_pme_list_scan()
Date: Thu,  1 Oct 2026 09:25:55 +0200
Message-ID: <20261001072555.289265-1-ciryon@mac.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <f2e43015-19ca-4e58-9b86-bdd855ff6496@secunet.com>
References: <f2e43015-19ca-4e58-9b86-bdd855ff6496@secunet.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAyOSBTYWx0ZWRfX1pfEAn503xyK
 E4CS9VwOm/lGToVcn5NNQWXyDTFzCwyLoLywjO39EIRaeapQlq6T+ibv/ExKOuTt4sqUCjOKcpn
 B5H9kyN/4VAykTF9xX6APbDqQKHJWgfIG7HgKenMbyz8sdzkylk0SkzFrlGxcJBbXew/OpyndCc
 3gGSCV/xlwg/lVPZbr5cUPes4Rgvb4mwkUjynlhqd+UBNl3Voe5OI5dfIzPeOFDK/KlxSpIY1dR
 Dmk4ybr12qFZbuQ4khPfw1rOXTveR6bRtYiLNd32a/6wzD3+0uVT0LORZNFly0bJxtHU81aGmVq
 tfooHTO44KNB5Ovc97oI9Pb+ZlATyAkRpvz87NVQdx0GdCecaWSBeIO1tqniCY=
X-Authority-Info-Out: v=2.4 cv=YZ2wJgRf c=1 sm=1 tr=0 ts=6abe0b0b
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10
 a=cHkArRZ9ErEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=-ixN8YLanZpH-QonBzoA:9
X-Proofpoint-GUID: 1QY4AokTlTkxvDoUSy4siSwFmtnewRwA
X-Proofpoint-ORIG-GUID: 1QY4AokTlTkxvDoUSy4siSwFmtnewRwA
X-JNJ: AAAAAAAByausczEoitCB9zUDL4asBDMnKqX6Ujq2cn0gNU+2rYr8jBBVIant12jiIxJmwxlw3cEtS3TZjgbOPi3KxdjpbrOVCOiMi9K9F+TH70pTY7MQgfY/w0s1ZtP+NrKIJst4eA4Il8huTlIA9p2H0RQ7SkGjzB4Kr7NcdfNahdLlABURzJmKv1+qCa9NtGgJ+21rmebImoSYDhKlVtT+hLBtfu9yhhpyn5Q3AN+KhvNsSU2Ts+Glxoi8pxLmMpiWc2qhpYBfgWGNiaS/BdXoewIX32bW+u7YzPiGCTLLXsMJ35CTE00kN8Th6MOSdrFTi3nbwRg44kLPgDbjRB56t5L0Lk9Uc1Uvj3TcVGpBu3hUpGN28dFCMsejAtLR2FBiDIvsj8JkeyDvQKV/eQfOItKt9+DlZcR3oBun+8ll6MbLbvu1csju4xVrbKJ9CvjIN8Sw4ShHb1U54ekdG64JMdpuIbPzBTaihEPP0IontJdhYKtZS9xaMWOakaxGFGhOlQJ3QapFXKtKqDHldz/BWiepMY1zSuWJuHN5db2mG/H+CGufj7fK8pHTeYt9LaPkYant3DGefPY7A9AxEexnKUx3XtyKTWfdJ+m+cMhCohZmIbDM4+VupKFk2hnGAxkQfkHiVgvgBIFMr6BBvDMpsgsxt7uv43uaLqxr4mvGDA76D/m7MdwKUe6TJBXKQrDP3CEP/TRcW2p4DLwbz4WE2iNgIHLRWXNwYJixV2S1VRgeCcZ3x9RHxFAfmIo6C+kXF2Z9uAK/1AGzP7Sxm1IBSJWh9sU7rg/ylsGNHdcvYp+wJCA+xus8s2gRIgjs2g6qvzoHxFN1bB4YCRyhFT2ds0q9syNvDoz32WXCGjgDtDbEVy2HtWiBvaIq26vz2EtaWhEjiISklIfQ+t3EMl24zFHtV5ZsfnfupNrM7sr4HyKHqyUJUh7COT6LuJhj/2xxAuxn9ikhw1VGH8LyQEDKQ60QLat
 +b9/dn4DZXsR+TGRQPY/vO7YWAsaLQVdG4hvH/fKBPeIdWoe6C2B+oT/J5ksFuWnWIWrYDSdjsyU4rlSRsNBh4JTYUs8JvFeVwHWhzfOwcNJqKe4yk4x9+Uh9wJKW0Z6wmNrZVZNKiKPLwcYEXQ5ws5Sze/JyZxyapxWryRmvgiPUeKzRIGAi6TWRb2cdDnBbMDcmWYbsnG3nI2vDd63UEkjSq0RFmFu18XEgio8Xmhz3ZIA0eUhNhf52GsztIojksGz9DvmCW1krdL6AEofSbnw8gwbicVOubw==
X-Apple-Category-Label: Mjg2NTg2Nzg6JGNhdGVnb3J5JF9QZXJzb25hbCw=

Hi Torsten,

I hit what looks like the same use-after-free on an unpatched, non-PaX
kernel, so here is a second data point in case it helps the patch along.

Hardware: Framework Laptop 13 (AMD Ryzen AI 300 Series), BIOS 03.05
Kernel:   7.2.5 (distro build, 7.2.5-3-omarchy), not tainted
Device:   LG 40WT95UF monitor on USB4, with PCIe and USB tunneled

The monitor went into its automatic standby overnight (laptop awake, lid
closed), which drops the USB4 link and hot-removes the tunneled PCIe
bridges. In the same second as the removal:

  thunderbolt 0-2: device disconnected
  pcieport 0000:00:01.1: pciehp: Slot(0): Card not present
  pci_bus 0000:03: busn_res: [bus 03-21] is released
  pci_bus 0000:22: busn_res: [bus 22-40] is released
  pci_bus 0000:41: busn_res: [bus 41-5f] is released
  pci_bus 0000:02: busn_res: [bus 02-5f] is released
  BUG: unable to handle page fault for address: 0000075700000060
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  Oops: Oops: 0000 [#1] SMP NOPTI
  CPU: 10 UID: 0 PID: 4136500 Comm: kworker/10:1 Not tainted 7.2.5-3-omarchy #1 PREEMPT(full)
  Workqueue: events_freezable pci_pme_list_scan
  RIP: 0010:pci_pme_list_scan+0x4e/0x220
  Code: ... 48 8b 43 10 <4c> 8b 60 38 4d 85 e4 0f 84 b8 00 00 00 ...
  RAX: 0000075700000028 RBX: ffff8b26f0cca000
  Call Trace:
   process_one_work+0x19f/0x370
   worker_thread+0x1b1/0x330
   kthread+0xe4/0x120
   ret_from_fork+0x2bd/0x350
   ret_from_fork_asm+0x1a/0x30
  note: kworker/10:1[4136500] exited with irqs disabled

It faults on the same load as your trace (bus->self, 0x38 off RAX), with a
garbage pdev->bus in RAX instead of the 0xfe poison, i.e. the pci_dev at RBX had already been freed and reused.
Without free poisoning the stale pointer is just whatever landed there,
which is probably why this is rarely seen.

One thing worth adding to the commit message: without panic_on_oops the
damage is not limited to the one worker. It dies while holding
pci_pme_list_mutex, so every later pci_pme_active() blocks forever. Here
that meant:

- irq/34-pciehp and several pm workqueue workers stuck in D state, so
  the monitor's USB and PCIe functions never came back on replug (DP
  tunnelling still worked).
- Any config space read that needs a runtime resume hangs unkillably:

    task:lspci  state:D
     __mutex_lock.constprop.0+0x3e6/0x930
     pci_pme_active+0x158/0x1f0
     __pci_enable_wake+0x90/0xc0
     pci_pm_runtime_resume+0x9a/0x130
     ...
     pci_read_config+0x98/0x310

- System suspend failed in a loop for four hours ("Freezing user space
  processes failed ... 3 tasks refusing to freeze"), and a clean reboot
  hung as well.

So on a stock kernel a single hot-unplug can leave the machine needing a
hard power-off, which may be an argument for Cc: stable.

It is a race here: the same boot had two earlier disconnects of the same
device without an oops.

I can test a v2 on this machine if that is useful, though reproducing may
take a while given how rarely it fires. Full kernel log available on
request.

Thanks,
Christian
