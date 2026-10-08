Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1E44B4864
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791472789; cv=pass; b=tQhdFfA8JlfrSju/O1G/sBO+kUcdnUWxEvgRawIVp9PUHXEM5Z1G8IiOIZSicNv5FvTwhlcgOkXV/xUG0Hs3RlUEUjylmqp9EyO5bbRNZH6/lWrzWFOoRRRvKXGszpwRv8avrkNIfZhbw3H4DQZLlaESUaiziXiqUUkejMoRnxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791472789; c=relaxed/simple;
	bh=ztcG0kPL6O4kjt/PCXEoRW6KYzq3S3ux0BJDUx9xpug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFAYf2ei+AVQ76cXepU+DHReTX5nJiwyJKp+8lEHAR3YTzszqNWhgo7ElKHUO/6PedG6jGesxZU/BQaTlcmlFlziq++PX70bp3Z53JBLCDwoFfbTe3YkOBb+0nFltt5ICyV2a5ClMDAaWOWMEnTSgR68TZ83VuR+7qLtz6cHpDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nx6ZRbqd; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nx6ZRbqd"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-150b2fbd784so56922c88.0
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2026 08:19:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791472774; cv=none;
        d=google.com; s=arc-20260327;
        b=eyJYYVeKcCNLKM26d4uJHiEhvTstM2cK8Lnz5iZlmTJR2dsny8nTw6tWUqB0zIp6Eb
         us7ueL8tlgXTi/QDh7RuYIgBa9mhnmmCiKqROPONDgcMrK4VF15GWcdTCxMe3Tyo3/hE
         7dlSqzXYGzQl873r3ft5sCQ4M1640ytM+MxXigcQxav1C5TpuzO5lOkCOFsHCBTO86Xa
         jKZr8rmAvBO7eI29kTwT4TtcZxczi6rempYeeZlf7/3DFACCGZolKIHLX7L6xzH/+8YN
         0vVGvM5DQ3Jx/dQcfA8XVYv/zk964hAXXrb3QamSrHhzU+kyx8HZbr1rIfi15U8FGQKe
         5ToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=npfelcdpyTnvOtpnktEjaeVdPI171st1+yAn0CtmD5k=;
        fh=C3ag4zmXC33uFoujLDRQH/bFYOZs5gkO3ad9Jha59YY=;
        b=RjSjWqmnf8mU/EcFtr9ybnW03Z11pGc3FMUV1Jf/PB80t0r1TPPYZEDD5+GSMUCkhI
         1KQS7bTCNS552eP/zr8ZipSFjxlsUsVIppIg5M2r4l4bGtoDV17cFnacjPzNZTXyjNxH
         aTAX4EjQaldjIGC4arY5w8GOvEusKad38aU5cf4lhTBweUte53DKVMv1kjMzXa7ke+a1
         aQKnAaM0A5GHf/k+kk29h7x3wHOiCUtIQlcUHpVKshsFeY72kc2tqPS19fFE1JTyuL0y
         oYflN39lP6ein3Q4IMmf1XqGiuLPRcnoX1oKjj4WKSwlr/yViz40nTndlIMOY/PqdxzU
         ZkfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791472774; x=1792077574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=npfelcdpyTnvOtpnktEjaeVdPI171st1+yAn0CtmD5k=;
        b=nx6ZRbqdCGHSU31wABvd1GQfIjbPwIcscL0M/N0Wzs31mNKojQfo5MbAZzp6AzIp0k
         UHjfaFdf2y1Z/uZqNJM4N9hWZVStRuDxSz8S9ElYIFSq3rwC+Tyy+vHZLpMjt9uIvgKG
         MaZQHANnzkOLB2dgaIE9uvlbW+smFz42PLMDU+GK8r8RFkQFMUacrMUfHyoWMhLU5Awa
         67fi7HQ/Zcd52w9NPg5goYpmIvSArnoHicHVz64DWa4eUKB8FBGeAPHAp6m3LO0jgh4k
         ic/VjhRk2snpqsxiOMPnogYGYCL/P8M9hd86gzBtO7U1yNV0oTiQxG9dPPpm9g2GSr16
         m0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791472774; x=1792077574;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=npfelcdpyTnvOtpnktEjaeVdPI171st1+yAn0CtmD5k=;
        b=lCKZFOLw2/psYkINBzIIibv/WPCzJj94KSMCiixOtJDLuODhLdpbKce4Mz1zbqdB58
         YoqzSFBVu5m6ary1jXD8G+2llh0devy3ehEyEiSvW9rdxAFdNFRvJb8AofKVnEVKymje
         93VBvFAjci6dPcfUe4AB2wMcgJGNTL+BmCj67CQ/3szOsvGUwb2cfw2assOPQRbfQl2v
         Eh0XgbRjZom/otM0tRKjbYbemDxOFQDN17mDSHBIA71iaH7EPD5s9FWC1ykl8TMuZLbI
         oVCzU63oxivhh7hlKyjmgGkOmI2Mu2tRikF230pAdQPRW7PDHwGPTaQfIxp53HPa92kO
         jGAw==
X-Forwarded-Encrypted: i=1; AKwUvBzC2D+dBl5z/jTTSBtsvXfy5l6wTvXeLF+qGLCe3Figwo8t0rVvo02lcy54PI5uECdEUuDv4+9PH4g=@vger.kernel.org
X-Gm-Message-State: AFuF++k0oxXs+x1sWdb/qvDPmVv9wQvoUwb8m/JbvTm1eBA0Qs8rg65s
	XosJQ7TPIIVruw8+r+dPfOlulXrutZJx1/3KI026cizwqci3uA344+n2eupWbvIyvgViuCxfBFw
	wQdXsRFgHs6g3UJT91B9dIDKbpaizD/M=
X-Gm-Gg: AYBFou20v/ZTLWuopwXIhIgmFhKRV9V7rZxYppNH8wVaRVt/BtMPVivyh3rs4RL/mvP
	knAcxBAYaRmuihsXnMbMhKMQaPrcT4q5UDjoryk2MstAevWmD2t+mUg0Y6GQaKIbdqOkROxVJp6
	2fL8ux1v9c4NdQR5cvF4xHZLuPzayKP3Z7sXBfHlnqj1qrnkwbgHqiOBYOdEuX3gl0nW5WQj5mA
	i3SpKXDnp72pivUT72OGkS+hTHUtHP2yws00JQrLRS8oqGS2lb6D8hFOvDcMCIej2myoto2JvL7
	wcAy9buP3vZODPqY6bIU1MgsC8360ZQhRxjHvr5BvszCwI19wHRvqJcU4GjOM30JTJK0ITlpkf+
	af2kuLYrzcwBfH3rHeKR9daiQpF7DyZdLKuSxUnIC8A==
X-Received: by 2002:a05:7022:1505:b0:12d:c389:ae54 with SMTP id
 a92af1059eb24-1658abf47cfmr6616040c88.2.1791472774454; Thu, 08 Oct 2026
 08:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0552ed277e40a288e0157af799257ee6ec722534.1791460615.git.lukas@wunner.de>
In-Reply-To: <0552ed277e40a288e0157af799257ee6ec722534.1791460615.git.lukas@wunner.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Oct 2026 11:19:22 -0400
X-Gm-Features: AclHuK8eqqZZwcxfnGYDRIjGfmIuea5RApPlIzK4ZWhRJY1bOeK92MqHIl3h3To
Message-ID: <CADnq5_PVD6G_VMepJ3mAz=60vM1PHtun51Kccxyz9sdBsx_7wA@mail.gmail.com>
Subject: Re: [PATCH for-linus] PCI/AER: Skip error recovery on false alarms
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	Christian Koenig <christian.koenig@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, 
	amd-gfx@lists.freedesktop.org, Aditya Garg <aditya.garg@linux.dev>, 
	Jason Perlow <jperlow@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 8:26=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrote=
:
>
> Alex is seeing a probe failure of the amdgpu driver after the Root Port
> above an AMD Navi10 GPU has been reset.  The reset was performed to
> recover from a Firmware First reported Fatal Error.
>
> However all status registers in the Root Port's AER Extended Capability
> are blank, so apparently the platform firmware raised a false alarm.
>
> The issue is only occurring since commit eddba19b8b5f ("PCI/AER: Support
> Advisory Non-Fatal Errors").  It looks like enabling Advisory Non-Fatal
> Errors causes code paths to be exercised in platform firmware which
> were never validated before.
>
> Skip error recovery on false alarms, i.e. if no unmasked errors were
> actually signaled.
>
> Note that this will also skip recovery if both the Status and Mask
> registers are "all ones", as would be the case for inaccessible devices.
> However that seems justified because it would imply either a hot-unplug
> event or a Surprise Down Error further up in the hierarchy.  Interfering
> with recovery from that seems uncalled for.
>
> Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> Reported-by: Alex Deucher <alexander.deucher@amd.com>
> Tested-by: Alex Deucher <alexander.deucher@amd.com>

FWIW, I only tested this patch in conjunction with the other two
patches you had posted on the ticket.  I haven't tried just this patch
alone.

Alex

> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222095
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  When applied to pci/for-linus, this will cause a conflict during the
>  merge window with a commit queued on pci/aer, d4c842c3af5b ("PCI/AER:
>  Fix memory leak in aer_recover_work_func() when pci_dev is missing").
>
>  To resolve the conflict, change "if (pdev)" to "if (pdev && err)"
>  and move the pci_dev_put() out of the if-clause (so that it gets
>  called if pdev !=3D NULL but err =3D=3D 0).
>
>  If this is all too complicated and/or late, I can respin on top of
>  pci/aer or v7.4-rc1.
>
>  drivers/pci/pcie/aer.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d8dcd238fda1..922a726a52a5 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1360,8 +1360,10 @@ static DEFINE_KFIFO(aer_recover_ring, struct aer_r=
ecover_entry,
>
>  static void aer_recover_work_func(struct work_struct *work)
>  {
> +       struct aer_capability_regs *regs;
>         struct aer_recover_entry entry;
>         struct pci_dev *pdev;
> +       u32 err;
>
>         while (kfifo_get(&aer_recover_ring, &entry)) {
>                 pdev =3D pci_get_domain_bus_and_slot(entry.domain, entry.=
bus,
> @@ -1375,6 +1377,12 @@ static void aer_recover_work_func(struct work_stru=
ct *work)
>                 }
>                 pci_print_aer(pdev, entry.severity, entry.regs);
>
> +               regs =3D entry.regs;
> +               if (entry.severity =3D=3D AER_CORRECTABLE)
> +                       err =3D regs->cor_status & ~regs->cor_mask;
> +               else
> +                       err =3D regs->uncor_status & ~regs->uncor_mask;
> +
>                 /*
>                  * Memory for aer_capability_regs(entry.regs) is being
>                  * allocated from the ghes_estatus_pool to protect it fro=
m
> @@ -1385,12 +1393,14 @@ static void aer_recover_work_func(struct work_str=
uct *work)
>                 ghes_estatus_pool_region_free((unsigned long)entry.regs,
>                                             sizeof(struct aer_capability_=
regs));
>
> -               if (entry.severity =3D=3D AER_NONFATAL)
> -                       pcie_do_recovery(pdev, pci_channel_io_normal,
> -                                        aer_root_reset);
> -               else if (entry.severity =3D=3D AER_FATAL)
> -                       pcie_do_recovery(pdev, pci_channel_io_frozen,
> -                                        aer_root_reset);
> +               if (err) {
> +                       if (entry.severity =3D=3D AER_NONFATAL)
> +                               pcie_do_recovery(pdev, pci_channel_io_nor=
mal,
> +                                                aer_root_reset);
> +                       else if (entry.severity =3D=3D AER_FATAL)
> +                               pcie_do_recovery(pdev, pci_channel_io_fro=
zen,
> +                                                aer_root_reset);
> +               }
>                 pci_dev_put(pdev);
>         }
>  }
> --
> 2.53.0
>
