Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC4D494803
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320902; cv=none; b=BRSN/1UXEyLRByzqh1CpKlX88QEWuqBbW13Bbv1JNGFCXZTkvG4ypuTv6BI4lk4cOtUy/OYc6RPPsecbs8kP7fbIzB863UhADMuqqUjJ6aWwWMFyonHo4FPVdC89wY/UxLohHifaDHgmg8GAuSkH+Uw67TfbFoQ/Veld7NTNuZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320902; c=relaxed/simple;
	bh=N4ASD2Lc/rYatWUeyg/Sgs8rrjV4zhHJW5d8RCTUfDQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Np4s8nQh9iOXdKhy9cchjsAlvJTtjwbMezM/cmW8v/uasTLaQPaHlZmLfVR62D3A55F01Nif71ZwfLMBKbrSq0d2n6OHqa6ulL77E/uGDLAM7YcPULXiWLm57DDxP1NCZ8BkmyvMvH9HHtGTBH+eR7UQRU/vymzE4c7T6asEbuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAz3FViv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAz3FViv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652491F000E9;
	Fri, 21 Aug 2026 14:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787320900;
	bh=7kqNCoSKCt+xJC54hsFU42G/QdDP2LSkhJf+BFvSV/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WAz3FVivgQbUgJzEItsvxHCWrNdnVdd+kN7kRcTOEZNzZRKQYIiDIyojEAasy4Uo9
	 jj5Ace+oFNKAWJZvfM/6jy7kdKAo62xTj7A85rQZ1qHd+RN/XSnLzyPQ03bIdWDeqL
	 yFaq5oQfK2xVfJKrrD4zpzOLWZc/wZKr82+teh3m93NFh6FVjjesopIdZbBD9H7wol
	 yhPhM+xez0tvZ/mu9rFaLOY14bKqsmBPBvfsYHdg5RY2N23OFlZyDt91/4OqQ3FWtx
	 TJgfxtPMcS9UZ9s3VqCKiBw6BzszjMRtPHjHeB+Q9gdxQGYhXGR9NwOHJbT/eiOibz
	 pLtf21Dmfw/fQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI/ASPM: Clear L1SS capability when L1 latency is
 unacceptable
Reply-To: sashiko-reviews@lists.linux.dev
To: Aniket <aniketmaurya@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821134521.2211943-1-aniketmaurya@google.com>
References: <20260821134521.2211943-1-aniketmaurya@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 14:01:40 +0000
Message-Id: <20260821140140.652491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the ASPM sysfs s=
how and store functions (`clkpm_show`, `clkpm_store`, `aspm_attr_show_commo=
n`, `aspm_attr_store_common`) fetch the `link_state` pointer locklessly and=
 do not check for NULL before dereferencing it. If function 0 of a multi-fu=
nction PCIe device is removed via hotplug or sysfs, `pcie_aspm_exit_link_st=
ate()` frees the parent bridge's `link_state`. Subsequent reads or writes t=
o the ASPM sysfs attributes of remaining functions (e.g., function 1) will =
dereference a NULL pointer. If a sysfs write races with the removal of func=
tion 0, it results in a Use-After-Free.
--

--- Patch [1]: [PATCH v2] PCI/ASPM: Clear L1SS capability when L1 latency i=
s unacceptable ---
commit 484f6a2751436d7940ad4ac7d04ecc20b6162859
Author: Aniket <aniketmaurya@google.com>

PCI/ASPM: Clear L1SS capability when L1 latency is unacceptable

This commit updates pcie_aspm_check_latency() to clear PCIE_LINK_STATE_L1SS
from link->aspm_capable when L1 exit latency is unacceptable. This prevents
exposing L1SS sysfs control files when the link cannot use L1. Additionally,
it updates pcie_config_aspm_link() to check link->aspm_support to ensure L1
PM Substates are properly cleared in hardware if they were left enabled.

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 172783e7f519a..b2660892972a9 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but the ASPM sysfs show and store
functions fetch the link_state pointer locklessly and do not check for NULL
before dereferencing it.

drivers/pci/pcie/aspm.c:aspm_attr_show_common() {
    ...
	struct pci_dev *pdev =3D to_pci_dev(dev);
	struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);

	return sysfs_emit(buf, "%d\n", (link->aspm_enabled & state) ? 1 : 0);
}

Does this code risk a NULL pointer dereference?

If function 0 of a multi-function PCIe device is removed via hotplug or sys=
fs,
pcie_aspm_exit_link_state() frees the parent bridge's link_state.

If an unprivileged user then reads an ASPM sysfs file on a remaining functi=
on
(like function 1), pcie_aspm_get_link() will return NULL, causing an
unconditional dereference here.

[Severity: High]
Additionally, could a concurrent sysfs write result in a use-after-free?

drivers/pci/pcie/aspm.c:clkpm_store() {
    ...
	struct pci_dev *pdev =3D to_pci_dev(dev);
	struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);
	bool state_enable;

	if (kstrtobool(buf, &state_enable) < 0)
		return -EINVAL;

	down_read(&pci_bus_sem);
	mutex_lock(&aspm_lock);

	link->clkpm_disable =3D !state_enable;
    ...
}

If a sysfs write races with the removal of function 0, the link pointer is
fetched locklessly before taking aspm_lock.

If the removal completes and frees the link before the lock is acquired, the
write operation will dereference freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821134521.2211=
943-1-aniketmaurya@google.com?part=3D1
