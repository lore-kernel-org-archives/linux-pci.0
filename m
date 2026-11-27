Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795786499;
	b=KqCN59F5e4GTc062K6vtPkTZz9uOZVWsX7b9QOdXlYHgc9JL4ApmR/mA1LcazLEaTef6
	 ImibrkdjsTemY7UPNSuuXKYzi/inFzwEZ2QEUy13iSzXQwgO0JzAUJ2XDoakGcf/w/1hq
	 arItprOMmD76mtfAaZ0XSUsP4+laQI9j+xNx/O7577rZk/70sTflm3aQlWGbmN32IC3Sh
	 mx8XVI4f0yudSCk+nYOW9ak44GjG7rN14nEVgKqdlaRBEL4iG9KIEIYLxqAgOU3hWTEBD
	 ZglCXMhbhGDQ4PqYKIyuUvC8UbXmaEreEY6Sd7a0dmJRpXxxcHRP6YiGbVax2/lZSzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795786499;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=u5o0ealUp1sn1n0VByJbLDp7AoAU6cZUlUs1LN6JAEk=;
	b=hXzACwkZAYgwsHUAkxa5c+/ZgXWijcWyOxwvrwkeCclx/9gwOxZnE05nRr+A/lI38G3w
	 4e6ubjArOGDfPjicQ0NzTBufRjw/vUcwa/2LHCuBLuSybZQaZYePw6d40OVW8Rqh+tHff
	 2bLiNcR/SIxHbY9JReA2DZjyCfNY4W+FMbgyAutTRBPl7+pmPV6E4BMbBQ1Dml1kJtAsG
	 GJMlYkd2ZHChIHhqHrw9Au00jRujwNWHIuoyLyEVFyZgZnWLnROx5cJy9bLltX2lHIoUD
	 Ejqzb2QDw53uRsibQAnWduoe742AnP0q94V9/Oc9XZmMy6fj62Ps/g9nv4tAJO8bjIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i35fWrdt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C15606A31E
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i35fWrdt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5D81F00893;
	Fri, 27 Nov 2026 13:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795786499;
	bh=u5o0ealUp1sn1n0VByJbLDp7AoAU6cZUlUs1LN6JAEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i35fWrdtEjz4EmGbz/xU1VHick/0bIfCnR88KTvClk4j6nVNzA5Le/L3s7lTFop6B
	 V6zgkGZ6Hvc/OEgHL10FPeXPBunNNJElZHQQLgu73hjyA/P/JOtgPS4cjXzIDK1TKp
	 /l5G6DMUW1Lp3Y2IAbkb5FZpF2R5/JJeggEQVLQjcQwk83s7kuirhwN8uQolasIZa0
	 q1O6/4cLjbCzpJLdO73pQ2GDepqM3ijTsMy+NMk/A1d8+BPyIgNoBPPc295pQBWn/C
	 CDZ+SjSB8y+x2V/TI6MxYNT8foORoWaRj1d84vBzXgHqr8GKcmYkytkW3hKP3jxbe6
	 rCfcbk6VA51ew==
Message-ID: <sashiko-outbox-237497@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] PCI: Add warning about possible danger for
 pcie_bus_perf mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Tang" <feng.tang@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <awmEjs8VnJO5XIXd@U-2FWC9VHC-2323.local>
References: <20261125155829.77269-1-feng.tang@linux.alibaba.com>
 <awfv0WKc6iblVA9E@infradead.org> <awmEjs8VnJO5XIXd@U-2FWC9VHC-2323.local>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 13:34:57 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] PCI: missing Signed-off-by trailer and changelog due to leading
  --- separator
- [Medium] PCI: retroactive Root Port MPS limit in pcie_write_mps()
  misses switches
- [Low] PCI: raw vendor ID 0x144d used instead of PCI_VENDOR_ID_SAMSUNG
  in quirks.c
--

commit 4da6a5be70bc88f019059fbcf823ed6f76b2a353
Author: Feng Tang <feng.tang@linux.alibaba.com>

> PCI: Add warning about possible danger for pcie_bus_perf mode
>
> On Thu, Nov 26, 2026 at 12:37:37AM -0800, Christoph Hellwig wrote:
> > On Wed, Nov 25, 2026 at 11:58:29PM +0800, Feng Tang wrote:
> > > During stability test, there was a bug that running 'mount' on a type
> > > of commercial NVME disk failed on an arm64 server and raised PCIe RAS
> > > error and panic the kernel later, when using "pci=3Dpcie_bus_perf" ke=
rnel
> > > cmdline parameter.
> > >
> > > The NVME device has MPS(Max Payload Size) capability of 256 bytes whi=
le
> > > its corresponding root port is capable of 512 bytes. When enabling
> > > PCIE_BUS_PERFORMANCE mode, its MPS and MRRS(Max Read Request Size) are
> > > both set to 256, while the root port's are both set to 512. But the
> > > NVME device doesn't comply with PCIe spec (v6.3), Section 7.5.3.4:
> >
> > Please add a quirk for these devices now that you have identified
> > this problem.
>
> Following is a draft patch as suggested, which can solve this issue. Plea=
se
> help to review, thanks!
>
> - Feng

[Severity: High]
Because the email reply precedes a "---" separator, git am strips the actual
patch subject, changelog, and Signed-off-by: trailer below it and records t=
he
reply text above as the commit message.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2e84fc3d5df96..a15e5a8ee284f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2948,11 +2948,14 @@ static int pcie_find_smpss(struct pci_dev *dev, v=
oid *data)
>  	return 0;
>  }
> =20
> +static void pcie_write_mrrs(struct pci_dev *dev);
>  static void pcie_write_mps(struct pci_dev *dev, int mps)
>  {
>  	int rc;
> =20
>  	if (pcie_bus_config =3D=3D PCIE_BUS_PERFORMANCE) {
> +		struct pci_bus	*bus;
> +
>  		mps =3D 128 << dev->pcie_mpss;
> =20
>  		if (pci_pcie_type(dev) !=3D PCI_EXP_TYPE_ROOT_PORT &&
> @@ -2972,6 +2975,27 @@ static void pcie_write_mps(struct pci_dev *dev, in=
t mps)
>  			 * allowable MPS based on its parent bus).
>  			 */
>  			mps =3D min(mps, pcie_get_mps(dev->bus->self));
> +
> +		/*
> +		 * Quirk for devices that issue Memory Read Requests larger
> +		 * than their MRRS.  "Performance" only guarantees a child's MPS
> +		 * is <=3D its parent's, so the corresponding root port may have
> +		 * bigger MPS than the device. When such a device sends out a
> +		 * Memory Read request with length > MRRS, and the root port
> +		 * returns CplD packet with length larger than device's MPS,
> +		 * "Malformed TLP" AER error or Machine Check Error(x86) could
> +		 * be triggered. So decrease the root port's MPS/MRRS down to
> +		 * match device's.
> +		 */
> +		bus =3D dev->bus;
> +		if (dev->broken_mrrs && bus->self &&
> +		    pci_pcie_type(bus->self) =3D=3D PCI_EXP_TYPE_ROOT_PORT &&
> +		    pcie_get_mps(bus->self) > mps) {
> +			pci_info(dev, "Device has broken MRRS function, limiting MPS of upstr=
eam %s to %d\n",
> +				 pci_name(bus->self), mps);
> +			pcie_set_mps(bus->self, mps);
> +			pcie_write_mrrs(bus->self);
> +		}
>  	}

[Severity: Medium]
Does checking only pci_pcie_type(bus->self) =3D=3D PCI_EXP_TYPE_ROOT_PORT m=
iss
broken_mrrs endpoints attached behind a PCIe switch?  When dev is behind a
switch, dev->bus->self is a Switch Downstream Port
(PCI_EXP_TYPE_DOWNSTREAM), so the Root Port's MPS is left at 512 bytes and a
512-byte Memory Read Request from the endpoint still draws a 512-byte CplD
that triggers the Malformed TLP error.

Lowering bus->self retroactively during the top-down pci_walk_bus() in
pcie_bus_configure_settings() also leaves any earlier-visited sibling
functions configured with an MPS larger than their upstream bridge.
Pre-scanning the hierarchy under the Root Port to cap the Root Port's MPS
before running the top-down pcie_bus_configure_set() walk would avoid both
issues.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index fff85df3c301c..de41e44778952 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6635,3 +6635,24 @@ static void pci_mask_replay_timer_timeout(struct p=
ci_dev *pdev)

[ ... ]

> +static void quirk_broken_mrrs(struct pci_dev *dev)
> +{
> +	dev->broken_mrrs =3D 1;
> +}
> +DECLARE_PCI_FIXUP_HEADER(0x144d, 0xa80a, quirk_broken_mrrs);

[Severity: Low]
This isn't a bug, but PCI_VENDOR_ID_SAMSUNG can be used here instead of open
coding 0x144d, matching the other Samsung quirks in drivers/pci/quirks.c.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/awmEjs8VnJO5XIXd@U-=
2FWC9VHC-2323.local?part=3D1
