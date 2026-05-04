Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B6835A3AD
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904169; cv=pass; b=K1X5v7WQRNjLo2kWyp98/EIBSYIppQmyHICkHfGJMtLOlBDJ+gqPoAsXnhMMXI7DEKeA7QwgppOVcLQmStognah4A7xtrQzymzP/UqA1GZcwiFttXM9gJY+oVrFNZO6EI5VOdUfBF6COok21WLRDniAqj6LWrqm26rkDn6v7jkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904169; c=relaxed/simple;
	bh=VOn49HlNRay1uKQzA9gv8X3gxIOUwSLBeqqmLJ+Vnq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQZiPtVb+iXuUnCKISmg0NtAONPKAbUPOvp99SejYHF6yeVgAZTdLDSYmkRaeo+xZyTmERtTfu7Ed2l8v51JpuAbrmUZywL9kcMS3ECdurCQsbBWerjoNRKkn1EPjEI4uHaFID4BwPh5yXme/VILWKa1IJ0vgjehzs9nZbs01/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6H/8jn2; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6H/8jn2"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65c396d3b36so2240301d50.0
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2026 07:16:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777904167; cv=none;
        d=google.com; s=arc-20240605;
        b=LoYfx9oZVgx6ZiA4P88OVkJ3x25l9y9KiT2YE/dkyvPuUk3L/L8/xrGrbYogANwm/7
         STmWQqtZ3dMp6LWwOL5FV2YQLZktjXmnuMvuIP+AE9CWm534uWNNVSldF+4R/ipIYjoQ
         F808syVc9SidNQVBDt5yN4RxpTXJapfIiJRprm1M54GOoG0SeB/xdIShs/JkzY0GJtyB
         J9wBI/z74MsZ1kyeGcKd7RIeNhGjjt6G04MHqg46wlGp9c2mn/ujy6FI0FMnZQzN4yKW
         51evvWqa/sZ+8zQkuaN0KOpXyQu3dPM3gO5nPWZXxeLu9q80A0SIgpN9pJptYy8fsQx/
         9WWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KJYvNhQ3mzD7bXhkgriTfy1RxP23dOYPeDTU/pUBZ1I=;
        fh=xUXHU8/H0kyzStj44o5yP31q7h6DyanVUUqDHY8Pcms=;
        b=Ucj7bTjRmls7UqkXgm7G1CtAH7Klx7LVHciNBvNe+Ys0xGgxj5HQt8VMQWyXlU59gn
         koC3b+EBNepofzjwR4+MQ6DpVcoSMGdNW1WCri7YyuSFSLJuj6+bmcySlyL4+6cFijmg
         AqEo4eikxxOU4N/zorb6WbmrwEnh/QvlwxqubvG6olDxuJvqF0rJ68tqmIgfhdkrz3Am
         945ZBM464+ftkwV+XVCSObnCnSUo6sSfgdJtVBJxCW/jXwTY5eRQtfmLXQerSaeDV4BY
         iL8N4M7cmC69uv0ouZUANWzjnv0qx2X/u568vAn+Hx/mwJjzRR4X6/lrVA7Mz/tyVfk6
         Y48Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777904167; x=1778508967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJYvNhQ3mzD7bXhkgriTfy1RxP23dOYPeDTU/pUBZ1I=;
        b=p6H/8jn2uNhEs2uENPb4RwTeH3NQkKU9CoZkey3WlD1mF0EiCUPfPrnLXbdZ4++/Rb
         Zbw/h5veLwFcqG2DGH7Sli9HDrm//q2oW3Id3yYR2RnvEIEfgjtLRodgVjm7uD4suNVj
         b80gPzPHjLTOci+4wfDFS5nMnBaFAyxffDS0yEjowYcxHvlcD2Kzcbc+j3g++b30esdi
         nE6WlrZp6LSJXDmZEodWroJXHv3MDo3mAaLTFIWUhKsx3PM/2+yTYOBSuUTsWFO0My8J
         MCq8gz78T0W0OMrwq7rRoD1T3qXJ1g7PPlc2f5eyA3aBZELlHUZXUi4wyM5j1EnaU80w
         ShuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777904167; x=1778508967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KJYvNhQ3mzD7bXhkgriTfy1RxP23dOYPeDTU/pUBZ1I=;
        b=E81cyL/EbFADHEpOjCkjjSiPR13Ec+Mn4IVg6p+qY3LImmsOGXl3GH1rqaZdnvUDU9
         wXx47diUIPtZjXnWslar/fP85JQAMn7VpzTBzyxRemC4P1Gaebq2tANfr86M32U8ttpL
         mUKUYI6TmYWtg7VBzW8DIq1ADMxCNKth5PLet7Htr5mE6xqTHio0jDNX6Wb6TDP6PJZM
         bbqboaG1gfCU3b2bISJTRw14GMHv9JDVQfwXwL1gKrfhVi9IiZZw9nPMd1tEIZ8extRH
         7Ph8/TAIn+aHrP5lAqVplPzDRKJPBExPHh4/tL8wLUzkV7QpcpS2IEa+XgiTHda1kqna
         7C4A==
X-Forwarded-Encrypted: i=1; AFNElJ81NsnbY5NHM+cV+z4jFdeRsSkRy+hG6CksgK9QaVQprEIKP0M3Hx8gfypvz8g6RaNkVYiQFssNfdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfxO/yhkTvweP37JTBLRoWSkkdlozadn2xyepyIoXP8C6ASkxg
	Ju2AyC/GPEfMi2bvBvhp9PI+vW//2+H94hSqaIMxAamCZZIFb+n/02vomZVPlpj2vqtOuy63FBy
	GTKJZOCiNPAHL0qXVn5opUY5UyDCMeIE=
X-Gm-Gg: AeBDietb2fQIUaOHekIecmeQjlPAfEypVRqLA7fxwdWgOEM+biMclqmZWveZFwU6q+H
	SR16OkzuFhZsOk8r6qTqbge6YsGihVqs5VldHyf/56yFCzmK6h7H146SVwq1AcA7jOaOKNuJZgV
	MRd6F0FVyosNpjPDjGpLSi0juX+LLZyjKRP3/LdL+urADon2t9nWdafRlWkfcWkAB9CV6Zi1b9Z
	fiYhNrM7sKQLq+E8/GsqVxJZKqkPyljJiyE3xYQ51pKaWTe2i/XxTaCrw/m86GMFad+R0KAtXQX
	vF5VqS0ufPCCvcISFV4=
X-Received: by 2002:a05:690e:1186:b0:65c:6452:1ccf with SMTP id
 956f58d0204a3-65c64522530mr786151d50.8.1777904166584; Mon, 04 May 2026
 07:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dd4dc11e-338a-4d13-9830-095a93187f4c@oss.qualcomm.com>
 <20260504041407.289464-1-threeway@gmail.com> <ffd59407-c65c-4f99-a587-3b968f9c82c5@oss.qualcomm.com>
In-Reply-To: <ffd59407-c65c-4f99-a587-3b968f9c82c5@oss.qualcomm.com>
From: Steev Klimaszewski <threeway@gmail.com>
Date: Mon, 4 May 2026 09:16:00 -0500
X-Gm-Features: AVHnY4JCkZFUA50J5VjxRP-M3UPWI_XzDvfu0OdsGPxK7C4Ok0bBFRM_vOJe338
Message-ID: <CAOvMTZgpYg-UFuQE01NsECTPf3UEHDifnCLYu7iEqOUnvzs0Ag@mail.gmail.com>
Subject: Re: PCI: qcom: Add D3cold support
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: bhelgaas@google.com, bjorn.andersson@oss.qualcomm.com, 
	jingoohan1@gmail.com, jonathanh@nvidia.com, kwilczynski@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krishna,

On Mon, May 4, 2026 at 2:06=E2=80=AFAM Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:
>
>
>
> On 5/4/2026 9:44 AM, Steev Klimaszewski wrote:
> > On Sun, May 3, 2026 at 10:37=E2=80=AFPM Krishna Chaitanya Chundru <kris=
hna.chundru@oss.qualcomm.com> wrote:
> >>> v4 of this patchset *boots* along with Mani's patchset, however, v5 d=
oes not,
> >>> and unfortunately, the machine does not seem to get to a point where =
I can even
> >>> get logs from it.  Do you know what I might be missing?  I have *not*=
 attempted
> >>> to remove the nvme drive and boot off USB to test it.
> >> This series, will not have any impact on the boot, this series comes i=
n to the
> >> picture only in case
> >> of suspend and resume. can you share your platform details and kernel =
you are
> >> booting with.
> > Oddly, it seems to, because if I simply go back to v4, the system boots=
.  I'm
> > using a 7.0 kernel on the Thinkpad X13s (SC8280XP).  The sources are at
> > https://github.com/steev/linux/tree/lenovo-x13s-linux-7.0.y (with the v=
5
> > applied).  PCIE_QCOM is built-in to the kernel.  Not sure what other in=
formation
> > is needed.
> Hi Steev,
>
> I made mistake in re basing the code, can you try below and see if that f=
ixes
> your issue.
> I will send this in next patch series.
>
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1327,7 +1327,7 @@ static enum dw_pcie_ltssm qcom_pcie_get_ltssm(struc=
t
> dw_pcie *pci)
>         struct qcom_pcie *pcie =3D to_qcom_pcie(pci);
>         u32 val;
>
> -       if (pcie->cfg->ops->ltssm_enable)
> +       if (pcie->cfg->ops->get_ltssm)
>                 return pcie->cfg->ops->get_ltssm(pcie);
>
> - Krishna Chaitanya.
> >> - Krishna Chaitanya.
> >>> -- steev


Indeed, that fixes it, thank you!

-- steev
