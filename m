Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F184F30FE;
	Wed, 30 Sep 2026 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781475; cv=none; b=X6MFdL1LdSMMoOPDGkMN/+bgpB0zEH0VIaiTaI/0j27kZDNy9nqyJ9ClFTOTZgg7Gbx+OxTApD99sv9nwdOVUyDivIyZIDGqW/x/BxMpusWYzmVY5DSc3F0ifkAPJIabrRbCEIywfQBRrRByQxlQv5k5TfzyImaV8OJh/ON4XNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781475; c=relaxed/simple;
	bh=IpHiY1hRZ4ZqoNtBptXW5wIqv/+HeqkF2zParF6pE6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GBWCzwGgi18uzCRdrpAoLkdJVGmYxs8D/1QnftcmwCLeTWQhoHlfeYFTlb8cXDM9gnpv+uTUkSCddVv1J7b27NQYDaNx8JT2QjuwUlEANbLPQn8Q4S8/E6NZp7MwL6yXgAffgTxqcH8vfZjuXxILCxJgVYp+yMXmaX73rXQaFtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELHyD1m1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELHyD1m1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE401F00893;
	Wed, 30 Sep 2026 15:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790781466;
	bh=UNu5zVZ7xQk/ROVl1xUlzSAPPPInMy0HhdC6GL98V/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ELHyD1m1qINrGFl75geurTwbL0VhY90bNmyPqY3PiKjtHzcdj2/GDN1AKkcLGNB0o
	 pghQ91P62hdv1JQJ+cXxen33tPObPPTtMx/leNzcWaC+jRIOAIgnEm50ZXhMqBCZVS
	 hBv+iGyCQZ3G2L20Kzmhl+aDOZNRx9hoN9PkdTuJKv+tZal8w57CyBOAYojjdJL0P4
	 JH/pUfdgpzessKI5Yz5JvBVRmzoyZ/sAhb/nCfQfClR7xnn8NbXznQ61rR3FiNIDBe
	 6wVda1OdD0lPcKLnK0QN3Fx5jS16PWXBoZND32onk+r9sVYuCzr11LHx9r4hBEDxi5
	 wi7A591tHLZsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] ath12k: add PCIe link recovery retry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260930140833.576941-7-jtornosm@redhat.com>
References: <20260930140833.576941-1-jtornosm@redhat.com>
 <20260930140833.576941-7-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 15:17:45 +0000
Message-Id: <20260930151745.DDE401F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] ath12k: infinite loop in panic handler due to jiffies-based timeout
- [Medium] ath12k: 5-second busy-wait loop using mdelay() causes severe CPU=
 stall
- [Medium] ath12k: missing post-loop check causes spurious timeouts on pree=
mption
--

commit 5337b864dac2a64cb78f0c14498962bdb92990b4
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

ath12k: add PCIe link recovery retry

This patch modifies ath12k_pci_soc_global_reset() to add a retry loop
waiting up to 5000ms for the PCIe link to recover after a global reset.
It returns an error if the link remains down, preventing continued MHI
initialization with a dead link.

> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless=
/ath/ath12k/pci.c
> index af0e882fd0b51..65712486d3127 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c

[ ... ]

> @@ -206,14 +208,29 @@ static void ath12k_pci_soc_global_reset(struct ath1=
2k_base *ab)
> =20
>  	mdelay(delay);
> =20
> -	val =3D ath12k_pci_read32(ab, PCIE_SOC_GLOBAL_RESET);
> -	if (val =3D=3D 0xffffffff)
> -		ath12k_warn(ab, "link down error during global reset\n");
> +	/* Wait for PCIe link to recover, especially important in VM environmen=
ts
> +	 * where timing can vary significantly from bare metal.
> +	 */
> +	timeout =3D jiffies + msecs_to_jiffies(5000);
> +	while (time_before(jiffies, timeout)) {

[Severity: High]
Will this create an infinite loop during a kernel panic?

The panic handler ath12k_pci_panic_handler() executes via the panic notifier
chain:

ath12k_pci_panic_handler()
    ath12k_pci_sw_reset()
        ath12k_pci_soc_global_reset()

Since interrupts are disabled during a panic, jiffies does not advance. If
the PCIe link fails to recover, which is common during a system crash, does
this loop evaluate to true indefinitely and prevent kexec or reboot?

> +		val =3D ath12k_pci_read32(ab, PCIE_SOC_GLOBAL_RESET);
> +		if (val !=3D 0xffffffff) {
> +			link_recovered =3D true;
> +			break;
> +		}
> +		mdelay(20);

[Severity: Medium]
Does this busy-wait cause a severe CPU stall?

A 5000ms busy-wait monopolizes the CPU, causing a severe latency spike. In a
virtualized environment, which this patch targets, it can starve other vCPUs
or host tasks, and risks triggering RCU stall warnings.

Since mdelay() relies on a spinning loop and actively consumes 100% of the
CPU instead of yielding, should msleep() or context-aware wait functions be
used for delays this long outside of atomic contexts?

> +	}
> +	if (!link_recovered) {

[Severity: Medium]
Can this cause a spurious timeout if the thread is preempted?

If the thread is preempted or descheduled during or just after the mdelay()
call, which is common in VM environments due to vCPU scheduling, jiffies may
advance past the timeout.

When the loop terminates due to time_before() evaluating to false, it retur=
ns
-ETIMEDOUT without verifying the register one last time. Does this ignore t=
he
possibility that the hardware condition was satisfied during the preemption
window?

> +		ath12k_err(ab, "PCIe link failed to recover - device may need power cy=
cle\n");
> +		return -ETIMEDOUT;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930140833.5769=
41-1-jtornosm@redhat.com?part=3D6
