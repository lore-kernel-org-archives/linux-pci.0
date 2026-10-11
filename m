Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD172BD022;
	Sun, 11 Oct 2026 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791705938; cv=none; b=en795XyFGUtlbXZQlLgfEyb9yJYdwRHjQ8ZUCboyk/PbNBgX2KpWjS8ja/zO7XP7oYJVFX3AtarXFTw0B8hQoSdkOwsA+Vvvfx1Ih41RGxU1UaJCySK5haDthjNUSMvxDBQac4OtAjxnizIlfnGXLTtGzurMQ6r2dznapQQHxLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791705938; c=relaxed/simple;
	bh=N4OqcijCEFEjEKvs/OwbAiCxDXhzjDPVC0mRT3dth00=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=N45vSI6kL5SJhg4WHGHoBup4063h3UGEHePYeYA/jLgRifWNGaZFM+hKBZSJAr+aZfXaafAQD6zc0oLOjCCnC3YB8uhX3LnTtDhu0UKR8PYKXjwPpIiezFFTnBSJONqhiXBXgXCiwSQDlC+IsQoSLkb4wiiBMwS5OWa7L44FqdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVGG526G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVGG526G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3D31F0089B;
	Sun, 11 Oct 2026 08:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791705936;
	bh=hHwfZl/xXo2uuebAXRVuG06zvE+oqKbrYi0y401fXks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jVGG526G7OfijwCT6T7tKvdC78QhqkE6qqxyUbof7w1I5BHby6k2hoB20NaZCvzQB
	 /kYkwFJwua6aw3/CwYph72qDc3U3OQUI2bRLN8oxT8Er80d8UUW/3qLrEmRWrTewEZ
	 +Ay/2zWszQsEHE3dIITvjXKDHTbGKqw++n+DotKWGQZoJqEAzmEtEiN+xhHt6DGvNT
	 CMT2IQwJSbtiSqFFw3LFpHcf93fhTC7Pd+O6VBVy0nW9bR4s5SskXdPrzkzlZosZ3P
	 +yXW5Z7fq9DdhycL/+HDVq9cXrAlKP5EkA3DbZvTc4HCprR1YnduyYrPUnlL73+cec
	 5lIay0FQVtE7A==
Message-ID: <sashiko-outbox-167117@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] ath12k: add PCIe link recovery retry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261011074514.515894-7-jtornosm@redhat.com>
References: <20261011074514.515894-1-jtornosm@redhat.com>
 <20261011074514.515894-7-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 08:05:36 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ath12k: 5-second CPU stall during surprise removal due to mdelay()
--

commit d00e14e9dd0d255c530deddfbc808bf7524a6d82
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

ath12k: add PCIe link recovery retry

This commit adds a retry loop to ath12k_pci_soc_global_reset() that waits up
to 5000ms for the PCIe link to recover after a global reset. This addresses
MHI initialization failures caused by virtualization layer timing variations
in PCIe passthrough environments.

Link: https://lore.kernel.org/all/20260930140833.576941-7-jtornosm@redhat.c=
om/

> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless=
/ath/ath12k/pci.c
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
[ ... ]
> @@ -206,14 +208,28 @@ static void ath12k_pci_soc_global_reset(struct ath1=
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
> +	while (retries-- > 0) {
> +		val =3D ath12k_pci_read32(ab, PCIE_SOC_GLOBAL_RESET);
> +		if (val !=3D 0xffffffff) {
> +			link_recovered =3D true;
> +			break;
> +		}
> +		mdelay(20);
> +	}

[Severity: High]
Will this loop cause a 5-second CPU stall during surprise removal?

During device teardown or module unload (such as ath12k_pci_remove() ->
ath12k_core_hw_group_cleanup() -> ath12k_core_hw_group_stop() ->
ath12k_core_soc_destroy() -> ath12k_hif_power_down() ->
ath12k_pci_power_down()), if the device has been physically removed, the
memory-mapped read will continuously return 0xffffffff.

This forces the loop to exhaust all 250 retries, resulting in a 5000ms
busy-wait (mdelay) in process context, which severely disrupts system
responsiveness and can trigger soft lockup watchdogs.

The commit notes mention this was changed to use an iteration counter
for ath12k_pci_panic_handler(), but it doesn't appear that such a
handler currently exists in the driver. Even if one were added later,
stalling the CPU for 5 seconds on all teardowns and suspends might be
unacceptable.

Could this code use msleep() instead, or conditionally check
in_atomic() / is_panic before busy-waiting?

> +	if (!link_recovered) {
> +		ath12k_err(ab, "PCIe link failed to recover - device may need power cy=
cle\n");
> +		return -ETIMEDOUT;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011074514.5158=
94-1-jtornosm@redhat.com?part=3D6
