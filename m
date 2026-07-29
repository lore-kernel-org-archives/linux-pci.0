Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9ED2DCF74
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 05:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785301653; cv=none; b=OP+8wO1yxtCRKFF7ehqzZJV79T6/bL4P/mXfLis06v2x0scRen4s4RI5m36JS/pvIYOmrmzqebE4DiLSlPPaizHFKdyiT19PpavrlnddpOazmFvE/byo8zEP1kXQuoyCzx8IRTr0LsZkMAhoDpaclGCS7VLZ6gMdPiYLvJJbHlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785301653; c=relaxed/simple;
	bh=Uvb31QcrId6cZtQxqZ2FwZgfHJPLneMwqECrHbipFGg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T5rpekvAixUS8bUhKD5tuDhT6jH/ajb8fONhgKVLroz+7YNLfkW43FM1yUnOYNmatQ7t8AV9jys7sa67UJDZz+E/M2JrIkERWhH2OzMzGkxQ5HJOvIyU324gWdWoBgcBLSPhEX8PBtuXcIr5bIJrodiC0C0JluJB1Ew7B0pNzdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwUWMrsS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwUWMrsS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36A81F000E9;
	Wed, 29 Jul 2026 05:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785301652;
	bh=2aI6kzuc4FCtbnGpW8h9zBj3pCP/PTpgYuFTwT+aLW0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KwUWMrsSsEUTtZZmThFrWOn6TiW0Ht0TnUcDDdBObXaFMSlH216zr9E4RgIgntBR7
	 L+hJJcQGnp1L2bbpJEzZvmrQMRxDYD/08i23/2+TvAGHomaO8UyWN8z7EzqNB+D8uW
	 tOZfLdxYSO7hr8hiWqqfm5B4yvXL+eK8zRLkWy9jB5LX6bETSbR37GRaRfyBA5Ut5G
	 aMq4O1UEvNXMX8ACwLSeUL5qGVLbp8bXRJovY947EnZ1+gHQQGElluWc+ZhcfL4kMa
	 /GNSaKe7iajrya3JtEC0yCR097Ya0sxdodMKTC6hqg5aeS3GjCsxAeYqyEEpYm6COQ
	 7Mg7uGtguoMnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/5] misc: pci_endpoint_test: Add AER error handlers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260729-pci-port-reset-v9-5-53570b92064d@oss.qualcomm.com>
References: <20260729-pci-port-reset-v9-0-53570b92064d@oss.qualcomm.com>
 <20260729-pci-port-reset-v9-5-53570b92064d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 05:07:31 +0000
Message-Id: <20260729050731.B36A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] AER error handlers do not abort pending tests, causing ioctl thr=
eads to hang permanently in D state.

Pre-existing issues:
- [High] A use-after-free vulnerability exists in the ioctl handler if the =
device is removed while a file descriptor remains open.
--

--- Patch [5]: [PATCH v9 5/5] misc: pci_endpoint_test: Add AER error handle=
rs ---
commit 1d34d50e68e455ba411f0fd8383353d65b5616cf
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

misc: pci_endpoint_test: Add AER error handlers

This commit introduces AER error handlers to the PCI endpoint test driver.
It adds functions to restore the configuration space and report the correct
recovery state when an error is detected.

> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
> index 3635741c3e7a7..b7a1497157008 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -1325,6 +1325,8 @@ static int pci_endpoint_test_probe(struct pci_dev *=
pdev,
>  	misc_device->parent =3D &pdev->dev;
>  	misc_device->fops =3D &pci_endpoint_test_fops;
> =20
> +	pci_save_state(pdev);
> +
>  	ret =3D misc_register(misc_device);

[Severity: High]
This is a pre-existing issue, but does this code have a use-after-free
vulnerability if the device is removed while a file descriptor remains open?

The test structure is allocated earlier in pci_endpoint_test_probe() using
devm_kzalloc(). If a userspace process has the misc device open and the
PCI device is unbound, pci_endpoint_test_remove() calls misc_deregister()
which doesn't block waiting for open file descriptors to close.

When the device unbinds, devres will free the test structure. If the
userspace process then calls ioctl(), pci_endpoint_test_ioctl() will retrie=
ve
the freed structure from file->private_data and dereference it when attempt=
ing
to acquire the mutex:

struct pci_endpoint_test *test =3D to_endpoint_test(file->private_data);
struct pci_dev *pdev =3D test->pdev;

mutex_lock(&test->mutex);

Could this be fixed by changing the lifetime management of the test structu=
re
or ensuring the teardown synchronization waits for open file descriptors?

[ ... ]

> @@ -1452,12 +1454,33 @@ static const struct pci_device_id pci_endpoint_te=
st_tbl[] =3D {
>  };
>  MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
> =20
> +static pci_ers_result_t pci_endpoint_test_error_detected(struct pci_dev =
*pdev,
> +					      pci_channel_state_t state)
> +{
> +	if (state =3D=3D pci_channel_io_perm_failure)
> +		return PCI_ERS_RESULT_DISCONNECT;
> +
> +	return PCI_ERS_RESULT_NEED_RESET;
> +}

[Severity: Medium]
Will this error handler leave tasks permanently hanging in D state if an AER
error occurs during a test?

Test functions like pci_endpoint_test_write(), pci_endpoint_test_read(), or
pci_endpoint_test_copy() initiate DMA and sleep on
wait_for_completion(&test->irq_raised) without a timeout while holding
test->mutex:

pci_endpoint_test_write() {
    ...
    wait_for_completion(&test->irq_raised);
    ...
}

If an AER error occurs during this wait, the newly introduced error handlers
execute to recover the link but fail to complete the wait queue. Since the
device state is reset, the expected interrupt never arrives, leaving the io=
ctl
thread stuck forever.

Should the error handler complete test->irq_raised to wake up pending ioctl
threads and abort the tests?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-pci-port-r=
eset-v9-0-53570b92064d@oss.qualcomm.com?part=3D5
