Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6CB2FFFA4
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290752; cv=pass; b=lYMBE+KuX1q5tPsm91uPYVA3SdwvbhJbI/qgbkvAWjxwqbkJL8TRyZ7eW6cgLFbdZiheU5dCawvPR8m7xomMzLbdmjQFdVMWnUO8feym6icY3mez+H5AU0jYDzI8QVJaBMFXE4UgTNs07okCNb0etBulj8vKY2oVdIH5WQSam+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290752; c=relaxed/simple;
	bh=/SYLM8z0d7369E+qEuLTDVRQCcOKLvZy8qSOLW6me7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BucjpgAtKGa+X/HxSljVQwzSavbrSdc1T+OaFEf+h9R6w7C3jxHWCt8tluOMYF8TFBU8D2NNxjFa4z9xlZADz30kceLVD334wG+pWBX9ZgMa6kv6emH3Ugmp5Zq8jvyqOeeQ2FAl7KbuBUGE8MRypeTMXBdx+sbj7B1/qIInriw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=WqWP7g+6; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="WqWP7g+6"
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1418C3F618
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 08:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1782290747;
	bh=LszxVVF7zIFzpDkaPzoZ9nnXKOUlv99v9ukFI8N7+BY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=WqWP7g+6hEyPGmecAjQrHW6xHL19ZBVz6VcnAUORzB5I5vp80Z/cEJ7aE/7L0tJVV
	 EjOJoN0FONTMtr/oTUw2+XHw2j/B2iyucPD9oCFnCjPDjU8c9LMCW7u/zciqToFHvF
	 D2Eu555Gd8TC31Q0aCgOb8u11ee47T+K0fTbdyYMORcF5PtvCTpXV4IDxRfkTuEE3V
	 G3DWUPnkebolErSxKzgE9Z9NFZSn4G9APT5ldWFjHr4eGI4MfFGDSYEpsT0hxH+v4W
	 /WQLaXeOgKMIFY+mRYNakA+GlYsw2mXsISOieIwURnLf6QF8egK+ZL8r8rB1kvEp01
	 6EJcdhHQ3WO0HkXHIsJk5i+suQ21m2sMtsNiTReAu1NyHkYdxxBhcV4HZ178n3QwBQ
	 r13y68IoNfmQ8kqThow6w8Q3XHAcMUtezQJHoM2J+VzYOmqY5Wiu4SCFbpyrSYQEGH
	 nhOKNA1gmjdWwzPOyJRC7XsWuqa6rHpF9ullhkESzJl2pNba5z0GrdE4VV6ZQ0JxJC
	 dZQnifucPV1779mD0SkdRyCYoyPEcDxPQuQvPqtiq2lvnQ1NnjbfqnRZbK8lTc7FHO
	 xHsEZfsH2BybplsNqtwQwaWLWbTWtURGO0gX21lB93Vo0Jv9vutJjP/KrPKGyDNvDW
	 jU9GBbcL8I3XTzl4AoEU5TNs=
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-138acbc0e69so3428934c88.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 01:45:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782290745; cv=none;
        d=google.com; s=arc-20240605;
        b=dQOAqhpvdTpiJOAW8XQltGmKtEvKVtH4P0Wa7usCasL1hkJutrubALGHIGnq6qfjeV
         2mM08zMgMY9qKP6Jh4jJfSnjXRhEptaQ6Jdjsks+gbtwx8x+fi893lpmOvuN0w3y9nfe
         gkLcnoepJDmMe7m7KZcdzpg/wTPB6KcmOdFKmHTnsYInF2EkdHN6yq/MEe+l3RfDL3qr
         jUyaCDrzX98+ukt9lnWXzFHqUMKlD8F7i+3EElWPdyOFKnwGSyzkMDjZlozL8zvgBuPn
         Pp/mOY6HNjTJ342HF2MYXdkInsU4P3o2vVxKN8tHJbOaQRScpQgbCSv16I4CY9uH3BcE
         SnYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=LszxVVF7zIFzpDkaPzoZ9nnXKOUlv99v9ukFI8N7+BY=;
        fh=11jbXT7orBCf4m5HKL6L0DlTSq6+7kLidmg1VzxWqFw=;
        b=Z/rwG9ByG0l4Mnb0CnxEumv9Ry8y7GfpWLm8WGAZhy8dMfqoQ4CuYqpOwqvrNkZjQM
         XZhGJiLh3yxHwiOFt9Kzu3ALS6cQt9GMWPxaA5M20SfDLD1VuaWUXZvtB1D+nlVVb+1X
         0PkisHklBQ7BzhQWofMOvc6XwdCc7OqVkQakpZcMZY+0FTWKRL54muHXwbZaA/PhHHdf
         5vJampJjz68RaTLGqpeIZx5NfEeu2ZxZnrpHvGZl3nYrtGy0VKbWJPgbDPSnfIyT+mhf
         5qZhrJPQWH3RC3tuXqrGNBRi2Bl9f076emj0ri0WRRnahMuUEv+WJ8hM+YU7AgbrLHoJ
         tAiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782290745; x=1782895545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LszxVVF7zIFzpDkaPzoZ9nnXKOUlv99v9ukFI8N7+BY=;
        b=W8rsnVhpTmM4n9EFotsbYQluClD2ruoz4oV0pDgGs2ueoaNku9qpgBVC0JftXa/f9o
         SfCFx/07cGjdtBqd9PstSSlK6pCTb3j6IBVb5rhdUZTkqt/yOdWarsfmu6NbK+SCTRbB
         dIPSDwtAY0E6I05gCOS0S/b+WvWf8zhwJ+8cjcqkZvWd3B+hX3o54EdpTdkFziih0ecS
         SLnM2Q3GGU9fOA9qY7icmDeszaWZC9JqXk1wCGaJZ0Wm/RJSH8vvwhNQyftOvk8yRMFv
         WNnjXWqwTOPKEWnGtyil/JwE3n9vlZek8SJqtvH7sQCyg5vMzHU2Z3JXWNOydkZm3gVV
         ekHA==
X-Forwarded-Encrypted: i=1; AFNElJ811py5HiyDYPsxZ5DsijdGOdWVpc6VqU55P/wJoQEWbICABjK7I8wWRuaLXVwfUR0Nf6ZuDdBqzeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyUW4iq57Eag3tutFxD0lim8FqDtbmInwkxiARujVi4weH8WGT
	tEWSGCPs1ztgEuwc89yKsD9DoKisbaNHIXb/LYjt7adYFSsnutBkAJtbJ+DO2rIlqTDml0D842d
	7ak7sWztrVxxPOXm2/U4uxJhTEdgHGa3NnPUQOaoBQIN79nctRVen3IlhKbocumiKOl706JYTiG
	ujnTAkiP5Jdn0JHXwytCNmZTO5OPVQZJ2p7l84YrLYGR0afiLBITCd
X-Gm-Gg: AfdE7clPwVu0QRlPTl7Q3zuo0NlIMr//PWyMDotQmO8v538Op9KFhmBMhVqgObht45d
	UUFiDNXu9vscnweEmXzj+bcS+yMH3Bnt8bs5w7GhONEyX1bMaZjFjQq/rXl9vWZZhIIbV5Yvdbz
	hW+YSGqcr9JrFGgpDCndIDUjBJvbSEk20W1gOeUygWZhzlpmx2bkl5vFJwQJluyzQbo58++wjOo
	AD0FaxkwZa4YcpU37LwkTJoQoA+wv4+aqjlJqTi3bqciWJeoeIw
X-Received: by 2002:a05:7022:fa02:b0:139:78a3:7eca with SMTP id a92af1059eb24-139ad72bf89mr14040983c88.36.1782290745218;
        Wed, 24 Jun 2026 01:45:45 -0700 (PDT)
X-Received: by 2002:a05:7022:fa02:b0:139:78a3:7eca with SMTP id
 a92af1059eb24-139ad72bf89mr14040943c88.36.1782290743831; Wed, 24 Jun 2026
 01:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623141505.1816786-1-mario.limonciello@amd.com>
In-Reply-To: <20260623141505.1816786-1-mario.limonciello@amd.com>
From: Aaron Ma <aaron.ma@canonical.com>
Date: Wed, 24 Jun 2026 16:45:31 +0800
X-Gm-Features: AVVi8CfhvNlR7i35on3VAhxeE9ZqO0Yx-nAnnlDwZtrqts_8t5hzCPurpXo0GPw
Message-ID: <CAJ6xRxWBtaPZZ=SVff2WVE+B2c+fMJ6vTTracHU4BqH16ROXeA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/video: Only fall back to vga_default_device()
 without screen info
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mario,

Tested your v2 patch + Xorg MR !2242 on the hybrid system
(AMD 0x0380 + NVIDIA 0x030000, EFI framebuffer on AMD).

Result:

  AMD:    boot_display=3D1, boot_vga absent
  NVIDIA: boot_display absent, boot_vga=3D1

Xorg now picks AMD correctly. boot_display is fixed.

Tested-by: Aaron Ma <aaron.ma@canonical.com>

Aaron

On Tue, Jun 23, 2026 at 10:15=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Some multi GPU systems may have a VGA compatible device, but that might
> not be used for display.  If due to enumeration order this device is
> found before the one actually used for display then multiple devices
> may show the boot_display attribute, confusing userspace.
>
> When screen info is valid, use it exclusively to find the primary
> device so that only the device backing the framebuffer is reported.
> Only when no framebuffer has been set up does it make sense to fall
> back to the default VGA device.  This ensures at most one primary
> graphics device, preferably the one with the framebuffer.
>
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: ad90860bd10ee ("fbcon: Use screen info to find primary device")
> Reported-by: Aaron Ma <aaron.ma@canonical.com>
> Closes: https://lore.kernel.org/linux-pci/20260618081803.2790848-1-aaron.=
ma@canonical.com/#t
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>   * Fix subject
>   * Keep vga_default_device() as fallback instead of remove all
>     together
>  arch/x86/video/video-common.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.=
c
> index 152789f00fcda..8ed82fff7638e 100644
> --- a/arch/x86/video/video-common.c
> +++ b/arch/x86/video/video-common.c
> @@ -43,21 +43,26 @@ bool video_is_primary_device(struct device *dev)
>         if (!pci_is_display(pdev))
>                 return false;
>
> -       if (pdev =3D=3D vga_default_device())
> -               return true;
> -
>  #ifdef CONFIG_SCREEN_INFO
>         numres =3D screen_info_resources(si, res, ARRAY_SIZE(res));
> -       for (i =3D 0; i < numres; ++i) {
> -               if (!(res[i].flags & IORESOURCE_MEM))
> -                       continue;
> +       if (numres > 0) {
> +               for (i =3D 0; i < numres; ++i) {
> +                       if (!(res[i].flags & IORESOURCE_MEM))
> +                               continue;
> +
> +                       if (pci_find_resource(pdev, &res[i]))
> +                               return true;
> +               }
>
> -               if (pci_find_resource(pdev, &res[i]))
> -                       return true;
> +               return false;
>         }
>  #endif
>
> -       return false;
> +       /*
> +        * No framebuffer was set up by the firmware/bootloader, so fall =
back
> +        * to the default VGA device.
> +        */
> +       return pdev =3D=3D vga_default_device();
>  }
>  EXPORT_SYMBOL(video_is_primary_device);
>
> --
> 2.43.0
>
