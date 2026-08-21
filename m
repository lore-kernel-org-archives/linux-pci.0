Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729F847CA64
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309138; cv=none; b=nNHpG6DqdmVM9gM22gdqBpU2ODP6ea0uooVx7cdodskYTInKTLbuE5zfxzXFaEBqkqeopRbdkMN1nCKXNOamgrVoCuWYopxXDid773S/SDMYT/LVPywG2hX3DE/xlHgtBiAwDnvTdk7WVo0NfgltGqYlTMn+BQzqD2984T95zbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309138; c=relaxed/simple;
	bh=OWpoYk6o1kAqLapZAPcztLhuyfVkilnk979TAOtTzAQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F5KwUugvtaVGe26pmVdJzAqFKVC7PphPx0kdITod6arTxIpXP9pjHb3A7HCd4TMniqJjx/8dP6ATdhpSQ22khAzVc7TZqAo7KYVHlWBvHtuT4opOR2WT7NXwQS6YDk1vcnZFfWXYc8hq7EhPDGYmp0OaqOafKxMOd2EYvxDJvcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAtTRr7/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAtTRr7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1F41F00A3A;
	Fri, 21 Aug 2026 10:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787309137;
	bh=DSiTHUMk5glq0DqxJ7rYg/6CPIctzAVeAI/2/NBN0Mo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hAtTRr7/++Y10lZ5Ev/humzU46/GGDj1ryJKhfgRa7WCjYvNSXjHZF2mbDmrPF9Rl
	 a5G94TY+ICH4s1z6Iaur+XYflNwXO/DJF4l5VxgvDm984ppvCXM+/sdGng9xIDJ8as
	 MoAlPWFijVQQQfmf8yLfwwPJ1kWmgU0jh/mmSDo40h1aUp5BIJQ2GZ9r8x/fMJC43c
	 vCyKRCcQ4RzHaD7vCQ6AsD3hHAnNcCQBCajyqOIi26nGx2ylRU3x5TidxA/XANgiN5
	 xGoRf5QX7cDvWiNwcswriymUGnnbv3WWf7xrQPN+5CuRTq+JuZ1ZPBs/xISlpbtXha
	 eapJxOfTJo+jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/ASPM: Clear L1SS capability when L1 latency is
 unacceptable
Reply-To: sashiko-reviews@lists.linux.dev
To: Aniket <aniketmaurya@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821103214.2049218-1-aniketmaurya@google.com>
References: <20260821103214.2049218-1-aniketmaurya@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:45:36 +0000
Message-Id: <20260821104537.0A1F41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hardware State Desynchronization: Clearing PCIE_LINK_STATE_L1SS fr=
om `link->aspm_capable` prevents the kernel from properly disabling L1 PM S=
ubstates in hardware configuration registers.
--

--- Patch [1]: [PATCH] PCI/ASPM: Clear L1SS capability when L1 latency is u=
nacceptable ---
commit b94fabc7c75525f540a542b9992482d82ee2ac83
Author: Aniket Maurya <aniketmaurya@google.com>

PCI/ASPM: Clear L1SS capability when L1 latency is unacceptable

This commit clears PCIE_LINK_STATE_L1SS from link->aspm_capable when L1
exit latency is unacceptable. This prevents L1SS sysfs control files from
being exposed and avoids invoking pcie_config_aspm_l1ss() unnecessarily.

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 172783e7f519a..38eb7b1e23774 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -666,7 +666,8 @@ static void pcie_aspm_check_latency(struct pci_dev *e=
ndpoint)
>  		latency =3D max_t(u32, latency_up_l1, latency_dw_l1);
>  		if ((link->aspm_capable & PCIE_LINK_STATE_L1) &&
>  		    (latency + l1_switch_latency > acceptable_l1))
> -			link->aspm_capable &=3D ~PCIE_LINK_STATE_L1;
> +			link->aspm_capable &=3D ~(PCIE_LINK_STATE_L1 |
> +						PCIE_LINK_STATE_L1SS);

[Severity: High]
Does clearing PCIE_LINK_STATE_L1SS here prevent the kernel from disabling
L1 PM Substates in the hardware configuration registers if the BIOS left
them enabled?

When pcie_config_aspm_link() runs later to apply the state, it checks this
exact capability before performing the cleanup:

pcie_config_aspm_link() {
    ...
    if (link->aspm_capable & PCIE_LINK_STATE_L1SS)
        pcie_config_aspm_l1ss(link, state);
    ...
}

Because the capability was stripped earlier in pcie_aspm_check_latency(),
this condition evaluates to false. Will this bypass the hardware cleanup
routine, leaving stale BIOS configurations active and causing L1 to be
disabled while L1SS remains enabled in hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821103214.2049=
218-1-aniketmaurya@google.com?part=3D1
