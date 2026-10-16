Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01C379998;
	Fri, 16 Oct 2026 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187011; cv=none; b=t/H66Sd9M7XkNVrIN8ippe1ZG82HGkWClC0bgfQmcacIqSYAE8KOLauPsNncd1ksnWDo3t/vpbI5W9d1fG9Flg9k/3u8gzdJoPvRklBVZ7wYcdyOVt64eNSJ08DBhbACMWZpT7mMpXIwN8D9h6N4FbmXuBTkGiSTpq/hecmLcMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187011; c=relaxed/simple;
	bh=5ni9DWOhhkA6ZJMpivpMZJ/ffnQ58jGVkOB6Wp18s9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sooNBgSupxLpS37DwmebrAyIN0pXITnPMOQlXH/lTKwQalK8NrYVsO+j3joHcFNWILk4absUsV2qvwLRH0CxIXCJTsGbzSMZk6GnKoho8y3AW10RLGvI23U9NSE3DOlaDPPsqn665x+LwIpV8k1NFNxt39ltPy4D/DfQZuLRmM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUcTsyYw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUcTsyYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5891F000C4;
	Fri, 16 Oct 2026 21:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792187009;
	bh=OBNIk6GoeiU0KnlnafzMX+l37pZvubkqJSQdyn+9OqA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UUcTsyYw7p+QaiI/82XOMyszxWhbgxO5ajlXU/cERhbYXKfFN6+3JDyTjQF9t3UI6
	 iAfZEQLi0CECOTsIYXRhP9IGVr7Fr85HQBpZFJ+oRuqO9Bxbl9BMsJ2Cvf7i/4IccO
	 WBA2H+/kZfW2vb6h26JUJEH9imRMaFwDkq37kk7JC834HyKE2tPx1DbBoo0AgGA3q5
	 0tNKTK/PAunpnL3thq8rr7AMdKVbQc81Bxr0NnEyy+sEvEG4IcKJOVaUfgHYCyffml
	 7IpoESXjnieEfW4SnWw2E7eau9RF90SYLLHIKcxzDRCIHvnA2gUkce8RMW8+8i08py
	 9Y0tD+I/0gnRA==
Message-ID: <d8a95ffc-d4ab-4c45-9d6d-53c49e3137aa@kernel.org>
Date: Fri, 16 Oct 2026 16:43:26 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Disable async suspend for AMD rev 0x62 ACP and HD
 Audio
Content-Language: en-US
To: Diogo Sousa <diogogsousa@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 David Glushkov <david.glushkov@sntiq.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261016135042.44914-1-diogogsousa@gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261016135042.44914-1-diogogsousa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/26 08:50, Diogo Sousa wrote:
> On AMD platforms with a revision 0x62 ACP, such as Dragon Range and Fire
> Range laptops, the HD Audio controller usually stops responding after
> resume from suspend:
> 
>    snd_hda_intel 0000:69:00.6: CORB reset timeout#2, CORBRP = 65535
> 
> Audio playback then stalls.
> 
> The ACP (function 5) and the HD Audio controller (function 6) share an
> audio block whose power is gated by the firmware.  In the AMD CPMACPV4
> SSDT, the _PS0 method of each function marks the function as present
> and then calls a common method that powers the block up only if exactly
> one function is present:
> 
>    Method (_PS0, 0, NotSerialized)  // ACP; AZAL sets M279 instead
>    {
>        M278 = One
>        M276 ()
>    }
> 
>    Method (M276, 0, Serialized)
>    {
>        Acquire (M27E, 0xFFFF)
>        If (!(M278 ^ M279))
>        {
>            Release (M27E)
>            Return (Zero)
>        }
> 
>        // Power up the audio block.
>        ...
>    }
> 
> The presence flags are set outside the lock, and M276 calls a debug
> print method before the check, during which the AML interpreter can run
> other threads.  So when the PM core resumes both functions in parallel,
> both flags can be set before either _PS0 reaches the check.  Both _PS0
> methods then skip the power up, each assuming that the other function
> did it.  An ACPICA trace of a failing resume shows exactly that: the
> M276 call of the ACP sees both flags set and returns early.
> 
> Disable async suspend for both functions, so that the PM core never
> suspends or resumes them at the same time.
> 
> This started with v7.1, which moved these ACPs from the RPL driver to
> the YC driver.  With the ACP bound to the RPL driver, test resumes
> worked, but it isn't clear why the YC driver makes the race so much
> more likely.
> 
> Fixes: df4148a5a3cf ("ASoC: Add DMIC support for the AMD RPL platform")
> Link: https://github.com/CachyOS/linux-cachyos/issues/950
> Assisted-by: LLM
> Signed-off-by: Diogo Sousa <diogogsousa@gmail.com>
> ---
> Tested on an ASUS ROG Strix G16 G614FR (Ryzen 9 9955HX3D, BIOS G614FR.317):
> without this patch (v7.2.9), every resume from s2idle broke audio; with it,
> on top of v7.3-rc7, three resumes in a row worked.
> 
> This also covers the MSI Raider A18 HX A9WJG, for which a quirk matching its
> subsystem ID was posted:
> https://lore.kernel.org/r/20260606204547.11945-1-david.glushkov@sntiq.com
> 

Before you go down this direction, can you please check for a BIOS update.

There was another issue very similar to this which was fixed by a BIOS 
update.

https://gitlab.freedesktop.org/drm/amd/-/work_items/5529

>   drivers/pci/quirks.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index de9bbccda21f..d4e4ab3c332e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1901,12 +1901,44 @@ static void quirk_jmicron_async_suspend(struct pci_dev *dev)
>   }
>   DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE, 8, quirk_jmicron_async_suspend);
>   DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_CLASS_STORAGE_SATA_AHCI, 0, quirk_jmicron_async_suspend);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_JMICRON, 0x2362, quirk_jmicron_async_suspend);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_JMICRON, 0x236f, quirk_jmicron_async_suspend);
>   
> +/*
> + * On AMD platforms with the revision 0x62 ACP (e.g. Dragon Range and Fire
> + * Range), the firmware power gates the ACP (function 5) and HD Audio
> + * (function 6) together.  The _PS0 method of each function marks it as
> + * present and then powers up the shared audio hardware only if the other
> + * function isn't present yet.  The marking isn't done under the lock that
> + * serializes the power up, so if both _PS0 methods run concurrently, they can
> + * both conclude that the hardware is already powered up.  The HD Audio
> + * controller is then left unpowered, with all its registers reading ~0.
> + *
> + * Suspend and resume both functions synchronously, so that the PM core never
> + * transitions them at the same time.
> + */
> +static void quirk_amd_acp_hda_async_suspend(struct pci_dev *pdev)
> +{
> +	struct pci_dev *acp;
> +
> +	acp = pci_get_slot(pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), 5));
> +	if (!acp)
> +		return;
> +
> +	if (acp->vendor == PCI_VENDOR_ID_AMD && acp->device == 0x15e2 &&
> +	    acp->revision == 0x62) {
> +		device_disable_async_suspend(&pdev->dev);
> +		pci_info(pdev, "async suspend disabled to avoid ACP/HD Audio power up race\n");
> +	}
> +
> +	pci_dev_put(acp);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e2, quirk_amd_acp_hda_async_suspend);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e3, quirk_amd_acp_hda_async_suspend);
> +
>   #ifdef CONFIG_X86_IO_APIC
>   static void quirk_alder_ioapic(struct pci_dev *pdev)
>   {
>   	int i;
>   
>   	if ((pdev->class >> 8) != 0xff00)
> 
> base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053

