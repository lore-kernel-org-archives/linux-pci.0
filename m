Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFE01A23B1;
	Wed,  6 May 2026 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778025665; cv=none; b=kNcfEMAwrTmWpsOQTJ5Q56zgVTTXU7DVHfK9LEoo7kpYKL3AhQBASpleDOze7EqopdUBl4ldGt2eOoNrBaWo72hf+MuLfo2z3xjARIsU3csBBUqTXR0trGyLFb6vPFhLzU42k7oD/cTnf6LsamqicqQPcpb2qXAu3W5kbeu8CoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778025665; c=relaxed/simple;
	bh=sr/Qb7QrZmwUG6tPlnwW4oPDv404K8bOpWYBhxjQ2lo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=hecAK2yB2NACXYi0HcQJ4MRM6PzrA/Yvnhi1tIkEwHVgwQPkbK6K5lxQk89kp05T+VMwONNsAgGgBua0eOl4KwivljIQRdmvta/R7/Mm7VhRdbBbQu28oIP8X0qLlzLMHDKIUcOt3nSCTQqoAZKvu6h2Y4R67ScvpS1/Ut0+0ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWWAAuAI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWWAAuAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509E5C2BCB4;
	Wed,  6 May 2026 00:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778025664;
	bh=sr/Qb7QrZmwUG6tPlnwW4oPDv404K8bOpWYBhxjQ2lo=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=kWWAAuAI7VjNjbnjpgESBmy/z/5qXP+d9kiCCx4jImU+nGPgN1dL+f9oUYXDBCCfZ
	 3Dh4QHhrlFexBDuS4lffD+RxfKnV4SWIAtwHch8GL6qKdA/imESQ9NBou2ckr+K5wa
	 IsRomE9yH7pE8ev0EKVZQDAnlzLPOeCYYqDzKYti48+RIpsJD4pA6cYzUlxPo1hkFq
	 X4qR6mZ/TVYx4o3UieGV+EcS00iDOn8nF3/4Tb8QakXkEE5t82TG3IRBrafTJlEkuI
	 +YbC/2KRbsV0PdwTnhXS+ptyffyLFMhFK8+tgMN19IE+vUm4uOKXA+POGN0IrkQFC8
	 C4HzK6W4sX07A==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 May 2026 02:01:01 +0200
Message-Id: <DIB5HSQV09B8.3KK82M5HN2NZY@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2] PCI: Init temporary pci device in new_id_store()
Cc: "Bjorn Helgaas" <bhelgaas@google.com>, "Bandan Das" <bsd@redhat.com>,
 "Gui-Dong Han" <hanguidong02@gmail.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Alex Williamson" <alex@shazbot.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Samiullah Khawaja" <skhawaja@google.com>
References: <20260505234327.716630-1-skhawaja@google.com>
In-Reply-To: <20260505234327.716630-1-skhawaja@google.com>

On Wed May 6, 2026 at 1:43 AM CEST, Samiullah Khawaja wrote:
> When setting new_id of a PCI device driver using sysfs a lockdep splat
> occurs. This is because the new_id function new_id_store() checks for
> driver_override by creating temporary pci_dev structs.
>
> Since the newly added driver_override spinlock is not init for temporary
> pci_dev structs, the lockdep splat complains about it.
>
> Initialize the temporary pci device to fix this.
>
> [    4.464296] INFO: trying to register non-static key.
> [    4.466207] The code is fine but needs lockdep annotation, or maybe
> [    4.468487] you didn't initialize this object before use?
> [    4.470486] turning off the locking correctness validator.
> [    4.472494] CPU: 2 UID: 0 PID: 177 Comm: liveupdate-iomm Not tainted 7=
.0.0+ #9 PREEMPT(full)
> [    4.472497] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [    4.472498] Call Trace:
> [    4.472501]  <TASK>
> [    4.472503]  dump_stack_lvl+0x5d/0x80
> [    4.472508]  register_lock_class+0x77e/0x790
> [    4.472512]  ? check_prev_add+0xf4/0xd30
> [    4.472513]  ? check_prev_add+0xf4/0xd30
> [    4.472515]  __lock_acquire+0x3b4/0x1b80
> [    4.472518]  ? raw_irqentry_exit_cond_resched+0x20/0x50
> [    4.472556]  lock_acquire+0xbf/0x2e0
> [    4.472558]  ? pci_match_device+0x24/0x180
> [    4.472563]  _raw_spin_lock+0x30/0x40
> [    4.472567]  ? pci_match_device+0x24/0x180
> [    4.472569]  pci_match_device+0x24/0x180
> [    4.472571]  new_id_store+0x189/0x1d0
> [    4.472574]  kernfs_fop_write_iter+0x14f/0x210
> [    4.472578]  vfs_write+0x263/0x5e0
> [    4.472583]  ksys_write+0x79/0xf0
> [    4.472585]  do_syscall_64+0x117/0xf80
> [    4.472587]  ? clear_bhb_loop+0x40/0x90
> [    4.472590]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [    4.472592] RIP: 0033:0x7fe7bc0beeb2
> [    4.472595] Code: 18 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 1a 83 e=
2 39 83 fa 08 75 12 e8 2b ff ff ff 0f 1f 00 49 89 ca 48 8b 44 24 20 0f 05 <=
48> 83 c4 18 c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 10 ff 74 24 18
> [    4.472596] RSP: 002b:00007ffcdbb1ed80 EFLAGS: 00000202 ORIG_RAX: 0000=
000000000001
> [    4.472598] RAX: ffffffffffffffda RBX: 00007fe7bc2415c0 RCX: 00007fe7b=
c0beeb2
> [    4.472599] RDX: 000000000000000a RSI: 00005580955433c0 RDI: 000000000=
0000001
> [    4.472600] RBP: 000000000000000a R08: 0000000000000000 R09: 000000000=
0000000
> [    4.472601] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000=
000000a
> [    4.472602] R13: 00005580955433c0 R14: 000055805932493e R15: 000055809=
5545490
> [    4.472605]  </TASK>
>
> Fixes: 10a4206a2401 ("PCI: use generic driver_override infrastructure")
> Fixes: 8895d3bcb8ba ("PCI: Fail new_id for vendor/device values already b=
uilt into driver")
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>
> ---
>
> v2:
>  - Use device_initialize instead of spinlock init
>  - Set release cb and call put_device to release
>  - Add Fixes tag for the commit that added temporary pci device without
>    initialize.

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
