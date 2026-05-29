Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F2D2E0925
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780060053; cv=none; b=ZFIap+bCTezaVYK7rmbqPmmdJ/1Pfvg3zqxSlGPrzKOlj3Jv2LZU06R2znIr+aCBRaoN7Er77uV3BL8MgMT6PkpZh9JnNlHUhQiIFZSQTB5ojDh46EOizHGwdhcO0vzW2RXUpHOVRGn2GcFg6PiKYu5VZUvTiN1kj9jo44XLKfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780060053; c=relaxed/simple;
	bh=hd4LcNwj6ksj2iLj3ZD/dP35j67yXqIvzJr4hsBXpJ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xw8NqBqpGXjRRfSgylTc5N2kzhr8OU7289TwCy2FqCeH3sW3lgIpUh7kFGADKdE07DHt6NeYfQ8xrwyHDAQv53XEInQhvXTpHhjNjxTyBB+9gVv0Rxkh6HwPeCpQSAko5y5oyW5RRlE4l8Bp/Uc47n6bOlkNmOwqHLoVt4gTDXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WD/DP8DV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WD/DP8DV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A26F1F00893;
	Fri, 29 May 2026 13:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780060052;
	bh=ux8H2pFS6ildcVRJ51mseZ3+aU3sAxVBu3awp4TkCis=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WD/DP8DVfwtfd/f1UgwWXExgqAaUO3Hybb32broHP/UwqZWxIAgc712NszWQOYy9n
	 qg1LrI07iCAFA7okPHeSOHlizUnSvBHerFSA39NDQe0TVfAFwnpPkQmXBbElVlUCRN
	 vKek8z7G7xFeJOJJMgmtWxBnfPGtvBFz3FCPkafwXqbTJthnvhD5qrxk2uNvxvM+lg
	 4d5aTIL+1Ejqw0ysdO9MhtOFXp8wnD6pm0qtbD+c+hdkevDTqkA+fYegdi0/etMeDa
	 v0RKbl3CgqNW8nczZHw6pMKGpf9yPMsY1t/+lsPVDluLJXrSggYEwE411sUdSUX9N1
	 gidtXY6H09TQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/6] PCI/ATS: Mandate checking pci_ats_supported()
 before pci_prepare_ats()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260529111208.387412-4-praan@google.com>
References: <20260529111208.387412-4-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 13:07:31 +0000
Message-Id: <20260529130732.5A26F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Adding a WARN_ON() inside pci_prepare_ats() causes severe kernel w=
arning spam during boot and creates a DoS vector via hotplugging on AMD sys=
tems.
--

commit d186831ffc8e024f9925cf7f6047ad60755bc2d8
Author: Pranjal Shrivastava <praan@google.com>

PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()

This commit updates pci_prepare_ats() to wrap the internal
pci_ats_supported() check in a WARN_ON(), mandating callers to verify ATS
support prior to calling it. It also updates the function documentation.

> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 9cb23780093dd..f1434f86ac40b 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
[ ... ]
> @@ -64,7 +66,7 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
>  {
>  	u16 ctrl;
> =20
> -	if (!pci_ats_supported(dev))
> +	if (WARN_ON(!pci_ats_supported(dev)))

[Severity: High]
Will this trigger severe warning spam during boot on AMD systems?

Currently, the AMD IOMMU driver unconditionally calls pci_prepare_ats() for
every PCI device in amd_iommu_probe_device() without checking if ATS is
supported. Since most standard devices lack ATS capability,
pci_ats_supported() returns false, which seems like it would trigger this
stack trace for every such device during probe.

This breaks git bisect and causes boot panics on systems with panic_on_warn
enabled, or provides a local DoS vector via device hotplugging.

I noticed this is fixed later in the series by commit e469ff12f2f6
(iommu/amd: Fail probe on ATS configuration failure). Should the AMD IOMMU
driver be updated before this patch to preserve bisectability?

>  		return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529111208.3874=
12-1-praan@google.com?part=3D3
