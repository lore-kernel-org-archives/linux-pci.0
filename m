Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9601233D6D5
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691992; cv=none; b=aC7vcfqefghYfoXxjxW38qE7ZMlIn80tsHzUlAORXAtoSNXLoYYuUuVmU3AIDA0GNpiywBMi/xjctkJQ0hmmaVPUgvY9KH8nlzGdO0UGOPQAHR26k68hm3QTGxMyZtvsziyEa8jOPBVLjFEVEIgLt8yya3BtnFOC73d1MZt7JE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691992; c=relaxed/simple;
	bh=xv5CJtsoZ73+GLarI6RkspqINrMoRAJ5ePmde0H8n4Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S+svZhAHeOc65r+TMtWDdXX7C4srC7onfrjh1M090CiuZPj+FoG/+PT5+/tAtT24vIqDWah9GQSczoPt9kFScO/R+HEG6xDUjiGR6srreMqXbPXC0/ac9YSbZjaFDwpatAGbulTslg81Tieazy2a+g1/xWZMMmYgQ8t1VaEGtp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyKxlUSe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyKxlUSe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085BD1F00A3A;
	Fri, 14 Aug 2026 07:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786691991;
	bh=+httrL2YXqMriFQRMPDxWxd0E1eWtrixYoxHnMt9pwE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kyKxlUSe2LWllKWk0J7WhEGcnak0cNWqhuZYoSBNCI4zQe1o74QP2yhfPp0gPQG39
	 sPrqF+5V/Hl8iJTKW+r+UF230+IJR/xE4rvHBS7w18ZcMT173WxDrxe8Y6sTlolTSI
	 n5s4yiksOAOMWfn0OdORfou+A50n4ajsTI/ZHX9J7iyJVXsw7S+29m+i++1iR+xfH6
	 VDFl9LmuE5U4wZrJ0PzwTGbnY4kBIB0Wk1hvgn76kN84txWUV78v9PTDIf0guhZk+L
	 IGobf6hmiz5TQBfCh7qi+IqqNl0jLQC2rXWw9CoRpaP1iZZPXOSsp+v63zk2BwOzod
	 K+8UwMJmZJ8xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] PCI/sysfs: Handle a malformed _DSM result in
 acpi_attr_is_visible()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260814070522.2327975-4-kwilczynski@kernel.org>
References: <20260814070522.2327975-1-kwilczynski@kernel.org>
 <20260814070522.2327975-4-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 07:19:46 +0000
Message-Id: <20260814071951.085BD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The function `dsm_label_utf16s_to_utf8s` passes the byte length of=
 an ACPI buffer as the `inlen` parameter to `utf16s_to_utf8s`, which expect=
s the length in `wchar_t` elements, leading to an out-of-bounds read.
--

--- Patch [3]: [PATCH 3/4] PCI/sysfs: Handle a malformed _DSM result in acp=
i_attr_is_visible() ---
commit 1e24bdb9829d783f4fae2c39ec3d3567d6ea73df
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

PCI/sysfs: Handle a malformed _DSM result in acpi_attr_is_visible()

This commit updates acpi_attr_is_visible() to evaluate the Device Name
_DSM when deciding attribute visibility. This ensures each attribute is
only created when the exported element has a type that the read path
accepts, preventing failing reads for malformed objects.

Closes: https://github.com/pciutils/pciutils/issues/175

> diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
> index 5b08f50653a37..abb941530c560 100644
> --- a/drivers/pci/pci-label.c
> +++ b/drivers/pci/pci-label.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing how the _DSM
buffer is handled in this file, I noticed a pre-existing issue in
dsm_label_utf16s_to_utf8s():

drivers/pci/pci-label.c:dsm_label_utf16s_to_utf8s() {
	int len;

	len =3D utf16s_to_utf8s((const wchar_t *)obj->buffer.pointer,
			      obj->buffer.length,
			      UTF16_LITTLE_ENDIAN,
			      buf, PAGE_SIZE - 1);
	buf[len++] =3D '\n';

	return len;
}

Does this code pass a byte length instead of a character count?

Because utf16s_to_utf8s() expects the inlen parameter to represent the numb=
er
of 16-bit characters, passing obj->buffer.length (which is the size in byte=
s)
might instruct the function to process up to twice as many characters as are
actually allocated for the buffer.

Could this result in an out-of-bounds heap memory read when an unprivileged
user reads the world-readable /sys/bus/pci/devices/.../label sysfs file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814070522.2327=
975-1-kwilczynski@kernel.org?part=3D3
