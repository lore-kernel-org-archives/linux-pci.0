Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9817035CBC3
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739340; cv=none; b=cd3CYuOSn3glZDJbqQaeacwhu6JXiBLWafOkNFGF0qSqpvouSHH/L61pwbS6DAxqg00Kqa4rCvH1Tc5E3y/lgyJQ3WTSTxBUrrRUPHl4Of/XDkpWS+jjuIDW1awEU09MgWsca9fbbGA/FOSaIhr6+5Qt1hz39KkWNiiH/Ge7PXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739340; c=relaxed/simple;
	bh=YL1qckNngKPg1R3UrGGuG1Du0sRAaM7EbetK2ca0b5E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qqVifIsdi0rpKoM+ecBqZCZo3C/yhMPFNdFPk7U7BVUtvIiJybEPtAQglzf6tp4vN9t472Tlk/XGhBYkoVuQUsnVCloS8zbds1zianBzbzGgCSlTc8sRQ5Idmw3+sMrfFFyVKQLAPP3xZjF4Z6eWc99hqKWwy4WEZNnUk7woqps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTD9oKu7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTD9oKu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218021F000E9;
	Fri, 14 Aug 2026 20:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786739339;
	bh=Kc9bA0vZaOAq8g1eAlIbyiF9zNjaZjuYD0MPDesAFbc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iTD9oKu7iDvIMKOq8gYru6mrSoHviM2eK+ABPhErm/Dyo8NsiSmLPyk6hWezN4jjL
	 RTOIavo2FON2uEcgkZ5SqTAAMwa8GJb8z8VoaNPgJMIrCtm4ERbPB3C7s1Yd+9mhaE
	 xusb/qb/z/4W1Tr8RrlAWPqu2hfq0PIeqEYm7XP2mbTSrV77r6dkSPDA3AbI9v3hdH
	 rYomd8cwu74rt173LSzYuc1Qlw8t2khOldvlrSMveFbxroJ21aVHguGak9P8zOJ5lO
	 s8uqp3V4Cq1wEG+KotVB3XVefA5rbZdSVaMAdY8D5yhQ5GIwjae4Zfr7z2IqFg3CxJ
	 00aDA1q9vnm6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 3/5] PCI: Save and restore the Device 3 Control
 register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vidya Sagar" <vidyas@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260814201621.2281245-4-vidyas@nvidia.com>
References: <20260814201621.2281245-1-vidyas@nvidia.com>
 <20260814201621.2281245-4-vidyas@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 20:28:58 +0000
Message-Id: <20260814202859.218021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Topology Corruption in pci_restore_dev3_state().
- [High] Data Race and Concurrency violation in pci_restore_dev3_state() wr=
iting to bus bitfields.
--

--- Patch [3]: [PATCH V3 3/5] PCI: Save and restore the Device 3 Control re=
gister ---
commit 308945c2aad690ba20eb4cf961ec76f5391413d4
Author: Vidya Sagar <vidyas@nvidia.com>

PCI: Save and restore the Device 3 Control register

This commit saves and restores the Device 3 Control register across PCI pow=
er
management transitions to preserve the 14-Bit Tag Requester Enable state. It
dynamically sanitizes the saved value upon restore to clear the enable bit =
if
the hardware link is no longer operating in Flit Mode.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee615..b881163febb6a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> @@ -1703,6 +1703,85 @@ static void pci_restore_pcie_state(struct pci_dev =
*dev)

[ ... ]

> +static void pci_restore_dev3_state(struct pci_dev *dev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	u32 *cap, val, dev3_cap, dev3_sta;
> +	u16 lnksta2 =3D 0;
> +	bool flit_now;
> +	int pos;

[ ... ]

> +		pci_read_config_dword(dev, pos + PCI_DEV3_STA, &dev3_sta);
> +		dev->fm_enabled =3D !!(dev3_sta & PCI_DEV3_STA_SEGMENT);
> +
> +		pcie_capability_read_word(dev, PCI_EXP_LNKSTA2, &lnksta2);
> +		flit_now =3D !!(lnksta2 & PCI_EXP_LNKSTA2_FLIT);
> +		if (dev->bus)
> +			dev->bus->flit_mode =3D flit_now;

[Severity: High]
For bridge devices like Downstream Ports or Root Ports, does writing to
dev->bus modify the upstream bus link status instead of the downstream link?

When a Root Port resumes, dev->bus points to the shared Root Bus. Reading
LNKSTA2 (which reflects the downstream link) and applying it to dev->bus
could misrepresent the shared upstream topology state.

Would dev->subordinate be the correct target for bridge downstream link
status?

[Severity: High]
Could this assignment also cause a data race during concurrent resumes?

The PCI power management subsystem can use asynchronous resume. If multiple
sibling endpoints on the same primary bus, or multiple root ports on the
root bus, execute pci_restore_dev3_state() concurrently, they will write to
the shared dev->bus structure simultaneously.

Since flit_mode is a bitfield in struct pci_bus, writing to it without a
lock from an asynchronous context could result in an unsynchronized
read-modify-write operation, potentially corrupting adjacent bitfields.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814201621.2281=
245-1-vidyas@nvidia.com?part=3D3
