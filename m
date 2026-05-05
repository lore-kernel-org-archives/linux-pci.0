Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0520531717C
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 20:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778013412; cv=none; b=ORuCqK63hNMHvNo1QmbNK1lKhGTcNVVgkQW3kgcGHtHItdzc3xuwTIo3upF1nnGwScXDRjGEadfx0Ocwe4WfJ+4lKevRzcCURi9HjQXskuyyIYRBYz1+l7h8SLSXBF9ND5bwKjFCKUCoYNQ6OK49Q1K/SnHL7kOxjxFOJpLSxiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778013412; c=relaxed/simple;
	bh=Bl4EzR+RDEf6NeV287iKQmvj4GAWe1mSiV8FLmhGBDg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dbojww/S77gQpxKMtHc5PXKp6p1NFpA6sYRSpPSYaIfa2tqv6v72cmRNksk7q5i0GpbWCXmj9k9zwdye1Ge5xexdXSoUsmwarOKPW0mjCg4lKdRS23AyyUXUYAffNCQq7i27MuYStArSTWuMz2FOYCFRUc6c9Vyzgoey4vc2s1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpEp1D1H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpEp1D1H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D631C2BCB4;
	Tue,  5 May 2026 20:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778013411;
	bh=Bl4EzR+RDEf6NeV287iKQmvj4GAWe1mSiV8FLmhGBDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=EpEp1D1HcFD8wRoHKBk6j8nArhBEbM3N3Knz009aBSACj/8g9Wl5wHCzdPAlih14y
	 SSMasXVzlZYTEY1Ue2MezWP/QxwIVYw//9ajs6JYQ3n8NvtZJvSsPx/uYhdvo4LvvS
	 INtWE8rS1DFsrnE58cqjhEUeuPLfZOPEDcJ/2RQCIJ0zx72Fg37cASKLaToz9j/k7l
	 KSeTXLY425q5eF/lwh6IJse59R4SH+M54FANgWCmtulyw2hJVOZ3ZFsryPy2ESZjzB
	 3UkidyYsTteVZl3IFiSQgA0UTBg7FmMsnSHULVGHWKsAxTgx4RrABve2R9YcsytKUy
	 9P3jxiA6SjpzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] PCI/IOV: Restore initial VF ReBAR sizes on SR-IOV
 disable/failure
Reply-To: sashiko@lists.linux.dev
To: "Marcin Bernatowicz" <marcin.bernatowicz@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260505170010.3414074-3-marcin.bernatowicz@linux.intel.com>
References: <20260505170010.3414074-3-marcin.bernatowicz@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 20:36:50 +0000
Message-Id: <20260505203651.6D631C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Early error returns in sriov_enable() bypass the newly introduced =
sriov_restore_vf_rebar_initial_sizes() cleanup.
--

commit 4da183a318507a36de3ca157ee8755ad1eec90ca
Author: Marcin Bernatowicz <marcin.bernatowicz@linux.intel.com>

PCI/IOV: Restore initial VF ReBAR sizes on SR-IOV disable/failure

This commit introduces a mechanism to restore the initial VF BAR sizes when
SR-IOV is disabled or when enabling it fails. This prevents the PCI core
from persisting inflated VF BAR sizes, which can lead to MMIO space exhaust=
ion.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5937

> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 217e133a38c73..a05c1be388d2f 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c

[ ... ]

> @@ -687,36 +721,42 @@ static int sriov_enable(struct pci_dev *dev, int nr=
_virtfn)
>  	}
>  	if (nres !=3D iov->nres) {
>  		pci_err(dev, "not enough MMIO resources for SR-IOV\n");
> -		return -ENOMEM;
> +		rc =3D -ENOMEM;
> +		goto err_restore;
>  	}

Should the earlier error returns in sriov_enable() also jump to err_restore?

There are early validation checks before this point that return directly:

drivers/pci/iov.c:sriov_enable() {
    ...
	pci_read_config_word(dev, iov->pos + PCI_SRIOV_INITIAL_VF, &initial);
	if (initial > iov->total_VFs ||
	    (!(iov->cap & PCI_SRIOV_CAP_VFM) && (initial !=3D iov->total_VFs)))
		return -EIO;

	if (nr_virtfn < 0 || nr_virtfn > iov->total_VFs ||
	    (!(iov->cap & PCI_SRIOV_CAP_VFM) && (nr_virtfn > initial)))
		return -EINVAL;
    ...
}

If an early exit occurs here, the hardware BAR remains inflated and
iov->num_VFs remains 0.

Because iov->num_VFs is 0, subsequent cleanup calls like pci_disable_sriov()
during driver teardown or system shutdown will bypass the restore logic due=
 to
the early return in sriov_disable():

drivers/pci/iov.c:sriov_disable() {
	struct pci_sriov *iov =3D dev->sriov;

	if (!iov->num_VFs)
		return;
    ...
}

Will this leave the hardware BAR permanently inflated across kexec or warm
reboots, potentially leading to the MMIO space exhaustion this patch aims to
fix?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505170010.3414=
074-1-marcin.bernatowicz@linux.intel.com?part=3D2
