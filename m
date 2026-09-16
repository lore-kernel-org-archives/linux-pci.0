Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCB73BA225
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789536201; cv=none; b=eN26rget62qnqprTJd1q8vJ32Qe/mAtrvNfTAXzRkhGLReBU4DlEly5pOHQxeZ1SmC2skX/Xz7T1IyiTaLtyTGnXET1GcP+Cv4dBtiS7V77M8XiwC6vrltNF81G4xgmNxu9bD70k0ETPV1ThSCDuqClqlH84VOywLHrPLB4Lyzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789536201; c=relaxed/simple;
	bh=JTsUR9nxKIRnss3amwohxmhi0MRQcW9MAQTBsZ2msdc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YR+vDGQJONPD2P3Qf1YPszn23npI7E+KKc96Q8FyHLow9OQHQlrSbGoCH6MrooEDOFV1tK44WVIAyB38pflNK2WLDaVUjt50vhKcH4ADo7ULHNV9uWv6Z1Jw1ZHp2KVDS5YQQu4+C6GLUa2K3xhuzkbl5zkV7fpNE/C4Zi0b0rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSB04ASv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSB04ASv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3E81F000FF;
	Wed, 16 Sep 2026 05:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789536200;
	bh=Pg3SMoGRUz6ETIR7KjfmKM0/cLqm6x2Y+FcU0Obtdjc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JSB04ASvM2v2+a4VNtjanjgDGdSE4lwky0+fmppm8eDy+DfKdOAIQ1yMX2B/kpTaC
	 B4xNVwc/6Q/9JwBpHCIQxqBqnYi5L6+8h0ITPMxgmvlKvF0t5M5+ocIR1p/1VkNYkH
	 Yp6JbrwpMXRR4dRTf5zqD7tLtoFE6THN4g/IY6SF5PtjwiEq+YkqTi7TQfetvN4SlR
	 Ucdrzhj/Le0wJwEFcKcvfITq+SmWWmz9zxnxGzqMbQAet1KdEqQhqwU9C3OhpSR8bi
	 Lt0TK1hy8jeD1EireeVoo1Wr3wnEmI6cg5qfK13at+ha9JokJbdfus21bJg8K7rxq9
	 dcSVpAbvbMnGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] PCI: Put PCIe bridges with downstream devices
 into D3 at hibernate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260916051034.180226-3-mario.limonciello@amd.com>
References: <20260916051034.180226-1-mario.limonciello@amd.com>
 <20260916051034.180226-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 05:23:19 +0000
Message-Id: <20260916052319.EC3E81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: config space corruption on hibernation abort due to missing D=
3 guard
--

commit 99f9dafa720163cc3dfac6ce20da883f888fb896
Author: Mario Limonciello (AMD) <superm1@kernel.org>

PCI: Put PCIe bridges with downstream devices into D3 at hibernate

During S3 suspend, pci_pm_suspend_noirq() puts PCIe bridges with
downstream devices into a low-power state. This commit aligns the
hibernate poweroff_noirq flow to use pci_pm_suspend_noirq_common(),
ensuring bridges with active children are also put into D3.

> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
[ ... ]
> @@ -1280,8 +1283,9 @@ static int pci_pm_poweroff_noirq(struct device *dev)
>  			return error;
>  	}
> =20
> -	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
> -		pci_prepare_to_sleep(pci_dev);
> +	skip_bus_pm =3D pci_pm_suspend_noirq_common(pci_dev);

[Severity: High]
Could this lead to configuration space corruption if a hibernation aborts?

If a driver's poweroff_noirq callback puts the device into a low-power
state (like D3) but fails to save its state, calling
pci_pm_suspend_noirq_common() here will unconditionally invoke
pci_save_state().

Because the device is already in D3, reading the configuration registers
in pci_save_state() will populate saved_config_space with 0xFFFFFFFF
garbage.

If the hibernation process subsequently aborts, the PM core executes
pci_pm_restore_noirq(), which will blindly write this 0xFFFFFFFF garbage
back to the device's configuration registers (BARs, command registers, etc).
This will likely cause a system crash upon subsequent memory-mapped I/O
access.

Does pci_pm_poweroff_noirq() need the same explicit D3 safety guard that
the S3 suspend_noirq path uses to prevent reading config space from a
powered-down device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916051034.1802=
26-1-mario.limonciello@amd.com?part=3D2
