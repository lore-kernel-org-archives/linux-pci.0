Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794557928;
	b=VSIhgFERiaVcHkzqcGasXNl75+eyrP8cGxkhn3xjNPnn78JE+iWiCgXCnZPisORELbbN
	 mK9LF539oxFntA478NtDNTo7bCElEcgpyzm2PXY1afN4kRNz88MgmLFw+/tcQBbpxEC1+
	 2KAuSw3za223D4gloRWPR4BcfriwCLwbbF/NJ/zvFpyp4cww+Wd9naa9FjwdZSg+H9OaE
	 HvqG6r3jG/UGiZzMwer2ifDHd51l2e21LoG3hLleVwKuLMoGDBhOFnyR9BLBH8aFevY2D
	 VCAcD0zJUplHgiQn5Y3ViE0nhk9Uyowihpd+FoWd+8P00P1IRFHWtYv0Meajhh6f+Bw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794557928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=xd+/2V9dVSgcQCcfh0x4nJopin8BfKQSMmEPRbkonzA=;
	b=ev6ljTNq4dQ7xZcsZLD79MTECSgpUQg4q7ZtZqhf4TQt3hpDCtzR6KtlxapOzWxQODuh
	 5w1LHf7EzaoPq+dSJMi8pXFrulJdE89kiTPPXLTratxPmTgZse48WLGxl7Yd8pPTYPGcD
	 BdQxCYu2FXIF+ORg0WYE982CrLhPEirV8mfrzuBSLeDEiEOFLmM64rd0ohLum9rxcx4Xn
	 QVHmVTn3Rlti1th7yRUw6jrJG1v4xiTOoyS/9d4LQwGubWM3VwjMKj96axMc2BJiBhWqW
	 Bsrvy0a0YeVgNg8cuUe0ZlDddkiOUkWvH/WpNkgd9tQYurmRb9EpvyK8sb0e7x2Wjdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LcGnlyZb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464E8606A323
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 08:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 464E8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LcGnlyZb
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a594d313a3so791400b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 00:18:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794557927; cv=none;
        d=google.com; s=arc-20260327;
        b=IRdmFi4ML1u1TuOg5FPRkipRkJP5hwzPDPLEpgcFFRbXUDtTPZL733IpMG+HxPCTFP
         rPbBo+y0BlC0flMTC1OVS+/9dBVvIidhtS0oNCXnf15FwIOn1faFKCl8jzB1j1xmp/na
         bqa+JkzQ5kDGaVU7m28s+nQPctKQR+6P3gv/hQ3EmznUglDT8nGvL248vI+JYAcd8cRn
         r/iEom5IpHz7vOS3Tu71Ekkn+fMfoab31h0qjhUWc02W/t2z5fcwKaR/6PZJtq6Q4y7w
         8/PJb4VtJwNaQELm1zFg/LD3FFc6p2ijncxYsEcj34jskvMwEvuNvHRflKfy3tsSv31+
         KfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xd+/2V9dVSgcQCcfh0x4nJopin8BfKQSMmEPRbkonzA=;
        fh=RRKBNNs4nsthXB9WDOG+vTWIH2rBD3mVmQncs/8q3d4=;
        b=Lrud+QT+zeBFg/D6Ch6vc3/Set3qN+i9P1pNYXscRwarC6ITng/AxFx5fAhXAv6i30
         Xqp4o3gdjsImiNwkXZ/pv/GqsDFE+SsoND21xTQ4rlsXMd9ch56Cm4mFX24KByRK2VqX
         utvv304I4iwa3Bxwj0TOpvb59kMhCQGfDDxgvxtblVS2x/xR/18G1aRE09Ev/YBH42i9
         oBGOZLvJcDyIhtndDWsRnSsJncZV7A2/dybl11zDmcvDoykbL+vdYDVi+7fslrE4dRya
         2cGDZlQ3Y15EQft7QedC5xajKuR5GJUzS93a+YmfoKAq+/H+82w702PEDihSoQGxR0Kq
         Kvng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794557927; x=1795162727; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xd+/2V9dVSgcQCcfh0x4nJopin8BfKQSMmEPRbkonzA=;
        b=LcGnlyZbAGynNuw00EbyMtmhBGuQHUi5jq0peV3XxKnaaXPSbHADFLoyvL54MLibYw
         5n1XvWC8PqlNNp7TqiBKqA0eTIleLfdcnn+CJgtO5SKAUQrXUSFsjZ8N/3fzEZtf64YH
         dF+5KHWyFOutT3HYCZwEjaeIx4YHN2bKO8WGZT+TW/JbE9eCI91X8b7KXxjTVvxRr1M7
         +dGaZ/sF1Zve9xugvyf9qwqoozob2v7XZAYPuAcUP1hDE1tzWJVQN/ycf8VVS0Ezz7vG
         41u87zWu3JPav+YPjnj5oSzRz3/rfQkrmH68t4S6ZAVPxrq3y0aMsphKZEq/TN5IuQ1o
         Tygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794557927; x=1795162727;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xd+/2V9dVSgcQCcfh0x4nJopin8BfKQSMmEPRbkonzA=;
        b=KyUY28gn8gHktue2TjG+u4HoKJPXhpP8iQx2XVpmOaNmDPwDJV0Ch14AHgmfrrazEF
         qDKn46kWk/fCNMbDPOKmiRLk1NpcVZhzQt33G6vy2FRdkFb8iTHxKJlrLQh3V1qm/ybv
         ObVw+a30RZN0SVXvVoj3J1sWZClwHM9PnARlwgfOzyCCgfcRXMmFY+LMBjIdRDp1iIKL
         1tI+0F2YQ0CH7g9rO0xp6ih/cZHBfGtgvNz96qc7574JHxKrRiTesPJToIErXjf4Ndfl
         xdik/AtSQiGrZUxdFvaTmmTl3KlxDjaiOkgz5F8zlaaGEeTBGvkIuw8CH2TFaYKgNT2S
         SooQ==
X-Gm-Message-State: APuU4Z8TgrNTIQJ/xIXBURnyu9Eb/gA/SYvG8g2wj9EqYVOM8qnz6+sE
	iOp8aIzL/RX26Dy8uUCpT0NC7KKdus5aot1ZBxQO0GULpzRne9jldgSJuqadu5aklf7sPy/Zvvx
	7WtJN3xgPGUmVaRBeaIkXr86dlRQUFuLuzSwD12A=
X-Gm-Gg: AYBFou1EoN7/vcUWDwQnt//mA7jTnMIlu7hxIM0TgxF3HWH3qw8drZpFMZWfN+BiPNT
	S/qHW/U++ZG5SYlfgtG3BkR7hEGifTiewfIZfwn9v6e01s2NddPMxY0vNonhuD2KKnhdU3Szvs5
	R5UvUBwZqM0vWEk9USNiEDJKGS5xIVyDWb+/tv+aC7juy0u7xEJ61C2CFcKBefLBip4yxKGSyBs
	5kZOYlAcdZEEsSXj7GbkbMsxow2vOP11DA43/D8BnEd+O8bxUoSqNF4H1Zh1S9Uxhp8mBdWZnET
	JEYK86t9KPosIcqB/7r5qEw3g+KzCsSfgKO0zYkxxgCOtvykoPVi3xf1DFn2Piwaic9OEXjUHWV
	7G3FOVko/7YEiRFm02EBafraWcNQoJi7zxw==
X-Received: by 2002:a05:6a21:8cc3:b0:3e2:86b6:9beb with SMTP id
 adf61e73a8af0-3f7a86d3e52mr1508354637.74.1794557927394; Fri, 13 Nov 2026
 00:18:47 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 13 Nov 2026 03:18:46 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 13 Nov 2026 02:30:03 -0500
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: lionel margueritat <margueritat.lionel@gmail.com>
Date: Fri, 13 Nov 2026 03:18:46 -0500
X-Gm-Features: AclHuK_vRbanoXsfRd3nMKnKHSC9WBzSr18OdL9kAndDRvjkGPKIyGfiSYMImsA
Message-ID: <CAL0aDZ_HOq1Sof90GJoBDzPo7Gmr7P_rSnYJaN75QH4K+iodpw@mail.gmail.com>
Subject: [PCI/Thunderbolt] Intel Titan Ridge DD (8086:15ef): ACSViol on
 link-local LTR Msg (route 100b), possible ACS Source Validation false positive
To: linux-pci@vger.kernel.org
Cc: linux-usb@vger.kernel.org, bhelgaas@google.com, mathias.nyman@intel.com, 
	westeri@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Linux PCI, USB xHCI and Thunderbolt maintainers,

I am requesting review of a reproducible Intel Titan Ridge DD PCIe ACS
Source Validation violation on a link-local LTR Message TLP. The goal
is to identify and correct the first rejection without disabling ACS,
AER or IOMMU.

Hardware: GEEKOM A7 Max AMD USB4, BIOS 1.26 (2025-09-15); ACASIS
TBU405Pro Intel JHL7540 Titan Ridge DD, NVM 69.84, 40 Gb/s. Ubuntu
24.04 HWE 7.0.0-43-generic.
Both reproduced boots use AMD PCIe tunnel root 0000:00:03.1 -> Intel
upstream bridge 0000:06:00.0 -> downstream 0000:07:01.0 -> NVMe
0000:08:00.0, plus downstream 0000:07:02.0 [8086:15ef] -> Intel xHCI
0000:09:00.0 [8086:15f0]. Earlier privileged data showed ACS Source
Validation enabled on the xHCI-side bridge; current non-privileged
lspci -vv does not expose PCIe extended capability registers.

Current boot (signed experimental Thunderbolt timeout module; kernel
timestamps in seconds since boot):
[1532.142389] AMD 00:03.1 pciehp Link Up
[1532.273384] Intel 06:00.0 bridge configuration invalid ([bus
00-00]), reconfiguring
[1532.280...] Bus and BAR assignment completed for endpoints
[1532.282964] xhci_hcd 09:00.0: xHCI Host Controller
[1532.824413] Intel 07:01.0: Correctable Data Link Layer BadTLP [6]
(NVMe-side bridge)
[1533.779213] Intel 07:02.0: Uncorrectable (Non-Fatal), Transaction Layer
[1533.779233] Intel 07:02.0: [21] ACSViol (First)
[1533.779243] Intel 07:02.0: TLP Header 0x34000000 0x00000010
0x00000000 0x00000000
[1533.790681] xhci_hcd 09:00.0: AER: can't recover (no error_detected callback)
[1533.790732] Intel 07:02.0: AER: device recovery failed

The Correctable BadTLP was observed approximately 0.955 sec before the
ACSViol, but on the separate NVMe downstream branch; causality is NOT
established and an analogous pre-ACS BadTLP has NOT been observed on
the previous stock-driver run.

On the previous boot with the STOCK Ubuntu Thunderbolt driver, the
same xHCI-side switch port reported first ACSViol at t=2459.768614 and
the identical LTR TLP header. Across different observation windows:
stock 75 identical ACSViol headers / 74 xHCI recovery failures,
experimental 39 headers / 38 failures. Counts cannot be compared as an
improvement.

The packet appears to be a link-local routing 100b Message TLP with
code 0x10 (LTR) and Requester ID 0000. PCI-SIG ECN of 15 April 2026,
'Access Control Services (ACS) - Source Validation Clarification',
discusses false Source Validation errors for locally routed Msg TLPs
(100b, 110b, 111b):
https://pcisig.com/PCIExpress/ECN/Base/AccessControlServicesACSSourceValidationClarification
This is a strong hypothesis, NOT a confirmed Intel silicon erratum.

Unbinding only Intel xHCI stopped new ACSViol while the NVMe continued
to enumerate; no new ACSViol since 12 Nov 19:30:05 CET. Sustained NVMe
I/O has not been validated. ACS/AER/IOMMU have NOT been disabled or
masked, and no firmware has been flashed. Both USB4 domains report
iommu_dma_protection=0. Please do not suggest wholesale ACS disabling
on this Thunderbolt topology.

Questions:
1. Is the LTR TLP with route 100b and Requester ID 0000 valid on this
downstream switch port, and should ACS Source Validation exempt it?
2. Is there a known Intel Titan Ridge DD JHL7540 NVM/silicon
limitation, or a device-specific signed firmware correction? ACASIS
support has been contacted.
3. Could an init-time software quirk or firmware correction handle
this without weakening device isolation?
4. What passive pre-reject tracing/register evidence would you want
gathered during a future supervised maintenance window?

I can provide sanitized full dmesg/lspci/topology evidence. This is
not a claimed mainline regression; no clean upstream reproduction has
been done, and the experimental build is tainted.

Regards
