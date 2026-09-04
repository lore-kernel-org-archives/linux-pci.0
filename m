Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D41237B40C
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 02:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490498; cv=none; b=O7yMfTo/Cw9KCenhGbtat19kgT4eOV8EhCUr8bHVdoNYQb9U5PiVmRuOG6iyi03lQeKKsc8UJWBtL07JwzpNMjg1+DKLpli/ZhnTHatAhABkq8RZk7/0tbTDSgWcNogYnPSOfsvqHUj+yqqxGh5ymrPXyv7EmmfOHbb+VzDzyk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490498; c=relaxed/simple;
	bh=bkkCvfRWwBrZWo5iBlZzyVu/jkc9+lgqES8HTvyYpu4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V5xufnc47EX1KyuipQcWDZ0h+nk0P28lWX4sOhfSlm29BuxcY0+dxUP8o6kCvCkGwxbTLlf5zRxt9IbAGZ+qF0kkPpjszupBExf1bTwHnh9PnAG5iuI2Sd1CUCZu53HuDeSfRDxou28slSHmKib2UUXMXqSyLqYF/o3Cj/Ftu8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4OW0q/w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4OW0q/w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279D31F00A3D;
	Fri,  4 Sep 2026 02:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490497;
	bh=cTPmI1lPC4Vzw4+L0apM2zD39DqtGU+gL+2ahZAw+0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a4OW0q/wwH4uKlTDB87LZ9SdzsKSOkjL0NaXpgebJ5e0NYkYjnWLfh/ypd1oqQbH9
	 mMLSXxbhFCZcxOJtNFLbqMEoWsGGduha4waQaD+mbIm+olmysMw11V1RaAgtKbC9J1
	 cNqim8y9RS+7566XWlFxyfuxCfhK9UEpr6X0CubyFkX0gyL729ClxdED6QFH20kpuQ
	 04TvLD0vL6AzlCceB/LN3gY9eP9Uz6DRSJc3WTfa9vlRO6xdcDWG9mlL7tnqgciVmt
	 2bGlTy1GG2xCZdyw5IED5sM3Taw03f4XbjKE++XRweuhCa6EPtMXMlkzoOskIsWlPc
	 I2OBlySbfcB/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] PCI/ASPM: Add pci_aspm_inhibit() helper for
 temporary link state suppression
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260904-pcie-link-endpoints-v2-2-16fcb301a3e4@google.com>
References: <20260904-pcie-link-endpoints-v2-0-16fcb301a3e4@google.com>
 <20260904-pcie-link-endpoints-v2-2-16fcb301a3e4@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 02:54:56 +0000
Message-Id: <20260904025457.279D31F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, pci_disable_link_state() permanently disables ASPM on a PCIe
> link by setting link->aspm_disable. However, several kernel subsystems
> and driver operations require temporary ASPM inhibition without
> permanently disabling power management:
>   - PCIe Lane Margining at Receiver (LMR): receiver testing requires
>     the link to remain continuously in L0 throughout the test duration.
>   - Device firmware updates (e.g. NICs and NVMe controllers): link
>     latency or L1 transitions during firmware flashing can disrupt
>     device communication.
>   - Secondary Bus Reset and link retraining sequences: prevent
>     unexpected L1/L1SS entry during link reset and recovery.
>=20
> Because pci_disable_link_state() cannot be reversed by
> pci_enable_link_state() to clear link->aspm_disable, drivers previously
> attempted manual manipulations of PCI_EXP_LNKCTL (ASPMC). This
> [ ... ]
>   - When all inhibitors have released (aspm_inhibit_cnt =3D=3D 0), restor=
es
>     the configured ASPM policy to hardware (Upstream Component before
>     Downstream Component per sec 7.5.3.7 & Table 7-24).
>=20
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-pcie-link-=
endpoints-v2-0-16fcb301a3e4@google.com?part=3D2

