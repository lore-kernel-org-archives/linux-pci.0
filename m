Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB703C063E
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624052; cv=none; b=p7f20T/kQt+MuxgMnhaGs2QiHUObJudvcqiT5PttLhT6flLXdc8gbMy/zab+zofuN4a602F3VSi/hA/opeXUUXiiHy2MFk46LAg7RmRMu3tjMZ/pMgrJmmEhjUiidGSiqVQ8X3O4HRFQraWVvaAxrgLXQU21qx7sC4dsqXNE3Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624052; c=relaxed/simple;
	bh=f+9i5dEZ4dM3O8i1O0m5/V0gXbRg7EDtKmwosRrg1vE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nkR/DWYG/dYvCJwquE7H5SNYnz2P7rpQBMnRNummhKyjG6ZW2/PrZSBDQNeiD2I4TMsQMGHdVkYQ+8HVyhTnPl8orWcF2bB1Ct99bqmjSoFsJ1Co92+bmHy/zk9CRMRqecoqwazNUK08Vyi/UzJ5XnPMYgIS5pfWtEbriAzVTx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A81JPRGP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A81JPRGP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19A11F000E9;
	Thu,  9 Jul 2026 19:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783624051;
	bh=Emjfd5TILLFL0SdjCs21JQidKV5m6A1Ak+peWAGf64s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A81JPRGPABTzIcnsqLROcvdGk69239X6fzvhX5WNebwtVMkKo9jHQG15rpwI14oh4
	 8PArcmyXcn+iLplLSk61sHzOgAri9DbCt+Fke7g7gFwdZm96VqXQcx56KtgyB1hrkq
	 we0nyEZOR/64LLw5ItBAuumwqR9rjeY2Uv3MZLeK/RI+GstbrsebagaTr6zu6PdZPK
	 IBJAB39YKCotYzOPPd0v6P9tit3z9LoTqJKUhhYjVDwjeKjioZJvsLVQJAiD374Vuw
	 VS8o/LJlvY6Zu9nY/MvVGodD/jbBAP69bHO6VcXZmHRQ6abi4MDLjdrBKtAwG70v00
	 zq5PBPXfbCQIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI: Add pci=nodpc kernel boot option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Murashka" <yurypm@arista.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260709185429.627968-3-yurypm@arista.com>
References: <20260709185429.627968-1-yurypm@arista.com>
 <20260709185429.627968-3-yurypm@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 19:07:30 +0000
Message-Id: <20260709190730.E19A11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `pci=3Dnodpc` parameter disables native OS DPC but still claim=
s DPC control via ACPI `_OSC` and enables it via `_DSM`, causing permanent =
unhandled link errors.
--

--- Patch [2]: [PATCH v2 2/2] PCI: Add pci=3Dnodpc kernel boot option ---
commit 9eea006773bbca0de0b0f501e83971ad7b74166e
Author: Yury Murashka <yurypm@arista.com>

PCI: Add pci=3Dnodpc kernel boot option

This patch introduces the pci=3Dnodpc kernel boot option to disable PCI
Downstream Port Containment (DPC). When specified, DPC initialization,
state operations, and driver registration are bypassed, allowing userspace
to handle PCIe errors.

> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 2b779bd1d861b..759d9f18812ee 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
[ ... ]
> @@ -404,6 +411,9 @@ void pci_dpc_init(struct pci_dev *pdev)
>  {
>  	u16 cap;
> =20
> +	if (pcie_dpc_disable)
> +		return;
> +

[Severity: High]
Does returning early here leave pdev->dpc_cap as 0 and cause issues with Er=
ror
Disconnect Recover (EDR)?

When pci=3Dnodpc is set, calculate_control() in drivers/acpi/pci_root.c sti=
ll
requests DPC control from firmware based solely on the compile-time flag:

drivers/acpi/pci_root.c:calculate_control() {
    ...
	if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
		control |=3D OSC_PCI_EXPRESS_DPC_CONTROL;
    ...
}

And pci_acpi_add_edr_notifier() in drivers/pci/pcie/edr.c unconditionally
enables DPC in hardware:

drivers/pci/pcie/edr.c:pci_acpi_add_edr_notifier() {
    ...
	if (acpi_enable_dpc(pdev))
		acpi_remove_notify_handler(adev->handle, ACPI_SYSTEM_NOTIFY,
					   edr_handle_event);
    ...
}

If a PCIe error occurs and ACPI firmware notifies the OS, edr_handle_event()
will trigger but immediately abort because edev->dpc_cap is 0:

drivers/pci/pcie/edr.c:edr_handle_event() {
    ...
	if (!edev->dpc_cap) {
		pci_err(edev, FW_BUG "This device doesn't support DPC\n");
		goto send_ost;
	}
    ...
}

Will this cause EDR to abort recovery, incorrectly log a firmware bug, and
permanently abandon the link instead of letting userspace handle it?

>  	pdev->dpc_cap =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
>  	if (!pdev->dpc_cap)
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709185429.6279=
68-1-yurypm@arista.com?part=3D2
