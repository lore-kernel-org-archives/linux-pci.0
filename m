Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DD89463
	for <linux-pci@vger.kernel.org>; Sat, 27 Jun 2026 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782545904; cv=none; b=RXBthSON4hDEThgPUufu8oZPihe56D9iuzQFxr66wHP7p9ff1m0He3lhotCo3qT5ah9Wd3V5FgMBZPEwAoI0akv79bmO4y22jDY0jd3yUmF7+VNSimGQkc0VSJCVic4HL5ryRP5b2yXRiSqJel9/dtqIZ+H2vnScaUA25rAFfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782545904; c=relaxed/simple;
	bh=a5mL9grplLRS79eQFGeR77oquENOH0IuIRrQS89mFmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkuqls88ujHYb15DH97vErCY49swMxuPJPP2VxyX8JLrGX3xPNJ1fMwV0l97/y8vcAaZcWU1AwO4jz0PppSrIGS4Ox3o7iXox29Hm/eb2wlgkN6vKzuZHEbv54Xex3SYf9cx8SkUVkx4n13LwMYJKOa6NQLn/usFnzNI3O/+JCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2/f/yzQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2/f/yzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956061F000E9;
	Sat, 27 Jun 2026 07:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782545902;
	bh=AdiDt3k3gJpZ7oiQWlHFqrq17RWTiI6WgatsDL4o4fI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H2/f/yzQ4UJ2f44hO7zipo3TvOFZnzuA5TBq6EXnOt5KP8BNMRz+EpKcKG7znp8DZ
	 kVc6iG0c1xixP7bZro9cx63yqksotDGPj8S4HcCFOBREjLE8j2nQ7haLdi9KuW5t92
	 4/AC/Czr+JwJInreA3GyO+x/ryzMH84nAR2jdT2AX0zW9WreRGLYsJLT0W916uUmoV
	 w/01n48NOvdQKxwxnO1FFsAeSc/POAa0UHlHauxAjZtxsHU846XJJSX5gm9ygqcssK
	 j1Y3nW0eGKm8KG+RZIGZ07D5+27pvQx5vf6ZveScicS3R4gVgC3EqLSo+AMY/qDDCh
	 OnY512R6Rz5PA==
Date: Sat, 27 Jun 2026 09:38:05 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Paul Guder <enyalios@gmail.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	linux-pci@vger.kernel.org
Subject: Re: Wireless Regression
Message-ID: <hgawzx4gdd6e2lam5fk5qvnbvi3xqranhenkpdqkp5fizalonr@ez623pzimpxi>
References: <CAH-zrtu1Bci7M-tQc9Vme9z+Bw=1gthM7z6=XX33Jjd_Q6itcg@mail.gmail.com>
 <0538faed-ffc8-4ade-906b-5e3ee7bfae4a@oss.qualcomm.com>
 <CAH-zrttRYZd9yJsSzUBVLs6tZyguifJ+3eZ+j0q3N7C5k-yuwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-zrttRYZd9yJsSzUBVLs6tZyguifJ+3eZ+j0q3N7C5k-yuwg@mail.gmail.com>

On Fri, Jun 26, 2026 at 08:08:10AM -0500, Paul Guder wrote:
> Attached is the complete log.
> 
> -paul
> 
> On Fri, Jun 26, 2026 at 1:04 AM Krishna Chaitanya Chundru
> <krishna.chundru@oss.qualcomm.com> wrote:
> >
> >
> >
> > On 6/26/2026 6:19 AM, Paul Guder wrote:
> > > Hello,
> > >
> > > I seem to have found a regression with the wireless on the thinkpad
> > > x13s laptop which uses the qcom chipset. This commit seems to cause
> > > the issue:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=f176c47683bf
> > >
> > > Any kernel that has this fails to load the ath11k_pci module with the
> > > following errors in dmesg:
> > >
> > > [    7.298226] ath11k_pci 0006:01:00.0: BAR 0 [??? 0x00000000 flags
> > > 0x20000000]: can't assign; bogus alignment
> > > [    7.298232] ath11k_pci 0006:01:00.0: failed to assign pci resource: -22
> > > [    7.298234] ath11k_pci 0006:01:00.0: failed to claim device: -22
> > > [    7.298267] ath11k_pci 0006:01:00.0: probe with driver ath11k_pci
> > > failed with error -22

I just reproduced the issue on my x13s with stable v6.18.35 kernel. The problem
is the classic hotplug bridge resource allocation issue. When the bridge
advertises itself as hotplug capable, and if there are no devices found during
initial bus scan, PCI core allocates a conservative 2MB of non-pref bridge
window with 1MB of alignment.

But when the device later shows up with 2MB of non-pref BAR requirement, kernel
couldn't allocate the required 2MB with 2MB alignment from existing bridge
window and the enumeration fails with the above message.

Before commit f176c47683bf, the bridge was not marked as hotplug capable. So the
PCI core never pre-allocated the bridge resources during initial bus scan. And
later when the device showed up and the bus was rescanned, the resource got
allocated based on the device requirements.

To fix this issue, we have 3 solutions:

1. Simply revert the commit f176c47683bf from 6.18.35 stable kernel. This commit
is not causing any issue with recent kernels like 7.0, 7.1 because, on these
kernels the pwrctrl core probe defers the PCIe controller until the endpoint
driver gets probed. So this means, the bridge resource will only get allocated
when the endpoint is visible on the bus. This change was added to handle these
kind of hotplug allocation issues. But since it is not a bug fix, we cannot
backport these changes.

2. Teach PCI core to allocate hotplug bridge's BAR window to be aligned to its
size if no device is found. But this fix is fragile since the default MMIO size
used for a hotplug bridge is 2MB. So if the device requires > 2MB of BAR memory,
even this will fail and the users have to resort to cmdline param like
'pci_hotplug_mmio_size'.

3. Allocate a big bridge window for the Root Port in BIOS and teach linux to use
it, like x86. While this is something we are evaluating for the future chipsets,
it is not possible with current BIOS for the exisiting devices.

So the only conceivable fix would be to revert the offending commit f176c47683bf
from 6.18 and 6.12 kernels. Hence, I will submit the reverts.

Thanks for reporting the issue.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
