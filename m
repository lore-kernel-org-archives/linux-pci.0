Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7A24BD0F1
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826074; cv=pass; b=mwT+eAy2UNpyPPtrklwiRDpAhF7YeO67+eszQt3m/35xaARSW3FItDNE0+rleDzOd2Ip/6dcVvP9d5RPBZRRUYXKCNIW3TzqSOl+yVJAHy2Qolq63gFC8zBN2gyMwV+//BEr0oU76ADgAlNCMKU2HaXxEh7uljhecbYZDmAfdes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826074; c=relaxed/simple;
	bh=ixcvxfw6JuRgsZ4xESMIS6I3nEqDDX4qbcHLQVtaIaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOX6HYkJ7q9B4MQmkbUerbyRwqlJUjaUlcD/4gRNjjGunV2VOC6zF2pAdgtPt6a+DBywV84yszgELIM/X8DKqi39VQu4ZK2iYv4d0V907vaTay49RE7QCpOYMuHTerzqZMPCSn1mWhk3xPdWLRQv307eRoxZnmjL99p2PGa/xqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMxZ02yj; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMxZ02yj"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c29c6a3930bso267752266b.3
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 10:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791826069; cv=none;
        d=google.com; s=arc-20260327;
        b=QxiSkSMsIfc46ZS/mInZkckUzjTMTw4C+SXuHRrFEs9k/G2Fi36MhRhdAZOPgQ1EVs
         gSHVoGC3lJPdNHZmkTtcPoRaDVV7kOXf4GRIMjTZ4ZEwnkjd+G4LvY+JAQLu8sO346Zz
         QMUEB0t1Q+i01Wihr7Jnkm9uZ6m9yRAcqbKFuYTaO1dcjExwUlhdLpBKjn2FiUWjvfmi
         VAgaWpdkFFb8hpw4IEvgw6v6TczutxGDNEs72pAC8pVFMOdXUGG5OKktBfHilCQtvpLm
         oGCxFDGY4DAR2jWpAEA42emHUDvmFKFX5gLrs5Ou7LbAhYz7EfKX9D5T7ZN9rBvB0rv7
         VDOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OtJOsVO1K2acZAU4qcatnAuGrI6UgGvUj/f3n1t6+og=;
        fh=UaHSrk+DWCGk8tApTv3P+RXASmmglj1D8bkcJ1WtnL8=;
        b=drfl6r/ep0NxkosprwDG5wJooJ2VptsZSfaxRYlVIyOG9ZKdP6MaG0fmF67sQlHaT5
         eEiPZsenBSrDT+D/iNKmLg/UZVIMNZ79N5bOjjUYYJlE0XBLoHBE/6GHHgUT80w+x4yE
         l1FMXhttbzYHEv6D+I3cKlldGTbzAbQSVMGozr6xNREr8EiVgbvIiBn5KO10TCWM1nf2
         YEFb6f9wrRkX1BZmGbwSNuqiNNMZUCSI5NPdKXV8PmP53wKkEGV21HUv75M42lJuk/A3
         rTzgmTdUmT9YwuU7xOOfMbSroc9ma3/uUBpqC5R4C6T9NeZGmtsvmfec0RpYRBVKzr5m
         LLwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791826069; x=1792430869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OtJOsVO1K2acZAU4qcatnAuGrI6UgGvUj/f3n1t6+og=;
        b=FMxZ02yjkS/+8mnJtVGEx6kiX75q1BBnnTa/09CZZ3pj7UNf0YQ24kbVE+1A1QVNQB
         MWywY9qwODp0u5ghALQvloxDEmnvnQtPg28zalbAfUJbsMFAyqzQDFeWAPL+rYuQAzQg
         IgkF4woS79HFyrgnvdy3KeKl9GIUwj/Bdb5AJEPzGKPTul0vy5eJqRRoJ/lTdJOTO1hO
         u4QlIZd5WVDXy+cXf4lOESYd2WqvEj636zsEu/NIT5jFj8ZU+wVa2NyejNayyroBSXRX
         XDETjTsMITxQxR/3OvZP+LSngeW7AYfHr3RaD3YguUc5/hTmTNe6G2vPutd9frNcl7UY
         /mbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791826069; x=1792430869;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OtJOsVO1K2acZAU4qcatnAuGrI6UgGvUj/f3n1t6+og=;
        b=NsSYY1Ef4Pl0B1mPxp7Mp9TmULb71ycVI875lOTI7gBL/xa93ViVAB48sY5KXfhlUj
         icl7pVmTSIkhebCx1iHtBRqr6gEChsILa7H0r4Kw0kCBzE6H25YLfD1+10fu/HfOJHqz
         WhQ7ZuB3lYjWojY2/nYwhCahhOKq369KGGrGTONYhHf4GVnAC/l62EdFwayeq0/12pWr
         Bz408haAKOSjR+MQNM8haZBzBrLktpm45rHikBsfGtC2mdVqGHP5H4CQHLjeuBMcxPtm
         F6FNDxEJIcVIndiid2YBHRthuMXiPWZa+8yLGblmchHH1qvBx2EDolRiCRAQxW+/qA76
         fG7Q==
X-Forwarded-Encrypted: i=1; AKwUvBywwSWUM0OUMyuUoE2peQ8hPCVlQqbTX/lctZ1SQO5mgm9WpSKac5JoCcv7VkhOSjh6ZNnRgQBbH1Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpi3rUMi+aXGBecmFZIiQSUtbhS2dUIlc3Iw64pjR/zJzhu/qf
	H+LrL7bfsPpIxq9AH6zrjXVUHRMhQYQ2RjucTUDBYoeLPvUEPLO8OhUqFeGs7ClzlGL68CCKU9F
	qvycMoCwpyZs12+Q2CfsJZ41wZCoLbU8=
X-Gm-Gg: AYBFou1nXZN8kSqc+w2Zz9n4LtYY4yTPVltdpBXoEJ7EGxeWHjczpcrPwR0YH+1T91c
	27fcAfohK86caZcCBEBWfJ5Y3hkUfE5ZRztH0ZAA2bK6j5vy3trBocutoEJJrBHzKVQrztrLjXM
	2n6ZAnfIxAr1snfbNwEY9OWpt++78oB8iUQFvfhJlMU8XT4c9ASSHYs4a38LAakhVC8yerXurSh
	lwg0+bKkh+CF47f0MLSJQrjj6sXrhmB6rfKaNhTyPwN1qpNqovaa8d3979WEWPtVSksVJxWXlTu
	f7ano1gXzQjX7a34Osf38sPfbkFYtieO34IqqdyN/4EnaUCB3cgnL1wJ0I3QzRPIJRZ8o0apTf9
	hZbQMj7v9w4/arsWGhdWfVJRv/Rxt5jYzmUGGYh2UN68/qERnjwtuiTGJKf4n4iPP5kkiSnHQ+T
	1Y2yLmsik8peQL7BR6jYMowA==
X-Received: by 2002:a17:907:1c89:b0:c2e:2d8c:4585 with SMTP id
 a640c23a62f3a-c31a9fdb266mr1030063566b.36.1791826068900; Mon, 12 Oct 2026
 10:27:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABZrw2EfeChvuWDJ_hiwr9Oh_QpyrfZKLq_-jOxkzZH=fr575Q@mail.gmail.com>
In-Reply-To: <CABZrw2EfeChvuWDJ_hiwr9Oh_QpyrfZKLq_-jOxkzZH=fr575Q@mail.gmail.com>
From: "Perlow, Jason" <jperlow@gmail.com>
Date: Mon, 12 Oct 2026 13:27:37 -0400
X-Gm-Features: AclHuK_bqLyPVGQ-mr7n1NMFfYWUOt-_0I21LZphufLfVxtdEishkHylWbha0rs
Message-ID: <CABZrw2H0ArT0nJdMGe5zXZOrfxD79NZc84PZVfCPmWzUfvyhRg@mail.gmail.com>
Subject: Re: PCI/AER: MacBookPro16,1 test results with Apple SEP ANFE quirk
To: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>
Cc: Aditya Garg <aditya.garg@linux.dev>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bjorn, Lukas,

Follow-up to my October 10 report. I have now tested the quirk on v7.3-rc7,
which already contains 79c168e2aa95 ("PCI/AER: Skip error recovery on false
alarms").

Kernel: v7.3-rc7 (24a19b953e2a) with the Apple T2 patch stack and the SEP A=
NFE
quirk. The quirk is an EARLY fixup on Apple [106b:1802] that sets a per-dev=
ice
flag, so pci_aer_init() leaves ANFE masked on that one function. ANFE handl=
ing
is unchanged everywhere else. There is no global revert of eddba19b8b5f in
this kernel.

Systems: two MacBookPro16,1 (Core i7-9750H and Core i9-9980HK), freshly
installed on this kernel.

Results, both machines:

  - Boots to the graphical session, confirmed on the panel (not only by
    service state).
  - Suspend and resume complete with the session intact.
  - Cold boot from power off works (both machines).
  - 2 hour idle soak: no AER, GHES or MCE report, oops, BUG or call trace i=
n
    the journal.
  - Read-only config space check of the correctable error mask:
        04:00.2 [106b:1802]  0x00006000   (ANFE, bit 13, masked)
        04:00.0 / .1 / .3    0x00004000   (ANFE unmasked)

Controls: an ASUS GU502LV and an Intel Arrow Lake desktop boot the same ker=
nel
with no SEP device present. The quirk does nothing there and nothing regres=
ses.

Limits: two units of one model. No AER error injection, kexec or other T2
models. The test kernel was built with gcc 16.2; the release kernel I compa=
red
against used gcc 14. The quirk matches on vendor/device ID, which the T2 te=
am
says is the same on all T2 models, not on DMI. I still do not know why
unmasking ANFE on this function powers the machine off; the quirk is a
targeted workaround, not an explanation.


On Fri, Oct 9, 2026 at 11:49=E2=80=AFPM Perlow, Jason <jperlow@gmail.com> w=
rote:
>
> Bjorn, Lukas,
>
> I have tested the Apple SEP ANFE quirk together with Lukas's false-alarm
> recovery fix on two MacBookPro16,1 systems. Both stayed up for over two
> hours after booting the candidate kernel. The patch is being prepared
> against pci/for-linus at 79c168e2aa957ed0054c93db17caba653b95e377.
>
> The candidate retains eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal
> Errors"), adds 79c168e2aa95 ("PCI/AER: Skip error recovery on false
> alarms"), and leaves the ANFE mask unchanged only on the Apple T2 Secure
> Enclave Processor [106b:1802]. The global ANFE revert is absent from the
> test kernel. The per-device flag approach follows Aditya's earlier
> proposal, with an EARLY fixup so the flag is set before pci_aer_init().
>
> The test systems are:
>
>   MEDUSA:  MacBookPro16,1, Core i7-9750H
>   CHIMERA: MacBookPro16,1, Core i9-9980HK
>
> Both ran 7.3.0-rc6-6-t2-edge-apple-sep-anfe-test, confirmed by uname and
> the kernel banner in each current boot journal. At the 23:24 EDT check
> on October 9, MEDUSA had 2 hours 22 minutes uptime and Chimera had
> 2 hours 21 minutes. Their boot IDs were unchanged from the initial
> successful candidate boots. graphical.target and the display manager
> were active on both, and neither had failed systemd units.
>
> Read-only config-space checks gave the same results on both systems:
>
>   Function                    Correctable error mask
>   Apple SEP, 04:00.2           0x00006000
>   Apple function, 04:00.0      0x00004000
>   Apple function, 04:00.1      0x00004000
>   AMD GPU, 03:00.0             0x00000000
>
> ANFE bit 13 is therefore masked on the SEP and unmasked on the other
> observed functions. No config-register writes were used in these checks.
> The implementation matches vendor/device ID, not these bus addresses.
>
> Neither candidate boot journal contains an AER/GHES report, kernel
> panic, oops, BUG or call trace. Neither recorded additional kernel
> messages after the initial 21:04 checks through the 23:24 check.
>
> The earlier Wunner-only candidate booted on MEDUSA but then powered off,
> as I reported on October 8. Its retained journal ended before that event;
> there was no recorded shutdown sequence or panic. The cause of the power
> loss is still unknown, and this quirk does not establish a firmware
> mechanism. The combined candidate has not reproduced that symptom within
> the observed interval.
>
> There are remaining boot warnings unrelated to the reported AER symptom:
> ACPI duplicate-table/method errors, AMD SDMA fence fallback warnings,
> HID rotation probe failures, and Broadcom P2P failures. Chimera also logs
> CPU 0 machine-check records in banks 12 and 13. These warning categories,
> including the same machine-check status/address records, appear in the
> previous boot logs. I am retaining them as separate follow-up issues.
>
> This was a v7.3-rc6 test build with the existing T2 driver/patch stack,
> using Debian Forky GCC 16.2 and binutils 2.47. It was not a vanilla
> upstream kernel or an identical-toolchain comparison to the older GCC 14
> release image. Artifact checksums, exact source/provenance, config checks=
,
> t2gmux/t2smc builds and imported-symbol CRC checks passed. A generic
> KVM/OVMF boot also passed; the hardware observations above come from the
> two physical systems, not KVM.
>
> The T2 team reports that [106b:1802] identifies the SEP across T2 models,
> but this report covers only these two MacBookPro16,1 machines. I have not
> tested other T2 models, power-off/cold-start, suspend/resume, reset, kexe=
c
> or deliberate AER error injection. Physical confirmation of the rendered
> GUI is not included in this report; desktop service state was checked
> remotely. The existing release/rescue boot files were preserved.
>
> The patch (enclosed) leaves other ANFE handling enabled and is idempotent=
 across
> repeated fixup/AER initialization. Please review it as a targeted workaro=
und
> for the MacBookPro16,1 regression, with the testing limits above.
> I also have a zip file with all logs/evidence if needed.
>
> Thanks,
> Jason



--=20
Jason Perlow | Argonaut Media Communications

Voice/Text  (954) 242-3484 | jperlow@gmail.com | Blog: techbroiler.net
Read my Tech and Food Industry articles: https://linktr.ee/jperlow
Bluesky: https://bsky.app/profile/jperlow.bsky.social

Need to schedule a meeting with me? https://bit.ly/3y8P3Gp
