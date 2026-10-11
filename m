Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55841EED8;
	Sun, 11 Oct 2026 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791705442; cv=none; b=XtnURKOeqOBremBE0DD36Va4td9ktKw/88XwfZk3dYDbRHu1vosfPeQAapJH6XUtartBzlCbQFO0RfwnUQNPo6T7P4+CTCXPG6Sc48zE2t8TXA5+3cnkjRvGDibcPVExY++WmNV8+Sw0D9e+yHyUll1CLK7SYm5hiD7F4QdxxqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791705442; c=relaxed/simple;
	bh=oEE5pG1g434D2f/S38ix1VopGEIMi82QsFpb1ixxgaI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CrdrKyCFDDYXfQ3kGJaQwyE6mE3EgnfBFwiKzb2SraGZJoDbDcGvkf8wTQXY9dZHiHs785vGQYgbzFer7pgEws9mQrbvcso2oJAF1bRAMopN4HFLP5/N/SKD3EKc7arY+qIbenXL/fzOsGAQq8lETLdd/29DPj/uC71+Hfm4+FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afLzqwU2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afLzqwU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13441F0089B;
	Sun, 11 Oct 2026 07:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791705441;
	bh=UDCsHOZNullcNlWrw/vugB+Q8kLI0T8bSuQbYj9FxWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=afLzqwU2088+Q5uE5t031yAxeGJNKDfy9QaaAXdbxcGzZ+11XDwoq97jZzFsTnUX0
	 iQZvFGMyyUQmRZzCM6UsLe0tJXXVGOh7GvfFDEHQ9WtwkMs93YtG2Dn5VdQ0DdWJla
	 lOnJMzKlie1ovm45U7nu0DOfS+RiiobPHRKOwyBHR8KyQFgaF7GRPIe5/yz2F80ae8
	 s4ZfrsZPQtSTxyzeveMK6hDPp2LM3H0TmALgtJydMGKfSe9cNyfU5CGbDelMOyB6SQ
	 Cvi/CcPbIFCiwIjNQDPJpNb+m4ogT4KfV8pQ4BPKcHAHzyuJEWPLn+qhntLcWjoyUo
	 hoy3VRES69xaQ==
Message-ID: <sashiko-outbox-167110@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/7] PCI: Add pci_find_free_ext_cap_offset() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20261011074514.515894-2-jtornosm@redhat.com>
References: <20261011074514.515894-1-jtornosm@redhat.com>
 <20261011074514.515894-2-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 07:57:20 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] pci: zero-scan identifies zeroed payload of highest capability as =
free space
- [High] pci: out-of-bounds config space access due to hardcoded PCI_CFG_SP=
ACE_EXP_SIZE
- [High] pci: config space corruption due to zero-scanning capability paylo=
ads
- [Medium] pci: function fails to identify completely empty extended config=
 space
--

commit c1630045212cdfa197e241362843099e2b8fa29f
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: Add pci_find_free_ext_cap_offset() helper

This commit adds a helper function to find free space in the PCI extended
configuration space for VFIO variant drivers to use. It walks the extended
capability chain and scans for contiguous zeroed space.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8cc6a89130b53..ae234c9a2a29b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
> +int pci_find_free_ext_cap_offset(struct pci_dev *dev, size_t size)
> +{
> +	int ttl =3D (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
> +	int pos =3D PCI_CFG_SPACE_SIZE;
> +	int start =3D 0, run =3D 0;
> +	int highest_pos =3D 0;
> +	u32 header;
> +	int offset;
> +
> +	if (!pci_is_pcie(dev) || dev->cfg_size <=3D PCI_CFG_SPACE_SIZE)
> +		return 0;
> +
> +	if (size =3D=3D 0 || size > PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE)
> +		return 0;
> +
> +	if (pci_read_config_dword(dev, pos, &header))
> +		return 0;
> +	if (header =3D=3D 0 || header =3D=3D 0xffffffff)
> +		return 0;

[Severity: Medium]
Will this early exit prevent the function from utilizing completely empty
extended configuration space?

If the header at PCI_CFG_SPACE_SIZE is 0 or 0xffffffff, it indicates
the device has no extended capabilities whatsoever. In this case, the entire
extended configuration space up to dev->cfg_size is unused and free.

Returning 0 here prevents drivers from utilizing this completely empty
configuration space.

> +
> +	while (ttl-- > 0) {
[ ... ]
> +	if (!highest_pos)
> +		return 0;
> +
> +	for (offset =3D highest_pos; offset <=3D (int)PCI_CFG_SPACE_EXP_SIZE - =
4;
> +	     offset +=3D 4) {

[Severity: High]
Does this loop bound cause out-of-bounds configuration space accesses?

The loop condition is hardcoded to PCI_CFG_SPACE_EXP_SIZE - 4 (4092 bytes),
completely ignoring dev->cfg_size. Many PCIe devices and host bridges have
restricted configuration sizes (e.g., 512, 1024, or 2048 bytes) due to hard=
ware
limits or quirks.

For these devices, calling pci_read_config_dword() outside their physical
configuration space can trigger unsupported request errors, leading to mach=
ine
check exceptions or system errors.

If the bridge returns 0 for these out-of-bounds reads, the function could
falsely identify non-existent space as free, leading to out-of-bounds write=
s.

[Severity: High]
Could starting the scan exactly at highest_pos cause the function to scan
an active capability's payload?

The scan begins exactly at the header of the highest-offset capability
(highest_pos), instead of skipping past its actual size.

> +		u32 val;
> +
> +		if (pci_read_config_dword(dev, offset, &val))
> +			break;
> +
> +		if (val =3D=3D 0) {
> +			if (run =3D=3D 0)
> +				start =3D offset;
> +			run +=3D 4;
> +			if (run >=3D (int)size)
> +				return start;
> +		} else {

[Severity: High]
Will this zero-scanning approach corrupt active capabilities?

Because the scan doesn't skip the actual size of the highest capability, it
reads the payload registers (such as status, mask, or log registers) which
often naturally default to zero.

If the scanner finds a contiguous block of zeroes inside the active payload=
, it
will falsely return this internal offset as 'free space'.

Callers writing to this offset will then silently overwrite and corrupt the
active capability's state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011074514.5158=
94-1-jtornosm@redhat.com?part=3D1
