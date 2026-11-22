Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795390661;
	b=iegMdJ8qWps2gqvLIWjDd4GG7tjrL1xKXUBRu31cmK3mz8CkhzT8M1imLY5Emu9vvSou
	 TWq6s66oi5hsDkO186DENr76zmQWgCdF+GRQPd/KrFKwaWWTwV+TQkfeLXRKuLGZyojtc
	 j0ukDwCeupzGGLSGzgjMMOMkt8ujwTD+oN7vIT2gEx0hTIZNeC7SBpIqScbZFYhNhOJyn
	 kden3kahjyaAf/IUmf7Ve8Expw3LsSoz7G0P5uqLAXlZej/C6m7jS4ZGWHtOs5HbWbWp0
	 cJYRWUk4IMmY9sYjEOXYmEYEWVhxY8QqoPfMjXbxlsUti45QX7TtgZFBtlddVQeukIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795390661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:Content-Transfer-Encoding;
	bh=8ffBs0tJIuv00hogL2olsxuJysDEzEP4qDEDIz2bEew=;
	b=NJAP8s0YLnCoKuWVwm5/5QXLkW4tXfEkj/9RHTkNTGDuaPDGiS8zV2HaI7dCNpFsOaDu
	 A9G4KLKnftK9shbFeGw+uFV9flkvPaAcETkzN01X4DWSoE4lnccoof1sAVynodZPIe5+0
	 YWduJIXvXZ+35eF0waQagO5qqF0tbH8/91aZH5uo2UogUsHVgrlSV36ZcFO7Mlu8fEQOr
	 s9Wv2vAw2UqYVUwdDU6Lu7WndYFGWo2BAqVi5mOpOwXJodd8shf/21wbKtZLAgmY18Q1j
	 1Ds50QAR9S6f7Ib6N90Z44g2PHXjP+EjF9UAaI2qlIjJpi7xVQBZsZp7gm32OYqsmBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u7eUU2Se;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A3E606A31A
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 23:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72A3E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u7eUU2Se
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be3d5927ceso3987812e87.3
        for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 15:37:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795390659; cv=none;
        d=google.com; s=arc-20260327;
        b=dIa+Rf0r+XN1oNE+2RGK6Oas4ZTTlvNeV84FRymxm1gGb3I0qI73KeeCGrq0yZpw4M
         h0P4sfOWFvu83xvA/K3u9BYex7PHkVQ/CU/65P0rVC41jVS167/KctHA78FkV3h9Z0sj
         Xlc4XYnETbi3upbgBwr/n60KwRpPb6idbL7OlRQ2HbryiEdhm8a1oA6rw6i51IWCNVsA
         d/rZuiVCP6Jqp394Nxjo/HlZijyZLa4ZXiPMtxj6+mHmfURWk3pn8ZzTjvEJn5jP/f0f
         Xc48D6q3N7XpFrVGYVdiJKBfZ+u6ULFx48ofXl+Pe01agXclrFNBlG/9XnrV1d1aJrrS
         T+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8ffBs0tJIuv00hogL2olsxuJysDEzEP4qDEDIz2bEew=;
        fh=EfujMstWYmdFvPeCBAhLBiPi7yWFoNM15oJi8Rh/J0k=;
        b=TyX1X80ULuiIMPZZWA8VQxYNER4z3eIxdwOvb0jP2wFDzP636P/1wrXJH6n/qvo2jv
         eNZazMm2vkyKZLswFBURDUuXA3mVZTvsNYiOM+hJyDN1SZjRFNSGwdr9JyHjKnW76aFo
         sFB9yNPUK23DI4eM7oCPb+pht8ftutWgrqAQgR+krKYAke+X6e1J8kIofnUKooO+igNs
         TXc/Jxrk/oIJHiE+fI7ZV+1cYZIJzU+sSvoOPwAIa8CYAU6j0RLJ6hmLAIGOVeR9JXTa
         QUEczfkCRSqEQpsZof9d3rZBsP8pgMA7snVCb6NfORjhJaOBFcYkUs6USu/c9YQLzwD+
         Tnfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795390659; x=1795995459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8ffBs0tJIuv00hogL2olsxuJysDEzEP4qDEDIz2bEew=;
        b=u7eUU2SeWG7xQQkrkyeR0N+HseatSguw1QIgzgBEbBE4ubAUgqYFjB202n40lo91Ez
         jYVyDa2l1ny12cPCgnok1pzJ8UmpeSSDwAw/alr68fs7cnku3JuYXyvxFGdmbrh1Gm0M
         IAFZGMEWvvx//iK8asVPrG/V7HoLccSyGl84GRP4qxZKGdIeyOuqLsOkjsk14r2PkyI8
         6HMAMIXZ/yvjckjmxpOw2l0ZuA7VoIliLFi6Ii7nIp0EwX6dTteUTAJgt5/cX9eDCX1a
         jLB1cQ2rcLqeeNPeiG2LWSSRdeoHiO1GfmUceDp7S/tesIYkQW4Cl5Harg0NtPXKKMHL
         HlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795390659; x=1795995459;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ffBs0tJIuv00hogL2olsxuJysDEzEP4qDEDIz2bEew=;
        b=h05z+Jw2w3WNEyDml2omkL579UriroFuQRY/o4PGcNbrXa8Hip9zkoS5Wp+98qPPZA
         MRXVytatGaS8bkDUWc9ZpQHxfoxZ6Had4J4dnPU+43pnROtmbehLe2IA1dptKErNu4TO
         eWABIUwVCgAjRKJifziJ7ynTG9HcgU0t8u20iHLPW6j8hb5HAqkpQ4JKuq05KEUBTtxK
         k+mL6458XnZd03JvTcWYN0pTn+Zb360WtNE2UFcAbniGIBmppVJ6d5VYAn9+C5Yuyrrm
         nc3iHCc+arKhab5qitEB189oS5jnz3tZQ/M0HvuLZR4N68H7L10NABMEUluo+Tqyk8BT
         ZBRw==
X-Gm-Message-State: APuU4Z/4tmGl9UqxCl6qL9cd4Ox1Uc2DqJLL5Ge+GJmGlKgL0WG4VIYl
	V4BfTz4rRl9GT8a8pa7s5ivFlNZgez31B7z1fNFohlqIDyvLy+nPwG+vuGBuCc+gb1aElMCqk9h
	pgXx2yYNWAkHcuG0M1PQPphWkywJmqq253A==
X-Gm-Gg: AZFdTZd6edI4cFy5Wizm4t5ZqSuPNWdmmCH6/q3t9XTq0g0rfd3741J7SBIBii9kcju
	QVQPUTBEzsjGBr5xJW3jNVTGPnZCpS+hMXJp9VRlsxUs1wkWcI6FV49GiMzdt7KePHwkeEL69qZ
	SZeO0/yF9VJqJI8eYI4ACgsS8Ku8gRJ3givQBZx6s3Z1WuOBbPD279WCph0cPPXi6ksl1hTcBr8
	6quuPm9NF6gHuk6Dka7dtYt5Fx+hR2QVTSP8rVg2W2nykXNnumS1nZbk6ZCMk7hHGaqf75SJsSY
	mw9D5CfDYZ4VoElYGmdKsxlrsyzcTWZsW/bfIg6+7j6lVgDwC0HTe8Rq6N4H+Pu9Ple1cimA3YO
	QnPO63bv0N8TBlZ4bv5HroKowqTIHa96rKVMQxEelLnO3PzDnPW5mnDR6SHF+TIaQueGGUqAgtp
	Jj3oCG0UjBnlGj1BqfS9hTm17jQHRj2DUiGz6PF4d3+NOVf63Pvfj21zKwbdvPpUZsJ2F5Rb0dX
	w==
X-Received: by 2002:a05:6512:33cb:b0:5bf:d60a:5c60 with SMTP id
 2adb3069b0e04-5c1bc872b01mr3029254e87.55.1795390659260; Sun, 22 Nov 2026
 15:37:39 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <bug-222317-41252@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222317-41252@https.bugzilla.kernel.org/>
Reply-To: bjorn@helgaas.com
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date: Sun, 22 Nov 2026 17:37:27 -0600
X-Gm-Features: Aa3M54rYFidZ1wWEoFUmC_uVZHY5kJPp5lWSx3HLtp87cXJcX3tyn5DCMF1tOsU
Message-ID: <CABhMZUUybFWK5+Cy0xcgKZKu8HUmXQivUuBmzfR1tRnf2a+_tw@mail.gmail.com>
Subject: Fwd: [Bug 222317] New: pci: 8086:4c43 host bridge enumerated as class
 0x0604 breaks Intel IGD passthrough
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[+bcc reporter]

Thanks for the report!  It doesn't look like this would be a regression, ri=
ght?
Can you please attach a dmesg log and output of "sudo lspci -vv"?

---------- Forwarded message ---------
From: <bugzilla-daemon@kernel.org>
Date: Sun, Nov 22, 2026 at 1:51=E2=80=AFPM
Subject: [Bug 222317] New: pci: 8086:4c43 host bridge enumerated as
class 0x0604 breaks Intel IGD passthrough
To: <bjorn@helgaas.com>


https://bugzilla.kernel.org/show_bug.cgi?id=3D222317

            Bug ID: 222317
           Summary: pci: 8086:4c43 host bridge enumerated as class 0x0604
                    breaks Intel IGD passthrough
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: 2039475150@qq.com
                CC: kvm@vger.kernel.org
        Regression: No

Filed under Drivers/PCI because the underlying defect is the PCI class code
enumeration of the CPU host bridge; the visible failure happens in vfio-pci=
.
CC'd VFIO/KVM people for the driver side.

Passing the integrated GPU (Intel UHD Graphics P750, 8086:4c90) to a QEMU/K=
VM
guest fails on this machine. vfio_pci_igd_cfg_init() returns -EINVAL during
vfio_pci_open_device(), so QEMU never gets the device:

    vfio-pci 0000:00:02.0: resetting
    vfio-pci 0000:00:02.0: reset done
    vfio-pci 0000:00:02.0: Failed to setup Intel IGD regions
    kvm: -device vfio-pci,host=3D0000:00:02.0,...: vfio 0000:00:02.0:
         error getting device from group 0: Invalid argument

Root cause
----------

drivers/vfio/pci/vfio_pci_igd.c, vfio_pci_igd_cfg_init():

    host_bridge =3D pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
    if (!host_bridge)
            return -ENODEV;

    if (host_bridge->vendor !=3D PCI_VENDOR_ID_INTEL ||
        host_bridge->class !=3D (PCI_CLASS_BRIDGE_HOST << 8)) {
            pci_dev_put(host_bridge);
            return -EINVAL;
    }

This firmware enumerates the CPU host bridge 00:00.0 (Intel 8086:4c43,
Rocket Lake-S Host Bridge/DRAM Controller) with class code 0x060400
(PCI-to-PCI bridge) instead of the architecturally correct 0x060000
(Host Bridge):

    $ setpci -s 00:00.0 0x09.b 0x0a.b 0x0b.b
    00 04 06          # class 0x060400

    $ setpci -s 00:00.0 HEADER_TYPE.b
    01                # type 1 header, i.e. looks like a PCI bridge

    $ setpci -s 00:00.0 0x18.l
    ffffffff          # primary/secondary/subordinate bus numbers all 0xff

lspci -t shows the PCI core actually walking that bogus secondary bus:

    -[0000:00]-+-00.0-[ff]--
               +-01.0-[02]----00.0
               +-02.0
               ...

The other half of the IGD check passes: the OpRegion is valid.

    $ setpci -s 00:02.0 fc.l
    953ce018          # OpRegion base in PCI config space 0xFC

    # read at that physical address:
    000000  49 6e 74 65 6c 47 72 61 70 68 69 63 73 4d 65 6d  IntelGraphicsM=
em
    000010  08 00 00 00 00 00 01 02 ...                      size =3D 8 KB

So vfio_pci_igd_opregion_init() succeeds and only
vfio_pci_igd_cfg_init() fails. The IGD itself is fine; the failure is purel=
y
the host-bridge class check.

Why this is worth fixing in the kernel
--------------------------------------

The class code is a read-only PCI register and 0x0604 here is a firmware
defect. A user cannot fix it. The only workaround I found is patching the
cmpl immediate inside vfio-pci.ko after every kernel upgrade:

    bf3: 81 78 44 00 00 06 00   cmpl $0x60000,0x44(%rax)   # stock
         81 78 44 00 04 06 00   cmpl $0x60400,0x44(%rax)   # patched

With that two-byte change the check passes and the host-bridge, LPC and
OpRegion regions all register correctly; QEMU then reports a real Intel IGD
instead of a plain PCI device. This is a poor long-term solution: it breaks=
 on
every rebuild and requires stripping the module signature.

Suggested fixes
---------------

1. Preferred: a DMI-scoped quirk in drivers/pci/quirks.c that restores
   dev->class =3D PCI_CLASS_BRIDGE_HOST << 8 for 8086:4c43 on the affected
   board(s) only. This keeps the change off the other machines that report
   8086:4c43 with the correct 0x0600, and it fixes the value for every
   consumer instead of only vfio.

       static void quirk_intel_host_bridge_class(struct pci_dev *dev)
       {
               dev->class =3D PCI_CLASS_BRIDGE_HOST << 8;
       }
       DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x4c43,
                               quirk_intel_host_bridge_class);

   guarded by dmi_check_system() for Gigabyte/W480 VISION W.

2. Alternative: an explicit escape hatch in vfio-pci (module parameter or
   sysfs attribute) to relax the host-bridge class check, so affected users
   do not have to binary-patch the module.

I understand neither option "fixes the firmware", and that the class
check\nexists for a reason. Option 1 seems the least invasive way to make t=
his
hardware usable.

Environment
-----------

    CPU:      Intel Xeon W-1390P (Rocket Lake)
    Board:    Gigabyte W480 VISION W, BIOS F25a (2026-06-11)
    iGPU:     0000:00:02.0  Intel UHD Graphics P750 [8086:4c90] rev 04
    Host Br:  0000:00:00.0  Intel [8086:4c43] rev 01, class 0x060400
    IOMMU:    group 0, iGPU alone
    Kernel:   7.0.14-28-pve (Proxmox VE 9.2, based on Ubuntu-7.0.0 + stable=
)
    cmdline:  BOOT_IMAGE=3D/boot/vmlinuz-7.0.14-28-pve root=3D/dev/mapper/p=
ve-root
ro quiet
    CONFIG_VFIO_PCI=3Dm

Note: this board also hit a separate PCI bug involving
CONFIG_PCI_DYNAMIC_OF_NODES
(CVE-2026-98504, fixed in 7.3-rc5 / 6.18.55). That is unrelated to this rep=
ort;
CONFIG_PCI_DYNAMIC_OF_NODES is not even enabled in this build.

Note 2: the failing sequence above was observed on an earlier kernel on thi=
s
machine; on the current 7.0.14-28-pve the module is locally patched, so dme=
sg
no longer shows it. drivers/vfio/pci/vfio_pci_igd.c is unchanged in v7.3.3.

--
You are receiving this mail because:
You are watching the assignee of the bug.
