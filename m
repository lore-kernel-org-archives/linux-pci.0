Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795119009;
	b=3HgikH6fVWXiJ5K1u79FfuV/oDTUB468QwGO5tVHMNekO5eMoHBjeSJRG5lLLIHP8EZA
	 tmdt0zGZxVisLuQ4EOiZq5tJ/BXQcFtKy0OagQ8kj+riYC0kXldWkZli1GYGHkaM9eETI
	 bbHhjadLyvIbfHCnbZSf0Tx2u1EmnZXh8/T0QlEyYnGWV/Tq8I6oH5S2RhZ01jyY4MTZz
	 p9wS9uQF0PWxHsSlR4g8YsgS81Qih1A/q/qQY4NUfSSHUNCOS7L1l176xZBnRlkbaFAVv
	 01p4Hx7Gx8LjHXcNdov/udQYxM5EQhFpNOLfFoJsgMc/KD1OupSapyrYm1UZAg0IGeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QF7Ym8HltwH/EryL+lHedJXLoRmFZy+TQyk7QyouYW0=;
	b=1Ae3F0D4IDn/CYASxTd6T+A4aHofYERemYOb4YoyS6FjemuD4skQs8kP3FWhDWldsTcz
	 PJ69XCUGleb48/kRT1dAOYI7OCYTe4RzViBMcI7pkW40nfFVWcK4KBDQKrzEe0V8k8o9Y
	 LGy2ePnQsMbgcY+WQUn6oMk6DKhisqiWZtIF4PLkb88vG+JYgWydCTOmQG/K/VvH6Isua
	 08/UN1leBIv3Nr7noW2sf/mLOeuulif3IdFERDayyTrggAxyXX5g/Bq1vOkyKDbB/+to0
	 1S4rhPyG5hEMqxz3qOXSCME2g0d/t05lYyaGrZMR4oqSpEKJ8M91KQBjFikgYByYxAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dpvNgDE+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3002606A324
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 20:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3002606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dpvNgDE+
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-83c1a9bd428so20336a34.2
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 12:10:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795119008; cv=none;
        d=google.com; s=arc-20260327;
        b=pt5lcbob6ymOzprVp9WxE8NGv2QZYIqMC6DBM8CyNeqJqsEfB+3LAnC9+McLuQbi+j
         Eul+ExZ9+CiD5F8l9zrJkISF/HE1Wy6sw1FbdMzxDjQ6C8PmgreG+M5e5BVIbfz5DB9q
         1CicoPWBhabxMBghWzZ9W7cDHmGnW69B9yRCRMqH96UXIyTSjuvgetXgg5xNdtqsaHyx
         rZAQhNqajOyzcU5KKBFsadhbckOfQyfEWXjJfSIWGa772rR326GT6bzrBv1v6PbCE1A0
         y2dKrFoySSzWKc5YoWGHYMT2quRssHOS6TzcfFxLl6SJr2BkMFX5O+5+LMs9hkuAITNp
         Adtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QF7Ym8HltwH/EryL+lHedJXLoRmFZy+TQyk7QyouYW0=;
        fh=53bUhIaga9QopCOFxGlVjJI18y4RIe11CwMBFYe1HF8=;
        b=ODCB//Jgfd3xooO0CepmQzbr316kbymmXXwf3QKg8sIv17jj1kgsMKbEbfRADvi19E
         BbOgKEXjcQVunVypiqHGYH27/J11NBR1o1ciqLRqe0QNApu2fgZMMWcA+TuB6aelvdQ/
         dwtkqzTninxj30QPS72AcD9VszliYvhSgAD9ztXSxoQHYgJSYCy0l3utAn76c80wSvDr
         ZpaRvZpt6ofhKzJCoa4z4gkSkHcDJPOmY6GodfZ8c0wZZa+VIQ1WJGHNMb9d9jl5ii0d
         bAblMb48x6ISHgoddqAeWroH+LQbFG0npZYwRoQofZmLIm+8+tOh9CRoOTYkqV44E9nq
         zCUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795119008; x=1795723808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QF7Ym8HltwH/EryL+lHedJXLoRmFZy+TQyk7QyouYW0=;
        b=dpvNgDE+gKtgbU1a2e9d9Q06yysbl9HchhDXglmtZY7fXjYmQ+Umuq7vrnnJ2cNC/W
         43ce8bgiKAJkjdlfv3mgbwhao82dzxGd9wjLaryOL2zMouwcwYJNb6pCdZLAMfDf5CPV
         Ctv7gO6Dktqe4JvFYjZMWt2n0huI8q9aoXMjaA36s3MF65N/Nz9+s9ipXiQqUR6vyWuL
         pcf+jrCwqH0Ic76c0Zrc1/lO/gyLTIbko4x6YLOEybKfDz7H4ZpVpDw0lF7OSc7CDn+j
         yK4aVlQM7SHiLv8utcIFMrf1nO5Xk4w5ECiqErp4owz4+htZupe8/EjujpL09Wcpussl
         eb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795119008; x=1795723808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QF7Ym8HltwH/EryL+lHedJXLoRmFZy+TQyk7QyouYW0=;
        b=0kKEY8W5GQ5ydRfn/ZqCdgPUDDeWTyuRwrSZZiNBLWn2xs1+LTzTM/TAkDQRmGUBo2
         N4fPNiETo9Z5jqyP/Bpcl1Mk2JrDpovWcLjkMWfhUZ/13cHew8R84L81UJFqZep6RxyQ
         mtGqj4SX/sbegdkiw7+NLCr8L+fhyiRRKXZMSN4RG3OUG541CYSmouA+3K3PSGbUxqog
         W+MT68W34mptbVEjGavvZHCgioeuns4Vp8hzh2qS/nLQgv5bzlZKQOA2sv12AMRZX9H9
         kkhic4m/GE/zfOMBl8IYMZLZUEuxx2YNW6OeFbCGQTJnuHH1vpw0a/xpYNL45iy8St/c
         hudg==
X-Forwarded-Encrypted: i=1; AL+hErH0/t14YrHeOFobsIP0/A9y3TBtkR1IrxXzXeRSgtwcV5TTEqYpaLrCy3XYu3d+LetwUGTJO415zjM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dcjjj5J9/piwLOEzt4QmqupIa0x/qbTo7QUi91rx6YDFGK2s9
	Eti8efJhUHHI4FwGZBxVLqI7U/yOpFAbAY8NJKvD6Jt+59wTFRLwo47WPnUaBy43oPCOHo8sSod
	nRlTynLZiKbYABg+lenVbR9RbPM+8b0g=
X-Gm-Gg: AYBFou0/aQ1RcG+4IEHKdzYfVQshnl9eL6e4uoTC8IQmZIff8rlzaRwQGlcadjPLSvF
	aUJxmt2tT9YxAI1cve3zXXy3IhI0ICSB4HAZE2tYFAhtiNhb/3m88Rc1VXB5c+kfidMpATRawvw
	0jxU8aXglwUVkj26Lr7x+mPzl8rnFTblc37oC0TjpweSTWE0gBrPbQOwxcW81oQ3CmqHSXwhDld
	nMPEpRTMHVGt1pkQZamEzacwX6j9cOVHzHgpzhcg26M401xHQUKaUz3L9LKJpOxBFOtCrw1u5fN
	Vsdwvo2vl4J1DGVPAtOQ0KOqODi4JSJPNvfBCqUAt5Z8nxm0Qxk3fFtazjBguc/AQsVq5LC/RzY
	LrqQTqPsteOtkIFpUOBt3qy4j9dlDjP+XZOaqWffvyHwj+NO3P7zz63z3/3zg7plcFQpxwEpKmp
	NaLIHmsA0e4/bSEpDZ79mIKnPgPl0PLdmXwTT7Ba1o7wa/FYDCoNihIWUybpM=
X-Received: by 2002:a05:6808:f0d:b0:572:221b:221b with SMTP id
 5614622812f47-57a0ac2f919mr1693672b6e.5.1795119007693; Thu, 19 Nov 2026
 12:10:07 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119-vfct-regression-v8-v8-0-12463194e457@amd.com> <20261119-vfct-regression-v8-v8-1-12463194e457@amd.com>
In-Reply-To: <20261119-vfct-regression-v8-v8-1-12463194e457@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 Nov 2026 15:09:55 -0500
X-Gm-Features: AclHuK__78tAY_AkLxZQOytNoMhYChQRQsMLPxlHF7wI-_ZkmCSTiv8HLMQmS3M
Message-ID: <CADnq5_Mfn3XCzLxyot_=vybMDLam+VoDFMgwWujnEkrTh4XLSA@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] PCI: Cache bridge firmware secondary bus number
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, linux-pci@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 2:46=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Drivers such as amdgpu and radeon need the bus number firmware assigned
> to a device to match it against firmware tables like VFCT. The PCI core
> may renumber buses (e.g. with pci=3Drealloc), after which the runtime
> number no longer reflects what firmware programmed.
>
> Record the bridge's secondary bus number in its struct pci_dev when
> pci_read_bridge_windows() reads the bus number register. This happens
> once, when the bridge is first enumerated and before any renumbering,
> so the value is what firmware left at FW/OS handoff. Devices behind the
> bridge can then retrieve their firmware bus number via their upstream
> bridge.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/pci/probe.c | 1 +
>  include/linux/pci.h | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 9a178e0e5f7f4..89a7c52ac3e5b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -513,6 +513,7 @@ static void pci_read_bridge_windows(struct pci_dev *b=
ridge)
>         res.flags =3D IORESOURCE_BUS;
>         res.start =3D FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
>         res.end =3D FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
> +       bridge->fw_sec_busnr =3D res.start;
>         pci_info(bridge, "PCI bridge to %pR%s\n", &res,
>                  bridge->transparent ? " (subtractive decode)" : "");
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index aa3765a20a96c..4c1b1e557a607 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -363,6 +363,8 @@ struct pci_dev {
>         struct pci_slot *slot;          /* Physical slot this device is i=
n */
>
>         unsigned int    devfn;          /* Encoded device & function inde=
x */
> +       /* Bridge secondary bus number at FW/OS handoff */
> +       unsigned char   fw_sec_busnr;
>         unsigned short  vendor;
>         unsigned short  device;
>         unsigned short  subsystem_vendor;
>
> --
> 2.43.0
>
