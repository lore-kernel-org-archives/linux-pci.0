Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5201F42D769
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414839; cv=none; b=Nfirzvj21DfNAkthdegBDkTvIfMVjZLHp/h4HUdOvp5hCsS5IaAf6gsxPcwytHty6Y4Vwq7jf6nrf0RVgs2/c5jOiAs+bYRxKynUEVJe4EU+JoJoXwaD0cuJrlBJB0MqKW3DY4SE9HL2H4PFdookA8FT9zMP9wXEh9n6hmG5G4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414839; c=relaxed/simple;
	bh=aw9ICOYeL7e2UG+o6vTAHHFj46YRc9IeNmP4GCmHmYU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fnDlrdhLedqPoWbW3dX1jmU6LVMhZHD9Ks6ykx2G7cIN3fK8IccpSrKP8EQ2LHmCLieOnFDrkrGpr/6Cx455wfcivjvnfzBdGCIibBazLzf7Q0OlRxOUv1A2ekZQDEoYsnB15Bo8vSht/vRio0RTh/i1nDxR+9CIIB8A2Jo7nro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXEFYY9k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXEFYY9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D349F1F000E9;
	Thu, 30 Jul 2026 12:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785414838;
	bh=UBRUM2am88SRPRm+qZeF6r2XjzzGjCIuJnCmvwSczf0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AXEFYY9kkYh+Li9Yu+0dmH41RCl4r+pBIhhnj/asHlyuSR4CS+4clxHl7Pdax24hX
	 YPRGEhS6m7MNmljIx6Uj8WpuxthmLNmVUVufd0OI6j1eVRHER1hKJDgVjpqBozH1c1
	 W5kzHObSGQ5EOVzAM+qoZMRzd82jlbiReHh6uwofO0BhHwVQ6SuaoUkyLu/b77+c5X
	 OjOJTmwv8/5VfSZ+mc1xR3Z1y7dssLoD2ueuNA/uLTkfDlZqTay22r8mGZkw3mKZAd
	 0lZy0C5A1g8UUQ/O3PsfhAuI/C4kP+mP71BTD2RLy9/LR3QyjnhyNI4vx8mxdOreZT
	 iLhZI7gRyMFsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] misc: pci_endpoint_test: Improve logic to check
 status for doorbell test case
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260730122045.1382749-6-cassel@kernel.org>
References: <20260730122045.1382749-4-cassel@kernel.org>
 <20260730122045.1382749-6-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 12:33:57 +0000
Message-Id: <20260730123357.D349F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] PCIe surprise removals masked by incorrectly evaluating an all-1=
s read as success.

Pre-existing issues:
- [High] Unvalidated endpoint input leads to NULL pointer dereference and o=
ut-of-bounds MMIO write.
- [High] Race condition between module teardown and active ioctls leading t=
o double-free or UAF of IRQ vectors.
- [High] Unbounded, uninterruptible waits on endpoint interrupts create unk=
illable tasks and a global ioctl deadlock.
--

--- Patch [2]: [PATCH 2/2] misc: pci_endpoint_test: Improve logic to check =
status for doorbell test case ---
commit e34bb71884c618c46be8a57cc0405805a9d2c585
Author: Niklas Cassel <cassel@kernel.org>

misc: pci_endpoint_test: Improve logic to check status for doorbell test ca=
se

This patch modifies the doorbell test case to verify if the SUCCESS bit was
set rather than checking if the FAIL bit was set. This handles cases where
an IRQ timeout occurs or buggy EPC drivers send multiple IRQs.

> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -1094,7 +1094,7 @@ static int pci_endpoint_test_doorbell(struct pci_en=
dpoint_test *test)
>  	left =3D wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffie=
s(1000));
> =20
>  	status =3D pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> -	if (!left || (status & STATUS_DOORBELL_ENABLE_FAIL)) {
> +	if (!left || !(status & STATUS_DOORBELL_ENABLE_SUCCESS)) {

[Severity: Medium]
If the PCIe endpoint surprise-disconnects or the link goes down, MMIO reads
like pci_endpoint_test_readl() will return all-1s (0xFFFFFFFF). By checking
!(status & STATUS_DOORBELL_ENABLE_SUCCESS), an all-1s read evaluates as true
for the bitwise AND, making the logical NOT false.

Does this inadvertently bypass the error handler during a hardware failure?

[ ... ]

> 	bar =3D pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
> 	if (bar < BAR_0 || bar >=3D PCI_STD_NUM_BARS) {
> 		dev_err(dev, "BAR %d reported by endpoint out of range [0, %u]\n",
> 			bar, PCI_STD_NUM_BARS - 1);
> 		return -ERANGE;
> 	}
>=20
> 	writel(data, test->bar[bar] + addr);

[Severity: High]
This is a pre-existing issue, but is it possible for a buggy or malicious
PCIe endpoint to provide a BAR index that was never memory-mapped by the
host (where test->bar[bar] is NULL), or provide an excessively large addr
offset via PCI_ENDPOINT_TEST_DB_OFFSET?

Could this lead to a NULL pointer dereference or an out-of-bounds MMIO write
if test->bar[bar] or addr are not validated before the writel() call?

[ ... ]

> @@ -1133,7 +1133,7 @@ static int pci_endpoint_test_doorbell(struct pci_en=
dpoint_test *test)
> =20
>  	status |=3D pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> =20
> -	if (status & STATUS_DOORBELL_DISABLE_FAIL) {
> +	if (!(status & STATUS_DOORBELL_DISABLE_SUCCESS)) {

[Severity: Medium]
Similarly here, if the read returns all-1s due to a disconnect, will this
falsely indicate success and bypass the error handler?

[ ... ]

> static void pci_endpoint_test_remove(struct pci_dev *pdev)
> {
[ ... ]
> 	pci_endpoint_test_release_irq(test);
> 	pci_endpoint_test_free_irq_vectors(test);
>=20
> 	misc_deregister(&test->miscdev);

[Severity: High]
This is a pre-existing issue, but is there a race condition here between
module teardown and active ioctls?

If IRQ resources are released before misc_deregister() and without acquiring
test->mutex, could an existing open file descriptor execute an ioctl
concurrently, leading to a use-after-free or double-free of IRQ vectors?

[ ... ]

> static bool pci_endpoint_test_copy(struct pci_endpoint_test *test)
> {
[ ... ]
> 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> 				 COMMAND_COPY);
>=20
> 	wait_for_completion(&test->irq_raised);

[Severity: High]
This is also a pre-existing issue, but does this unbounded wait create a
potential local denial of service?

If a user issues an ioctl (like PCITEST_COPY), the driver holds test->mutex,
sends a command to the endpoint, and waits here. If the endpoint
malfunctions and never fires the IRQ, will the calling task become an
unkillable zombie in TASK_UNINTERRUPTIBLE while holding the device-wide
mutex indefinitely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730122045.1382=
749-4-cassel@kernel.org?part=3D2
