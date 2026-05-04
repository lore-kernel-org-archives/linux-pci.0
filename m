Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAA429E0E5
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919383; cv=pass; b=VaJpe5+Dk/NFI4B4e61fZ5uZcrXWwNRBnrTCbn2V3/OeLqmbAUKoIRukDrYcMBSQFMH6mj28yXmw919WMWr3XNrq8MxS/1LKEJgwFxLflzwVC5RB1WZ4udtFc+6oX/PjtHTy8P29A+vYaNWvpTZoNgelpmclWdHnrSEbvTJzYu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919383; c=relaxed/simple;
	bh=XFi6ghAMGpAQveSaIOf7LzX7URi7P2D3gGjZFi13awY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCm+S+svMUmFC1z3tVrlIBeqY9JIcqVTRYEVbjMTYfTwTY+pcJRCE1Kl507P8AiS7bIW2tieHEn3VPmo/qiwliTnu27m5AGiN/Tqv4D7OIrq60MWlkB40WMLfo06K/A7SXQNzmgD87xcyMUOq7w4mR7uG/FNXTVYartZnrrw0mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hkkm/+u8; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hkkm/+u8"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a4113ab355so4242998e87.1
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2026 11:29:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777919380; cv=none;
        d=google.com; s=arc-20240605;
        b=OKHlvmw7gF0c+rBIh8/fAjRvc5m9/xs8XbKGJnGNxCqqToEJVPSSmvPQWTtfz8cqBO
         kJrElwMOzWfKF5gxIL5tLGCqnh2rwVnHh9VWWchb4oU5lKNgjGMw290X3ksRPLTOg88y
         UC1Ohc3oRLh+Era6MPNXmg7uef+rya/tw0bz5PTPTBBbBldbjslwMpE1hZRMQQG3JQNJ
         3dH9GsGmZdAhCQbxSQpobP4ub7E3fLAEFVadDyl2IZKW/9n2iHbwuMG0HA+aHwwViOlF
         Ku9quITDDq5AvSR4noderr+tVdEbyK9Yu7XJSon4logf8eWDvenbbQlQUxojDhQ7iULk
         1dcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XFi6ghAMGpAQveSaIOf7LzX7URi7P2D3gGjZFi13awY=;
        fh=8qTvEQ0chts3MhbUQYRPe4zmJhbNkfd93jKyTUWmjUM=;
        b=TNRb08PpjOFZhVDzafvb7ICG/YASsI+8lsYfq5srJqCOSlhk1FjkGwgqejHG7lXK/r
         nwztET79WeZYD/49lOU8pxd1iA/iXy8IDo3gaKY4UzYNXmKAOseHHrDFv4btjmXWqChw
         Y6ErPecBAiiSaatMRroaE0blQtT7Y+JejbWxKo8BVFfUhxc2ywFrKkGQQ3Qead15RiiC
         D0ri4yUvfU86bmUPv7/5qAIzOKknO7edDZi/m7H37uUlNxcVsfSe4jrNa3D5IO8SIMlT
         lEfKbUg6S4fdMFRR6HDpaTyu2gHEUfk8E1kmNubzJRy5qezH0AhYazdirR+9n+/t4Xsd
         OWZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777919380; x=1778524180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XFi6ghAMGpAQveSaIOf7LzX7URi7P2D3gGjZFi13awY=;
        b=Hkkm/+u8pYdMBa2mYhlfYBLAfsY89jcxmynQj6AfQuqEcGkhuoE9sdBJE0M7e8+lZE
         qLafK1AYpcu9yShNVZ+fO5LP6Wz6UAGrobtPt7E0h5OwbO4gAXkW2wJcYykrXlz4gPRN
         I6in1PvQlD2WvC6eQlfF1yRGjXLPU+4NkhohQhP6SEp+6dy4vxTM7RH137bdJp68RYN2
         fGa2n8s7J9X+sI4FTH8PLeqcC4DA88DFso/97S7/KFdXZEkmJXKp4IeI2vW5Qu9N/Xor
         11ZJp9PpYtmMRX08q5v3PwNH2yPXTb5YnNUWVpYzEBYXjuZ2FarrCKmVjFau49NAhL1h
         GeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777919380; x=1778524180;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFi6ghAMGpAQveSaIOf7LzX7URi7P2D3gGjZFi13awY=;
        b=sKxkC9IKEKGQt1xt8uPqB8LL3lj0iqZ4dIPZq5p/195nBLWtmFe8izRjDklNlsRCnP
         Xmn8/a9w9uOYegQeE8d9Hse760SxbVP1RoaZv9ZboHQaUJc+R14kfcqhRWiMaB9ASXdh
         tFdqIgoxD546g7A6OtBj/jr4kEmchWlTQoRppbqmj7OtBS0Clzuj2s0nSv/Kxtjgnc/i
         5zmIE8QJFZyawjRxh5GrHxjMiE/7sfNsZDqeXQKefZ+uZctcDeKPPl1UIiRyjVCSmtAb
         iCb2YG+4X6R77jUDyTzF0JDgU8JeNyhOry2ZCq1ZHtLjEM3Oq8C8K5ovL3+hZy7cv4Z2
         Wp9g==
X-Gm-Message-State: AOJu0YySGImaExIGm4XyJD+8dl5lOpcXnOvgxFYVpdtgYOA/5b1ODCE6
	JKU7IJj+dBLQlFlgm51/ytY744mxYqjrlSx3a1raXdQVt8q5BTsPg5TMf3TT77fTcD9JeSbDqrZ
	zVGYBevCzNkQntbrq1lECZBvwyMR14Z31Nbmj
X-Gm-Gg: AeBDiesxwSljM7Mlmf3uckInZG7QQiTKm6hPoNnjhAukFS1bFG1IAWtjGpxTMbxvjen
	79eWjfQIArfYOiRt+V3UCJuCNyMpVzkZv7BdnizvyKMctCmtQTpOUy6OoQVsUkeJYFgJJQbboOZ
	TPDP/h++oIJ+Bt78wHS3DzTu753OAw2KNaj7EdJ1Qhzdl+5V5L0i+pU+kgKTBB9EuwGHyPjufA+
	jcPZVExF2s08C1SofuEhiRy96uvcEXSbhqLsjHi4GGXAUbtxuG4C1HZ08Lp0cMf1g26WosZNWZG
	pVQyCGFfxBi4scKX63MafimjwqzHe6DsIX1M7mAe+gItPOS98WD2unyFpJSWMqIUOypWZ0JReq0
	R18wl94mZYLI+hLw=
X-Received: by 2002:a05:6512:3441:b0:5a8:6747:b053 with SMTP id
 2adb3069b0e04-5a86747b7abmr2425506e87.27.1777919379817; Mon, 04 May 2026
 11:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bug-221457-41252@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221457-41252@https.bugzilla.kernel.org/>
Reply-To: bjorn@helgaas.com
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date: Mon, 4 May 2026 13:29:28 -0500
X-Gm-Features: AVHnY4LFz5i-1E5THcyLGTXu5pp9DYAUsDLj6I0YBkKXmbHannLjS_a_UD2xVoU
Message-ID: <CABhMZUVSiQM+KAXeEFCPJSnQFq1Bc7F6GZys1ucfpE0Gs+3V6A@mail.gmail.com>
Subject: Fwd: [Bug 221457] New: PCI core drops Resizable BAR sizing after ASPM
 common-clock reconfiguration on Thunderbolt/USB4 hot-plug link
To: Linux PCI <linux-pci@vger.kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

---------- Forwarded message ---------
https://bugzilla.kernel.org/show_bug.cgi?id=221457
...
SUMMARY

Initial PCI enumeration assigns BAR 1 = 16 GB on an RTX 5060 Ti behind a
Thunderbolt 4 link. Shortly after, the pcieport ASPM service runs a
common-clock reconfigure on the host root port, the downstream bridges go
through [bus 00-00] reset and re-enumeration, and BAR 1 is reassigned at 256
MB.


HARDWARE

Host: Framework Laptop 13, Intel Core Ultra 5 125H (Meteor Lake-P), BIOS INSYDE
03.06 (no Above 4G / Resizable BAR toggles).

TB4 root port: 0000:00:07.2, Intel Meteor Lake-P Thunderbolt 4 PCI Express Root
Port #2.

Enclosure: ADT-Link UT3G, ASMedia ASM2464PD, 1x4 mode. Single PCIe upstream
port (0000:55:00.0), single downstream port (0000:56:00.0).

GPU: MSI GeForce RTX 5060 Ti 16G GAMING TRIO OC (10de:2d04), 0000:57:00.0.
ReBAR cap (/sys/bus/pci/devices/0000:57:00.0/resource1_resize = 0x7fc0)
advertises 64 MB through 16 GB.

Link: PCIe Gen4 x4.


SOFTWARE

Distro: Ubuntu 24.04 LTS.
Kernel: 6.17.0-22-generic.
GPU driver: NVIDIA 580.142-open kernel module.
Session: Wayland, PRIME on-demand.


OBSERVED STATE

lspci -vvv -s 0000:57:00.0 :

Region 0: Memory at 80000000 (32-bit, non-prefetchable) [size=64M]
Region 1: Memory at 4000000000 (64-bit, prefetchable) [size=256M]
Region 3: Memory at 4020000000 (64-bit, prefetchable) [size=32M]

Capabilities: [134 v1] Physical Resizable BAR
BAR 1: current size: 256MB, supported: 64MB 128MB 256MB 512MB 1GB 2GB 4GB 8GB
16GB

Bridge 0000:00:07.2, 0000:55:00.0, 0000:56:00.0 each have a 32 GB prefetchable
window.


BOOT TRACE (PRISTINE CMDLINE)

Captured with cmdline "quiet splash" only -- no pci= flags, no pcie_* flags.
All entries within ~1 second of one another.

Initial enumeration:

pci 0000:57:00.0: BAR 1 [mem 0x4000000000-0x43ffffffff 64bit pref]
pci 0000:57:00.0: BAR 1 [mem 0x4000000000-0x43ffffffff 64bit pref]: assigned

ASPM service runs and the bridges below re-enumerate:

pcieport 0000:00:07.2: ASPM: current common clock configuration is
inconsistent, reconfiguring
pci 0000:55:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:56:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:57:00.0: [10de:2d04] type 00 class 0x030000 PCIe Legacy Endpoint
pci 0000:57:00.0: BAR 0 [mem 0x00000000-0x03ffffff]
pci 0000:57:00.0: BAR 1 [mem 0x00000000-0x0fffffff 64bit pref]
pci 0000:57:00.0: BAR 3 [mem 0x00000000-0x01ffffff 64bit pref]

Final assignment from the re-enumeration pass:

pci 0000:55:00.0: bridge window [mem 0x4000000000-0x47ffffffff 64bit pref]:
assigned
pci 0000:56:00.0: bridge window [mem 0x4000000000-0x47ffffffff 64bit pref]:
assigned
pci 0000:57:00.0: BAR 1 [mem 0x4000000000-0x400fffffff 64bit pref]: assigned

NVIDIA driver loads ~5 seconds after the re-enumeration completes.


VARIANTS

Same hardware, same kernel, only cmdline varies.

Variant 1: cmdline = "quiet splash"
BAR 1 final: 256 MB.
common-clock reconfigure event: present.
bridge configuration invalid ([bus 00-00]) event: present.
NVIDIA probe: succeeds.

Variant 2: cmdline = "quiet splash pcie_aspm=off"
BAR 1 final: 16 GB.
common-clock reconfigure event: absent.
bridge configuration invalid ([bus 00-00]) event: absent.
NVIDIA probe: fails (Unable to change power state from D3cold to D0, device
inaccessible).

Variant 3: cmdline = "quiet splash pcie_ports=compat"
BAR 1 final: 16 GB.
common-clock reconfigure event: absent.
bridge configuration invalid ([bus 00-00]) event: absent.
NVIDIA probe: fails (same D3cold error as variant 2).
