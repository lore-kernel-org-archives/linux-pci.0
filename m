Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F35B4A92D0
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188828; cv=none; b=hhDV8ZdSDLN8B8RxTh5DZcBiDm3jDf/EiMDEl5RGlbJi/uRbI9SYH7l92D7Joq2qHRfosQDXbHspAtaZtBKneZWZg2d4dM/vv5X2RydXE6Hn3mDfbBYWFPprPILpyPRe1J9ZZF5ptDv/E7VBQ2upOu0zMLaYz50QF+YCh5OEFsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188828; c=relaxed/simple;
	bh=RB+0oXosJFsNWrnjYNJmHRwUef7tHyv4yz11a16jEng=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VQ4KXajdy//fCa16Ej0jda1X5V8mi5Ju3gfT54q5T/IrC7Faw5W799Edjh15RAwXKcvUvdRtoAmkgdHuKWHuL8f02gjh1yuyBVLfgusxz6fzLowzsJYG59CvS2Egag/33Eo7c5S9/grdgsLunzO7nzCYXzaHYBjCP/JxlhuQiWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFse4cz3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFse4cz3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390631F000E9;
	Mon, 31 Aug 2026 15:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788188827;
	bh=4mwXdJ4IhvHtgxyeWLfU8MMr+BQppRPNQQ0Fm6oXKbY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kFse4cz3ZyvpjTBnVEPY8BX2AUjioFG5bJHwWyL91clleBSYVAkA5i3qynytbhNKj
	 D2M7ZJBF7IwrhacoJICymvqfVCPO/rlTNTXDFVeh7R43mqNC0IVpyvQJptazuKb2n5
	 FHG3Dt5qipNrtDvvcFBsQWVqDXaHGTfUWs2FnezZInYtOsKzkOL+ZSiKyUGynHx86W
	 LVMkHr9z3fyG0j8K2UThd0tslhcl38UwBniAyWeaCQ1A061hwP9FTIiqdlSrBocbJK
	 mmo8cqyf95FBDaaaTh6UO9kq0J3g0glcuf64DgY9mCCwKsAWBZyy4aE/rkK6koAnXj
	 uWF5esREOSA8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] misc: pci_endpoint_test: Validate BAR
 index in doorbell test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831133314.4125787-225-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-225-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:07:06 +0000
Message-Id: <20260831150707.390631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The newly added early return bypasses the COMMAND_DISABLE_DOORBE=
LL cleanup step, leaving the endpoint device in an inconsistent state and c=
ausing resource leaks.

Pre-existing issues:
- [Critical] The endpoint-provided `addr` offset is not validated against t=
he actual size of the BAR memory region, allowing an arbitrary out-of-bound=
s write.
- [High] The driver verifies the `bar` index bounds but fails to check if t=
he targeted BAR is actually mapped (non-NULL) before dereferencing it via `=
writel()`.
--

commit 7fede1d6ad3da3ad8055d4fe4ae5cd8853f975be
Author: Carlos Bilbao <carlos.bilbao@kernel.org>

misc: pci_endpoint_test: Validate BAR index in doorbell test

pci_endpoint_test_doorbell() reads the BAR number directly from an endpoint
test register and uses it as an index into test->bar[]. Add a defensive
bounds check before the dereference.

Link: https://patch.msgid.link/20260410230300.135631-2-carlos.bilbao@kernel=
.org

> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
> index 1c0fd185114fc..43e2282f8a76e 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -893,6 +893,11 @@ static int pci_endpoint_test_doorbell(struct pci_end=
point_test *test)
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
> =20
>  	bar =3D pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
> +	if (bar < BAR_0 || bar >=3D PCI_STD_NUM_BARS) {
> +		dev_err(dev, "BAR %d reported by endpoint out of range [0, %u]\n",
> +			bar, PCI_STD_NUM_BARS - 1);
> +		return -ERANGE;

[Severity: Medium]
In drivers/misc/pci_endpoint_test.c, does this early return in
pci_endpoint_test_doorbell() bypass the COMMAND_DISABLE_DOORBELL cleanup
step?

If a userspace application invokes the PCITEST_DOORBELL ioctl and the
endpoint reports an invalid BAR index, this early return skips sending the
disable command to the endpoint. It appears this leaves the device in an
inconsistent state and leaks the memory and MSI IRQs allocated when the
doorbell was enabled.

> +	}
> =20
>  	writel(data, test->bar[bar] + addr);

[Severity: High]
This is a pre-existing issue in pci_endpoint_test_doorbell(), but does this
code check if the targeted BAR is actually mapped before dereferencing it?

If a userspace application triggers the PCITEST_DOORBELL ioctl and the
endpoint returns a valid BAR index that was not successfully mapped during
probe (for example, if it was not an IORESOURCE_MEM), this writel() call
could result in a NULL pointer dereference.

[Severity: Critical]
This is also a pre-existing issue, but is the endpoint-provided addr offset
validated against the actual size of the BAR memory region?

A malicious or buggy endpoint can provide an arbitrary 32-bit addr offset
that exceeds the size of the mapped BAR. When writel() executes, it could
perform an out-of-bounds memory write, potentially corrupting adjacent
kernel memory or memory-mapped IO regions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-225-sashal@kernel.org?part=3D1
