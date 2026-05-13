Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AA720010A;
	Wed, 13 May 2026 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683702; cv=none; b=AWP0FkMnLRwyE74o4Ul7kkCLztZsQqJzN1hDHs7v0MZPKcPEReX3/aS+Wgu9fIAh3G5uM3RNAuVw15z674OliBF+WWYMhseMRMoqN4Op6/BzQQBS9QELhXA4NJwAwg1Po5P5pl2XJplTj2QqPQfbktLxk0EKfDDMKIUDibL3fow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683702; c=relaxed/simple;
	bh=nEmiCF6b5LfZ2kHKUKhThiK1MHbozn7yi/GBKke71jQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zf97vQGICdXNrsV9h7MoMNUyD7Tko+K6Nrf5XhnixckkxSjaDwjy/UwmQt2M3D0V4KXPVU3urcX90J3UbzYeuOOWeL3TRwkdIKGFD+oPwGJD1gcokT3LcfEvFWLrBsQaJj0B9OHK9kxygCSQCSS5SV6cwNdnS0sdJxfBeqeLFAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cM/nbQZn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cM/nbQZn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0142CC19425;
	Wed, 13 May 2026 14:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778683701;
	bh=nEmiCF6b5LfZ2kHKUKhThiK1MHbozn7yi/GBKke71jQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cM/nbQZnxhoUBvxlr1XOcfgS13OwM6T6zV6y5h9LOS52MIjJvsxz1bkELetuRrynP
	 buoOLf9sCIXeM7onQX+aEzf/vZwhofMcQopZR/mfuH6cvmGhkd0DVzC/eKAklpRJe5
	 y24RrLjap7NeSbZuh7yJR8OgDejSZ2/JrGvgVE9Ekr6hjJCNxRX9G9upIpBjJFVJ6k
	 xzLrMfpTPM8duhRB2qjAuuV0WsJOh74R40c+i5/nlxaFb1a/4P3NHOsKFKFRRjX5Fh
	 E9fD1sKAzyNFqrdNv/kpCF4gxaKT41u5c8jEQtJzDx/C7Tylt9vwHO9+zjvSPnoR+O
	 M5Fur968h7POA==
Message-ID: <c94e9352-91e3-4bc0-bb29-f522c78b03ab@kernel.org>
Date: Wed, 13 May 2026 09:48:19 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] AMD Promontory 21 xHCI temperature sensor support
Content-Language: en-US
To: Jihong Min <hurryman2212@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260512213910.871859-1-hurryman2212@gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260512213910.871859-1-hurryman2212@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/12/26 16:39, Jihong Min wrote:
> Hi,
> 
> This series adds temperature monitoring for AMD Promontory 21 (PROM21)
> xHCI PCI functions.
> 
> Patch 1 adds a small PROM21-specific xHCI PCI glue driver. USB host
> operation is delegated to the common xhci-pci code, while the PROM21 glue
> publishes an auxiliary device for optional sensor support.
> 
> Patch 2 adds an auxiliary-bus hwmon driver that binds to that auxiliary
> device and exposes the PROM21 xHCI temperature value as temp1_input.
> 
> The hwmon driver reads the sensor through a vendor index/data register pair
> in the xHCI PCI MMIO BAR. It does not wake the parent PCI device for hwmon
> reads; if the parent is suspended, the read returns -ENODATA.
> 
> Changes in v5:
> - Add support for AMD 1022:43fc PROM21 xHCI controllers and document the
>    new PCI ID.
> - Make USB_XHCI_PCI_PROM21 depend on X86 and default to USB_XHCI_PCI.
> - Keep the PROM21 PCI glue built-in-only when enabled, while allowing the
>    hwmon sensor driver to be built as a separate module.
> - Move PROM21 xHCI PCI device IDs to xhci-pci.h so xhci-pci.c and
>    xhci-pci-prom21.c use shared definitions.
> - Pass the parent PCI device, MMIO base, and resource length to the hwmon
>    driver through platform data defined in a common header, instead of
>    inspecting the parent driver's drvdata from the hwmon driver.
> - Remove the private hwmon mutex and rely on hwmon core serialization for
>    this driver's callbacks.
> - Clarify that the driver only serializes its own hwmon callbacks and does
>    not synchronize with firmware, SMM, ACPI AML, or other possible users of
>    the PROM21 vendor index/data register pair.
> - Use readb() for the temperature data register, validate the value before
>    writing the output pointer, and drop the 0xff invalid-value check.
> - Use pm_runtime_put() after successful reads with the parent device active
>    so the PM core can re-evaluate the parent device's idle state.
> - Simplify the documentation and use more precise terminology for the
>    supported device.
> 
> Jihong Min (2):
>    usb: xhci-pci: add AMD Promontory 21 PCI glue
>    hwmon: add AMD Promontory 21 xHCI temperature sensor support
> 
>   Documentation/hwmon/index.rst                 |   1 +
>   Documentation/hwmon/prom21-xhci.rst           | 101 ++++++++
>   drivers/hwmon/Kconfig                         |  10 +
>   drivers/hwmon/Makefile                        |   1 +
>   drivers/hwmon/prom21-xhci.c                   | 238 ++++++++++++++++++
>   drivers/usb/host/Kconfig                      |  20 ++
>   drivers/usb/host/Makefile                     |   1 +
>   drivers/usb/host/xhci-pci-prom21.c            | 123 +++++++++
>   drivers/usb/host/xhci-pci.c                   |  11 +
>   drivers/usb/host/xhci-pci.h                   |   3 +
>   include/linux/platform_data/usb-xhci-prom21.h |  22 ++
>   11 files changed, 531 insertions(+)
>   create mode 100644 Documentation/hwmon/prom21-xhci.rst
>   create mode 100644 drivers/hwmon/prom21-xhci.c
>   create mode 100644 drivers/usb/host/xhci-pci-prom21.c
>   create mode 100644 include/linux/platform_data/usb-xhci-prom21.h
> 

Thanks for the driver.  I think this looks good now, and thank you 
especially for documenting your reverse engineering efforts that led to 
it.  If there are problems in the future I'm supposing it's going to be 
based upon the calculations with the magic values to scale numbers.

There isn't a lot that can be done in the event that BIOS is accessing 
the same register pairs, but since you identified that this is exactly 
how Windows HWInfo64 does it too; this is 'probably' low risk.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
