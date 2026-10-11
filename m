Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3823223B634;
	Sun, 11 Oct 2026 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791705559; cv=none; b=aNa8R3rOSXqEy6BkTtU8hACHuxh9WgYznVfl2SGaTCY/mqE7nln0V9urPTkj/01SCeCqJs4ctGEWAybx57zSynzYcjym0dS3dkt4COaslmtfEb4oi2X7ZTlNnlgSuLm6y5OmkOVcQeXG/HmlQHNEw8T9cnYNFEElAdkFppDBH8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791705559; c=relaxed/simple;
	bh=RaDRPepabFwCeZ+XqqnVO9PfT+wgE/sGQSZonKxo2dA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hyVO9X1UtKirwbr2XA/j6RrPYGVQWA3YN1QlrFpfALkM1OPRmMeMvJ0LjnIMICje2MOHhtuvqHNrxJgfhZj6tTPQupIAc/cwdqbGaMerTJktthUuIcvQry3lRqDnTwLQAZpucB9CKtI9OLIZZelnzV6FaxnoM0n7KQhA6apUMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwKVRu9K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwKVRu9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BF51F0089B;
	Sun, 11 Oct 2026 07:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791705557;
	bh=imdtB9/rU20qSQp8mcAHM4RY5ZUNnzsQ98ZBTaOhXtE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OwKVRu9KiWKT9uzOyv9yazylqGiN+vJDIbL0N8knz1CKu+yThgIvEshWWpGsQFbvX
	 GBWQc5YC/Js3uHV8cpzSm1WaBniHiWtZreDT1/BDwnM09xSekMDv7BFlRQ1dNwDZfW
	 TVmCUZ9ca+1pCs8LO1I1WfTNTBnRwLCo5uzsD9F2/hnhmL5yS4sfCTabtY181X8NCb
	 sv/NZg9fcQPdVEm21OHvs/7lz6x4P0BZ760jlrnAkpSy1Gl/q46yc96HY4nExIyTzH
	 CQ1zOa7E00xxzjJyxZcry/I4gkdn++YtGfvPPNWWLIH6Io7Sqaah14hT8/BgIPwxAK
	 IH80rWzJztznQ==
Message-ID: <sashiko-outbox-167113@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] ath11k: add PCIe link recovery retry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261011074514.515894-5-jtornosm@redhat.com>
References: <20261011074514.515894-1-jtornosm@redhat.com>
 <20261011074514.515894-5-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 07:59:16 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ath11k: 5000ms mdelay() causes severe CPU stall in normal contexts
--

commit 457eae9bbd9159c5c25a5626326a881f1232316d
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

ath11k: add PCIe link recovery retry

When ath11k devices are passed through to VMs via PCIe passthrough, the
PCIe link may not stabilize immediately after global reset. This patch
adds a retry loop to wait for the PCIe link to recover after global
reset and prevents continuing with a dead link.

Link: https://lore.kernel.org/all/20260930140833.576941-5-jtornosm@redhat.c=
om/

> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless=
/ath/ath11k/pci.c
> index a163168f36176..7e29ebaf97731 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c

[ ... ]

> @@ -215,14 +217,28 @@ static void ath11k_pci_soc_global_reset(struct ath1=
1k_base *ab)
> =20
>  	mdelay(delay);
> =20
> -	val =3D ath11k_pcic_read32(ab, PCIE_SOC_GLOBAL_RESET);
> -	if (val =3D=3D 0xffffffff)
> -		ath11k_warn(ab, "link down error during global reset\n");
> +	/* Wait for PCIe link to recover, especially important in VM environmen=
ts
> +	 * where timing can vary significantly from bare metal.
> +	 */
> +	while (retries-- > 0) {
> +		val =3D ath11k_pcic_read32(ab, PCIE_SOC_GLOBAL_RESET);
> +		if (val !=3D 0xffffffff) {
> +			link_recovered =3D true;
> +			break;
> +		}
> +		mdelay(20);
> +	}

[Severity: High]
Does this mdelay() loop cause a severe CPU stall?

The commit notes indicate this loop was changed to an iteration counter to
work in atomic/panic contexts. However, looking at the callers of
ath11k_pci_soc_global_reset() (such as probe, core_reset, core_restart,
and resume_early), these execute in contexts where it seems safe to sleep.
Even in resume_early, interrupts are enabled and jiffies advance normally.

Furthermore, immediately after this loop, the code calls
ath11k_pci_restore_window(), which unconditionally takes a spinlock with
spin_lock_bh():

ath11k_pci_restore_window(struct ath11k_base *ab) {
    ...
    spin_lock_bh(&ab_pci->window_lock);
    ...
}

Since taking a bottom-half disabling spinlock would be invalid in a hardirq
or panic context, doesn't this mean the code runs in normal process context?
If so, spinning the CPU without yielding for up to 5000ms (250 * 20ms) might
degrade responsiveness and risk triggering the soft lockup watchdog.

Could msleep() or fsleep() be used here instead?

> +	if (!link_recovered) {
> +		ath11k_err(ab, "PCIe link failed to recover - device may need power cy=
cle\n");
> +		return -ETIMEDOUT;
> +	}
> =20
>  	/* Restore window register as its content is cleared during
>  	 * hardware global reset, such that it aligns with host cache.
>  	 */
>  	ath11k_pci_restore_window(ab);
> +
> +	return 0;
>  }
> =20
>  static void ath11k_pci_clear_dbg_registers(struct ath11k_base *ab)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011074514.5158=
94-1-jtornosm@redhat.com?part=3D4
