Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272BC30EF64;
	Mon,  8 Jun 2026 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934383; cv=none; b=WZBmv04UUUqh2c124H0GCGTwZPyKt9677lrl5XWLrLLPixM22WgDvr4AL43XhgGcet2H325v42L6HVjvsYHW4OycCGxYo4PBgOdCOfdqkGMSNzqod7V7GMdt3OPwc/P+kwjH6Lg4EdvcwvcKbtYqcPRvUYRFFVfrCQLWYgT1Zyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934383; c=relaxed/simple;
	bh=hsPFwd6bFzldr9WlAPgzd2QW/6jBZKsRJPRXHnw4VZo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=I8JHocY4aq22g+8Kh3j94r1xLkNvI8fKbsxjJgdOpOFcmj4dQo7ddZ0Yui7MYuVwO6cvpLiMLyfI1nUruOtrEEJYUjJQyRJ2UAW/DUOaT9vYjV/qzsrVgG5bdaoZKcSTEDj71cr25bxo0HRILVhCl6MLTZvcL3v6gfa7fqyll00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zvx3H9TD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zvx3H9TD"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9B9291F00893;
	Mon,  8 Jun 2026 15:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780934381;
	bh=2fg3xJu2SeOTvWj9nC6kVs1L8oJdNyr9FCt7P84bJ+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Zvx3H9TDdF+B64fOTrkShwawqhfz7LIzN9h8sFsP+j4iDbu/XCT4M/PDdov8PeD7i
	 kejTQVdbMd1XijGclKcFhTCpWMpPoqzzUKTzOy38juD2r93Ny7UJHTHhD/xwg9oDMK
	 iUdkHal49uNoy8EBd/M+j2dvRFsBxhWwRSDcF+JkVLlouZ3PN5XCCLihayGH7i+tLT
	 txSzWzo3MuTH0RUM7RYAizawNvOPI8gbL48vcLFn4CGcDFCTI69MrwCwcdvpeDChNS
	 g7PU3gRYqv4Y9LXsdmrhHyYnwAeT2u3mB6BV6eNw8tuos3bT7YHCgw5v5HpwoAODJr
	 Ju2SO1MKZUFLA==
Date: Mon, 8 Jun 2026 10:59:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sumedh Thakre <tsunedh74@gmail.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: dwc: custom-arm: reduce bus enumeration latency
 by ~15%
Message-ID: <20260608155940.GA37162@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJkrBpvmxxfmnj4iwuxqEhAxUJrt4EOXmM7=sX=aNHjN8te2aw@mail.gmail.com>

On Mon, Jun 01, 2026 at 11:24:45PM +0530, Sumedh Thakre wrote:
> Hi Lorenzo and Bjorn,
> 
> I'd like to submit a two-patch series that fixes three independent boot-time
> latency regressions in the custom ARM DesignWare PCIe root complex driver
> and
> its companion device tree.
> 
> The patches reduce PCIe bus enumeration time by ~15% (7,100 µs mean
> improvement across 500 cold-boot cycles) on a Cortex-A55 / DesignWare Gen3 /
> NVMe platform:
> 
>   Root cause                          | Component | Savings
>   ------------------------------------|-----------|--------
>   Double PHY reset via .host_init()   | Driver    | ~8 ms
>   Sequential PHY + clock init (DTS)   | DTS       | ~5 ms
>   1 ms link-up poll on 2–4 ms hw link | Driver    | ~2 ms
> 
>   Baseline: 47,300 µs ±820 µs (n=500)
>   Patched : 40,200 µs ±610 µs (n=500)
> 
> Patch 1/2 adds a phy_initialized guard to prevent double PHY reset and
> introduces a platform-specific 250 µs link-up polling interval
> (compliant with PCIe Base Spec 4.0 §6.6.1).
> 
> Patch 2/2 corrects the device tree to declare explicit PHY clock parents
> (enabling parallel probe), adds the required REFCLK stagger margin
> (250 ns, fixes sporadic LTSSM failures below 10 °C), and aligns
> PERST# assert timing and poll properties with the driver changes.
> 
> Both patches are independently bisectable. The series has been tested with:
>   - 500 cold-boot iteration benchmark (ftrace timestamps)
>   - dtc validation and dt_binding_check
>   - dt-validate against dt-schema
>   - Sparse (make C=1): no new warnings
>   - checkpatch.pl: 0 errors, 0 warnings
> 
> The patches are attached to this email and are also available at:
> 
> https://github.com/tsunedh74-droid/linux-pcie-custom-arm-latency-fix/tree/main

If it's possible to send the patches directly as responses (not
attachments), that would be better:
https://people.kernel.org/tglx/notes-about-netiquette

Looking at the github tree, the patches touch
drivers/pci/controller/dwc/pcie-custom-arm.c and
arch/arm64/boot/dts/vendor/custom-arm-pcie.dts.  Neither exists
upstream.  Maybe this work is based on some downstream tree that
includes a driver that isn't yet upstream?
