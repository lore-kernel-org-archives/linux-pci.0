Received: from hermes.f3n.de (hermes.f3n.de [212.204.115.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3272FDC3D;
	Mon, 16 Mar 2026 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.204.115.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773672719; cv=none; b=ltMyLZbphP6wzP/LezrUYhngUmG9WYyWSjDDvK3T2Nz8xyqK7Tx2XFCguxY38d3qPjpQ/39bDI6TIIhrtjEXln7QwkMXGGS1qt9w3w7oSDdDjYMHKeWujyGVh65T/T2zRmKCqGdHKVxUPvzB2nfZNqPZXjHZtvDjw88jpctPRD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773672719; c=relaxed/simple;
	bh=78PKWBBTckDNf8W1c7v9X9PPGSOJD6IKwuTftDVMhu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFwozuHykXE4yT3pEIk0j1MHpQW/MIL7B9ac3oiyvTaZ4hXA7kGn/HUzS7PS+c5gDfhtT4uaOfo1g/YaK8xQ/Zd/3VqYbWZCpgFhCQyIcguwcFl4aqUa2yMZ1tD5cTWuf3N6evP18Gqi3PRxTQunMJw8jODunIKzHUZZZPCUiWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fen-net.de; spf=pass smtp.mailfrom=fen-net.de; dkim=pass (2048-bit key) header.d=fen-net.de header.i=@fen-net.de header.b=HJIPrPXu; arc=none smtp.client-ip=212.204.115.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fen-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fen-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fen-net.de header.i=@fen-net.de header.b="HJIPrPXu"
Received: from [192.168.178.55] (ip1f124e75.dynamic.kabel-deutschland.de [31.18.78.117])
	by hermes.f3n.de (Postfix) with ESMTPSA id 1A4613000F30;
	Mon, 16 Mar 2026 15:43:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fen-net.de; s=ds1-f3n;
	t=1773672217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RQm7xresWjvF9sNcKRMghw13/uCAmMCBZZabe7x5Tzc=;
	b=HJIPrPXuHoIwhuDfbylsZk3Xq/Uku7SVzXXerk0504auOOn1xjcBfpcJrpKh12PHmQ5SGz
	Y8Tn+LFJnp6wsmPOvgmNIRFgVmjgD0hsZ/w2uZ7qQnl8MvzUaB5nRvb9lRA8HbeuxahI/P
	n5ame47Jsw9zqKCjpYxG3e8yErokeX0j0hssWXkZUGeN6skYpQ83KLgGyYnslCb8eto005
	ywhvpV5q7kVW6m5T9CgHiqAx0nJOsjABIVX94cTI2QEBxljL/iR4+3c2U5myYQzAVl9nEO
	Z/Z9mssGQIhuRHTkZzyRKqwlKwRwRGt5amOhg2Q9pPCNHTlNc8+UeH+9WP4pdw==
Message-ID: <e81045f3-4446-49e7-b9bb-44245766098a@fen-net.de>
Date: Mon, 16 Mar 2026 15:43:36 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PCI/bwctrl: Disable BW controller on Intel P45 using
 a quirk
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Adam Stylinski <kungfujesus06@gmail.com>
References: <20260116131513.2359-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US, de-DE
From: Roland Ziegler <ea3393@fen-net.de>
Autocrypt: addr=ea3393@fen-net.de; keydata=
 xsDiBDuf0YURBADsCCoG/vjnXFkf4F6HxUgRh7ueD3EpvRauJIR0IE0hFkQ1E4Z2Q2896ovK
 Dh+se07P1kyfif6KkBfTuXU3FExI3X7sR7xrEoNHLV4IxMlDaaWRkOu6h5lMxDoxa5RMnkTQ
 teVSC4nfSqWHG1XOk2PEcaYIJnwbkM6JrlRSxDDkaQCg/4FlKCaW9okVTPXZLEVhvjSIjmsE
 ALMB+48nM4WlCEfPfULV4/wjPONBah8nM2MEkqrofZ5mAzv9sJhMa58xvqX1/EFKEKz0R0JE
 0mKk1oiwrThB4oGvfZU/YFgerKm4a5ITVe/H2hsmVcqMKE7slDiz4ar+Rc4GDKCetbIhjGvF
 68GxjOiapHeM6hHYxEAilzmzf1JrBADR5T54z89AN0zX8cfnxuAeHdyw/ycVI0slF+Gf2+Zz
 QOgOeamMBjdaduzW1knTNwlYYpyv2mbDQrhht5oVTVm6JB0jhef/w+kkVqbRZdgD+whR4Hdx
 u9ZaK0M5MpvW6fC1cN1BO7PUgTqET0wJWK9PIpGi6GSFcZAsf/kL2ePkKs0aUm9sYW5kIDxl
 YTMzOTNAZmVuLW5ldC5kZT7CWAQQEQIAGAUCO5/RhQgLAwkIBwIBCgIZAQUbAwAAAAAKCRAk
 mQ2yhQMA3UbOAJoDD75klDT4RePJ7xBuFDaaLpIxTgCfTObr1kJXyGZbJWcEBxM1SsGsk6LO
 wU0EO5/RhRAIAPZCV7cIfwgXcqK61qlC8wXo+VMROU+28W65Szgg2gGnVqMU6Y9AVfPQB8bL
 Q6mUrfdMZIZJ+AyDvWXpF9Sh01D49Vlf3HZSTz09jdvOmeFXklnN/biudE/F/Ha8g8VHMGHO
 fMlm/xX5u/2RXscBqtNbno2gpXI61Brwv0YAWCvl9Ij9WE5J280gtJ3kkQc2azNsOA1FHQ98
 iLMcfFstjvbzySPAQ/ClWxiNjrtVjLhdONM0/XwXV0OjHRhs3jMhLLUq/zzhsSlAGBGNfISn
 CnLWhsQDGcgHKXrKlQzZlp+r0ApQmwJG0wg9ZqRdQZ+cfL2JSyIZJrqrol7DVekyCzsAAgIH
 /i3/MTr4ZTy5iru7Mn/o7dcfYBkHfiVac3KKHmWCvEnZmwKtNNEseBc16pLjGRm1ATGCJYWX
 oIpYZUOfYHXFwuux9ofKrvC1gakTvh2DMrkpWSJ+octTNVVYJFiv/Wlulvk/nvcMx+24yZmQ
 Uqjjt7zjmc0U3hOJKpRtB6kt5ulr3nGxuGZ8gRBmSA/ygsIobaVPYXOhOSm+9JNZyeSJ2C+a
 1C1Scg3jZA5vo6yqdXzYmXGfriii7cqaXGAXmauQAE9DpZ/xtFxaLdTQwOhLd8A0nAEi76Hs
 oNTFaIMTDY0xdCsDC1wDWTa7yWnhgBiGA2iAPSmY/quBw0pod7qPmjnCTAQYEQIADAUCO5/R
 hQUbDAAAAAAKCRAkmQ2yhQMA3StFAKDXoOTEsSCLDEOWewQlmzUwbaECxwCg3OVWblLOzxfW
 9mXh/YFerX6r8rk=
In-Reply-To: <20260116131513.2359-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, 16 Mar 2026 13:15:13 +0100, Ilpo Jarvinen wrote:
> The commit 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as
> PCIe BW controller") was found to lead to a boot hang on a Intel P45
> system. Testing without setting Link Bandwidth Management Interrupt
> Enable (LBMIE) and Link Autonomous Bandwidth Interrupt Enable (LABIE)
> in bwctrl allowed system to come up.
>
> Add no_bw_notif into the struct pci_dev and quirk Intel P45 Root Port
> with it.

The commit 665745f27487 re-added BW notification support in bwctrl,
but on Intel P45 root ports it can cause a boot hang when both LBMIE
and LABIE are enabled.

This patch modifies bwctrl to allow the interrupts safely. For ports
marked no_bw_notif, each interrupt is enabled separately, preventing
the hang while keeping BW notifications functional.

Patch has been tested since kernel v6.13 on P45 hardware without issues.

---

Patch:

--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -190,8 +190,13 @@
 	if (ret == PCIBIOS_SUCCESSFUL && link_status & PCI_EXP_LNKSTA_LBMS)
 		set_bit(PCI_LINK_LBMS_SEEN, &port->priv_flags);
 
-	pcie_capability_set_word(port, PCI_EXP_LNKCTL,
-				 PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
+	if (port->no_bw_notif) {
+		pcie_capability_set_word(port, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LBMIE);
+		pcie_capability_set_word(port, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LABIE);
+	} else
+		pcie_capability_set_word(port, PCI_EXP_LNKCTL,
+					 PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
+
 	pcie_capability_write_word(port, PCI_EXP_LNKSTA,
 				   PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS);
 
@@ -250,9 +255,6 @@
 	struct pci_dev *port = srv->port;
 	int ret;
 
-	if (port->no_bw_notif)
-		return -ENODEV;
-
 	/* Can happen if we run out of bus numbers during enumeration. */
 	if (!port->subordinate)
 		return -ENODEV;

Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller")
Link: https://lore.kernel.org/lkml/20260116131513.2359-1-ilpo.jarvinen@linux.intel.com/

Signed-off-by: Roland <ea3393@fen-net.de>


