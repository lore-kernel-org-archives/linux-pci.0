Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829D13451C1;
	Tue, 21 Apr 2026 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801971; cv=none; b=MVn50YXXrmgLa5z6wT4lh13hrGrVbvbQwkaE0V27qBCm/o2KkFNshwurx9+o2sMxVsEQzBlgYPcGQ74x3Rt5R94vSf0P/Wb4vpyRwh7PLqoJdkVmMqq4oJSwFQUEDwOvvkoRkxLxU7rbbJVqyPX19MkXNc4MeRV9+CtAKHJqjWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801971; c=relaxed/simple;
	bh=zLaqEY2AdfsU2z/D1pNc/O8p+28fE6XTfonBYfspxZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDMPyzdVq17Yq4OfhOUAgINLVMcga5rvVK+LmtelFLo3nEy3W32BhhMO2mzq4aSlES+Ggw1+bfc/wHHAOWVr2qOS3Siz/IanZJOcqXdU/g5ldmD6G7apVmaX0P8Bf4QUNh1o3ZAXKx+8/hU3JKrMUEtNcF/d32/wTmfP31xV6+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLk8TvvJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLk8TvvJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9ACC2BCB0;
	Tue, 21 Apr 2026 20:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776801971;
	bh=zLaqEY2AdfsU2z/D1pNc/O8p+28fE6XTfonBYfspxZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PLk8TvvJWIBLYMgP5fE2xmhBa2sDysetrsKMet0ZyBqA4TLBhTuhOrlV6iENIIWdR
	 9MV2DnzdojJcU3BaEzpZCq2nUisl1jhVxlquirkUp8NXpn/65Tey1NbkfAf0MoQRcv
	 BpBJ4xsWX8UfXeTe08QMZri30FLYvVkHL44G4R3Hm2kTuyCO6FGLT0kmyUuMmo9qzC
	 eHkN1fzraxOPfgFp/hQv5mF0ZAen36o18ZcP+xAqjQw9i1L1JMGfMochPPfqEaOKtP
	 Z4t34hSHUtGQudYD+6ZGVOL5oHNDy5g84MtN1dY3ENmO/ZjzYdaXdh/GgRcBd6KaOs
	 fKtSFqf6yTcTA==
Date: Wed, 22 Apr 2026 05:06:09 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	Oliver O'Halloran <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 22/23] PCI/sysfs: Convert legacy I/O and memory
 attributes to static definitions
Message-ID: <20260421200609.GE1684602@rocinante>
References: <20260416180107.777065-1-kwilczynski@kernel.org>
 <20260416180107.777065-23-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416180107.777065-23-kwilczynski@kernel.org>

Hello,

> Currently, legacy_io and legacy_mem are dynamically allocated and
> created by pci_create_legacy_files(), with pci_adjust_legacy_attr()
> updating the attributes at runtime on Alpha to rename them and shift
> the size for sparse addressing.
> 
> Convert to four static const attributes (legacy_io, legacy_io_sparse,
> legacy_mem, legacy_mem_sparse) with is_bin_visible() callbacks that
> use pci_legacy_has_sparse() to select the appropriate variant per bus.
> The sizes are compile-time constants and .size is set directly on
> each attribute.
> 
> Register the groups in pcibus_groups[] under a HAVE_PCI_LEGACY guard
> so the driver model handles creation and removal automatically.
> 
> Stub out pci_create_legacy_files() and pci_remove_legacy_files() as
> the dynamic creation is no longer needed.  Remove the __weak
> pci_adjust_legacy_attr(), Alpha's override, and its declaration from
> both Alpha and PowerPC asm/pci.h headers.

There is feedback from Sashiko about this:

  https://sashiko.dev/#/patchset/20260416180107.777065-1-kwilczynski%40kernel.org?part=22

This is a pre-existing issue that is does trip KASAN:

  - Read successful; larger buffer.

    root@kvm:~# dd if=/dev/zero of=/sys/class/pci_bus/0000:00/legacy_io bs=4 count=1 seek=32
    1+0 records in
    1+0 records out
    4 bytes (4B) copied, 0.004042 seconds, 989B/s

  - Splat; smaller buffer.

    root@kvm:~# dd if=/dev/zero of=/sys/class/pci_bus/0000:00/legacy_io bs=1 count=1 seek=128
    [  138.516163] ==================================================================
    [  138.516843] BUG: KASAN: slab-out-of-bounds in pci_write_legacy_io+0x90/0xc8
    [  138.517311] Read of size 4 at addr c29697b0 by task dd/37
    [  138.517685] 
    [  138.518188] CPU: 0 UID: 0 PID: 37 Comm: dd Not tainted 7.0.0-rc1-g973e040579d6 #1 PREEMPTLAZY 
    [  138.518578] Hardware name: PowerMac3,1 7400 0xc0209 PowerMac
    [  138.519019] Call Trace:
    [  138.519165] [c2b8bbd0] [c12deee4] dump_stack_lvl+0x50/0x78 (unreliable)
    [  138.519632] [c2b8bbf0] [c03f67e4] print_report+0x14c/0x514
    [  138.519968] [c2b8bc50] [c03f646c] kasan_report+0x104/0x1d0
    [  138.520288] [c2b8bcd0] [c0925e94] pci_write_legacy_io+0x90/0xc8
    [  138.520624] [c2b8bcf0] [c0626cb4] kernfs_fop_write_iter+0x484/0x6cc
    [  138.521003] [c2b8bd30] [c0419d1c] vfs_write+0x5fc/0x12f4
    [  138.521299] [c2b8be60] [c041aeac] ksys_write+0x120/0x244
    [  138.521605] [c2b8bf00] [c001d218] system_call_exception+0x14c/0x304
    [  138.521976] [c2b8bf30] [c002b1bc] ret_from_syscall+0x0/0x2c
    [  138.522317] ---- interrupt: c00 at 0x100a59f4
    [  138.522695] NIP:  100a59f4 LR: 101005e4 CTR: b7bf44a0
    [  138.523013] REGS: c2b8bf40 TRAP: 0c00   Not tainted  (7.0.0-rc1-g973e040579d6)
    [  138.523413] MSR:  0000d932 <EE,PR,ME,IR,DR,RI>  CR: 28004462  XER: 00000000
    [  138.524028] 
    [  138.524028] GPR00: 00000004 bfbff210 1027d520 00000001 102795a0 00000001 10277237 100a4ac4 
    [  138.524028] GPR08: 0000d932 00000002 00000000 bfbff2c0 b7bf0000 102790b2 10230000 10226faa 
    [  138.524028] GPR16: 10237d81 00000000 00000000 102795a0 102795a0 00000000 1027721f 00000001 
    [  138.524028] GPR24: 00000001 00000000 10271500 10270000 00000000 00000001 102795a0 00000001 
    [  138.526014] NIP [100a59f4] 0x100a59f4
    [  138.526264] LR [101005e4] 0x101005e4
    [  138.526500] ---- interrupt: c00
    [  138.526740] 
    [  138.526913] Allocated by task 37 on cpu 0 at 138.516066s:
    [  138.527334]  kasan_save_track+0x3c/0x90
    [  138.527572]  __kasan_kmalloc+0xb8/0xec
    [  138.527816]  kernfs_fop_write_iter+0x55c/0x6cc
    [  138.528076]  vfs_write+0x5fc/0x12f4
    [  138.528269]  ksys_write+0x120/0x244
    [  138.528472]  system_call_exception+0x14c/0x304
    [  138.528688]  ret_from_syscall+0x0/0x2c
    [  138.528950] 
    [  138.529108] The buggy address belongs to the object at c29697b0
    [  138.529108]  which belongs to the cache kmalloc-8 of size 8
    [  138.529673] The buggy address is located 0 bytes inside of
    [  138.529673]  allocated 2-byte region [c29697b0, c29697b2)
    [  138.530173] 
    [  138.530318] The buggy address belongs to the physical page:
    [  138.531001] page: refcount:0 mapcount:0 mapping:00000000 index:0x0 pfn:0x2969
    [  138.531454] flags: 0x0(zone=0)
    [  138.532076] page_type: f5(slab)
    [  138.532520] raw: 00000000 c1c01300 00000122 00000000 00000000 005500aa f5000000 00000000
    [  138.533046] page dumped because: kasan: bad access detected
    [  138.533372] 
    [  138.533496] Memory state around the buggy address:
    [  138.533955]  c2969680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
    [  138.534328]  c2969700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
    [  138.534693] >c2969780: fc fc fc fc fc fc 02 fc fc fc fc fc fa fc fc fc
    [  138.535066]                              ^
    [  138.535358]  c2969800: fc fc fa fc fc fc fc fc fa fc fc fc fc fc 04 fc
    [  138.535661]  c2969880: fc fc fc fc 00 fc fc fc fc fc fa fc fc fc fc fc
    [  138.536058] ==================================================================
    [  138.537335] Disabling lock debugging due to kernel taint
    1+0 records in
    1+0 records out
    1 bytes (1B) copied, 0.023071 seconds, 43B/s

Something to fix as a follow-up.

Thank you!

	Krzysztof
