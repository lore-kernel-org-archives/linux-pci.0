Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D44463B8B;
	Wed, 30 Sep 2026 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778097; cv=none; b=RL9KHocp/6BAfPAq6H4RUqHoZdvD63JaWl4j60Qe2w6vSDaDtJJABH82KbFUMsWm38wBk4HXy1+CVEsRmEgFlUsLiDwtBCFIVo0HFeMLifxm3Xd4ZyrDgtxvGtYX2x05fc0ULDZzJbNmz5BR5ZLdOSMHpnIUMSPie1dAK7caIMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778097; c=relaxed/simple;
	bh=qOGGQpcV4adFKXFJPDC7wkDK6ZL2KkF+hBrcaqDSTRU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sLf8cWARH/AjBcspJAZkC2/1+FarVZe0Uu3pGCiqzFYB8h5FXzpVFnuCCRqHobiZ+ukqywx9Ujc42a4Z3wLxAGOUnNDwGWSYLwo4rLclBQCURwfBeU6dqpJ+dtZpKyTdGBHJ0znJFonhVcZ7WQgqQjupQxZbvXbpV8BNv97m4wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiSo8fE0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiSo8fE0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE351F000FF;
	Wed, 30 Sep 2026 14:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790778087;
	bh=xKPNqitElMsSvuJgqRsEtc0NdLLL40K8tqIo1gkfE5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HiSo8fE0z6CJsuw6J5MwgKiVzuFk9HsJQnzko4HgB4wM6yYNKwt4AzonDMFKmBA1i
	 L+AXOeGAUJcL6Cx8j0YnQ/8WbkkGpj/1k8sgwGGIj4pqkMskBjpOROu6XQolaxz/ls
	 jGBtlMyff0kyYgRik7zCYhZButbs2Iz+376BPKXnYFIoGQ75yDn53P1NPItenGxIQY
	 z8gQDTEzJwNxJdbd3Gh80PUtVzPhXJ8fUZsOkGa8Ya3P95UIo5unnAsOcRE7YNLevh
	 IEl761tPSVS7IanHwMCly/O/I5yKFZYiJ4zFJW/xGR72KSCh8cS+wyqpagpBLMWlAr
	 TYexIvBg0kmDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] PCI: Add pci_find_free_ext_cap_offset() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260930140833.576941-2-jtornosm@redhat.com>
References: <20260930140833.576941-1-jtornosm@redhat.com>
 <20260930140833.576941-2-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:21:27 +0000
Message-Id: <20260930142127.9BE351F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] pci: infinite loop in pci_find_free_ext_cap_offset() without TTL
- [High] pci: hardcoded 64-byte size in pci_find_free_ext_cap_offset() clob=
bers large capabilities
- [High] pci: out-of-bounds config access via integer underflow in pci_find=
_free_ext_cap_offset()
- [Medium] pci: stateless allocation in pci_find_free_ext_cap_offset() caus=
es resource collisions
--

commit cd8d51b3f77c9157b1c6d30b169fe7c04efaecb1
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: Add pci_find_free_ext_cap_offset() helper

This commit adds a helper function to find free space in the PCI extended
configuration space. It scans the extended capability chain and returns an
offset to a gap of at least the requested size, intending to allow VFIO
variant drivers to use unused space.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f80..31f70e2982b63 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> +int pci_find_free_ext_cap_offset(struct pci_dev *dev, size_t size)
> +{
> +	int pos =3D PCI_CFG_SPACE_SIZE;
> +	int last_cap_start =3D 0;
> +	int free_offset;
> +	u32 header;
> +	int next;
> +
> +	if (!pci_is_pcie(dev))
> +		return 0;
> +
> +	while (pos >=3D PCI_CFG_SPACE_SIZE) {
> +		if (pci_read_config_dword(dev, pos, &header))
> +			break;
> +
> +		if (header =3D=3D 0 || header =3D=3D 0xffffffff)
> +			break;
> +
> +		last_cap_start =3D pos;
> +		next =3D PCI_EXT_CAP_NEXT(header);
> +		if (!next)
> +			break;
> +		pos =3D next;
> +	}

[Severity: High]
Could this loop indefinitely if a malicious or buggy PCI device presents an
extended capability chain where the next pointer points backwards or forms
a cycle? It looks like this traversal lacks the Time-To-Live (TTL) limit
that is present in other helpers like pci_find_next_ext_capability().

> +
> +	/*
> +	 * Use space after the last capability. We align to the next capability
> +	 * boundary (typically 4-byte aligned). Start at a safe offset past the
> +	 * last capability - capabilities vary in size, so use a conservative
> +	 * offset. Most extended capabilities are <=3D 64 bytes.
> +	 */
> +	if (last_cap_start) {
> +		free_offset =3D last_cap_start + 64;
> +		free_offset =3D ALIGN(free_offset, 4);

[Severity: High]
Is a hardcoded 64 bytes always sufficient here? Some standard capabilities
are larger than 64 bytes (for example, AER is 72 bytes, and VSEC/DVSEC can
be up to 4KB). If the device's last extended capability exceeds 64 bytes,
would this offset fall inside the bounds of the active capability and lead
to data corruption when written?

> +		if (PCI_CFG_SPACE_EXP_SIZE - free_offset >=3D size)

[Severity: High]
Can this subtraction result in an integer underflow?

If the last capability starts near the end of the configuration space such
that free_offset exceeds PCI_CFG_SPACE_EXP_SIZE (4096), the subtraction
would yield a negative integer. Because size is a size_t, wouldn't the
negative integer be implicitly promoted to a very large unsigned value,
bypassing this capacity check and returning an out-of-bounds offset?

> +			return free_offset;

[Severity: Medium]
Because this offset is returned without reserving the space in the
capability chain, could multiple callers receive the exact same offset?
This stateless allocation appears like it might cause multiple subsystems
or quirks to overwrite each other's data at the same offset.

> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_find_free_ext_cap_offset);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930140833.5769=
41-1-jtornosm@redhat.com?part=3D1
