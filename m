Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F02DECA1
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 01:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228499; cv=none; b=e8FruoJqGsvF+qUCny198l1gWhSfkL8D/USvPV3+Ye1Lz9FyJ/R/46XqfrVhaHIY4QpZiRq8EXF9FqhkL9BV4m1o/Nb5BJ6gCWhL+SrTyux+B/9uC+MRSYk6L6o7VvraQguwKOuoLXBg9p+9jsZfQBx3ED1JAYwLOFJpy0H8mGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228499; c=relaxed/simple;
	bh=rulNg115E3R+kaBr5HJXSoq3q365/BDtWhOxAJhnd0c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Th/5EkByDsq73Z2hPKIqW8pSmdYvwyZWilMHDwbK2lZ94KQb97g4d7f/CZmz3cfPmWrtuUNYa2fx9Bz6vPB30KJceA8XBzVGpFfbl2wFSgpmUZyVAINobN0qgHZczN9CFAsGudHDwp+Wbcb+LvTeQ5AV6g1A/9a3HJM+d+SgHKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4qarPCn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4qarPCn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204D61F000E9;
	Fri, 12 Jun 2026 01:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781228496;
	bh=X/iMufLjPDncYLXqyKR2nzQGmSt71maly0Kscm6iQ+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z4qarPCnKXJAebG0vOTuYVlRbrsgAauz/JpkVqFL+mEFppUilnbKmNAH4Xbd2sbQh
	 sZSdBkBMvyCuhngaSQjDsf4hbjrBDcoDtmgbp6Pt2MiEnFJsVwJvIO1fuKDmfC4kFn
	 hkkrVgkHCx2xINMLb/4+rQiAZXkWxTZn7JsP54xOr+itYO/CWCMaPn/bCqkbyNqCTV
	 kQFOtXso8nnaCzUiIYDe9j1f6gVZlj6tIXa7oIQMcyvsi+K7dbnKBTTQbf5qLI8GRK
	 46qhMPpZYz4vF++O5kFo7clwqCnB7tvAuIqKC8O01WiROwNKv6JiGbD3dKwMpgFK94
	 Z1LAQZnCwHBVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] Bluetooth: hci_core: Add reset_type parameter to
 hdev->reset() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chandrashekar Devegowda" <chandrashekar.devegowda@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260612012832.2395034-1-chandrashekar.devegowda@intel.com>
References: <20260612012832.2395034-1-chandrashekar.devegowda@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 01:41:35 +0000
Message-Id: <20260612014136.204D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] BTINTEL_PCIE_RECOVERY_IN_PROGRESS flag is never cleared on reset f=
ailure, causing a permanent deadlock of the recovery mechanism.
--

commit 01c1befdb681c2e10f544ce7e32e0eba288f218c
Author: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>

Bluetooth: hci_core: Add reset_type parameter to hdev->reset() callback

This patch adds a reset_type parameter to the Bluetooth hci_dev reset
callback, allowing userspace to specify whether to perform a Function Level
Reset (FLR) or a Product Level Device Reset (PLDR) via sysfs. Internal
callers are updated to default to FLR.

> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 9e39327dc1fe2..d3a03cf964216 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
[ ... ]
> @@ -2680,7 +2680,7 @@ static void btintel_pcie_reset_work(struct work_str=
uct *wk)
>  	pci_unlock_rescan_remove();
>  }
> =20
> -static void btintel_pcie_reset(struct hci_dev *hdev)
> +static void btintel_pcie_reset(struct hci_dev *hdev, u8 reset_type)
>  {
>  	struct btintel_pcie_data *data;
> =20
> @@ -2692,6 +2692,12 @@ static void btintel_pcie_reset(struct hci_dev *hde=
v)
>  	if (test_and_set_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags))
>  		return;

[Severity: High]
This is a pre-existing issue, but if btintel_pcie_reset_work() fails, does
the BTINTEL_PCIE_RECOVERY_IN_PROGRESS flag remain set permanently?

Looking at btintel_pcie_reset_work() in the same file, if
pci_try_reset_function() or btintel_pcie_setup_hdev() fail, the code jumps
to the out_enable label:

btintel_pcie_reset_work() {
        err =3D pci_try_reset_function(pdev);
        if (err) {
                BT_ERR("Failed resetting the pcie device (%d)", err);
                goto out_enable;
        }
        ...
        data->flags =3D 0;
        ...
out_enable:
        enable_work(&data->coredump_work);
out:
        ...
}

Because the error paths bypass the data->flags =3D 0 assignment, the
BTINTEL_PCIE_RECOVERY_IN_PROGRESS flag is never cleared. Would this cause
all future reset attempts (including the sysfs triggers introduced in this
patch) to be rejected indefinitely by the test_and_set_bit() check until
the module is reloaded?

> +	data->reset_type =3D (reset_type =3D=3D 1) ?
> +			    BTINTEL_PCIE_IOSF_PRR_PLDR : BTINTEL_PCIE_IOSF_PRR_FLR;
> +
> +	bt_dev_info(hdev, "Reset triggered: %s",
> +		    data->reset_type =3D=3D BTINTEL_PCIE_IOSF_PRR_PLDR ? "PLDR" : "FLR=
");
> +
>  	pci_dev_get(data->pdev);
>  	schedule_work(&data->reset_work);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612012832.2395=
034-1-chandrashekar.devegowda@intel.com?part=3D1
