Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1273F8251
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117121; cv=pass; b=CUmYMq0JKx0v04++ktrKX1dT5pyzd/cLksMX590xOKqYgll2MTdfCq+N7ERJwVQnNI1jtfA3M3diWOxCFZCvAO3uVsLxKfGS/tpeTMRV2kB6yRbJQ98OWuo7jhTQb0/UiEpevosCZcHL+/mRgQzV81HYDk64EphVSSRBoivd2q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117121; c=relaxed/simple;
	bh=KRWayakKg54b1ejAA7wnTRxMcaVbAc8OZKXSDlvym5Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Vpzk+0XfQxqRUTlVGZft+sj0Lq/XVXtR/Y5YGELIjmn/9k+TN18FBjUbwWngwPXH6FfYjOSijeiZ9V8TvEx0XbmJbXWQnkOkNQ5IL8ckfKBmMUHw7Rc9W0Xfc33tZCbRtuJy8XwMjScY6S0NKWmqgx4w12Ely1RjiJxrQlIpMZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Svk6h4EJ; arc=pass smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Svk6h4EJ"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-78a7003f9f5so404996137.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 01:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789117118; cv=none;
        d=google.com; s=arc-20260327;
        b=T0XDC4JqO980K/0QylJeRqWxPlXuJZt/wnLzlRfxrkQ3A5Mcsu3GoDToc3+8cVGUL9
         +PIy3mSpbPCKAeoV07QOD2IGn8XwCDL+L3EdBdaP4pS59spIFX3ivKwiA8gAiu+LkC+l
         /bq2/ZEr6y4/nCYOFZJniO2Uo/dVfu9S+wB3G9OwLlVGvk8VcJ2O2YKNDUar41KfKoWJ
         4bxeZ7HSoGVjYqeAChMzL+OQ+gA1qlNOpWW36DDGM2IHAw0UkawXaFQXit1h9LrQ+9qP
         1+FhuY6CXsZG9V9RXM7DPPlydqdTOAuH4ZVxG9QL0LPKL6Nq3CpSu4z3Wp+xkEwlacO1
         z1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=sIlFHZx9QRrxI0zvnnTqa2141v+o9orLJpuHyRKFQEs=;
        fh=mDvTlny6IhipJ7dOL1sxhHVp05WeiaMSGO44yYh4oIs=;
        b=nXuNbl+AXnRk66U/Nk1q4CdTxAfK3J/qPHvKvMQv+wBfuVBKkHzAK3FrnQbH8Z6Bwz
         xhpZyIgYVr8X9DCo2x9m3MgvdpGuHw50On7v1L0Y4mUWXp79UsGQb3SnujtXJ13ZHVmV
         Twx9cpyGXqMgVWZ/vxYqgQ6e4S1S4YP/IleQavE7WPdlRNA8nEEEEPCmQTxolHJfVyGU
         zREmxLO/6jx6rn8VqBl5jbZdUiNUlaStR30oIXJE5FsZ7zu3s3Mfsrf7EQ0M1M0eF6kZ
         G8KQKesrjq1m8n2PJZwaFlWoi/2ALpLxQmeX6KfDpZMCeuRaNdqZYmHAczGY+gtWyqa9
         nkwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789117118; x=1789721918; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sIlFHZx9QRrxI0zvnnTqa2141v+o9orLJpuHyRKFQEs=;
        b=Svk6h4EJTrf0sIM29sNvHKM3DH0AEUODSYyoV3mbX4DBitj4wwc5mbgb0/GvadujCC
         DPkCf9GacO7d/MKSN/rt4VfFLYs4lha/cc7YcJp9oS3ILuuIXbZHzGqFjU+dROUZxiFN
         9SdJtQqR9TG7LKM0VtKC3dZ2pPpKJ2vptp9NoBi8SbooSBkDe1yVihWu+fQmmk8ySweH
         uJ6tQGRYIEykdRe73qN7gHuqD4O2qBF8MMPkPGj4lcSaLfsmEfELelQ4pjuZHJJ1yTy+
         slMGCFhJnT3oDstT+X612FzwKMAlKxxRw+gbtFeRxc75K0R8WP/ajiv0Fjo2erql22U1
         VFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789117118; x=1789721918;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sIlFHZx9QRrxI0zvnnTqa2141v+o9orLJpuHyRKFQEs=;
        b=ZGdSAJ4OVqT4t2YXohz0YKKamf+UycD1h3cm11N1ONeIhDkFwexQX9rVT5zQ1FOXfi
         Ma93BT2NI+V6VRpXNwFWgS9cAVGM9jjBKduD1098u/pPqmaFtUq5lLxbo81fQnpwULa2
         5dYPLyBUIhzZPbcPk/iNkaG1mv6mzqu1DsZN+i2B0ZeiibDyld237x2C66/SUWS609Bm
         itRghhbXgO9zXjUMJ7mhAJqnthac70TlWoLNlwuSQizGLAzcqP06IGtNfNXw4vs8XEsC
         Wjd+OSVfcR+krCeJkCn56baVIZnNFbls7YawfL24f2HsosZ2oNqxackBR2VQH6+UBYL7
         1PwQ==
X-Gm-Message-State: AFuF++luLSGyc4tjR/EC15jDQiD+zu9ZuMzVwVzKmg3Q+tWj2uDQkZqD
	tx2/aoSGRWgtwj5L6LGVxZE0KgAWZkd1RTkJO2oURLErOUUoHv0waa9IO62WyQ1XD7LtpZLnSwC
	i2g5RJGXSaQTPLq9/3tLnX8iUvK/qodf82Z2a+cQ=
X-Gm-Gg: AYBFou017PqLd5HRgZqyNFiu2yXzLKIrSBMHUEhjG+EiLYi1e46L4i0OD4wCLMM764e
	qj7IwnArtA5ZKzq66/TQ7xBXpZSxxBPP8n10xN9A/nRmjbRgDI8lCKdFqoGUzVNc/JA2Tt9Abea
	ao3pnVB7JHC0zVkvWdeIawn6uI7IgRd0IajBFn47LWsnZdwlSc93pEgZ4WtZbj4APlRL7/LFIHy
	r+q4hmSTqz8UTBYYS3kTBzI9MZWDu3+gJTmHNKXqxvS+74Qyuy6j4owuvNuLF/cD1poYlYEClZu
	U3oB/ZWLhK+FaF3NmnJQIOYnzKOMxw5RAYM7dThKhym6APBUb18vnUFD
X-Received: by 2002:a05:6102:5719:b0:78e:1e0f:ea42 with SMTP id
 ada2fe7eead31-792a47f4705mr1895004137.2.1789117117241; Fri, 11 Sep 2026
 01:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?6bOl5LqV5Y6f6IyC?= <monogokoro2026@gmail.com>
Date: Fri, 11 Sep 2026 17:58:26 +0900
X-Gm-Features: AcwNN1U40C3-c-OzibjwOHdiCZ7c30ZeLMPgU3KxM6RxiJbLZNEyCv9dhpn1p6M
Message-ID: <CAFpUU0sqt2VzdGGUcx3fkLyyDSynOhNgAraT7-gL53oBq1aMfw@mail.gmail.com>
Subject: PCI: Resizable BAR never considered for Thunderbolt/USB4 hotplugged eGPUs
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, ilpo.jarvinen@linux.intel.com, 
	linux-usb@vger.kernel.org, westeri@kernel.org, andreas.noever@gmail.com, 
	YehezkelShB@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi,

I am reporting a case where a Thunderbolt/USB4-attached eGPU is
enumerated and links
correctly but can never be used for compute, because its BAR stays at
the power-on
default of 256MB and the Resizable BAR capability is never exercised.

I am not sure whether this is considered a known limitation or a bug
worth fixing, and
I would like to ask before assuming either. I have the hardware and am
happy to test
patches.

Environment
-----------
  Host:      ThinkPad X1 Carbon Gen 13 (21NS0000JP), Lunar Lake
             BIOS N4BET77W (1.47), 2026-06-30
  Kernel:    7.0.0-31 (Ubuntu 26.04.1)
  Enclosure: AOOSTAR AG03, connected over USB4 (not OCuLink)
  GPU:       Intel Arc B580 (Battlemage, 12GB), driver xe

What happens
------------
The card enumerates, binds to xe, and its edge connector trains at
16GT/s x4, which is
the expected ceiling for a USB4 PCIe tunnel. The link is healthy.

BAR2 stays at 256 MiB. The card advertises Resizable BAR support for
256MB..16GB:

  # cat /sys/bus/pci/devices/0000:24:00.0/resource2_resize
  0000000000007f00

Level Zero (intel-compute-runtime 26.31.39395.13) prints

  WARNING: Resizable BAR not detected for device 0000:24:00.0

and then drops the device from enumeration entirely, so it never
appears to any compute
API. The integrated Arc 140V is enumerated normally.

Why the BAR cannot be grown after the fact
------------------------------------------
Attempting the resize by hand fails for every size down to 512MB:

  # echo 0000:24:00.0 > /sys/bus/pci/drivers/xe/unbind
  # echo 14 > /sys/bus/pci/devices/0000:24:00.0/resource2_resize   #
16GB -> fails
  # echo 9  > /sys/bus/pci/devices/0000:24:00.0/resource2_resize   #
512MB -> fails

BAR2 is placed at 0x2010000000, which is only 256MB-aligned, so a
larger size cannot be
aligned to the bridge base. The prefetchable window of the Thunderbolt root port
(0000:00:07.0) is only a few hundred MB and comes from firmware:

  PCI: Using host bridge windows from ACPI; if necessary, use
"pci=nocrs" and report a bug

I measured 711 MiB and 448 MiB for that window across two boots.

Things that do not help
-----------------------
  pci=realloc                  no effect on already-populated bridges

  pci=hpmmioprefsize=32G       makes it worse: the Thunderbolt
downstream port the GPU
                               sits behind gets no window at all, and
the whole card
                               disappears from the bus:

    pci 0000:22:00.0: BAR 0 [mem 0x00800000-0x00ffffff 64bit pref]: assigned
    pcieport 0000:21:00.0: bridge window [mem 0x00800000-0x00ffffff 64bit pref]:
        can't claim; no compatible bridge window

  pci=nocrs                    the machine does not boot: the NVMe
holding the rootfs
                               fails to get resources and probe returns -ENOMEM
    nvme 0000:04:00.0: probe with driver nvme failed with error -12

  thunderbolt.host_reset=0     no effect here, and I believe the
reason is that the
                               firmware never enumerates the tunnel at
POST. The eGPU
                               first appears 63 seconds after kernel
boot (16:05:11 boot,
                               16:06:14 first sighting of the card),
i.e. purely as an
                               OS-side hotplug event. There is nothing
from POST to
                               preserve.

The BIOS has no relevant setup option: under Config > Thunderbolt 4
there is only
"PCIe Tunneling" (on/off). No Resizable BAR, no Above 4G Decoding, no
BIOS Assist Mode.
I have filed a separate request with the vendor about that.

What I think the underlying issue is
------------------------------------
On hotplug, the PCI core reads the BAR at its power-on size, sizes the
bridge windows to
match and assigns addresses, all before any driver binds -- and the
ReBAR capability is
not consulted at any point in that path. By the time a driver could
ask for a larger BAR,
the surrounding windows are already committed and too small to grow into.

This looks like exactly what "PCI: Allow BAR movement during boot and hotplug"
(Sergei Miroshnichenko, v9, Dec 2020, 26 patches) was written to solve
-- the cover letter
explicitly lists Resizable BARs as a use case. As far as I can tell it
never landed:

  # grep -c -e rescan_prepare -e rescan_done -e bar_fixed -e
movable_bars /proc/kallsyms
  0

Questions
---------
1. Is ReBAR-over-Thunderbolt-hotplug considered a known limitation, or
is this worth
   treating as a bug?
2. Is there any current plan to consult the ReBAR capability during
hotplug resource
   assignment?
3. What is the status of the movable-BARs series? Is it abandoned,
superseded, or waiting
   on something?
4. Is there a kernel parameter or sysfs path I have missed that would
let the BAR grow
   after enumeration?

Thanks, s-tory.
