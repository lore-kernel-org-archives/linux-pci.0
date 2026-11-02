Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628735;
	b=VYwuW3OIsuLAnrczyOAJGvljvCk4wIkkf0h20eFisUJvB1pb5vtLmriN2/PcZb9a7Amv
	 vY2kCm/lWkbDsIGwwxhHVZnWwM7q9n7edPz3f3fOAGYmPxDCWFVlSmhfDuf6neTZjaiLJ
	 V5zUofaSxjz4WDRM8q+rlmwTsuv8ah4Mi4GQt30wuuZyYisUnpT2mrqgUSB9phonjuleD
	 cUH+TTHLs2Zt2x0o6ZgfPl5Ffo67WDGS5m6Y8adzOHRAT4gXvkQYFcjL4KO8sIjxcSwp/
	 4BAdDNyWYxL99v9drT6+L/tsvXClaSxgJPeTDKdGNIbbvudM8ufB4xc1+wt+NAKx6FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628735;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vtS+ahUD6/AMbO8dbmSrvXk0SZVNl3wA2+s8nuaM9cI=;
	b=duM8AjWOK2lYyK3VRnNFSQuxQ15LPi18tkdjrIta1txlondicvP4ED0JRBJRPisoKdJJ
	 LkIH4wwkR+7e9NsM4AQhnOhXakrTuaqKdJ9Arh+IR1W1KjOV5G6yMma+cGCL4XrThQaVD
	 URvsJ/oEvFKmcgEQx1KBGVsp6hAi5Vj1zwsaKASNwkE1cM5PRat3zgH3TrAVQT8iDuVfW
	 9Tk1yXX11m6IOupc/TecqP62ERVGfGzln6OogrX8bqfGhKt2ML2L/A9szH6DL5c+IOmST
	 xPdqpq3kOp/G59dhYnlbTUpAuVeu8fatQpirRiiVzvOEmJ7NTein8upX+WWlABa2gVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=os0Hj4Ug;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CDB606A332
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=os0Hj4Ug
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0131F00A1E
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 14:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793628735;
	bh=vtS+ahUD6/AMbO8dbmSrvXk0SZVNl3wA2+s8nuaM9cI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=os0Hj4UgpsiOSs6L4/4zhswoyy8R/fLoo0afC6lvSEJMaZ3Ig0pdSZS19dpynNfyJ
	 sOFVf9bd5JSaz05iYdEyRngdsK0y+OL3+4HLbAjscI/nKZTdcarHO3ZNzjtv6UaL5b
	 rJk98wpAC3KiDvxKg1CO6zAP792zAIvOV8ILT8RZUVOQBnrfzqyzpQH4Wbapfcw5Fh
	 dvvWc6hiUNTwcxp615/MD3tO93O22N1ruDmf2xAPKXyPqli+TmyHKj6WTk9R96w1u3
	 fCwqArObELc/h2LbrBTxxdu4qGQEUt6tMzANKBW55wK7a1cJEOxkZvvYojoEMUoZIe
	 m6ul+S/Nas3tw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5bcb0f245e0so2871286e87.3
        for <linux-pci@vger.kernel.org>; Mon, 02 Nov 2026 06:12:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzaCR6xGWMYQ4yr2apNxg5CLlXNvt7xTDg4VoeTSTKoedSGRL2HIGDTFeRU6EFVoKevxaRHppddNFE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QsYN9OgEpMSG6liCS3Vfn7mgbFgW+2geXA0aZSVcGmzT0JYbf
	9LrNlgicdgaL14RE5+54KnYhmascp1FECgto+UhxYIW1/etOGJQ2pg3gLcJUdYBI1Yi+ut8u02k
	vjh8yVpdTpGYWEiUMKNphmC6gqJbj5SU=
X-Received: by 2002:a05:6512:a96:b0:5bc:d39d:b451 with SMTP id
 2adb3069b0e04-5bfd9520645mr3437142e87.9.1793628733573; Mon, 02 Nov 2026
 06:12:13 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-superm1-kbz-222179-v1-0-c91a664ba251@kernel.org> <20261102-superm1-kbz-222179-v1-2-c91a664ba251@kernel.org>
In-Reply-To: <20261102-superm1-kbz-222179-v1-2-c91a664ba251@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 2 Nov 2026 15:12:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ikk6T2=5ii5EGkaMrNeWsmvw_uUjzLHvF3KCcx5QuWbg@mail.gmail.com>
X-Gm-Features: AclHuK_y616LHZNNpN9vVI5OLDXWvIO35XjrED62YW0L-9gXoIlJ6613pW3AJ6w
Message-ID: <CAJZ5v0ikk6T2=5ii5EGkaMrNeWsmvw_uUjzLHvF3KCcx5QuWbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI/PM: Avoid D3cold for HP Spectre x360 Convertible
 15-ch0xx PCIe Ports
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org, linux-pm@vger.kerenl.org, 
	linux-kernel@vger.kernel.org, Tony Murray <murraytony@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 2:57=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> HP Spectre x360 Convertible 15-ch0xx is an Intel Kaby Lake-G system that
> contains an AMD Polaris Radeon dGPU.
> Attempting to use the dGPU fails with the following sequence:
>
> ```
>   amdgpu 0000:01:00.0: not ready 1023ms after resume; waiting
>   amdgpu 0000:01:00.0: not ready 2047ms after resume; waiting
>   amdgpu 0000:01:00.0: not ready 4095ms after resume; waiting
>   amdgpu 0000:01:00.0: not ready 8191ms after resume; waiting
>   amdgpu 0000:01:00.0: not ready 16383ms after resume; waiting
>   amdgpu 0000:01:00.0: not ready 32767ms after resume; waiting
>   amdgpu 0000:01:00.0: not ready 65535ms after resume; giving up
>   amdgpu 0000:01:00.0: Unable to change power state from D3cold to D0, de=
vice inaccessible
>   [drm:atom_op_jump [amdgpu]] *ERROR* atombios stuck in loop for more tha=
n 20secs aborting
> ```
>
> The issue is that the Root Port the dGPU is connected to can't handle the
> transition from D3cold to D0 so the dGPU can't properly exit runtime PM.
>
> The existing logic in pci_bridge_d3_possible() checks for systems that ar=
e
> newer than 2015 to decide that D3 is safe, but this system appears not to
> work properly.
>
> Add the system to bridge_d3_blacklist to prevent D3cold from being used.
>
> Reported-and-tested-by: Tony Murray <murraytony@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3389
> Signed-off-by: Mario Limonciello <superm1@kernel.org>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/pci/pci.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 17ec7f065682d..151b98757ba57 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3039,6 +3039,24 @@ static const struct dmi_system_id bridge_d3_blackl=
ist[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "314D"),
>                 },
>         },
> +       {
> +               /*
> +                * Changing power state of root port dGPU is connected fa=
ils
> +                * https://gitlab.freedesktop.org/drm/amd/-/issues/3229
> +                */
> +               .ident =3D "HP Spectre x360 Convertible 15-ch0xx",
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "83BB"),
> +               },
> +       },
> +       {
> +               .ident =3D "HP ZBook 15 G4",
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "HP ZBook 15 G4"),
> +               },
> +       },
>  #endif
>         { }
>  };
>
> --
> 2.53.0
>
