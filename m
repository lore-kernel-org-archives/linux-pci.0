Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB1F28505E
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784211525; cv=none; b=KJ0iOaviJCWuPmgG6yT39AsfKXi4XDNhS8q2iJiA4d4n5FgGdAYKy8lUO9aWwBrGLQ8S06smFYa8JVY0Ytt1ZAiUVA9zQ3e7v+LwedaEPfFbqF+C5JP/2l/wxOqyvxoYkXjDClnL45K/XRy6QylYb3N/RdcdG+Qxlg4wWZRnQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784211525; c=relaxed/simple;
	bh=N6JzTQQcSsJwKoG/nwEYpA1OhEGL7wk+z5Q5VS7FRGU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c105nL8Eq7QnVrnL34C81yXvWtFMzYJgFM7IWJ/3uowbU+R9rRBm3YOBx3C6uRtFDHhUc9hL8PKPMKRMC226xAz9R0FsyD/ExZkCRoPvHQSi/E97nDsBiM12rioak4BV9Tew5ACiirvlYBLmHPn+k/PExA8ipRRhzh3k+DG3TSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHqdBB+p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHqdBB+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3171F000E9;
	Thu, 16 Jul 2026 14:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784211524;
	bh=Go0YeeVHE9OtB5flaW5oLbIr7wX4yMV8jurgKjVj2B4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JHqdBB+peexjSZYg55YVt/NiFqYvErvARoUdTgYT5REcDKpTiZlJrzp3H7iErfLse
	 CfcKI7HXS7EwhGg1Q0iuxU3KfyoonN+A5m90XzON+Ve/wL3MTdsYXVedvOlng2dpGL
	 Dnb/IcjXcftASwSW0nZPgqIb7Y66DMqfRwnXkwUkxcpMrdMiy9CmPS+yek4fA6m4eV
	 5kxyvZmny6ULL/p8KiTiLTnDhHcubVnY1ZOx28Sza0PjohemDpMRxN4M+So3yxx3iA
	 CAtOoNs4FIrv7cQjOtdjcIPVAtS9HrNc7YRtEadDTNjuEdkVIlB3KB/skpiQH0rbjV
	 vNEFhfog2Y0KQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] ACPI: PCI: Introduce acpi_dev_get_pci_dev()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <3430928.44csPzL39Z@rafael.j.wysocki>
References: <12935400.O9o76ZdvQC@rafael.j.wysocki>
 <3430928.44csPzL39Z@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 14:18:43 +0000
Message-Id: <20260716141844.4A3171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free in acpi_get_pci_dev() due to unpinned acpi_device p=
ointer
--

--- Patch [2]: [PATCH v2 2/4] ACPI: PCI: Introduce acpi_dev_get_pci_dev() -=
--
commit 96691f509a95b92252e42efea5c07ebf2acebfd2
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

ACPI: PCI: Introduce acpi_dev_get_pci_dev()

Some acpi_get_pci_dev() callers already have a struct ACPI device for
which they want to get the struct pci_dev pointer of the associated
PCI device. Add acpi_dev_get_pci_dev() to handle this and turn
acpi_get_pci_dev() into a static inline helper.

> diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
> index 402b97d121381..bff2ca035fcf3 100644
> --- a/include/acpi/acpi_drivers.h
> +++ b/include/acpi/acpi_drivers.h
> @@ -59,14 +59,19 @@ int acpi_pci_link_free_irq(acpi_handle handle);
[ ... ]
> +static inline struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
> +{
> +	return acpi_dev_get_pci_dev(acpi_fetch_acpi_dev(handle));
> +}

[Severity: High]
This is a pre-existing issue, but does this inline function expose a
race condition with ACPI hot-remove?

acpi_fetch_acpi_dev() returns an unpinned acpi_device pointer without
incrementing its reference count. If a concurrent ACPI hot-remove event
occurs immediately after the lookup, the device object could be destroyed
and freed by the hotplug workqueue.

When the dangling pointer is passed into acpi_dev_get_pci_dev(), it
gets dereferenced here in drivers/acpi/pci_root.c:

acpi_dev_get_pci_dev() {
    ...
    guard(mutex)(&adev->physical_node_lock);

Could this be prevented by using acpi_get_acpi_dev() to acquire a reference
before calling acpi_dev_get_pci_dev(), and then releasing it with
acpi_dev_put()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/12935400.O9o76ZdvQC=
@rafael.j.wysocki?part=3D2
