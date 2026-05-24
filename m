Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1B133C192
	for <linux-pci@vger.kernel.org>; Sun, 24 May 2026 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779613982; cv=pass; b=ZdnpgCy5wusslg58VL1KoXrwy3+Im59cFCiY+lWPTwIxp+0rocWnHc6xt77dKQT3pqIgwmuubMoDnt27ra6pirhwiqAcppemTrH5mzZEm/CgL0rjkrUSQa6/Ps/CY1ZMst/r10wN1pxpW9jk7Tg0uRozD/ZgulJhxufVTgV36/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779613982; c=relaxed/simple;
	bh=1YVtUUYHqKZHLdKG/YTVsOhkNPp8wNInCotB1CSUH5k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=A4okiAsaDtNEjdbkhpvF5QKbc7J6VRNZJhVkhUXA6fQXGwJtRtBNE44/ikgn04W3qpYhXbpiFb6HRn48dZjKJkpJv8PQT5FOpU6z6zkATJ/oJUdHHDRIRmm848tr74b7qC9XBGPGNQFlxZHMsZn1GyQM8USGV7A/BLEv4I1pnJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNuMRT6c; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNuMRT6c"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a8dc2606a0so9102227e87.2
        for <linux-pci@vger.kernel.org>; Sun, 24 May 2026 02:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779613979; cv=none;
        d=google.com; s=arc-20240605;
        b=cIMb89X4KVrZhLDFh7RqMNXV6nTmw8qIB8LU0CU77RiJzQreq89x2D2ullL6z717Lb
         gaQdwk6rSFVq710bUCTIKH6n1RJPm5Q6U//9xLVG1aT5UX8r9XjwrG11FUc0hbuzK2Ge
         vUBqHclpZbZC59QYFMVdZ0VgDo93KkVir7fwED5XTnc9Gze4EIzGIDO+1CYWlirOAlYl
         tVLBK1cMR3+6nbU1HOjjr1iU4Uu5HKGJhw64xhXLVYJbaQrjU3TX58W10QM9xqeA7+au
         gn9YKsJaFa3QQgI1yOM5jt1H3UJr1lWuAVf1/P5NNMrirMTYfen/eENsMBoKyVlKk25H
         gOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=XDooQDkpgZGB9pNbUbWH4WkeNvFWNhBwPeKTDwxU0pY=;
        fh=5wRQp6mbJ/FnAhfvhjDVn0enW4+u35lzc3HARVRGpb8=;
        b=OsutzFsd00WShvKiY+Oddijv4Z753nyYsSiVB9FFLolcBIjbgsY42IWB1lowO1amGz
         N2hNrQpSBQIM1ZqhXkitmKPnqXnK41gHO09H2zJ3MbHZ+vvraAx5xN/vG9RdL6d4P0Kd
         cbR6K1gTycYK/S7cc0rhQdbGPOgJOTVlcnvo7/bYkyRVOegACp7U28mNyuKgUvSx14Ox
         VoshD9Ph0PQPtkaMG3014g4xN+m3wNxa3J45kBTD9hCQ9zJ5JvLeO6PmeMIOfhEs7qHx
         cuFq1Jf1Xd3DsomUFCCJh56tdJPHECrxxTHIyKiOK2V5rZ1gzQuOi/2+bJmEpG0eFMvg
         ZyzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779613979; x=1780218779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XDooQDkpgZGB9pNbUbWH4WkeNvFWNhBwPeKTDwxU0pY=;
        b=PNuMRT6cVugqAS2pYYrcURp8mzj0B6Rg4dX8l2vwNpBT+be7bOK/K/tPUSGHaz/dv6
         PfG8DzcrudIG7uwa53cCjWY/n5ofB2lwt0E/4aDHT7v/yryfkYrMrT1JSLJDBgUYuniT
         ub7tIaqnmH2gzo7mvfJoWn92H28JI03WN0bhMOgtflrOeqpPOh2i0U+HZYjpRFgKIJzA
         h2mQk2RfzEnihqxyGqs8NYc6F780HKB5QidKA07CZxFrMUp8TRXklGJmSWXho8K3uuCk
         V4Jebr7wUcPAkln4+okAoillUjia7HxKAQpdpsF0t9Hch277mlIw3KdmFyEJVoLTB0Qq
         VK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779613979; x=1780218779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDooQDkpgZGB9pNbUbWH4WkeNvFWNhBwPeKTDwxU0pY=;
        b=RuFFumA8LeAJwpMAq8NOgQxafsaam/+9lnWjs3wqf55CRMnVgO7+G2IdVaRz1VM3+M
         PJXifuDc2hl5whFXpFvHbqjwvcGW48UloWLxPRheTkkFZKlxsy04RNzZFWU5gLkw6KKK
         B+kNcxDP8IPH9O9URWTn8+VFjmInxU576625M2dq/UUPgyYX9cFgbpYAXhRvlKVmAuwf
         Ad4e34CCkQ/r7e8xik7WQXt/l52Ax2y0FcrhIS+BiH/UvgixBv0/4KWBPS8tHbkpue2L
         onYYwtPjaO/ig6r/fGS/jTJ7jxQsZog273LGrBDyBuzyBYhaZiEZdO/trwi3MVYyJgaD
         oAYg==
X-Gm-Message-State: AOJu0YwAi2WF19ySZF8VI44FkiToVanSg9TRVrDgL6Ot78aSyZnNkctR
	Q0OYiRfcRn010v+6om7VhXM7WnQ3cmvP6P04V+mNJ3Y+ZAg8Sv9mpnameY09IO71dx9/GU7eJ8D
	2KZWPb5sedTOfJ8fuFx9nUAgxlJgvTt4ikOrLJpY=
X-Gm-Gg: Acq92OH/EqQupt7lNR37sv04plAhabR5/ZoLKKLc/jnHhfcXi2B1sS2OedHJ+Ykx9gp
	W5PMXQXNApFg4GxvPCXdX5AmIG6tHjyiiJ17D+EtHuSFRLCmNx/UsEfIAHCv/ntOrVac/NHGhC/
	6Gvmu2fbWKTuvwgaDnaO5ZsZy9uCsORoY3dRt5BS1446d+2Lg3kpsUwESZ9NaJLtPNbZi/bmYi9
	SJwd2H0cfEp6MPHnEHq5UjfqLZ92ZJ/8dYHzA9QvUZFLbBoIoMHXZ6Ve7E1/CtMk4vNEhqvK+v0
	ZkUq7lhmk+u2nj2snk6lQaHzMnnApp/B5bQBlGisXjsOtaA51jw=
X-Received: by 2002:a05:6512:1243:b0:5aa:116c:4127 with SMTP id
 2adb3069b0e04-5aa323a9065mr3414993e87.41.1779613979063; Sun, 24 May 2026
 02:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pat A <lasoyster@gmail.com>
Date: Sun, 24 May 2026 02:12:47 -0700
X-Gm-Features: AVHnY4LdIfKCFj7GfZNHbJ24yTYQGEuGNIdo6fI6XR9-klOIv5a6b2oEfI8owh0
Message-ID: <CA+jUz5KSBDTgYJVB=wUccrerXdekJ3mV_np8iat4PKDteSGmNg@mail.gmail.com>
Subject: =?UTF-8?Q?PEX88000_=281000=3Ac010=2Fc012=29_management_endpoint_incomp?=
	=?UTF-8?Q?atible_with_switchtec_driver_=E2=80=94_die_temp_inaccessible?=
To: linux-pci@vger.kernel.org
Cc: kelvin.cao@broadcom.com, logang@deltatee.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm running a system with both a PEX88096 (1000:c012, subsystem a096)
and PEX88048 (1000:c010, subsystem a048) on an ASUS x570 Board (AM4,
Ryzen 9 5900X). The switches handle 2 x GPUs and 8=C3=97 NVMe drives.

The management endpoints are enumerated as class 0180 (Mass Storage Other):

  20:00.0 0180: 1000:c010 (rev b0)  =E2=80=94 PEX88048
  29:00.0 0180: 1000:c012 (rev b0)  =E2=80=94 PEX88096

The upstream switchtec driver does not recognize these because:

  1. Vendor ID 0x1000 (Broadcom/LSI) is not in the driver's PCI ID
table =E2=80=94 only 0x11F8 (Microsemi) and 0x1055 (INTA/EFAR) are present.
  2. Class 0x0180 is not matched =E2=80=94 the driver only matches 0x0580
(PCI_CLASS_MEMORY_OTHER) and 0x0680 (PCI_CLASS_BRIDGE_OTHER).
  3. BAR0 on both endpoints is 16KB. The driver expects a
multi-megabyte GAS and tries to ioremap at offsets beyond the BAR
(SWITCHTEC_GAS_TOP_CFG_OFFSET =3D 0x1000, SWITCHTEC_GAS_SYS_INFO_OFFSET,
etc.), causing a kernel oops in ioread8 when the mapping falls into
the MSI-X table region or unmapped space.

I attempted:
  - Adding 1000:c010 and 1000:c012 to the out-of-tree switchtec-kernel
module with a new macro matching class 0x018000. The driver bound but
crashed in switchtec_init_pci =E2=86=92 devm_ioremap because res_len (16384=
)
cannot accommodate the expected GAS layout.
  - Enabling memory space via setpci (COMMAND=3D0002) and reading BAR0
directly via mmap of resource0. The MRPC registers at offset
0x000/0x400/0x800 appear to be present (non-0xFFFFFFFF after enabling)
but submitting MRPC command 0x4 (DIETEMP) with subcmd 2 (GET_GEN4)
returned status 0 =E2=80=94 the firmware did not process the command.

The PEX88096 is a 36W TDP part. Without access to the embedded die
temperature sensor, there is no way to monitor thermals on Linux. This
is a concern in systems where these switches are running under
sustained GPU and NVMe workloads. The back of the PCB where the switch
is mounted gets very hot. I want to know how close it is to
shutdown/failure.

Questions:
  1. Is the 16KB BAR intentional for Broadcom-vendored PEX88000 parts,
or is it a firmware configuration issue?
  2. What is the correct MRPC submission protocol for the 16KB
management BAR? The Microsemi GAS layout clearly does not apply.
  3. Are there plans to add 1000:c010/c012 support to the upstream
switchtec driver?

Happy to test patches or provide lspci/dmesg dumps.

Thanks,
Pat
