Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD75A4E5357;
	Mon, 12 Oct 2026 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791836010; cv=none; b=cNjWfAQvlVd65ofBGKEr/IUYSJ+2+AZIsZNZdMwXd8nC8Fx0wPD6bgW/zziURalJin3jPZcLrPr+H3GBFOVmJKTHw3gAsnr6dqcahjiv2lF4lKq2hFKUNIe6Xm2nXBcooGjJRe+89TCdiQ2jLWEuYWCNITqKxkn3boUE7WE21e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791836010; c=relaxed/simple;
	bh=M1Lj5as5bi2C4gscMGK4dz31rWCEL9ULprKscGsuckM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iPoiiHYS5h2MIc/kjd7s4JhZyiiYcZBHKeoPxzNww81rqMEDMOn/oqwZSsQAqPIGBS2Bn61GXpjBCWjCukLvrIRVxz3ttKcVL9ztOkQMmducynHTg7ZLygJuyXcTapyahwr57ZiP1RF69TDH7X4yp3JQ4IbrQ50ca0eRyzzr7m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyoLdGpv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyoLdGpv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36091F0089B;
	Mon, 12 Oct 2026 20:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791836008;
	bh=ipfnvz0/kYIxjRDd3MrcP9WRjs1t+zUVD4kVE6VTnwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=hyoLdGpv1N7sGAm4AzcgqI1HFHbe9lWlVuA3Xsh44J4j5++B7nzx8MNFy6RYzr12C
	 iwqiQ0OvFbdYiGii4edVrqlWETtX6iGWSl8ifOtoJ3+n2j/P270LtV7sFm5BlcwvAk
	 dcMkM+/KPOaunj9hNmijb7wT/r6jNqgmKyTqNSvgPJ3i1NPFvzF7pENZhnXP+zYQPj
	 o346GIOlTfOzowVTN6JWDvHXWlge+N3ggnejNlJgqvW3ji4T4EvdtXpb9TkKr/L/d4
	 kT0EfCGjux5TZ3AoMUUe+51ASBBzIQgmJcWv8U1FRXNwF9LkyLM9JOzTw7UXyOS3QD
	 aavAHvs1d6AJg==
Date: Mon, 12 Oct 2026 15:13:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Perlow, Jason" <jperlow@gmail.com>
Cc: "To: Bjorn Helgaas" <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Aditya Garg <aditya.garg@linux.dev>
Subject: Re: PCI/AER: MacBookPro16,1 test results with Apple SEP ANFE quirk
Message-ID: <20261012201326.GA1374572@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABZrw2H+3yt2Y7xiq6OyAWaJM7P9ox-2nJxoQuJMwoJHLgi+YQ@mail.gmail.com>

On Fri, Oct 09, 2026 at 11:38:50PM -0400, Perlow, Jason wrote:
> Bjorn, Lukas,
> 
> I have tested the Apple SEP ANFE quirk together with Lukas's false-alarm
> recovery fix on two MacBookPro16,1 systems. Both stayed up for over two
> hours after booting the candidate kernel. The patch is being prepared
> against pci/for-linus at 79c168e2aa957ed0054c93db17caba653b95e377.
> 
> The candidate retains eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal
> Errors"), adds 79c168e2aa95 ("PCI/AER: Skip error recovery on false
> alarms"), and leaves the ANFE mask unchanged only on the Apple T2 Secure
> Enclave Processor [106b:1802]. The global ANFE revert is absent from the
> test kernel. The per-device flag approach follows Aditya's earlier
> proposal, with an EARLY fixup so the flag is set before pci_aer_init().
> 
> The test systems are:
> 
>   MEDUSA:  MacBookPro16,1, Core i7-9750H
>   CHIMERA: MacBookPro16,1, Core i9-9980HK
> 
> Both ran 7.3.0-rc6-6-t2-edge-apple-sep-anfe-test, confirmed by uname and
> the kernel banner in each current boot journal. At the 23:24 EDT check
> on October 9, MEDUSA had 2 hours 22 minutes uptime and Chimera had
> 2 hours 21 minutes. Their boot IDs were unchanged from the initial
> successful candidate boots. graphical.target and the display manager
> were active on both, and neither had failed systemd units.
> 
> Read-only config-space checks gave the same results on both systems:
> 
>   Function                    Correctable error mask
>   Apple SEP, 04:00.2           0x00006000
>   Apple function, 04:00.0      0x00004000
>   Apple function, 04:00.1      0x00004000
>   AMD GPU, 03:00.0             0x00000000
> 
> ANFE bit 13 is therefore masked on the SEP and unmasked on the other
> observed functions. No config-register writes were used in these checks.
> The implementation matches vendor/device ID, not these bus addresses.
> 
> Neither candidate boot journal contains an AER/GHES report, kernel
> panic, oops, BUG or call trace. Neither recorded additional kernel
> messages after the initial 21:04 checks through the 23:24 check.
> 
> The earlier Wunner-only candidate booted on MEDUSA but then powered off,
> as I reported on October 8. Its retained journal ended before that event;
> there was no recorded shutdown sequence or panic. The cause of the power
> loss is still unknown, and this quirk does not establish a firmware
> mechanism. The combined candidate has not reproduced that symptom within
> the observed interval.
> 
> There are remaining boot warnings unrelated to the reported AER symptom:
> ACPI duplicate-table/method errors, AMD SDMA fence fallback warnings,
> HID rotation probe failures, and Broadcom P2P failures. Chimera also logs
> CPU 0 machine-check records in banks 12 and 13. These warning categories,
> including the same machine-check status/address records, appear in the
> previous boot logs. I am retaining them as separate follow-up issues.
> 
> This was a v7.3-rc6 test build with the existing T2 driver/patch stack,
> using Debian Forky GCC 16.2 and binutils 2.47. It was not a vanilla
> upstream kernel or an identical-toolchain comparison to the older GCC 14
> release image. Artifact checksums, exact source/provenance, config checks,
> t2gmux/t2smc builds and imported-symbol CRC checks passed. A generic
> KVM/OVMF boot also passed; the hardware observations above come from the
> two physical systems, not KVM.
> 
> The T2 team reports that [106b:1802] identifies the SEP across T2 models,
> but this report covers only these two MacBookPro16,1 machines. I have not
> tested other T2 models, power-off/cold-start, suspend/resume, reset, kexec
> or deliberate AER error injection. Physical confirmation of the rendered
> GUI is not included in this report; desktop service state was checked
> remotely. The existing release/rescue boot files were preserved.
> 
> The patch (enclosed) leaves other ANFE handling enabled and is idempotent
> across
> repeated fixup/AER initialization. Please review it as a targeted workaround
> for the MacBookPro16,1 regression, with the testing limits above.

Thanks for this!  Since you posted this before Aditya's essentially
identical patch
(https://lore.kernel.org/all/20261010172301.12764-1-aditya.garg@linux.dev/),
I used this one instead.  It's on pci/for-linus for v7.3.
