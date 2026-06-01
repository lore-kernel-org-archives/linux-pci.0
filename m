Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00BC3955CF
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310671; cv=none; b=afLGBke9LCccnX53hfhxJucW+ra45w9TGHhLdS91DJNyECYnL09rlTPpiMJ4cDwFCSOQJTVMXRCNSj2gknedSaQcohVFyp2r3/eHJhHQA3L9sr7aEhiZkSB9r9TKdzZ+BQfw3eInS0pAGahdTSxDXfhKknnKlDgXBArBamprt94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310671; c=relaxed/simple;
	bh=KUSnXcQMRs9QouEsHT/osqShp7Ck408bw+Fp1qQ6O1k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nXKXKbuCKD5+fj/ocVHId51D8PMk8ETzNyrcsWtJVRIB8N4HWfRCZqnAMImrpFvQsh0GdOGX9LNa7v3A7DxXdAGlSMAQ7kfVavvsw+ffceD1KEgVtiO9jWNlKAUZlOQA1TtZORoiuUbW3og5hS7/bcx/7h3tTLZHTB8ZGvE6+64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmQUAwVt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmQUAwVt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176A21F00893;
	Mon,  1 Jun 2026 10:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780310665;
	bh=vsXtNPOW1/etY3tq779+zbCxtxWaA3x2hXWhdFZ9xV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bmQUAwVtKnuGdqtFyJFlS5E2oPAL0UZUOd5A8tvqP88c4yaxRKf9smntWkjk7zDu4
	 ID/A5XGoaQjUqnaPumt1CAizubtVKYqXrxvX5JQEtO15Bw6JjO+jUjZbck8BdDFxLY
	 /xGkqCJxTRzBY74s4AiziyJQVB0UHZIzkarmZ+zcdyxGWYcgNWKhW59L0AIZbQ3hHl
	 RadgvuwTStX8QHLH5JWbF7RfPHv/rD2Tsv7Op+WCKA9R+pNkrBhBjjD3uhSGR/iw5O
	 PPH3TH6wdancIlxoy6rH58sdVoTEJjE04i6OlwaoVZxPwX8cjoA20ONoI9vmyCTvBm
	 OoVc+qCGm1q2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Fix null pointer
 dereference in remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chandrashekar Devegowda" <chandrashekar.devegowda@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260601102612.2164388-1-chandrashekar.devegowda@intel.com>
References: <20260601102612.2164388-1-chandrashekar.devegowda@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 10:44:24 +0000
Message-Id: <20260601104425.176A21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup of IRQ vectors, workqueues, and DMA pools in the `=
btintel_pcie_probe()` error path.
- [High] `btintel_pcie_remove()` manually frees devm-managed IRQ vectors, l=
eading to a double free.
- [High] The `reset_work` work item triggers its own unbind, causing devres=
 to free the executing `work_struct`, resulting in a Use-After-Free.
- [High] An AB-BA deadlock occurs between external driver unbind (e.g., sys=
fs/rmmod) and the PLDR `reset_work`.
--

commit 0f003413fd62d93d0e1f8c538f87a5d224d42aab
Author: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>

Bluetooth: btintel_pcie: Fix null pointer dereference in remove

This commit adds a NULL check for pci_get_drvdata() in btintel_pcie_remove(=
) to
prevent a null pointer dereference. This can occur when btintel_pcie_remove=
()
is called concurrently from the PLDR device_reprobe path on another CPU, af=
ter
pci_set_drvdata(pdev, NULL) has already been executed.

> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index eba563b660904..eeaefffaaf6b5 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2694,6 +2694,10 @@ static void btintel_pcie_remove(struct pci_dev *pd=
ev)
>  	struct btintel_pcie_data *data;
> =20
>  	data =3D pci_get_drvdata(pdev);
> +	if (!data) {
> +		BT_WARN("PCI driver data is NULL, aborting remove");
> +		return;
> +	}
> =20
>  	/* Cancel pending reset work. Skip only when remove() is called from
>  	 * within the reset work itself (PLDR device_reprobe path) to avoid

[Severity: High]
This is a pre-existing issue, but does this PLDR reset_work flow cause an
AB-BA deadlock and a Use-After-Free?

First, regarding the deadlock: if an external unbind (like rmmod or sysfs)
happens concurrently with the PLDR reset_work, the external thread will acq=
uire
the driver core's device_lock(&pdev->dev) and call btintel_pcie_remove(). H=
ere,
it will call cancel_work_sync(&data->reset_work), which blocks waiting for =
the
workqueue thread to finish.

Concurrently, the reset_work thread executes btintel_pcie_perform_pldr() and
calls device_reprobe(&pdev->dev):

drivers/bluetooth/btintel_pcie.c:btintel_pcie_perform_pldr() {
    ...
    if (!ret) {
        if (device_reprobe(&pdev->dev))
            BT_ERR("BT reprobe failed for BDF:%s", pci_name(pdev));
    }
    ...
}

This reprobe attempt will try to acquire the exact same device_lock(&pdev->=
dev)
to unbind the driver. Both threads block waiting for each other.

Second, regarding the Use-After-Free: when reset_work successfully triggers
device_reprobe(), it synchronously unbinds the driver. Since current_work()
matches, cancel_work_sync() is skipped. When the unbind completes, all
devm-managed resources, including the data structure allocated via
devm_kzalloc, are freed.

When the worker thread resumes execution and the work item function returns,
the kernel workqueue core will access the now-freed work_struct embedded
within data, causing a Use-After-Free. Does this need to be restructured so
the work structure isn't freed out from under the executing thread?

[Severity: High]
This isn't a bug introduced by this patch, but does the manual IRQ free loop
later in btintel_pcie_remove() cause a double-free?

drivers/bluetooth/btintel_pcie.c:btintel_pcie_remove() {
    ...
    for (int i =3D 0; i < data->alloc_vecs; i++) {
        struct msix_entry *msix_entry;

        msix_entry =3D &data->msix_entries[i];
        free_irq(msix_entry->vector, msix_entry);
    }
    ...
}

The IRQs in btintel_pcie_setup_irq() are allocated using the device-managed=
 API
devm_request_threaded_irq(). The devres subsystem will automatically release
them after the device is unbound.=20

By manually calling free_irq() here, the IRQ handlers are freed but their
devres tracking records remain intact. When devres cleanup subsequently run=
s,
it will call free_irq() again on the already-freed IRQs. Can we remove this
manual free_irq() loop to let devres handle the cleanup?

[Severity: High]
This is also a pre-existing issue, but does the btintel_pcie_probe() error
path leak IRQ vectors and workqueues?

If a failure occurs during initialization in btintel_pcie_probe(), the code
jumps to the exit_error label:

drivers/bluetooth/btintel_pcie.c:btintel_pcie_probe() {
    ...
exit_error:
    /* reset device before exit */
    btintel_pcie_reset_bt(data);

    pci_clear_master(pdev);

    pci_set_drvdata(pdev, NULL);

    return err;
}

This error path fails to free the ordered workqueue allocated via
alloc_ordered_workqueue(), the IRQ vectors allocated via
pci_alloc_irq_vectors(), and the DMA pool. Should pci_free_irq_vectors(),
destroy_workqueue(), and DMA pool cleanup be added to the exit_error path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601102612.2164=
388-1-chandrashekar.devegowda@intel.com?part=3D1
