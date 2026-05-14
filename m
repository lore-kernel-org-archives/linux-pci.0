Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3764C3A6B76
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 22:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778799226; cv=none; b=MS0AKmewg19FbbSC9ltMEfJ0lg0pPMohPZ3Jolf3ghGLBne5d0tQMlVd/1rt/1uE46QXLPcf7AqPY2x5MzP/m8U+IIuxUyoLSN9lnRbZiMv0zlvtY3TFcJnktQ7mlYJYTp7CGvibQcOes3DIwi/XaC81JuRxbfHgSUmrKylVs6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778799226; c=relaxed/simple;
	bh=ozREo/sQ6t0mL1sdsScRqqLoNACLzZ5mPjx0qACvXdM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C0sYjJeVEDjiwd6ImzehdBmIcr1Wbzq/fVU7iiqGjecz+oJdyex1ZjDqpOleuwY785pLOOxKXfxzsiXqD2mtOpfAcgn3UPDduU4vNWow6DCj/gu2vvudkfTg48V0AtUFy7RpVFIMdO764pzLEyvOSOOhI71/gYPVfSY/vWALj90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmJw3gNV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmJw3gNV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA866C2BCB3;
	Thu, 14 May 2026 22:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778799225;
	bh=ozREo/sQ6t0mL1sdsScRqqLoNACLzZ5mPjx0qACvXdM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cmJw3gNVb6Jfly8A/cu32tusmo+eSPAblLLEykK7CFWA1WenQi52yCQTAHJ3u9/aj
	 m1WnFLbEA2BtGGMc0L1/7r2mvlBAk6UF49vl3UYTY8CoityFV8WXlwIFeVsnWbuDXn
	 xL+hecNFRQC0YyaMj77I9m+M7HPESxMTZNwYykbKTQINmDIaHFYUc0qxloU9Oag8l4
	 BkYPPtko1FhxoiRcxxIHs3Qa0pqDl365Mc/QesI+DgEQ7Mvm585K9c8ujI58oHmMeP
	 O1IDwodD5DwYI6/9/kvfCc09702bCynwkILKcQWmb6Dx+QF1yT+1a0uc1RDOY2HlqX
	 CqNfwtOi4vGLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 4/7] s390/pci: Store PCI error information for
 passthrough devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260514180059.1553-5-alifm@linux.ibm.com>
References: <20260514180059.1553-5-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 22:53:45 +0000
Message-Id: <20260514225345.BA866C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unlocking an unheld mutex causes kernel panic.
- [High] Passthrough devices incorrectly fall back to host-level recovery i=
f the error queue is full.
--

commit 016a2e8c9545102f4de3d94db360fafe625fa60b
Author: Farhan Ali <alifm@linux.ibm.com>

s390/pci: Store PCI error information for passthrough devices

This commit introduces a mechanism to store PCI error information for
passthrough devices on s390x so userspace can handle recovery. It removes
the dependency on struct kvm_zdev to detect passthrough devices and
introduces pending error tracking.

diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 839bd91c056e5..ad273decb1c2b 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
[ ... ]
> +static int zpci_store_pci_error(struct pci_dev *pdev,
> +				 struct zpci_ccdf_err *ccdf)
> +{
> +	struct zpci_dev *zdev =3D to_zpci(pdev);
> +	int i;
> +
> +	guard(mutex)(&zdev->pending_errs_lock);
> +	if (!zdev->pending_errs.mediated_recovery)
> +		return -EINVAL;
> +
> +	if (zdev->pending_errs.count >=3D ZPCI_ERR_PENDING_MAX) {
> +		pr_err("%s: Maximum number (%d) of pending error events queued\n",
> +		       pci_name(pdev), ZPCI_ERR_PENDING_MAX);
> +		return -ENOMEM;
> +	}
[ ... ]
> @@ -216,12 +223,23 @@ static pci_ers_result_t zpci_event_attempt_error_re=
covery(struct pci_dev *pdev)
>  		goto out_unlock;
>  	}
> =20
> +	mediated_recovery =3D zpci_store_pci_error(pdev, ccdf) =3D=3D 0 ? true =
: false;

If zpci_store_pci_error() returns an error, such as -ENOMEM when the pending
error queue reaches ZPCI_ERR_PENDING_MAX, mediated_recovery evaluates to fa=
lse.

Will this cause the function to bypass the passthrough early exit and fall
through to the host-level error recovery mechanisms below?

It appears this could result in a host-initiated reset on a device actively
passed through to userspace, which might break passthrough isolation.

> +
>  	ers_res =3D zpci_event_notify_error_detected(pdev, driver);
>  	if (ers_result_indicates_abort(ers_res)) {
>  		status_str =3D "failed (abort on detection)";
>  		goto out_unlock;
>  	}
> =20
> +	if (mediated_recovery) {
> +		pr_info("%s: Leaving recovery of pass-through device to user-space\n",
> +			pci_name(pdev));
> +		ers_res =3D PCI_ERS_RESULT_RECOVERED;
> +		status_str =3D "in progress";
> +		mutex_unlock(&zdev->pending_errs_lock);

Does this unlock a mutex that is not currently held?

The zdev->pending_errs_lock is acquired and automatically released within
the scope of the zpci_store_pci_error() helper function using the
guard(mutex) macro.

Attempting to unlock an already-unlocked mutex usually results in a kernel
panic or lockdep warning.

> +		goto out_unlock;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514180059.1553=
-1-alifm@linux.ibm.com?part=3D4
