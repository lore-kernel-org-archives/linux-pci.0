Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795103632;
	b=w06frEEezhFE23GCf5qJorqvmYf6/+00mrRYXDBn+3hm7do/GtQ77yzGZvcyYt7Y+fBI
	 dIoMov2EEnXImWHO9bTYihUyd6LMG2xrvbBG1ZdvOPGwdGZ0xD4jodQILnQGU+GUUZfET
	 Hilkh2SwslIFaBFY+KTpS57iyxEBYN0wlkjbEwCxTNkFsiytl5yJmDc0sZRRfaXGxtTjo
	 mC0doQlocFrOGRlWZcbeRJJsypxSAXCjkQvr8hONPfBysEtjSrekhKgpbXlJnzc3QZXC0
	 lnizASYi27XKdXIO5xpuJlejoSIbwHJQ7HnyeKHlQjq6/b+qhLs9IvqSisS0+l9SIQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=jJcFJ3eu4IGO4aq8ch/i718Km3SL5FkAJDmQGQ4UhVI=;
	b=DvQ95jRKhOd7iV5RApMYs4zVQaMAQmMao2zEjOxWSvFeZq6xdsPX43hcusGM09S1bEDe
	 srwt5W1TiNZq8QWOrwHr5O8J/TfSS+Fk9mmbnguyVuP/Y4U3B3q9cbeXNwt5uDv8Xn6x0
	 n39Lnkmgrwnmxu6QiFD9rudsWokgie2ErCOZinGruTUq9BFDnW9ptfkRWGTBC+tl9WmcJ
	 och7IZdPFFER1IL0R9PApMIrUWPjrPI5rO7dIfYaXxhDa5VdMN2lQ0sX+o6s8X49cQKWY
	 Oyh8WHrNaqlQVgR4f3mw79WYNPhlsJwbe/y3IUlVrE+miZz0zpn1CUfObKrfN8+Almg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="y/1rEu4H";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF861606A32F
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 15:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF861606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y/1rEu4H
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b8627e0eb2so3478018a12.2
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 07:53:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795103630; cv=none;
        d=google.com; s=arc-20260327;
        b=eVr8L4e+D70OaKCXPDYUyuefqI+X2GN4yFrhFq/YF3b2ji3ZujcqCnPdX7x6atFt+z
         +zO+/Iyv1pKzJwhX9PRbjIjB9orqlULjbFCicdqKBkIerlr+2kc2Yevm9Fxtf18Q20/9
         YKEZOADs2lIpjGBza1dOXuUMQhrniYodsMNWkBX50KAMIcjCga4p/9RwPUNDVoVLV4tO
         WyUW49eMhjTTpHFbeC4wnjoTvJkyrIO44CI5aZufWanMWmqncxPGsLPpgIXeUCQ6mv7e
         VN/SbO+UFozgew/WDwkJFffr23k/ShVIBB9xevdynl6o3+/nXoczkXgGMU/Ua1ATegd+
         bd/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jJcFJ3eu4IGO4aq8ch/i718Km3SL5FkAJDmQGQ4UhVI=;
        fh=Z9mDe1eC32U9RekoG61o3iOCD5eBq+LHRaxOoreJGPg=;
        b=LGbvHXoZphQNY/T1r4awnYo8vEEvC/rKCd8EJ8ggX4Dq5KG9OBinN+/3MRwyzEYzlu
         MTpRgj66rvg4WZOVIvM9B0BLbKhVL+QzRfYOrkqMeRbuakVP0in3kK2xhOVDYUsJCLW4
         4BxaOhJBCUXMHFpxYSJAK//Gl8TWax6GHYvVy4GYO4GYaNxBmz2OquobK0afJFF/a7hk
         lUD/fGHU6fALGBfFJkjdQDWu/XZp80OqdSbZ1/kikc3t7mvZOeGbPN5SV6PVXzlfVzNP
         f2zYwEl6gJC7V7rYFNlmeGKcic4xYMO47DNFYbL6K6i4m0iMZixwT8lyhaWkHvXKE3gF
         tjcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795103630; x=1795708430; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jJcFJ3eu4IGO4aq8ch/i718Km3SL5FkAJDmQGQ4UhVI=;
        b=y/1rEu4HdRhw+lxt0DHibP3Q5gQRsB9972hWX2qprluzpGhulh1i4GO2truCiZFgns
         nkY7Hl0PBUfUOR9pC+7dfZQGfrsOCe0eJRObDW9d9/Obx8kvjq3BmEGEWbNgD3pJYdhw
         csvt9z9N7OVL+Xss1LSKDLM3fi3n3CWpBzkS3Zjj0BBKWuoStkOP1A6XeK5oY5KZiJqH
         RtRHE817CUxZhJ//l36pfOwEZ5X7D59uY6pncyvA+2ql58IPVohgUKyDwEEgbmOKg388
         oB4eOEJHIsGYprd998e0R1hUw4sOx9ZVYB8I2ckGVsa3XBi26AvCcBYWOzHPulEfGZ0a
         SlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795103630; x=1795708430;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jJcFJ3eu4IGO4aq8ch/i718Km3SL5FkAJDmQGQ4UhVI=;
        b=K+u/LNwqkmnY7rFB6Al7wIZ/Xv8x5hVko9Q2Z8gEqXeQH6L6WOxn64l3y+mHvRifme
         f9qF/uK6G8/kp2GgUbkRmv/Pdz5pQxi3FyFdpI3+eVidaR2WiCj8pUkTckcjDg8EhGec
         XILQi7E1cXQF5tdW/89guV5cQjEAL36JvjRalZnDrolY1fiDN2tRppT4MWqag8QxiWCw
         EC1aiiZ1irlanHyDj5i7GQP9YP+ez/BwJdlIKbnsjZ96HpeYqaNyAtD5J/Ci72sfIPrr
         BrXo/EQ208PFk4l5Xo0EgkPahI/tI6HjqKfazO8Md51iue49ZlHqO3kcdt+ShNEdmR6B
         Klgg==
X-Gm-Message-State: APuU4Z+D86UGd+Db/6baqJXX5J3/KKpDopeXa15HcLUuHD7Nvi6TGHec
	92ehI1/baR4EezISb12OsYSnwgVHzVynsz7ADy9MH7fqo2s2GADVk3I5mpMRE/hDoE9Qf9DR3FQ
	HuXMIoCojPNx2vgj0+7zquheIRtTQ4V2Mx73ruXk=
X-Gm-Gg: AYBFou0U5j/B7v+HeCS1wa3yBSBRoFuYeZYW1rJFgCHDoIQ9X+tWG2WLTr0vY0VXz+D
	UbrqS5znNnUWuYBnOtEvp9Q9GHYwDJhNU8i6sn7he0AXj4xQYyDBWxEl+tRIBtYmht3sfm2H72h
	qjqugoAMyPkd5C9kjDQrBe1qXCeg85yOJAH7pNgCb7FobBlqiLotTzJJG9xE9GoNaJ2UVJXzKR9
	ZJXw63jrjeNLYPCwTx15UYtWhIbtQFF1bFn9QlzBrUQnzBhF7+S6RjVO01655o/gDue05EZeV5M
	8mJZOG9Pp2GuykoqxMp7cc6QfVEHE1slhpzFTpueEiZJjDftH6zVH0Ll5EUzQ7iEhG80vv3IfRx
	qSnPSncte01PvbRMerLM/Y9L1tZ+TbriD+V3PexpYT1F9Wo/ODu7UqwDcjw==
X-Received: by 2002:a05:6402:1e8a:b0:6b7:fe9a:23fd with SMTP id
 4fb4d7f45d1cf-6b887c89865mr5822363a12.6.1795103630064; Thu, 19 Nov 2026
 07:53:50 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CACWbNdxohFg52KLwfH6fd95dGXiviffX9kNLw_1=j7ZpCCuMjg@mail.gmail.com>
In-Reply-To: <CACWbNdxohFg52KLwfH6fd95dGXiviffX9kNLw_1=j7ZpCCuMjg@mail.gmail.com>
From: Nursultan Yergaliyev <n.h.yergaliyev@gmail.com>
Date: Thu, 19 Nov 2026 20:53:38 +0500
X-Gm-Features: AclHuK9ZIE_P4IjqdbHIiGMXeG-GP5DxKQ8hEkOwSF186LbQAoh-k4ZRrIBcPug
Message-ID: <CACWbNdzUWe_Ej4sJpe44PC=c1g0NTjyPjfqDSmCbT057Xab5kA@mail.gmail.com>
Subject: Re: [BUG] pciehp: spurious "Card not present" on soldered dGPU port
 after resume deadlocks dpm_resume (Lenovo Legion 5 15IAH7 / 82RB)
To: linux-pci@vger.kernel.org
Cc: lukas@wunner.de, bhelgaas@google.com
Content-Type: text/plain; charset="UTF-8"

Follow-up with a narrower test:

Booting with default parameters and only unbinding pciehp from the
dGPU root port

  echo 0000:00:01.0:pcie004 > /sys/bus/pci_express/drivers/pciehp/unbind

(pciehp stays bound to 00:07.0 and 00:1d.0) is sufficient: pm_test=
platform passes, real deep S3 resume works and the GPU is fully
functional afterwards (nvidia-smi OK).

So the hang is caused only by pciehp on 00:01.0. Happy to test a
patch or provide more data.

Thanks,
Nursultan

On Thu, 19 Nov 2026 at 19:21, Nursultan Yergaliyev
<n.h.yergaliyev@gmail.com> wrote:
>
> Hi,
>
> On a Lenovo Legion 5 15IAH7 (machine type 82RB, BIOS J2CN57WW,
> Alder Lake-P + soldered RTX 3060 behind root port 0000:00:01.0),
> resume from suspend hangs reliably (s2idle and deep, also with
> pm_test=platform). Kernel 7.0.0-43-generic (Ubuntu 26.04); also
> reproduced on 6.17. Windows suspend works on the same machine.
>
> The dGPU root port advertises hotplug although the GPU is soldered:
>
>   pcieport 0000:00:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL-
>   AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis-
>   LLActRep+
>
> Before suspend the port is in D3cold (dGPU runtime-suspended).
> On resume (no_console_suspend, pstore):
>
>   ACPI: PM: Waking up from system sleep state S3
>   pci 0000:01:00.0: VC save buffer size does not match @0x100
>   pcieport 0000:00:01.0: pciehp: Slot(1): Card not present
>
> pciehp then removes the GPU functions while dpm_resume() is still
> running and user space is frozen, which deadlocks (sysrq-w via pstore):
>
> With nvidia loaded:
>   irq/122-pciehp: pciehp_ist -> pciehp_disable_slot ->
>     pci_stop_and_remove_bus_device -> device_release_driver ->
>     nv_pci_remove -> ... -> down_read [nvidia_modeset]
> With nvidia blacklisted:
>   irq/122-pciehp: ... -> pci_stop_and_remove_bus_device ->
>     azx_remove [snd_hda_intel, 01:00.1] -> snd_card_free ->
>     wait_for_completion
> In both cases:
>   kworker (async): async_resume -> device_resume -> mutex_lock
>   kworker (kacpi_hotplug): acpi_device_hotplug -> mutex_lock
>   systemd-sleep: dpm_resume -> async_synchronize_full
>
> The "Card not present" is spurious: with PCIe hotplug disabled the
> GPU is present and fully functional after resume (nvidia-smi OK).
>
> Results:
>   pcie_port_pm=off                      -> s2idle OK, deep hangs
>   pcie_ports=compat                     -> hangs (acpiphp removes the
>                                            device -> same deadlock)
>   pcie_ports=compat acpiphp.disable=1   -> s2idle and deep OK
>   00:01.0 kept in D0 at runtime (child d3cold_allowed=0 +
>   power/control=on)                     -> still hangs
>   removing 00:07.0 (TBT) and 00:1d.0    -> still hangs
>
> With hotplug disabled, I compared lspci -vvvxxx of 01:00.0 and
> lspci -vvv of 00:01.0 before and after an S3 cycle. The only
> difference is the PMCSR power state of 01:00.0 (D3hot before, D0
> after); vendor/device and subsystem IDs are unchanged and the port's
> slot status is identical, so this does not look like a "device
> replaced" case. The "VC save buffer size does not match" message also
> does not appear when hotplug is disabled.
>
> Questions:
> 1. Should pciehp ignore/defer a presence or link change seen during
>    system resume until the link to the device has been retrained?
> 2. Or would a DMI-based quirk that disables hotplug on 00:01.0 for
>    this machine be acceptable? I can test patches.
>
> Full logs (pstore traces, dmesg, lspci -vvv of 00:01.0, acpidump):
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2174812
>
> Thanks,
> Nursultan Yergaliyev
