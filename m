Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E412C15A0
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 05:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791698032; cv=none; b=rT3frivH32G1UvvK/7oe5xw2pGb1YfAOE1uRneY0ClHmTBKlit6mqs7FVIPh22TwYT0BZ8k6u4WPeKLw36oKO+lxw6TDFkqWF8Y5uPF0k66ChJnpIU57vydpmemjXrdDhQnnKKzYmplt4+ubfNDrxZanLd/hA0OrRlKEQl3fvCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791698032; c=relaxed/simple;
	bh=528pqHjrUjmHctwU0mLzUYV/y78CAep7MG9fr4gHLVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1vmSaUuTDN37YQtdvrmjT1LvkrQrQqKrb8AoVGQ8IPXD10/jgjObjbWnekIu00EtOEX9R1ic8JN2Ke7YriKt3mapC80WjtOobpUEBBRWpE39It+CiZH8zubIXczzILPTJuXC5QrhB6X2kdDkTBzocSOlTYHf268TKV+xpLh+j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id DA3C7684E;
	Sun, 11 Oct 2026 07:53:45 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 945936107914; Sun, 11 Oct 2026 07:53:45 +0200 (CEST)
Date: Sun, 11 Oct 2026 07:53:45 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Krittikun Wongnin <krittikunwongnin@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [RESEND] PCI: NVIDIA GeForce MX230 (10de:1d11) falls off the bus
 right after "Enabling HDA controller" quirk on Acer Aspire A515-53G
Message-ID: <asskafIxufz8abQa@wunner.de>
References: <CADS-TgDQ1G8vrTQLJeQ3RTBVFTyMe0C+5p2=UBKS=EFCDFuaxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADS-TgDQ1G8vrTQLJeQ3RTBVFTyMe0C+5p2=UBKS=EFCDFuaxw@mail.gmail.com>

On Sun, Oct 11, 2026 at 10:03:11AM +0700, Krittikun Wongnin wrote:
> On an Acer Aspire A515-53G (Intel Whiskey Lake + NVIDIA GeForce MX230,
> Optimus), the discrete GPU becomes inaccessible within ~15 ms of being
> enumerated at boot, immediately after quirk_nvidia_hda() logs
> "Enabling HDA controller". From then on, config space reads return all
> ones and no driver can use the device.

That's unusual, I don't recall seeing any other report about
such behavior.

> - I have not yet built a kernel with quirk_nvidia_hda() disabled to
>   prove the quirk is the trigger. I plan to do this and will report
>   the result. The 4.15 test differs from 7.1 in many ways besides the
>   quirk.

Below is a small debug patch to avoid the write to 0x488 and also
print the current value of the register to dmesg.  Does it help?

> If the quirk is the cause, would a DMI- or subsystem-ID-based exclusion
> (Acer 1025:130f), or skipping the quirk for class 0x0302 devices that
> report no HDA codec, be acceptable? I am happy to test patches and
> provide full dmesg, lspci -vvv (as root), and acpidump output.

Yes, output of "lspci -vvvxxxx" would be appreciated.

Let's first try to find the root cause before thinking about possible
solutions.

Thanks,

Lukas

-- >8 --

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbcc..51d3b65 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5863,8 +5863,8 @@ static void quirk_nvidia_hda(struct pci_dev *gpu)
 	if (val & BIT(25))
 		return;
 
-	pci_info(gpu, "Enabling HDA controller\n");
-	pci_write_config_dword(gpu, 0x488, val | BIT(25));
+	pci_info(gpu, "Enabling HDA controller %#x -> %#x\n", val, val | BIT(25));
+	// pci_write_config_dword(gpu, 0x488, val | BIT(25));
 
 	/* The GPU becomes a multi-function device when the HDA is enabled */
 	pci_read_config_byte(gpu, PCI_HEADER_TYPE, &hdr_type);
