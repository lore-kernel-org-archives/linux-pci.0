Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1713F8251;
	Tue, 29 Sep 2026 05:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790661336; cv=none; b=VjGMrZdkvJfIJMSATgo1rwVCakNlxgBcj6tA6qUUOOIXovOkNBZ3imrLY4ZCGab8bSA4qxD1BGcDqMkaBZYQ8m+PQO4x9wAJh2efWJL61VbujFsn87DlawyTQJPeg1QFy9NPUeyEd47TdLOXHuz1ConnQ9PMSQEcULj3F/PoxqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790661336; c=relaxed/simple;
	bh=CKxekNszWfSdwNcJCaViVu6IwzP+H2JAddE6YL8/04U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Dof8/pLyy3yQgXySkljpH4VKqBZhkERsdClKNFea3SDATnrnC/MnuA/tnjG0MGSI/wYIm1vQu76ap/YCEuUVydaxzpKyHvma5RzlV1o7ZXmdx4iKuBewDsuEFpM1DMsCUzCkSkrpsrHd1fwpdc2rBTTIOKx1ma/kWNiRMHCi2ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=X7nnMXwW; arc=none smtp.client-ip=188.68.61.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="X7nnMXwW"
Received: from mors-relay-8405.netcup.net (localhost [127.0.0.1])
	by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4hv6bs2vFRz74pR;
	Tue, 29 Sep 2026 07:46:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1790660761;
	bh=CKxekNszWfSdwNcJCaViVu6IwzP+H2JAddE6YL8/04U=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=X7nnMXwWuk8iotlPrRQUYMi12/+BdRJWLrSvFwou4IA9jl3ks1Vud12chW/hPkgSE
	 oKT5WFtxqt/HeCsC7PjpyRGLX7JcoHCsHdC6z3oe349NfaqqLVkENG3x38ycuOlRKS
	 w0N3D9TPDLlFvSovWqT/C6JrCSiIGk+CwcwPjzO/UE01+hq1l+dfhGf/lovuE7wasz
	 tpxhlbAMbx5JiN2Y5AzL3PQ5YTViSN7caT3Ze3wM7zwQI1VZKCfSkDbnT+lN+AjC/d
	 MKpSvU9FOfO97qYDc/ucXqeWOfzr8Ta5FBhHA89SuMSuncst+Ao2j6tdS5af/HD1+s
	 +NI2uLxGg/d7w==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4hv6bs29VHz74p0;
	Tue, 29 Sep 2026 07:46:01 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hv6br2lBwz8sbF;
	Tue, 29 Sep 2026 07:46:00 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 516BD5FADA;
	Tue, 29 Sep 2026 07:45:51 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <87c93553-d74d-4588-bd54-0ccb2728f327@leemhuis.info>
Date: Tue, 29 Sep 2026 07:45:50 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no
 link
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Andreas Wild <andiwild@gmail.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org, M M <restafvalendergelijke@outlook.com>,
 regressions@lists.linux.dev, blaat windows <blaaaat@hotmail.com>,
 edwardmalik95@icloud.com
References: <20260917233355.GA1115024@bhelgaas>
 <b4ed1637-ac6a-4af5-ab47-e07309af200b@leemhuis.info>
 <alpine.DEB.2.21.2609181131520.57799@angie.orcam.me.uk>
 <1b2cceea-8da4-4239-a955-e0c6b475a227@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <1b2cceea-8da4-4239-a955-e0c6b475a227@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179066075179.2935103.4041930143182765755@mxe9fb.netcup.net>
X-NC-CID: cVLYoJvbPniRBetUZOUHjc7CUf64eyIAZBcHv+euESFtTCoysO8=

On 9/21/26 12:33, Thorsten Leemhuis wrote:
> On 9/18/26 12:39, Maciej W. Rozycki wrote:
>> On Fri, 18 Sep 2026, Thorsten Leemhuis wrote:
>>>> But IIUC Aoxtj still sees issues with 72780f796468 ("PCI: Always lift
>>>> 2.5GT/s restriction in PCIe failed link retraining") even with this
>>>> patch
>>>> (https://lore.kernel.org/all/331e97c7-e422-420d-9f3e-5d9f734464b3@axtjblog.cc)

@Andreas, @Bjorn: JFYI, Edward (now CCed) in the bugzilla thread and in
private pointed out that the partial fix this thread is about ("PCI:
Skip Target Speed quirk on clamped ports with no link") was applied by
CachyOS, but then reverted due to problems:
https://github.com/CachyOS/linux/commit/5c1239de195c6f4d26c3e4fc292eadab6feb41a0

No reason given, just a link to a diagnostic file that from a very quick
look showed an Oops from the Nvidia driver:
https://paste.cachyos.org/p/49a2487.log

So maybe it's a problem in that OOT driver, maybe not. Just wanted to
let you know about this. To quote:

"""
> Aug 30 21:56:16 cachyos kernel: [drm:nv_drm_dev_load [nvidia_drm]] *ERROR* [nvidia-drm] [GPU ID 0x00000100] Failed to allocate NvKmsKapiDevice
> Aug 30 21:56:17 <hostname-redacted> kernel: Oops: general protection fault, probably for non-canonical address 0xe95cb1b08fafee9c: 0000 [#1] SMP NOPTI
> Aug 30 21:56:17 <hostname-redacted> kernel: CPU: 0 UID: 0 PID: 503 Comm: modprobe Tainted: G           O        7.2.2-1-cachyos #1 PREEMPT(full)  e429b9d2132c094dcc3a5be7de95f46bd03f9bdb
> Aug 30 21:56:17 <hostname-redacted> kernel: Tainted: [O]=OOT_MODULE
> Aug 30 21:56:17 <hostname-redacted> kernel: Hardware name: LENOVO 82RF/LNVNB161216, BIOS J2CN40WW 04/15/2022
> Aug 30 21:56:17 <hostname-redacted> kernel: RIP: 0010:__refill_objects_node+0x283/0x390
> Aug 30 21:56:17 <hostname-redacted> kernel: Code: 48 ff c0 48 8b 5c 24 20 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 44 89 c1 4d 89 5c c2 f8 44 8b 43 28 48 8b 93 b0 00 00 00 <4b> 33 14 18 0f 1f 44 00 00 4d 01 d8 49 0f c8 4c 31 c2 48 39 e8 41
> Aug 30 21:56:17 <hostname-redacted> kernel: RSP: 0018:ffffccf440bef700 EFLAGS: 00010287
> Aug 30 21:56:17 <hostname-redacted> kernel: RAX: 0000000000000008 RBX: ffff8a2380045900 RCX: 0000000000000018
> Aug 30 21:56:17 <hostname-redacted> kernel: RDX: 690fa410ac2511e3 RSI: fffff1bb44805500 RDI: fffff1bb44805510
> Aug 30 21:56:17 <hostname-redacted> kernel: RBP: 0000000000000020 R08: 0000000000000080 R09: 0000000000200020
> Aug 30 21:56:17 <hostname-redacted> kernel: R10: ffff8a23819df220 R11: e95cb1b08fafee1c R12: ffff8a2380041e01
> Aug 30 21:56:17 <hostname-redacted> kernel: R13: ffffccf440bef748 R14: 0000000000000020 R15: 0000000000000007
> Aug 30 21:56:17 <hostname-redacted> kernel: FS:  0000000000000000(0000) GS:ffff8a276e465000(0000) knlGS:0000000000000000
> Aug 30 21:56:17 <hostname-redacted> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Aug 30 21:56:17 <hostname-redacted> kernel: CR2: 00007fbf1ad14270 CR3: 000000011ffe4002 CR4: 0000000000f70ef0
> Aug 30 21:56:17 <hostname-redacted> kernel: PKRU: 55555554
> Aug 30 21:56:17 <hostname-redacted> kernel: Call Trace:
> Aug 30 21:56:17 <hostname-redacted> kernel:  <TASK>
> Aug 30 21:56:17 <hostname-redacted> kernel:  refill_objects+0x3f/0x3c0
> Aug 30 21:56:17 <hostname-redacted> kernel:  kmem_cache_prefill_sheaf+0xe3/0x210
> Aug 30 21:56:17 <hostname-redacted> kernel:  mas_preallocate+0x4e7/0x730
> Aug 30 21:56:17 <hostname-redacted> kernel:  __split_vma+0xc5/0x550
> Aug 30 21:56:17 <hostname-redacted> kernel:  vms_gather_munmap_vmas+0x119/0x350
> Aug 30 21:56:17 <hostname-redacted> kernel:  mmap_region+0x10b8/0x1890
> Aug 30 21:56:17 <hostname-redacted> kernel:  do_mmap+0x2b0/0x580
> Aug 30 21:56:17 <hostname-redacted> kernel:  vm_mmap_pgoff+0xf7/0x190
> Aug 30 21:56:17 <hostname-redacted> kernel:  ? ksys_mmap_pgoff+0xbb/0x110
> Aug 30 21:56:17 <hostname-redacted> kernel:  ksys_mmap_pgoff+0xb0/0x110
> Aug 30 21:56:17 <hostname-redacted> kernel:  do_syscall_64+0xa6/0x3e0
> Aug 30 21:56:17 <hostname-redacted> kernel:  ? do_syscall_64+0x65/0x3e0
> Aug 30 21:56:17 <hostname-redacted> kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Aug 30 21:56:17 <hostname-redacted> kernel: RIP: 0033:0x7fbf1b7241f6
> Aug 30 21:56:17 <hostname-redacted> kernel: Code: 00 00 00 00 f3 0f 1e fa 41 f7 c1 ff 0f 00 00 75 2b 55 89 cd 53 48 89 fb 48 85 ff 74 4f 41 89 ea 48 89 df b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 22 5b 5d c3 0f 1f 80 00 00 00 00 c7 05 6e 71
> Aug 30 21:56:17 <hostname-redacted> kernel: RSP: 002b:00007ffcb1466808 EFLAGS: 00000206 ORIG_RAX: 0000000000000009
> Aug 30 21:56:17 <hostname-redacted> kernel: RAX: ffffffffffffffda RBX: 00007fbf1b4f5000 RCX: 00007fbf1b7241f6
> Aug 30 21:56:17 <hostname-redacted> kernel: RDX: 0000000000000005 RSI: 000000000000a000 RDI: 00007fbf1b4f5000
> Aug 30 21:56:17 <hostname-redacted> kernel: RBP: 0000000000000812 R08: 0000000000000000 R09: 0000000000001000
> Aug 30 21:56:17 <hostname-redacted> kernel: R10: 0000000000000812 R11: 0000000000000206 R12: 00007fbf1b504580
> Aug 30 21:56:17 <hostname-redacted> kernel: R13: 0000000000001000 R14: 000000000000b000 R15: 00007fbf1b4f4000
> Aug 30 21:56:17 <hostname-redacted> kernel:  </TASK>
> Aug 30 21:56:17 <hostname-redacted> kernel: Modules linked in: xt_LOG nf_log_syslog nft_limit xt_limit xt_addrtype xt_tcpudp xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat x_tables nf_tables dm_mod pkcs8_key_parser i2c_dev crypto_user ntsync zram 842_decompress 842_compress lz4hc_compress xe gpu_sched drm_gpuvm drm_exec drm_gpusvm_helper drm_suballoc_helper nvme nvme_core nvidia_drm(O) nvme_keyring nvidia_uvm(O) nvidia_modeset(O) nvme_auth i915 drm_buddy intel_gtt i2c_algo_bit intel_lpss_pci drm_display_helper spi_intel_pci intel_lpss spi_intel idma64 intel_vsec cec vmd serio_raw nvidia(O) drm_ttm_helper ttm video wmi aead
> Aug 30 21:56:17 <hostname-redacted> kernel: ---[ end trace 0000000000000000 ]---
> Aug 30 21:56:17 <hostname-redacted> kernel: RIP: 0010:__refill_objects_node+0x283/0x390
> Aug 30 21:56:17 <hostname-redacted> kernel: Code: 48 ff c0 48 8b 5c 24 20 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 44 89 c1 4d 89 5c c2 f8 44 8b 43 28 48 8b 93 b0 00 00 00 <4b> 33 14 18 0f 1f 44 00 00 4d 01 d8 49 0f c8 4c 31 c2 48 39 e8 41
> Aug 30 21:56:17 <hostname-redacted> kernel: RSP: 0018:ffffccf440bef700 EFLAGS: 00010287
> Aug 30 21:56:17 <hostname-redacted> kernel: RAX: 0000000000000008 RBX: ffff8a2380045900 RCX: 0000000000000018
> Aug 30 21:56:17 <hostname-redacted> kernel: RDX: 690fa410ac2511e3 RSI: fffff1bb44805500 RDI: fffff1bb44805510
> Aug 30 21:56:17 <hostname-redacted> kernel: RBP: 0000000000000020 R08: 0000000000000080 R09: 0000000000200020
> Aug 30 21:56:17 <hostname-redacted> kernel: R10: ffff8a23819df220 R11: e95cb1b08fafee1c R12: ffff8a2380041e01
> Aug 30 21:56:17 <hostname-redacted> kernel: R13: ffffccf440bef748 R14: 0000000000000020 R15: 0000000000000007
> Aug 30 21:56:17 <hostname-redacted> kernel: FS:  0000000000000000(0000) GS:ffff8a276e465000(0000) knlGS:0000000000000000
> Aug 30 21:56:17 <hostname-redacted> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Aug 30 21:56:17 <hostname-redacted> kernel: CR2: 00007fbf1ad14270 CR3: 000000011ffe4002 CR4: 0000000000f70ef0
> Aug 30 21:56:17 <hostname-redacted> kernel: PKRU: 55555554

"""

Ciao, Thorsten

>>>> And M M / Mich (BCC'd) also reports an issue that (IIUC) is not fixed by
>>>> this patch (https://bugzilla.kernel.org/show_bug.cgi?id=221919#c3)
>>>>
>>>> So evidently there are still issues but maybe this patch fixes part of
>>>> them?
>>>>> Yeah, Maciej ten days expressed that we to look into this. Anyway, I
>>> suggest someone that is affected by that problem starts a new thread
>>> (please CC all those that are affected by it and the regression list)
>>> with summarizing the current state + this patch, as this thread got a
>>> bit confusing... (please drop a link to that thread here afterwards)
>>
>>  It remains on my radar, no worries.  [...]
> 
> FWIW, another report from "blaat windows" (now CCed) can be found
> out-of-thread here:
> 
> https://lore.kernel.org/all/AS2PR10MB7429335B6C8F4C7FA3F88638B5852@AS2PR10MB7429.EURPRD10.PROD.OUTLOOK.COM/
> 
> Quoting that below.
> """
>>>>> Another reproducible case of the active-link failure described in this thread.
>>>>>
>>>>> Hardware:
>>>>> Intel 4th-gen/9-series platform
>>>>> Intel 82571EB quad-port NIC
>>>>> Microsemi/PMC/IDT PES12N3A PCIe switch
>>>>> Root port 00:1c.4, LnkCap 5GT/s x4
>>>>> Working negotiated link: 2.5GT/s x4
>>>>>
>>>>> Kernel results:
>>>>> 7.2-rc1 fail
>>>>> 7.1-rc7 succes
>>>>>
>>>>> On failing kernels, the PES12N3A hierarchy does not enumerate and all four downstream 82571EB ports disappear.
>>>>>
>>>>> I traced this to pcie_failed_link_retrain() and specifically the new generic clamp-removal code introduced by 72780f7964684939d7d2f69c348876213b184484 ("PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining").
>>>>>
>>>>> I tested 7.3.0-rc3+ with only this block commented out:
>>>>>
>>>>>     pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
>>>>>     if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT) {
>>>>>             pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
>>>>>             ret = pcie_set_target_speed(dev, speed_cap, false);
>>>>>             if (ret)
>>>>>                     goto err;
>>>>>     }
>>>>>
>>>>> With that block disabled, 7.3.0-rc3+ boots normally, having all four NIC ports enumerate:
>>>>>
>>>>> 07:00.0 82571EB
>>>>> 07:00.1 82571EB
>>>>> 08:00.0 82571EB
>>>>> 08:00.1 82571EB
>>>>>
>>>>> The important result is that the initial 2.5GT/s recovery is fine. Leaving the link at 2.5GT/s works. It is the subsequent:
>>>>>
>>>>>     pcie_set_target_speed(dev, speed_cap, false);
>>>>>
>>>>> which breaks this PES12N3A/82571EB link.
>>>>>
>>>>> So this appears to be the same active-link failure mode, but with a PES12N3A switch rather than a direct 82571EB connection.
>>>>>
>>>>> This was tested against vanilla 7.3.0-rc3+ with only the above local change.
>>>>>
>>>>> I can provide full dmesg/lspci output and test a proposed fix if useful.
> """
> 
> Ciao, Thorsten
> 

