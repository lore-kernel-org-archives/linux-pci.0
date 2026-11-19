Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795098098;
	b=evL3qg/XpA6TWRU3xiQ/cOLP/kdlafqbZt+4uTvGQ2wsNo64UKSCYOYve9PN8I7r3eoD
	 fbyN5fw2IhQRU4TexAXh9dqgqS6CUQInL6t1IvkM53y5pQoCC2jRBo19XfXw0UDnTA45K
	 8ztUr/LYeFLkTt2Ua/XLeUBMRfbjjonRurgqtbEKho2NuSLFsEHzivNU+tNDRZGizHjUG
	 m3tXbFusfyspzOYxMLJ3DpVk90TBbdrHSVQ33LTg28ECzbbH3qzhSs4hEiHN1cpmijlCb
	 2rAnshixS/W3uXBIOCUAJeyrtzBtr4PYoTtFSKGE+a2klrYyu3iwOyzZF2GVUK9LD0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=QDudp/CNsMw0Q7hm89AwTv0NhCP0Hgb7jNITfRNvQy0=;
	b=4+dDIylbtpkKXUiGjZ7pbpcx0ZJR85lA+kh6/6k3eOnpjtS99xaSG/JfdRKGWBE4Wd26
	 aIvvST4LnKj+Kg0XO9SHlrv0s6mT5wnP3iShiCKqXmEzQBsBYc5fkfu/B0PBsfRSgCGqg
	 AfDOkVOe/3TmWV421HqyFX6an+4eiCoT6w1tK6ZNS2NpBlLFP2SRXfDys+EePCO+mS4Jm
	 lk2eotV7gTuK1eadEbnlUIF06dE3eTD/NwxnlIdk5OXASGrbENQSDUEha43gNWbnPxucw
	 v0zdNatputF35SWeRV65pHNygBe3irdQU8Ng0gUQKAlOgD/7/KA8YvIcbbdsTvvHnzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hyuTEaUz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7713606A338
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 14:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7713606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hyuTEaUz
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b8977f2785so2967104a12.3
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 06:21:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795098096; cv=none;
        d=google.com; s=arc-20260327;
        b=VwzQj39R0NKmNqLu7e4icQMBiQ/uFZQTwUQyKoP9kYOTidhqAgVqtw+zjVTeUt7qWq
         lbn49tSj1zjH4aju5+fmcpAiQTHooVBmDcJ5vH9mxpPuHNdypalUtYyCvFsLbuVhiIvX
         8ppqAWknS3JHv32yTiOIEsQVNy7UZutHWR6fjag7TDv8gUEwwu7I2nICw1nv7N0sj0ty
         ZGwZa1sAAJkGMnQ8yEIYLSQ9YclVovWcc4dnuDCr8xY0mD29JYEfhZNRlGlBoMoliaYO
         Pq8R57mHfCxgFNzcNWiUvhD+mZ9WDZLR3wvyxTKTWvxKUdh8Zgzq168W2IrR2FG+JgBR
         aLxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=QDudp/CNsMw0Q7hm89AwTv0NhCP0Hgb7jNITfRNvQy0=;
        fh=Z9mDe1eC32U9RekoG61o3iOCD5eBq+LHRaxOoreJGPg=;
        b=e8315M8+PUl5zzBMGRDS9nVgUjMLDLuCjTt+g0HDGHsqlv1Fq9SHf+C8ZWSmxzmJrT
         x3S8Y/q5xONXXgXeLcdn0ACE1MBK7HAzkJU0tVH6DrLYomOH1gBpyWZL1fOudvOG9T4i
         X6e/aanJ9B/nAcm5xIDX/5wy3pYn1aGE4FFHcKgpyUwzbHbLiFJl1KCD4UMWW/Olpu76
         PPmJkI1eQNrZKMa7gE/DydtgUuMaFD/JH92LJwfpcNhmYOO+eiUYIatfFNMAv8C6zfY4
         gYys6PjdO2/YlN+PsjkLCqvHQpyfN5Mour1IPIM9u7SjstOPGWUB7uDXATOmPLLxTBVx
         Ki1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795098096; x=1795702896; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QDudp/CNsMw0Q7hm89AwTv0NhCP0Hgb7jNITfRNvQy0=;
        b=hyuTEaUzmYESUMENRugMRtpbTrnwI20f0isotRNyHeWRJKcXR6ZXeYGbtjUBrHhF12
         syee6P85njyH6xfi1InZa8AJv2lnxU8B4rJeT6i9Ld28I7jzrXPc6o5r9wnCxS+qchUJ
         o4efHp9sTKCoCCGWN5lQLQuaM6Qdrja22Cedf9YUFSPWERzBFrhvFtgZR5YKO+C3JoGq
         8Z0FxnBf3TP0TBBJjgcgaJEI5Pjxg6qYrXWhcZnYRfJD44/E/r6AOf0iRK3+BhIdl5Il
         VSkR8ipqNzSJ79gWfYKe83/P0WhpKI+zTJAJh9usoCFLUfEuFZ/u9MAFIDVTgkFf3fvr
         7YjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795098096; x=1795702896;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QDudp/CNsMw0Q7hm89AwTv0NhCP0Hgb7jNITfRNvQy0=;
        b=fNQxS1Ea8vh2KeDMo+4KCOTJmtU2ov7b66xU+ZkiMx+RhCbptzAZ+0LZozIOT2QJqP
         Uuf5if5a5/5lualUrKH3fSj24bGO2CuheD8vu5vrDUXdKfVv+hXminMagN14DAPDAu+i
         jyYv2GpFlVkDh5mhfoLZPwh22COmG73+gLyv/OJRQdjaDMT/V3f3FndTY1zz0Zo/JLMI
         N4iLGTa8EdguQWYuIyWaHf2vew0r6l5W2HBuiwWC2VF0goFERz9VqIfJgct6DdZypn0r
         E0aM0xxPIVd+S/ldzhgyJPUQKyg3TNmNKyd324XRGW0DhQXFb4biTdZntQsn+jqHc0Pj
         Phmw==
X-Gm-Message-State: APuU4Z9JkWB+lSbHxXdA7XJ0mNgGCkDsaK4JJiSniNGFE8PT6e7BVFV+
	v4pP0N+DSMqbDw76udCsqFheGhlN3sqhqeX5BNA/ACZpjWz34CDQCR/O41yBGvhEoE4nrqYw9uA
	zDmFAeM1anp1anZbMKTyc6YC/GY5sLrqkrPcB+H4=
X-Gm-Gg: AYBFou3SRHEtoQKDmFV+3sJDFAN6gxCSAp2OZ/MUAR6k+RSj+XfnWRrc1ic1Xm1jkd4
	oxjjyqiY1RGSPnZm2xx/Ym79kYCUkQ65SjNyG3dC32dh4oDkdcN61+5ywA52A75qvWmaTiGEsrb
	eEuz4HjS+/NfGsP7pa2PNSP1ZLdW1W84fJn5X8i+x5KIuW786H/N4thSW9V6vuroO8aGw6pmvXQ
	hQiEUgvwY04Zm2lxjAlK5pDl/5wsQcSexgrWlPlvKh2iaJC69yyyWR6y49iKnXXm5FvI/yBhcFg
	+0NLJk72uTTmH2LDwxYXt2UfnJQHXZnylTC6IpJ0p44dYtJBU4BmOTNHQbejXPPw6xQLIfES9ti
	W1m2WBTclP7dA3j8LAiuHwLeQj8kLmq0eeykl
X-Received: by 2002:a05:6402:a513:20b0:6b7:df0c:18bc with SMTP id
 4fb4d7f45d1cf-6b887eacfe0mr3932874a12.17.1795098095861; Thu, 19 Nov 2026
 06:21:35 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Nursultan Yergaliyev <n.h.yergaliyev@gmail.com>
Date: Thu, 19 Nov 2026 19:21:23 +0500
X-Gm-Features: AclHuK-GPbU-n10FioifDd6zyXPcE9XxsktzVAibinWZC7QRfmlMnwK7uTQ1184
Message-ID: <CACWbNdxohFg52KLwfH6fd95dGXiviffX9kNLw_1=j7ZpCCuMjg@mail.gmail.com>
Subject: [BUG] pciehp: spurious "Card not present" on soldered dGPU port after
 resume deadlocks dpm_resume (Lenovo Legion 5 15IAH7 / 82RB)
To: linux-pci@vger.kernel.org
Cc: lukas@wunner.de, bhelgaas@google.com
Content-Type: text/plain; charset="UTF-8"

Hi,

On a Lenovo Legion 5 15IAH7 (machine type 82RB, BIOS J2CN57WW,
Alder Lake-P + soldered RTX 3060 behind root port 0000:00:01.0),
resume from suspend hangs reliably (s2idle and deep, also with
pm_test=platform). Kernel 7.0.0-43-generic (Ubuntu 26.04); also
reproduced on 6.17. Windows suspend works on the same machine.

The dGPU root port advertises hotplug although the GPU is soldered:

  pcieport 0000:00:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL-
  AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis-
  LLActRep+

Before suspend the port is in D3cold (dGPU runtime-suspended).
On resume (no_console_suspend, pstore):

  ACPI: PM: Waking up from system sleep state S3
  pci 0000:01:00.0: VC save buffer size does not match @0x100
  pcieport 0000:00:01.0: pciehp: Slot(1): Card not present

pciehp then removes the GPU functions while dpm_resume() is still
running and user space is frozen, which deadlocks (sysrq-w via pstore):

With nvidia loaded:
  irq/122-pciehp: pciehp_ist -> pciehp_disable_slot ->
    pci_stop_and_remove_bus_device -> device_release_driver ->
    nv_pci_remove -> ... -> down_read [nvidia_modeset]
With nvidia blacklisted:
  irq/122-pciehp: ... -> pci_stop_and_remove_bus_device ->
    azx_remove [snd_hda_intel, 01:00.1] -> snd_card_free ->
    wait_for_completion
In both cases:
  kworker (async): async_resume -> device_resume -> mutex_lock
  kworker (kacpi_hotplug): acpi_device_hotplug -> mutex_lock
  systemd-sleep: dpm_resume -> async_synchronize_full

The "Card not present" is spurious: with PCIe hotplug disabled the
GPU is present and fully functional after resume (nvidia-smi OK).

Results:
  pcie_port_pm=off                      -> s2idle OK, deep hangs
  pcie_ports=compat                     -> hangs (acpiphp removes the
                                           device -> same deadlock)
  pcie_ports=compat acpiphp.disable=1   -> s2idle and deep OK
  00:01.0 kept in D0 at runtime (child d3cold_allowed=0 +
  power/control=on)                     -> still hangs
  removing 00:07.0 (TBT) and 00:1d.0    -> still hangs

With hotplug disabled, I compared lspci -vvvxxx of 01:00.0 and
lspci -vvv of 00:01.0 before and after an S3 cycle. The only
difference is the PMCSR power state of 01:00.0 (D3hot before, D0
after); vendor/device and subsystem IDs are unchanged and the port's
slot status is identical, so this does not look like a "device
replaced" case. The "VC save buffer size does not match" message also
does not appear when hotplug is disabled.

Questions:
1. Should pciehp ignore/defer a presence or link change seen during
   system resume until the link to the device has been retrained?
2. Or would a DMI-based quirk that disables hotplug on 00:01.0 for
   this machine be acceptable? I can test patches.

Full logs (pstore traces, dmesg, lspci -vvv of 00:01.0, acpidump):
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2174812

Thanks,
Nursultan Yergaliyev
