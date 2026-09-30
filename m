Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F174FC8F1;
	Wed, 30 Sep 2026 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780226; cv=none; b=DLGycXLal9O4f/IhWCxlSzh/P3BApuvDEHHTa/UV40cnAn69IKnhlqKVp8eji9WKcxxXnf2uAf3jQy5aBC2+ZB0PD2VNX+QzH9K0JD5ffIhm8gEid+S7I7lulpNEy2jG3NPAjcYRegC9U8tGHPLynN8BUaHu/EdlheYFdh65JNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780226; c=relaxed/simple;
	bh=fLL1YiQ0mSvSgtXqfIsc74mWY7h1m69BnfrLDp70HQs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jj3PWZ9bcP/ONVWKQ5alsk/RKBRoLhvbwOCA/ljlPepmlz4ZqC960pnIZnUz4F21goNyoXT/u5yVDlu3gmhdC2k58hmy/IduY+zlbkbH+kyd1J9yLy01rQXosKQXe1XsZaVfXmOhieAkv5v+fl41ygpiVVCIPJNRKjvI2j+9b+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kztPf/zt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kztPf/zt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E037D1F000FF;
	Wed, 30 Sep 2026 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780211;
	bh=oU2je0mZ1Txz6YA0lR6AlNB/k5aBPaZXl37+pi5z3Ok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kztPf/ztx7gYxLvRI7BlPUa0fPthDlJavG+mZhgO5gFLe7tkYqPE94n5V7aC3+HW9
	 9YBnQJly5dpxwZWyPaSSD8lpFtQ3Y1yh99LCq1/u10KypqPJPYi8y6QIN294UtQeO/
	 5XG1wxWnLQR+CyapRJk+4aghJ/nJHQ3jY+IAa11bJ8f1GZO95cEPzC6rU/dXZiQ1Tb
	 encfXEUZhVs9c3WjWxYoTIi0qQ8Hjg2LNXkyYVZFgNzTtSMl4rMWtc5Wo9jzo0Nj/k
	 A7XH9pF4PDYDq4qKS23oDKXl2QhAuUUmebU8ddOhOafF1lMh4dYQw/DByWLiqemShb
	 WmGlawrGMxqpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] ath11k: add PCIe link recovery retry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260930140833.576941-5-jtornosm@redhat.com>
References: <20260930140833.576941-1-jtornosm@redhat.com>
 <20260930140833.576941-5-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:56:50 +0000
Message-Id: <20260930145650.E037D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] ath11k: 5-second busy-wait loop using mdelay() causes CPU stalls a=
nd soft lockups
- [Medium] ath11k: polling loop misses final condition check on timeout cau=
sing false failures
--

commit c8d0b71714f3dd812345dc63d33d90b3fe00f198
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: ath11k: add PCIe link recovery retry

This commit adds a retry loop (up to 5000ms) to wait for the PCIe link
to recover after a global reset. This aims to fix initialization failures
in virtualized environments where link stabilization may take longer.

> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless=
/ath/ath11k/pci.c
> index a163168f36176..c372676b097f5 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c

[ ... ]

> @@ -215,14 +217,29 @@ static void ath11k_pci_soc_global_reset(struct ath1=
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
> +	timeout =3D jiffies + msecs_to_jiffies(5000);
> +	while (time_before(jiffies, timeout)) {

[Severity: Medium]
Will this polling loop incorrectly return -ETIMEDOUT if the thread is
preempted?

If the thread is preempted during the delay, jiffies could advance past
timeout before the next iteration. When the thread resumes, time_before()
will evaluate to false immediately, and the loop will exit without a final
register check despite the hardware having potentially recovered.

Should the hardware state be evaluated one final time after exiting the
time bounds check to avoid false timeouts?

> +		val =3D ath11k_pcic_read32(ab, PCIE_SOC_GLOBAL_RESET);
> +		if (val !=3D 0xffffffff) {
> +			link_recovered =3D true;
> +			break;
> +		}
> +		mdelay(20);

[Severity: High]
Does this mdelay() in a loop of up to 5 seconds cause soft lockups?

During device unbind or surprise removal, the following call chain is
executed:

ath11k_pci_remove()
  ath11k_core_deinit()
    ath11k_hif_power_down()
      ath11k_pci_power_down()
        ath11k_pci_sw_reset()
          ath11k_pci_soc_global_reset()

In these cases, the PCIe link is permanently dead and will never recover,
resulting in an unconditional 5-second CPU stall using a busy-wait.

Since ath11k_pci_soc_global_reset() is called from sleepable process and
workqueue contexts, could msleep() or read_poll_timeout() be used instead
of mdelay() to avoid blocking the CPU?

> +	}
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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930140833.5769=
41-1-jtornosm@redhat.com?part=3D4
