Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E2740EBB6
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791802613; cv=none; b=EhMohLzusCShQRrlLQoLkQ6QbErZdIl4HaPjdDvl9TVhugxG6eXX/uujiWwTtXnK0is38dpTDkiN0tDLRzjSpBavXJ6xdHAvPWxkIqjp5wj173UPFmwwZX5FWAHUVxIElc2sp6ot8adInFeQFl9q2Aeeep2rW4IOl/NM7awtqhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791802613; c=relaxed/simple;
	bh=AVD3dBl+AYawyth9PDe39JDtzZdAhskfKPHsXWj25P4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZKOEi2gFpxcpz4/gkAZo9mqz5V5E4gqLS8MpXOBeoivbrkV+UtYgkGkdlTAehnIO9vvj16Ef6uW8Ac5wYT2ZJ9NhnprjhAKGABbR8QavG9pf46nzV7RIeuY/vXIsFdU98Gu254QNq8gilgnbdlJ4ZIcFGAo53wVBusvenDQMsgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bhki72x1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bhki72x1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECF41F0089B;
	Mon, 12 Oct 2026 10:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791802612;
	bh=kN2cfVYcckdnpeu97uCUhkOmd8vOCiG0gwNo/G8sUGk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bhki72x1SkYPstH89TNE1T7+6wP9IIGQZvICDIDx+3zAQUsLRGsPy9IswMHVkrmZQ
	 tlHAnTvXlTxMUrbEv05SCrqVdAhQ/7Cd7WregxSKr5yxFyKlsdKxa23TF25RkT9BtL
	 5TmiXPRZbZ2XSd1FtxU6rxIfy8DqTwJlMDCU33829bzumVpGKmrIsGz1+ScPTrd0ll
	 nq2kEH5g/hFOMGuIUm274SQWlYP1MLExhRafZ2YKEkG3ETwPrcKG1lP7+OLX0ttKbv
	 xop8uxg6r/hAi/OgqvpwpHODTAO7lKP+3wbJA0OfJjZOqnMO1Kn7+1zbbyQ0kVATpx
	 jlsCxd7t02lbw==
Message-ID: <sashiko-outbox-167997@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI/PM: Restore BARs after powering up during
 enumeration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Keng-Yu Lin" <keng-yu.lin@hpe.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261012104645.975190-1-keng-yu.lin@hpe.com>
References: <20261012104645.975190-1-keng-yu.lin@hpe.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 10:56:51 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Commit 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
> initializing") added pci_pm_power_up_and_verify_state() to pci_pm_init().
> The helper ignores pci_power_up()'s return value indicating that BARs
> need restoring.  Its resume callers restore saved configuration
> afterwards; pci_pm_init() does not.
>=20
> D3hot-to-D0 may reset a device and lose its BARs (PCI PM 1.2, sec 5.4.1).
> After enumeration powers it up, pci_enable_device() reads D0 and skips
> the full power-up path.  Previously, a device still in D3hot at enable
> time took that path, including BAR restoration.
>=20
> On AMD Venice SP7, two AMD xHCI controllers [1022:17d2] are in runtime
> D3hot with No_Soft_Reset clear before kdump.  Diagnostic reads on
> v7.3-rc6-37 show the following for 0000:01:00.4 in the crash kernel:
>=20
> [ ... ]
>=20
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializi=
ng")
> Cc: stable@vger.kernel.org
> Signed-off-by: Keng-Yu Lin <keng-yu.lin@hpe.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012104645.9751=
90-1-keng-yu.lin@hpe.com?part=3D1

