Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9954E3D567B
	for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2026 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162564; cv=pass; b=JacU4D+Hd9fAyFy9CtZbzjZfpjIkcCTw0HTv45ATq4iJQWAv/RfE16VgnvjfOPuKEiooqeC+/Xdy0O/HGzKbACCtljW7psVqMIh7s2ijtUInjiMQk9Fkkt/0qzXPWQlgoZoqbFMG7C4UV2jk5ebgceOW5im9XzHRh5d8yD1OWC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162564; c=relaxed/simple;
	bh=Ido82lTsBObPiLyE+cnbnYTa5RnXovthshiMl4cqqxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ez7mkD2CATGAzquRGA8c7P5NGrb8OCVvKXbKNPFx/FNtYKjHINlIjWG69rcfj/6Hzyp7k6JdSNTBfRdcfkSYEnKovmQP3h2vVSzbp4s2+IRZJRI2EIqlB+DSTpobrJWd0JNE+h9XH7OxzgE3hU/G6J+rdWZv+gNzKch36PqYUkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CAg1W+YC; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CAg1W+YC"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a402b2d102so1344950e87.3
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2026 03:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776162554; cv=none;
        d=google.com; s=arc-20240605;
        b=TJACjy6H3DKqbgGdubMoUvYqyTRmO332/weAARvRb+nfcmv9AU1UJv10dWqb1NI4zA
         mXmaMV/Jq/axHnbQI6tfIZAVNeE85B7Loqonbf9r7YyJRwpUhwARwoHAWKulpUBSdMuz
         AaGaQEYPTfrKAo0bpjfC0w4VRf2KBccO3nkBKYRHUaaHEvFeNDzk3D/khzmc4vPISOWQ
         RvptCO/+pEXkYjTBw0iKLjmZ/dnIiSvon3CR0FwkCsWIFdWTbRDKee0bxpn0/xJpCVyb
         J+cbSZRfULX5L0+aafMKSsTfdf5tc9on53au5c8OJZjQhy6jheki80wF1nQl+DrGzP5j
         kKNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=obCwu9OJRNTUN7BsZbzZ8PH73jQ+TTI+BXXfuHZowXE=;
        fh=GlYYNKQqgS6ge+izPnuhjdBhCcInYP5jDg8ErTSk1qw=;
        b=XoMmGQJo4FG2Sa/pMOASDc3vI28OtIto1TqGLGQU/Cl6DYKRWv4DnfEffvCbV05j3G
         sA1NreQ9T1N2+orredX3yK75UzZybqDsYl/DkN2J1AM4qNi+30qJPyW+V4j8WaiTnBbp
         5wNHk3QAkEnHPjXFNVymTV4avM4b5F7M2+e6Bnz5QLoI9FEbX5LuitFzuMgM9PnUEnbf
         xF3/SpqVj+Tj3roKvj8/Mv9zXPJ6qiS9EnMIxPCYVqdEscZ0Xw3jKyTBRX0QttZdX13Y
         inG33zSzEqZQX1DalqLeSLciMYYHzGFeMTUOSWnVJ5SqCj8LPGf/DiP6rKTILEDDoDV5
         +9cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776162554; x=1776767354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obCwu9OJRNTUN7BsZbzZ8PH73jQ+TTI+BXXfuHZowXE=;
        b=CAg1W+YCDWa+7hMyoFTX9wrJnea3anbAiHdxWmpDFPNhe7kCyRPxDRCs4+n9KcUSjl
         w6nzvTJigwS7oM6UFv5A3HKxmii0VyJz1d3VSyhkRHh9KbLCHy+zvkfyRpySbb5xZhZu
         JuL3QYV3wyDOI2wfxl8ehTcAnuZZDMlWKsh4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162554; x=1776767354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=obCwu9OJRNTUN7BsZbzZ8PH73jQ+TTI+BXXfuHZowXE=;
        b=GKkvJSH09HPBgj2trQWQY8zbaEKJ5h7CqLucVari6Ixtxr8hQCxBEnMrbsNTXZUEEd
         TCxtlP2IlFKzRGJTZblfJLp/eyXLZhsGxU/UIs/rVGrzxgiraxykioFfDGU4KG6QYno7
         zhv4G3ckgeHGLNw1cf81CLfWnWaCiarCF1yp5B0XG3s9jeFIpN9BLtj7jIrJUY7sne53
         Z2gRPc/333TRd1mSqX6iDrWfPM1vgB4+UOP2PoGF+ezk+2LfNNe975TVdIzEPyWi/KcN
         vqnrTplToMlswNdpXNCBdv+rRsYEWWIJ9GzuUFvdCPTNc7ywRemESdtsIKPFq3gPs0I3
         mhEg==
X-Forwarded-Encrypted: i=1; AFNElJ8quCgjw6HJRVTkAuyc2UHp0R1TeDGbGgvjCKgAdi0rgncC1TURW9Ypzo/+UWgNVz6/T6G2783Tz1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuDO4jyFxQGSUdDlK+QK2L06s45ddBajOxJ08ucYAhhfZdvd17
	OGFuk4FnkEjvWbsQsB0fcnFDjqIhA9bTQLwUrk4jMrjM/1BTuLMc+ShjZBKWqsDk0JLmKbzInR0
	sNpsGwi9avSp6POy4hAC+cMkLQ0HVTc4H5Jd0yV/t
X-Gm-Gg: AeBDieuubpAGrQ8+YXYfjLpn9aKudTJ68jHh9HUFvfc05WSnin2H7yGZSZqrTZ0xqAc
	cH/IZ3sg2Z9UGDHIjzsMHNNos4/iPT37AUqqI8AUSa3cFeM8s6juR2Gft/iY6wtWy8ykcLuzydH
	ADNtuS/bFXalnyNuZ5cx75ygIk6IFj7WCfOuue8s358KKMhkbNOQ/0j6jX7pac9j7T406SQ7faC
	erwOeAWjLo85OrH0V9dJecTHRXcqe011JXVUVKQzcSEWZ6fHIZwHfsnDmuNFbtMWkh2dpApGf8k
	9IDi+Am6UfnWvil3nrergOdaOwgFTQY2nR1W04yWadWHLRoV
X-Received: by 2002:a05:6512:68e:b0:5a2:ae27:c879 with SMTP id
 2adb3069b0e04-5a3efd7f0d8mr4850095e87.29.1776162554447; Tue, 14 Apr 2026
 03:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com>
 <20260413075459.GA2626902@google.com> <fpcs4p62f35a5qyqwgm5ysa73stbysxcr62tkmmkrrcvsuf4t4@4ivukyqjey57>
 <eeytuhqpgdz4do4tgtbmfntub2femtyq7bij7svhodpyjwaylx@j3gmvq2a2zqc>
 <CAGXv+5E=tujhtZjwi6Qm7hk3Ks74UzTQHWq82NiTEw1+vYod5g@mail.gmail.com> <ad36pIu-0dutL7Nk@ashevche-desk.local>
In-Reply-To: <ad36pIu-0dutL7Nk@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 14 Apr 2026 18:29:02 +0800
X-Gm-Features: AQROBzDHB_HCwto4iaprIWgL7mrQWt62yIrtGAtxckKlX4EUkJwTT3ZqPu-YslU
Message-ID: <CAGXv+5EGe59nJctLweEdZjb3MNmMvjuCHngGSfptzN985OiLdg@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Add support for handling PCIe M.2 Key E connectors
 in devicetree
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	Hans de Goede <johannes.goede@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 4:28=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Apr 14, 2026 at 01:03:19PM +0800, Chen-Yu Tsai wrote:
> > On Tue, Apr 14, 2026 at 12:08=E2=80=AFAM Manivannan Sadhasivam <mani@ke=
rnel.org> wrote:
> > > On Mon, Apr 13, 2026 at 07:33:12PM +0530, Manivannan Sadhasivam wrote=
:
> > > > On Mon, Apr 13, 2026 at 03:54:59PM +0800, Chen-Yu Tsai wrote:
> > > > > On Thu, Mar 26, 2026 at 01:36:28PM +0530, Manivannan Sadhasivam w=
rote:
>
> ...
>
> > > > > - Given that this connector actually represents two devices, how =
do I
> > > > >   say I want the BT part to be a wakeup source, but not the WiFi =
part?
> > > > >   Does wakeup-source even work at this point?
> > > >
> > > > You can't use the DT property since the devices are not described i=
n DT
> > > > statically. But you can still use the per-device 'wakeup' sysfs kno=
b to enable
> > > > wakeup.
> >
> > I see. I think not being able to specify generic properties for the dev=
ices
> > on the connector is going to be a bit problematic.
>
> This is nature of the open-connectors, especially on the busses that are
> hotpluggable, like PCIe. We never know what is connected there _ahead_.

I believe what you mean by "hotpluggable" is "user replaceable".

> In other words you can't describe in DT something that may not exist.

But this is actually doable with the PCIe slot representation. The
properties are put in the device node for the slot. If no card is
actually inserted in the slot, then no device is created, and the
device node is left as not associated with anything.

It's just that for this new M.2 E-key connector, there aren't separate
nodes for each interface. And the system doesn't associate the device
node with the device, because it's no longer a child node of the
controller or hierarchy, but connected over the OF graph.

Moving over to the E-key connector representation seems like one step
forward and one step backward in descriptive ability. We gain proper
power sequencing, but lose generic properties.

The latter part is solvable, but we likely need child nodes under the
connector for the different interfaces. Properties that make sense for
one type might not make sense for another.


Thanks
ChenYu

P.S. We could also just add child device nodes under the controller to
put the generic properties, but that's splitting the description into
multiple parts. Let's not go there if at all possible.
