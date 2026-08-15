Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A9334887E
	for <linux-pci@vger.kernel.org>; Sat, 15 Aug 2026 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786821904; cv=pass; b=cE0QC0O74tWziFgGkTKsXN5WrvDS0AD9MfMOCdVtT6Ov8gGNvf6C0Y0xcwqIf2HoBV7/aOW2TuAfGYfl4ZMNnXvZ5x4CzUhCjRqmd3dR7SmJ6kDshto3J7NuOOjVK/Tgej/WPe6sjyDP3dz5KIQjlRmafHc+Lqm/VK2o22CMT9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786821904; c=relaxed/simple;
	bh=LyNlX1j0btBnS535gwJipVHEdEB8Y2UpMhnwZbCY8KY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lM4ss7zrRqOi+1kztgpM+LDZdRpVC6WclGWAjg3WR4yb5bcpi2WPYwXvkO+MlTDDCVgSPaOD8i5MEDzCswAb04LB+E9Qb1jyRc3gVdGMldAkjZPZftaDYpr6+BwpftJPUH3Xo5GHycxdnBVwA9+WVvOxLNVdHcDYbt0JFaUpJkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9Qg6b2l; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9Qg6b2l"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66c2d726650so3142280d50.0
        for <linux-pci@vger.kernel.org>; Sat, 15 Aug 2026 12:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786821902; cv=none;
        d=google.com; s=arc-20260327;
        b=qKP3UZkDnLlwaTkTo50LFq6lJPpvL96bi3hQ+WGnokUh4t/CbbkNK+Fb6UN2R9XEyW
         fhVZ6FUwF7EZNUbe8JCoWRu4kPUnV9QcZBsbJdU1Ck1mhlvT7awhb3yBoSutN1kKEUjo
         UcXbvQ8Llr7vcmiDKHvTH8XhuU3ncZuCgsGSdj3Siuq8Rube42Ziq+eYYX4m1+qCkqli
         WrR+GMUi1sRyK8pdFxf8nNvq46FvdE1HBp945D2ucBlm5UWnqSZa3Zx9gFODo8g2Zzwc
         BLNSI+gauwIkSr3CFe5f5ZZ0f9/h7TQYrwaSYMjBQGrqEEeNo10P3uSqNXx5X3M4qTmO
         lSQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=i25AyZtKRFhzMR5QqIFCMCTbdMi3Ob+dfB3n/Bwk3po=;
        fh=6teCRm8P7SByL7gnFSwJNmt3Vydfk5JnuLDqoj79QPQ=;
        b=LPuxedz7U8dIPc9lGm/UsQo8M3jSrpdVfV4Pd4kRCsPdN8LPM0Cl96wC1sfvy27tLB
         jOOC72ZHy3Hmg8mWdsquhZBaN/zxz+LXn6P7N3O8APNNsG/jZprRiNWqSnUraFM4rlr4
         7YNQYsOMSxBdyPVfaduwGfyfw9uJdnFioEdHkqvQ4FxmZ5UtEyZyVm+VG6Ou95hj+T1a
         THueuogN4+MHyga5Dq4JVo5ToPB5Ll2fqxxlg1wK0wcv910Xxq05a/pUGWFnFb05haUH
         3KHJEmL3LQkaDrcFIZnmhik2gee0rLdnyCCpQ8POiy98JSf4Ruix6g4iPUTKqyiQQxZz
         9A6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786821902; x=1787426702; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i25AyZtKRFhzMR5QqIFCMCTbdMi3Ob+dfB3n/Bwk3po=;
        b=T9Qg6b2lhwTKRz4qoIKwp8oXObH6PhaZLp2KFaeIp047ELl2cRT/8D7JedL+n9/0Xa
         G47rkswcxgP9SPA6DA09mJ0nadkinakMCpfpd9vEwyaWv5sBb38KCJ0PUiqSMqGEs/5H
         c/7GJ8Sw1idWXX3Cd5Qi9ZsArrf33FQ88uAaEmEFeuK1VlAgIQFbMhop9iapVdQPDMO5
         Hn5pmoloRyBAvMqHKlUWIZCiTR7Leq0/eR+qH4prSt10lhwb9H7AfVKd6/86sa3riP2O
         /i7pEORaOkGX5EVrVYBp3rhh51x8MX9HHDSxHpGTJkAFqVLcxfD3A30nAmeMoUBLCL3v
         i/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786821902; x=1787426702;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i25AyZtKRFhzMR5QqIFCMCTbdMi3Ob+dfB3n/Bwk3po=;
        b=j+iyxSH9zVSYV275x1s0XPYpNYrEgY4+oCQN2hz0UAm1pdo1gb1G6s8SIqzwJ16+WB
         833aBnURZXT2ppkPqXTpbluhknf0ScR2VkqPNxaUKqMQ5nfSyD25Ta4LZZv3WddEfAyY
         JOihycM74uZGulaXZs4zBj4ZF55AHpZNkMO7XyFcMSIlCC39qNYGNN6BAKR29cJqKhbH
         vZTKpk1kpfYUbNEqh3Ucqx5mLkHZ8Y8lhJ0xMOP6v2ND4lTL8InN3XL6FpV3F2i2evox
         rgpanly8IPhnEw0aXj6Oe+gGJc7f9glE9zu/H7dMu4l4CYcoHeBvaWnyqgIV3d0ySel0
         FiDQ==
X-Gm-Message-State: AOJu0Yy6WHKkfT0g1SFl8S0SLjYNtfYc8jOVWnvCZybMeRWKQmxvujsR
	P/t5MIUa8nTXQ7YpHq+Jt+B95DuvXu2E5XyKyhR6rxcz7z1IzEThpp2IFRzptZ/dsxbX+xpi6MB
	LNMsmqXWAKD+sz7byjG5ze30AteJElpG0eaaaHPZVwBtiMfw=
X-Gm-Gg: AR+sD11l3LjBzBX9VXOYD2IUhMg69AMNNOrJ7BEt+GQQHc72ARNK9qusnvKzTllXaIs
	c5BoF+Cu54XHzTeXxQ7jS+2yNsXuYINP5Kf1R9oc87vSIRi6ZyZDOuXu61PcXZGMna/KMoPhgG9
	jhuCnWGnf0p/MAp188MpSDrMUpdBPROe00ZVDg0DcakVlTkypMl3K+i5KSHmP+3xRDrX/8rQzvT
	OqM7+HxNbE59ECttg/R0QTdXpbNkqyD8PQ/MKfnW5ET59Fb50JF9Ttr9NqVEMCZ4l2Ka7hmHPlO
	iMMtOAAtaMuwkQEhsEStFFEidPbePg==
X-Received: by 2002:a05:690e:2667:b0:66c:4be4:89f3 with SMTP id
 956f58d0204a3-66c72b88407mr4039050d50.15.1786821901937; Sat, 15 Aug 2026
 12:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anxo <01anxocalvo@gmail.com>
Date: Sat, 15 Aug 2026 21:24:50 +0200
X-Gm-Features: AcwNN1XY3zcIb-2qBkmL5Oz7UoNmiS06BY9gZ9xO0A2wnXKgIxx7jvvejaMOIu8
Message-ID: <CAMkZroTGOXnLFGx=j+mkiKnvrivsNAvUt5=kc5dJQON0JHhzBg@mail.gmail.com>
Subject: pci_device_shutdown() resumes devices on poweroff: ~19 W in S5
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On an HP OMEN 16-ap0xxx (AMD iGPU + NVIDIA discrete, Fedora 44, kernel
7.1.8-200.fc44.x86_64), a normal `poweroff` leaves the machine drawing
19-20 W in S5. A full battery is empty by morning. Windows on the same
hardware does not do this, and halting straight from GRUB - so that no
Linux kernel ever runs the shutdown path - measures 1.05 W. The
platform's S5 is clean; what poisons it is what Linux leaves behind.

The cause looks like pci_device_shutdown():

static void pci_device_shutdown(struct device *dev)
{
struct pci_dev *pci_dev = to_pci_dev(dev);
struct pci_driver *drv = pci_dev->driver;

pm_runtime_resume(dev);

if (drv && drv->shutdown)
drv->shutdown(pci_dev);
...

That pm_runtime_resume() is unconditional and runs after every userspace
shutdown hook. The discrete GPU, which userspace has already let fall to
D3cold, is brought back to D0 on the way into S5 and stays powered. No
userspace mitigation is possible from outside the kernel: you can put the
device to sleep a millisecond before poweroff and it is woken again
afterwards.

The resume was added in 2012 by commit 3ff2de9ba1a2 ("PCI/PM: Resume
device before shutdown"), and its rationale is kexec:

  "Without this patch, a device may not be enumerated after a kexec
   because the corresponding bridge is not in D0, so that configuration
   space of the device is not accessible."

On a real poweroff there is no kexec, and pci_device_shutdown() already
tests kexec_in_progress a few lines below, to decide whether to clear Bus
Master. The information needed to tell the two cases apart is already in
scope at that point; the resume simply does not consult it.

Measurements. All are battery energy_now before and after a real
shutdown, over windows of the stated length. Raw watts are not comparable
across windows of different length, so the nights and the 20-minute
windows should be read separately:

  normal shutdown, unpatched (n=2)      20.05 / 19.73 W
  dGPU pinned in D0, poweroff via
    PM1a_CNT so device_shutdown()
    never runs (single-variable control)      19.85 W
  GRUB `halt`, no Linux kernel ran           1.05 W
  dGPU kept in D3cold through S5,
    four whole nights           0.46 / 0.46 / 0.47 / 0.45 W

The 19.85 W row is the one that closes it: same shutdown path as its own
twin, one variable changed (the D-state the dGPU arrives in).

Ruled out, each with its own measurement rather than by argument: the
DSDT and all AML (measured with a live 56-byte DSDT), all 23 static
SSDTs, the SCI and the GPEs, the FADT and ACPICA's hardware layer, the
IOMMU, amd_pstate and the CPPC MSR, every armed wakeup source, all of
userspace and systemd (measured with a custom PID 1, no udev, no
journald), and the shutdown method itself (EFI ResetSystem vs ACPI). The
full log, including the dead ends and the measurements I lost to my own
methodology errors, is here:

  https://github.com/AnxoCalvo/s5-poweroff-fix
  https://github.com/AnxoCalvo/s5-poweroff-fix/blob/main/docs/EVIDENCE.md

I am deliberately not sending a patch. The 2012 commit message notes that
some shutdown work - MSI shutdown was mentioned - needs the device in D0,
so making the resume conditional is not simply a matter of testing
kexec_in_progress, and I have no basis for judging which drivers rely on
being in D0 inside their .shutdown(). Proposing a change to shared code
from a sample of one laptop did not seem right.

What I do have is a rig that measures this reliably. The discriminator is
battery energy over a fixed window; wakeup behaviour and thermal
signature both looked convincing and were both misleading. If a patch
would be useful to test, I am glad to run it and report numbers.

Caveats, stated plainly: one machine, one firmware, one vendor's GPU. The
mechanism appears generic - there are reports blaming Thunderbolt/USB4
docks and xHCI controllers rather than GPUs - but I have measured only
this one, and the numbers above are not evidence about anyone else's
hardware.

Thanks,
Anxo Calvo
