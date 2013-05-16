Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:50749 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755427Ab3EPIuC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 May 2013 04:50:02 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Phillip Susi <psusi@ubuntu.com>
Cc: linux-acpi@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: enabling aspm on ati radeon
Date: Thu, 16 May 2013 10:58:38 +0200
Message-ID: <1995989.Fff0uGKnZO@vostro.rjw.lan>
In-Reply-To: <519443A1.8050905@ubuntu.com>
References: <519443A1.8050905@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Add linux-pci to the CC]

On Wednesday, May 15, 2013 10:25:37 PM Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I thought that booting with the pcie_aspm=force option should make
> sure this was enabled, but passing this to a 3.8.0 kernel, lspci still
> shows:
> 
> LnkCap:	Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Latency L0
> <64ns, L1 <1us ClockPM- Surprise- LLActRep- BwNot-
> LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 
> What could be disabling ASPM?  dmesg confirms: [    0.000000] PCIe
> ASPM is forcibly enabled
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.12 (GNU/Linux)
> Comment: Using GnuPG with undefined - http://www.enigmail.net/
> 
> iQEcBAEBAgAGBQJRlEOfAAoJEJrBOlT6nu75D7gH/1/Nk62FAELr/IJR49pNFNVB
> TY0JflxJ7hRMxGUYtcKCgGLA2UrUSf95fFh11NmWMCZFRXHS/9WQXp2gr8KUGXIp
> iOlHHME2egFslbr8nUp3aHkmq0/D7lbZdK7eA1PO6hojnxapygbqt6tjpRKT7Vke
> djWz+43IiljDD7ZKz1JoUPjJIEV2v/Eg5BpXFEVEiXXFYFfjAU3ZG95/mNuvTX3T
> MraQFQOP/4kqpMc75tSsAsfMHg3ciYOt0GIYIk9SUE6mONkAY6o2g4kRgva5CwQC
> bBvhDZcQfx8QsIPlTBa74Kjjx9q7yQyOD6lkJTLE5SQWfTiBwB5ET9Dt0kKSJ/I=
> =WgMm
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
