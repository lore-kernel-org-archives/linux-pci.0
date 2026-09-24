Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69573145B27
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274191; cv=none; b=uCLpDq7t/UXg47uf1yWj4bD+iUvaD6MSv2UyBbh5k7VVsdhh7cOij68zvDqjvn0ojigngx/rHVm8eRaLiWwmBl1X7diSRXILHBuStWRaolLtAmKNTQyAZzDUFy1bS/no+uh5ajSL2BFM1/sc6SO94b1MkGyUXa/7YK/LF1PEZb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274191; c=relaxed/simple;
	bh=+r2H/jq1rikVKthqaDXpR+VDgaS/zrr19rC1jqGWjEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZY4/gLni1DIh2AYVbZxTDHB0ybjyDnWbz+oxGO835B9x6+C75ciVxL6uIONcb5JemFFgtmp1D9EYsfhZyxYDNhZY/9xvqfKRSfyFBhX9aqGHGmDpie0ghHJf1IA+3lX1JCV4gws3LZaSx1Kk2lToNQ3/gHY6SnIClsYLIX3FeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4AgpJ90; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4AgpJ90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A203D1F000FF;
	Thu, 24 Sep 2026 18:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790274190;
	bh=eC3ogfxkQveFA19tt9bSiCkqmBwIQRmVOXcA4jh2a4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W4AgpJ90ThVjy1/cKwWgv+Vf5/xNO6D+5cJtGFlYocFPI+gNA7tQBfe5QMaGiHkOw
	 0aDcXj49v+FmOF1P3iS3bRq+dny1UElv44he0KAS+u6O4+uPUDNCyqZZBfMjPXA3V7
	 Kx2EF0CQFhxA4vzB5JC+jHjW6eY79iR32TQdBwDsN1PEIdC5gTUSP/39/MZLXu108/
	 h0/JEw5gD4ZNzxTF03ljilIrKJ1NxgAWk6alReA2NmPu6XnKI3Kak4JVpEadnu+Jl1
	 FxGUJbIKQ8fiVOaZUtABYahaYjT2JY+l20k7vr1toZmVaPhjCaisuiZWfb3EHECDjr
	 Ejo5Ve25Efaaw==
Date: Fri, 25 Sep 2026 03:23:08 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Narendra K <Narendra_K@dell.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI/sysfs: Fix the ACPI device name attributes
Message-ID: <20260924182233.GC2386198@rocinante>
References: <20260814070522.2327975-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814070522.2327975-1-kwilczynski@kernel.org>

Hello,

> Currently, the "label" and "acpi_index" attributes are created whenever
> the _DSM function 0 bitmap advertises the Device Name function, and
> dsm_get_label() returns the literal -1 on every failure path.  Firmware
> that advertises the function but returns an object that cannot be
> parsed therefore produces two attributes that exist and fail every read
> with -EPERM:
> 
>   $ cat /sys/bus/pci/devices/0000:00:08.3/label
>   cat: /sys/bus/pci/devices/0000:00:08.3/label: Operation not permitted
> 
> Nothing in that path performs a permission check.  Tools that read the
> attribute print the failure on every invocation, which is how this
> surfaced in a pciutils report:
> 
>   https://github.com/pciutils/pciutils/issues/175
> 
> Patch 1 returns error codes that describe what failed.  Patch 2 stops a
> malformed optional device name element from also failing "acpi_index",
> which exports the mandatory instance number and does not depend on the
> name.  Patch 3 evaluates the function when deciding visibility, so that
> an attribute exists only when the element it exports has a type the read
> path accepts.  The documented ABI already describes the behaviour patch
> 3 implements, and the SMBIOS attribute group in the same file already
> works that way.
> 
> Patch 4 corrects the length dsm_label_utf16s_to_utf8s() passes to
> utf16s_to_utf8s().  The ACPI buffer length counts bytes, while the
> converter counts wchar_t elements.  For a buffer holding no NUL code
> unit the conversion reads past the end of the object allocated by
> ACPICA.  The bytes it finds there are decoded into the world readable
> "label" attribute.
> 
> Note that patch 2 changes behaviour on platforms that have a valid
> instance number together with a malformed name element: "acpi_index"
> starts returning data there.  Because udev derives the onboard
> interface name from "acpi_index", an interface on such a platform may
> be renamed once, on the first boot after this change.  The same
> mechanism, in the other direction, is recorded in dcfa9be83866 ("ACPI /
> PCI: Fix sysfs acpi_index and label errors").
> 
> No ACPI dump accompanies the report, so the object that platform returns
> is not known.  The malformed results tested below are constructed.
> 
> Tested under QEMU with an SSDT that overrides _DSM on the ACPI companion
> of a PCI device.  Function 0 advertises the Device Name function, and
> function 7 returns a chosen object.  Nine cases, on the series and on
> v7.2-rc1, with CONFIG_KASAN=y:
> 
>   Function 7 returns                        label       acpi_index
>   ----------------------------------------  ----------  ----------
>   Package(2){1, "TESTLABEL"}                TESTLABEL   1
>   Package(2){1, ""}                         empty       1
>   Package(2){1, Buffer{"BUF", terminated}}  BUF         1
>   Package(2){1, Buffer{NUL}}                empty       1
>   Package(2){0, 0}                          absent      0
>   Package(2){"BAD", "NAME"}                 absent      absent
>   Package(2){1, Buffer(0x40)} unterminated  32 chars    1
>   valid twice, then an integer              -EIO        -EIO
>   QEMU acpi-index=7                         empty       7
> 
> On v7.2-rc1 the first four and the last behave identically, so
> compliant firmware is unaffected, including the generator QEMU uses for
> stable interface names.  Package(2){0, 0} reproduces the reported
> failure there, with both attributes returning -EPERM.
> 
> For patch 4, the unterminated buffer case on v7.2-rc1 leaked two bytes
> of adjacent memory into the attribute, and under KASAN:
> 
>   BUG: KASAN: slab-out-of-bounds in utf16s_to_utf8s+0x21f/0x250
>   Read of size 2 at addr ffff88800e77b088 by task cat/109
>   ...
>   allocated 136-byte region [ffff88800e77b000, ffff88800e77b088)
>   ...
>   acpi_ut_initialize_buffer+0xc7/0x190
>   acpi_evaluate_object+0x694/0x920
>   acpi_evaluate_dsm+0x16e/0x230
>   dsm_get_label.isra.0+0x6b/0x300
> 
> With the series applied the same case reads correctly and KASAN stays
> silent.  The two terminated buffer cases produce no splat before or
> after.  Reaching the read needs the missing terminator, not the buffer
> form as such.

Applied to the sysfs branch.

I would like to give this some soak time via the linux-next.

Thank you!

	Krzysztof
