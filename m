Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A5B1A6829
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791940680; cv=pass; b=LrPuT0hBo0F7p5cRa0/VVgo8Alka41KQAdOi73r7GmGr2dqLgugo30oJlxeRJmDDoeYL3tERa94mc2VdLnq2Vr4Ey5zGbqspRLWFigQuiLYhr0hwwxnKlKtXIvRHH4CgHiyN83VCrCPzDbp59cXlLH3qNRuh/Y7zg7RRNky8IkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791940680; c=relaxed/simple;
	bh=Mx8pOrR7NuAhI6a7ZnAXwffRXaDHMNA286y6u6ETCWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMVT9uIILB7HHZmSfZPqea00eVOsBT6R7yAYPrYw7QgOiEgc7MMZJM64nt1wFBk3CI3JYgZgyYMqx021wkF2lKLJPSe+H8vD+pNkk5KvcCi7IbZ+seGxIlob2fO0/1mGNvn8xqL8ZyIo5MndKpkUbHJ0Tn4FX9u6RgKNeMfqPLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnazHBUh; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnazHBUh"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd5d2dafeccso1386358a12.2
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 18:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791940678; cv=none;
        d=google.com; s=arc-20260327;
        b=mMm4CzJEwhotLTvcPthqzOsE2R2aL6DJr4WaaHl7IKAeg2S/sMPktqC87YP4/k14J6
         t9SEJ9SeGFzW4y0ZmliEcRvhnjHW8vOFfHHZXs5ExBYILI4YzEIEjsJr6uscVRU3Iluw
         YG7Vy2wmh/8wfjO3rnyGtZkbjsVP6A8XOIoYrhe2ECduQYPDYyqgHbsY5sanum899idO
         4xUSnKMpAKUu8AbUPs3X5fhh0LjcoH/AnNzbFYpxsEKnJ5q8KDTKZ1LTMpYtuVx24yjt
         B9+8wXykTrdCzyEOC7vceutgEUY1+WZmK4v/1xOK6kf0FdYKBhUsTIoG43lFWKBJ5PIH
         IB5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jDmST7kAhWIJHCguqYIGPuaIfAHg6uPk1l3Ttc4Z6Hk=;
        fh=B5kWBELt/0byF6ZVMZHtTpzy/xGLEpgkwB4MjYy8QKM=;
        b=FSLRNSAc+dN9SZPp+o0Vqvg5oj9Mooy8DiaSyuvG0UxBGKiEgzEA/GbMl5jY58M3EY
         CO5zAtPJGPnJsnowgmr8R+jY3JlEuDyZsAnF3d1pgStPNttjdFY+q4uB7pImXomOxahS
         hII5amq4FsQtmeSjVT/CvrGfInvOcX4PFREzZnegF0Gh5Roz0bUU6xEPzTrSoTIqiXiF
         rpy9eOqi3pb3/NRzz6sClSVdVvikeVoDqzTm2FMT+1ViZft9evCxWJy+bi8+iWN+gxr0
         MGcctuffmxAGydB/wS778gjsqSzYDUt6Ryon1KhBqb2nmjt7SjyIlbNvOB5VChZZ60X2
         deuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791940678; x=1792545478; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jDmST7kAhWIJHCguqYIGPuaIfAHg6uPk1l3Ttc4Z6Hk=;
        b=NnazHBUhnMzRroXrKKL1OXMaxJT0nO7epnxwNXNtDY5cHhqa6D5MAzjytzbXbl2K1i
         cK927cmnp/GEDNgm/UC/buVpScS7JxEOVEbG+nOBN60VJXR7FUsb4w22GCpgtyW3JKLG
         P36Veqmd3W6mEzjLWu/E6ChFTJEh0W5ErOGGVt1/rbsqsW1kRXy/kpDw/r7+PQCYINqw
         3sw7Knd8QYFurjEkFLuPoCQAcjRoxOMKSQYij0GYGgPGVDlx6kH+byx1DM0mIQc3XTLK
         u2MYomsZia04C3cbGIWUtAkNAknQWvJGZOz5pu7Td4hwwyVMUcwrkJs3WK4kTOfgFlEx
         uMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791940678; x=1792545478;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jDmST7kAhWIJHCguqYIGPuaIfAHg6uPk1l3Ttc4Z6Hk=;
        b=hmm4zP/zSyyLdd7NLcLr2RqXYLiqyMC7rOkHM6bCOVrcYgRX0jcVpgfyXIZESQDZgZ
         QikPClnusmaN1zNVERLvIP6RtpPFQ5nz6U+O2yMkJ4mmQhnJX6Jhs4g8yGw1TjOWXoLj
         9BBv6iK9Q3q05xOYEgHc05l+DDzB2nh+er/7ZV1keuPNdThr2fYWr2K/T+V3dJPL0NW5
         VHfdumxAxOwH6Kc/Wov9eswVkt/uEQNDlL7x+3rsTGyFdmXojuIKcgDenHenI8XrLTO+
         UeUWNC0dU2rwjBFBK1F56x8GidzvZLKNoVo9sKbmailrnd8hPgmaxTjXkgliX8CukDCq
         Ttkw==
X-Forwarded-Encrypted: i=1; AKwUvBxb5qrih6o8OXchBaNSBuj0kAjgmwoVkXIGeek4HYBT6iYfufl20RRnB+czfKXuqyZ4YuraWoZfnuU=@vger.kernel.org
X-Gm-Message-State: AFq9FYINth7UsfIvJWwp184nQpba2Saszixa+8fvbckiADeWxbrGoMFI
	sfRsCCtvrKdFYUrzdeHe4jUJJiPtMM0GsiGOh4P6GeppeZq9W5vUYFuyGWM4gvzTxuUsA2UAb/T
	+yMHEabeZ/EBmWUxhpNt0zn0ueZnZgo8=
X-Gm-Gg: AYBFou2Ps+cqQeO1+utCL4k6lhyoYpmjJx3UTGGcBhJbRkKtGnSPf0UTzI2iSU5cMwT
	J82OuLv50GCoEeJBsPr3ABod9nbmfgjeyQr/b7Z3XcRMNEe+nIIuqaXdrpojbMLDQZ/OCt8iAoQ
	o4AiI1jZ+RyIBA7r8JNttoJlVHx7r6aHHdqRvUIk/SDk6+0kLnSZrsxKhQ3ycBJTZkTOjOK3MTT
	1xMgeL3Y2RpetwBZj3JbTrepz+jK3DC7KyrS9xLa4q2I5k9MmhRG91aYhnDlZ9k9tyyD470790H
	q4ImnxxLAgn4vFBfQR9O1PDCQ3PtP0pQqUPvF5wtErphPUObUNLD3dpKxiJh16LJJlSXWb4ZJjL
	I5C9JvLR8FDVze7B5aeBlYSDoFRLCkUxsMk2gtg==
X-Received: by 2002:a17:90b:518f:b0:3a4:b0a1:c7ed with SMTP id
 98e67ed59e1d1-3ab3a90e667mr11772541a91.13.1791940678077; Tue, 13 Oct 2026
 18:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013220421.1588051-1-bhelgaas@google.com> <20261013220421.1588051-3-bhelgaas@google.com>
In-Reply-To: <20261013220421.1588051-3-bhelgaas@google.com>
From: Semih Baskan <strst.gs@gmail.com>
Date: Wed, 14 Oct 2026 04:17:46 +0300
X-Gm-Features: AclHuK_e12mFZYv6Pnb8WSqKFNBAW2cZiwmazllPkVxW3EceBwkTGRAJSzPTr38
Message-ID: <CAAsRjRng=D-kP3pakPA=M5k-znYbTj3gz-RGiajnxhS3ymz8sg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PCI: iproc: Use the EROM outbound window on BCMA
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Rosen Penev <rosenp@gmail.com>, Rani Hod <rani.hod@gmail.com>, 
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 13, 2026 at 05:04:21PM -0500, Bjorn Helgaas wrote:
> The PCIe outbound window base on Northstar depends on the PCIe Gen2 core
> revision. Revision 0x01 uses 0x08000000, 0x40000000 and 0x48000000 for
[...]

Thanks for combining them.

Signed-off-by: Semih Baskan <strst.gs@gmail.com>
Tested-by: Semih Baskan <strst.gs@gmail.com>

Tested on an Asus RT-N18U (BCM47081, PCIe core rev 0x01) with both
patches on OpenWrt's 6.18.55, which carries 767012397976 as a backport,
driver built in. bcma0:7 enumerates the BCM4360 with the same window,
BARs and IRQ as OpenWrt's current image (an earlier version of this
patch), and bcma0:8/9 print the two expected warnings (DT 0x20000000
and 0x28000000 against EROM 0x40000000 and 0x48000000). I did not
build it as a module.

For the commit log, here is a version that describes the bcma and
platform side, in case it helps:

    PCI: iproc: Use the EROM outbound window on BCMA

    The PCIe outbound window base on Northstar depends on the PCIe Gen2
    core revision. Revision 0x01 uses 0x08000000, 0x40000000 and
    0x48000000 for controllers 0 to 2, revision 0x07 (NS-B0) uses
    0x08000000, 0x20000000 and 0x28000000. Broadcom's own driver branches
    on the core revision for this reason. The enumeration ROM reports the
    base for the revision present, and bcma provides it as addr_s[0].

    Commit 767012397976 ("ARM: dts: BCM5301X: Describe PCIe controllers
    fully"), in v7.1, gave the controllers in bcm-ns.dtsi a ranges
    property with the revision 0x07 values. bcm-ns.dtsi is shared by
    every Northstar SoC. The DT ranges cause two problems for this
    driver:

      1) devm_pci_alloc_host_bridge() parses and requests the DT ranges,
         then the driver adds the EROM window and requests the list a
         second time, so every controller fails to probe with -EBUSY.

      2) The DT window itself is only correct on revision 0x07. On
         revision 0x01, controllers 1 and 2 get an address the hardware
         does not decode, and the first MMIO access to a BAR takes an
         imprecise external abort.

    The window comes from the EROM and the interrupt from bcma. Allocate
    the bridge with pci_alloc_host_bridge() and free it through a devm
    action, so the PCI core no longer parses and requests the DT ranges,
    and request only the EROM window. The driver still reads the DT
    ranges for one check: if the DT describes a memory window that
    differs from the EROM one, it prints a warning, so a wrong dts shows
    up instead of being ignored. The driver works whether or not the DT
    describes a window.

    The same commit also added compatible = "brcm,iproc-pcie", so these
    nodes now match pcie-iproc-platform. With CONFIG_PCIE_IPROC_PLATFORM
    enabled, the default on ARCH_BCM_IPROC, that driver binds them first.
    It takes the DT window as it is, so that path needs a separate fix
    either way. This patch fixes configurations with PCIE_IPROC_PLATFORM
    disabled, such as OpenWrt's.

    Fixes: 767012397976 ("ARM: dts: BCM5301X: Describe PCIe controllers fully")
    Cc: stable@vger.kernel.org
