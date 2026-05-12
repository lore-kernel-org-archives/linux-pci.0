Received: from outbound.st.icloud.com (p-east2-cluster4-host10-snip4-4.eps.apple.com [57.103.78.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C72386425
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 21:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622600; cv=none; b=eWx/NCQDAuvqQrfIm6STaG8KRKFN5vMBiZzNyqRjnzDFnTN5NE39MHbAmU19qWPo70v7bw52TwMwtht0sFAjI5fHJqv9tDoij5e6+ZK2fz2YhyX8Z3L4a+X+t99/d3a4M4CQ9KNbuXi0KL/bJ1naGA38SBjwpPxjsXQ89ScHIKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622600; c=relaxed/simple;
	bh=LpIMpr0LF4SB+v0flh0pN80bH90pV+XyRBRxCoqwfYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRjwyw1PkwoOYfxRtymb/RWcIckrA7KFA+b4b1UykcJznH2SZ8E61Lph5Ydvw6FV64zVQ+SfiFlaYH66gRa5ftduGLc0CRxUqPcIqAQGZ51EGMDYZeS+z01Rr/wQZK//kgPMFo3jUWuNKrXplKLZ0YyL4INFr0u+ijVgDDHwLtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=OjTBGWk5; arc=none smtp.client-ip=57.103.78.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="OjTBGWk5"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-3 (Postfix) with ESMTPS id AC82D1800FD3;
	Tue, 12 May 2026 21:49:53 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtPHV8EWRxCC0gdXAdLVxQEEEYfRRJfEVdKAVwFK1sTVRdGCRkIXR0ZHldQXx5AAkAVUgMFWQNCeRFQAVgeVl5aF15NRQgPQQpYWwhbBA8fTAxRAkIFVl5KDB0EVAddBV1WUAJaS0IES0VoXAVcHEAXSB1faktWFAQRUAFYHlZeWhdeTVoCVk0FHQJbAlMHSV1VCghTCR9EDB4KQA9cUEQUTgpaAA0LRABNBFRVK1sTVRdGCRkIXR0HWEcURw4PGVoUXBhT
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778622596; x=1781214596; bh=Kppyk8UEPsrLyrcDoqcp3aNUHPA1vxN2Oz1CPm1YMKs=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=OjTBGWk5pnfPfi/OnGwNrVf36r09bBwk2pEKVGtD05ziHLzyqhesxRmxzNO6ohh7+sRlHpo6nec7Vdsj1n5MP8SQXSsusyKbV6uIVWxE8q18ko3QlUDCbYJy4Jk8ypSQ3bQUL3paZZJ5yVb8r/TQyEO7kR6VjCaKj4l9oEVArXVX6Q3kumBuNPojZbE8fgI0g7cYMal9aDQuFHkFkVXcC0X0G6lu+i5YiHNlfKxqHAnYFYADdTwiBfaoYnsepSElK+EtYfOQjGVPyGa4U75SqsP9FnPrnEqVLNwqUT71/opxl2JlLX0SxZnQdxqmI1VvB/JGGvdWD9yQfLG7Pjp45w==
Received: from [192.168.89.2] (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-3 (Postfix) with ESMTPSA id 0B2DA1800106;
	Tue, 12 May 2026 21:49:49 +0000 (UTC)
Message-ID: <e165859d-9edb-45f9-87b4-6977f949579b@icloud.com>
Date: Wed, 13 May 2026 06:49:47 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] AMD Promontory 21 xHCI temperature sensor support
To: Jihong Min <hurryman2212@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260512213910.871859-1-hurryman2212@gmail.com>
Content-Language: en-US
From: Jihong Min <hurryman2212@icloud.com>
In-Reply-To: <20260512213910.871859-1-hurryman2212@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIyNCBTYWx0ZWRfX9r+w2S4MTOg6
 QS94keHT0GwyMXxQcrK52R66hUWbm6hQ/uogWpE+2GQ1CmX93gMwT7Xwh24OwZ0sMtwbzr7PSTN
 e60OKQZ7wzNv4lAyyqjLDvgUSqq58XvI03tu0k902fh6M4LIbDdow1bf8i15/hq0cia70SgUfDN
 TsiCWFeBO6rIWDMg8sOSXVZt5B/v5umvdzXqPrfPX4bY9wRKtl0Wv8p6l2dx1zOMeqsYeatMQu2
 L+dWt0qVTxlune3li7Ulxd2iwXBWFe3qlfE1feR2HVVi/vJQRqa9zeX9l4FFHSZ5T6g88p69GO7
 PYIRDM7eU0n10JGX9JjsHlUonh2wysg2wpQ+xUHtWZaD3accSkU0lWAJKnZDUg=
X-Authority-Info-Out: v=2.4 cv=aKv9aL9m c=1 sm=1 tr=0 ts=6a03a083
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=5jDBv52wX64A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ueiO3zYk3rD1nXv0G94A:9 a=QEXdDO2ut3YA:10 a=PgRulw5oR9JgysbTFEid:22
 a=a4GWJDV2amYnlPsuj24T:22
X-Proofpoint-GUID: LQyB5dHg36abhvxfwI6_XNREqIBEcBcA
X-Proofpoint-ORIG-GUID: LQyB5dHg36abhvxfwI6_XNREqIBEcBcA

One additional note about AI assistance and authorship:

I am adding this note because this series has been mentioned in some online
discussions as a newly written Linux driver carrying an AI assistance 
tag. I do
not want this to create confusion about authorship or responsibility, so 
I would
like to clarify the scope of the AI assistance.

The initial hardware investigation was my work. My starting assumption 
was that
the value was exposed through MMIO. I identified the paired MMIO 
registers, and
the empirical conversion formula was derived from my own testing, 
starting from
the assumption that the raw value could be mapped with a simple linear 
formula.
AI assistance was used for writing and refining test scripts around my own
probing library and existing tools such as pciutils, but the probing 
approach,
comparison with an existing tool (HWiNFO64), and interpretation of the 
results
were mine.

The first hwmon implementation, including the MMIO access sequence, was my
work. I used AI assistance while figuring out how to integrate the 
driver with
the existing xhci-pci infrastructure, especially around managed resource
handling and lifetime management.

After review feedback, the design moved toward an auxiliary-device 
model. That
direction came from the reviewers. Since I did not have prior experience 
with
the auxiliary bus, I used AI assistance extensively while implementing and
iterating on that part. I reviewed and tested the resulting code myself, and
also used AI-assisted review passes to look for mistakes.

In later revisions, the PROM21-specific PCI glue driver and the 
platform-data
handoff between the PCI glue and the hwmon auxiliary driver were implemented
based on reviewer feedback and my own PCIe driver experience. The runtime PM
policy was initially chosen by me and later refined through review feedback
from multiple reviewers. The implementation was structured by me based 
on that
feedback, with AI assistance used for additional code review and 
implementation
checks.

Runtime testing and validation were done by me, using the methods 
described in
the driver documentation. The decisions about which reviewer suggestions to
accept and how to revise the design were mine.

I am disclosing this because I want to follow the kernel project's 
guidance on
AI-assisted work and be transparent about the process. The Signed-off-by 
tag is
mine. I understand that this means I am responsible for the submitted 
code, the
design choices, the testing claims, and any mistakes in the patch series.

AI assistance was also used to review and polish some of my English email
replies and documentation wording. I reviewed those texts myself before 
sending
them.



P.S. Thanks to Yaroslav Isakov for testing the series on a B850 system and
reporting the additional 1022:43fc PCI ID variant.


Sincerely,
Jihong Min


On 5/13/26 06:39, Jihong Min wrote:
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
