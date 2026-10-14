Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A93568FAB
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792002480; cv=none; b=NnMKppAR5QV4UH1y/DktpEspRZj34ggCPqyLmKuJj2mDMfZJW0kJ2n40+4oojWBHp8/0UcstbJBdynUysa2YNfM3G7DGsTlcAssHs8POUAIF9VIPNN7D5wEABOJ/deh1gn+yc7fWE2VFYlPLjpAXn+0xjGULQfWlbkneoXTV6yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792002480; c=relaxed/simple;
	bh=nAroKvIACtGOnopAxFWfh9fbac/LyBnxMxfOk2f9qtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbEwCIgBx+fr+zyU2zskjT+dXsIeoXw6sOFjNcqLUrDHueksNX6WG/JXaqgbhN7LQ5E9T2iSMOUaUiXMmFiKqyFCcEEsPn2qf1UvfojVfJqKydy4rLZ8HKWdt+ViUAXDCOS+OY0mub9AftHUkTDuJr+r/rdL/zjBW3KeJ9VMgbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlLNBEfw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlLNBEfw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D901F000CB
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 18:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792002477;
	bh=YSe10uDOb6rtPjA4PiXDX2T2zkuaMNvu+zSLR+jhY4A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UlLNBEfwG9nPSdPav/0OWYsj892BH3DzagMvnhzHAvFKHfvdhp9uHpW6Y5E+wSfQG
	 U/cXbHqxFXuAOJjPdEoVQzfGfkA5nKE8GWfLMi+7uS8SAmuSN7O+0avixeYniG5Z5V
	 v9T1xKzkqRM+jbwFcLe9LCMSeWS2/oDM7jKx/uTbDfEb/g9Tt8p74ODrNOMLEHt8cn
	 Dupp6nU/XWMUcjMQurFsV72CqtIZXyCfnkNzWRDA8ErJeLknOxLFGdaCoqTh+vAq5S
	 4fIpHs7NP4HQTw/pICBWiXx++LybeOy9Hcgu+/eKey0Vq9zkvjIo0erXjqmCc1qLdS
	 TBgOi3uZ/8nTw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5bccb867d6fso3591167e87.0
        for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 11:27:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByUHVr9PkAjIvhPjadi9fPF6evChKzh1duN6sg7GSJJLeGA1cxWkN93vsUj1p7JW7TSlcP6TLPWbmE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSgdPluBQh1sBYggRT1ScWvUS5W77nDnKA5z+XqYAOgpUAlFo3
	baySLlNBQ7y4YxPUN7YXQD5ZRQDc9TosI9T/5xD7gNY961hJ2HHetBTzUFRGgbGffLp55t0MyUg
	A3ZgiDLRUBfslKFEkEHRLjxOSvE6d9wM=
X-Received: by 2002:a05:6512:1290:b0:5ba:3c46:bc4e with SMTP id
 2adb3069b0e04-5bcde8c1f26mr6311591e87.47.1792002476317; Wed, 14 Oct 2026
 11:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013074245.4327-1-krittikunwongnin@gmail.com>
In-Reply-To: <20261013074245.4327-1-krittikunwongnin@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 14 Oct 2026 20:25:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hdtMx2QGadPQdcn28=YR=ApNWttTU5tCPoRYmweZbWmA@mail.gmail.com>
X-Gm-Features: AclHuK8OY2yNweAZuBpywP457DFYTBO-ran8UrM_Hy3vYE7dmh3IxJuLlz6yQ9E
Message-ID: <CAJZ5v0hdtMx2QGadPQdcn28=YR=ApNWttTU5tCPoRYmweZbWmA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Add Acer Aspire A515-53G to dmi_leave_unused_power_resources_on
To: Krittikun Wongnin <krittikunwongnin@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 9:43=E2=80=AFAM Krittikun Wongnin
<krittikunwongnin@gmail.com> wrote:
>
> On the Acer Aspire A515-53G (Whiskey Lake + NVIDIA GeForce MX230), the
> dGPU behind root port RP05 (00:1c.4) falls off the bus during boot and
> is unusable until the next power cycle:
>
>   nvidia 0000:02:00.0: Unable to change power state from D3cold to D0, de=
vice inaccessible
>   NVRM: The NVIDIA GPU 0000:02:00.0 ... has fallen off the bus
>
> The firmware ships two SSDTs which both provide power management for
> the dGPU:
>
>  - One SSDT defines \_SB.PCI0.RP05.PC01 together with
>    RP05._PR0/_PR2/_PR3 =3D { PC01 }.
>
>  - A second SSDT defines \_SB.PCI0.RP05.PCRP (_STA initially One,
>    _OFF calls \_SB.PCI0.HGOF, which puts the link into L2/L3 and drops
>    the dGPU power enable GPIO) and its own RP05._PR0/_PR2/_PR3/_S0W.
>    The latter fail to load:
>
>      ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.RP05=
._PR0], AE_ALREADY_EXISTS
>
> As a result PCRP is not referenced by any device and
> acpi_turn_off_unused_power_resources() turns it off right after the
> ACPI namespace scan. This cuts power to the dGPU, but PC01 still
> believes it is on, so its _ON method is a no-op when the PCI core later
> tries to bring the GPU back to D0.
>
> Windows does not turn off unused power resources, so the dGPU works
> there.
>
> Add the machine to dmi_leave_unused_power_resources_on, like the
> THUNDEROBOT ZERO which has a similar SSDT bug. With this change the
> dGPU stays on the bus and the nvidia driver binds. Runtime PM of the
> dGPU is unaffected, as it is handled through PC01: with no driver
> bound and power/control set to auto, RP05 reaches D3cold and the GPU
> comes back to D0 on resume.
>
> Link: https://lore.kernel.org/r/CADS-TgDQ1G8vrTQLJeQ3RTBVFTyMe0C+5p2=3DUB=
KS=3DEFCDFuaxw@mail.gmail.com/
> Signed-off-by: Krittikun Wongnin <krittikunwongnin@gmail.com>
> ---
>  drivers/acpi/power.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 23a4e207a..cf36dee56 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -1121,6 +1121,19 @@ static const struct dmi_system_id dmi_leave_unused=
_power_resources_on[] =3D {
>                 }
>
>         },
> +       {
> +               /*
> +                * Acer Aspire A515-53G: Two SSDTs both define power reso=
urces
> +                * for the dGPU root port RP05 ('PC01' and 'PCRP'). Only =
PC01 ends
> +                * up in RP05's _PR0/_PR3, so 'PCRP' is shut down on
> +                * initialization, cutting power to the NVIDIA dGPU behin=
d the
> +                * back of 'PC01' and making the dGPU unavailable.
> +                */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A515-53G"),
> +               },
> +       },
>         {}
>  };
>
> --

Applied as 7.4 material, thanks!
