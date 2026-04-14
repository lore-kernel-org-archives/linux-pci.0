Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D3D296BBA
	for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2026 05:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776143016; cv=pass; b=uX/DI4/d6hfdfnOcptM7RnyGbuaENob/fCyTR3l/RiRBAvU1MxegH43NU/vAuWfFZNjMuo4uT9c2WGbzzbKKHW6Tgxr/bjfX4zfbCMi+wWJgABZQ08Gn7fYtWY9hinljMWfq+lQAoiunaH2BoiefrgF6QyjownFqMowsZgdnNjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776143016; c=relaxed/simple;
	bh=/ONKg0B1L6p4zm87A4DLLkuv8Uix/xcFzs6/+rsavpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLYNVN0RrVPJ/8wxtjH2Wg8DSP5fViYiR5/VCaqVRZTkpJrgHmarIK38VlsAeHG9xFnsbA+C41EUjFmHDWZ2Ej0QOIQmvljeH7MogE6qgCC6kFv24XbI5OXGd5GQvFOUR4Ti7Uaum8sYUSH5TE0zx8ugAYKqRC0LD1p9wqDHmEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k9UhoHTv; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k9UhoHTv"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a337552604so4355268e87.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Apr 2026 22:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776143011; cv=none;
        d=google.com; s=arc-20240605;
        b=I8l8kAHyCN1WrnR2ZMwlIfj7SmNRiYP5++D3ciDUm/zfyfDMXRWX8TbTeUYtRj/gGw
         T7ccTECgrwsiqBdLy6fbrG4WF694b1sITeHU9QkJWM9hjZuQMtowTP62WValWJdpphf3
         F+mij62x4pDOC6vHgS1MirZ/F/EbMhFAi7SAo/FOP6Wes3H2Bj5Ao2adu3bSfuFdq8SF
         XE0uJE5jJESuD9b6xCAl8RvMDkG7Sio5t59f1aEURM6uFZfdeBWjPUQEYYm5EbmL12w+
         RYZhJntwX91aNlx2AFlVaG6wZzHLhdPRjLWsBhdKk5eHexM6HVCWGx3UCNLLbsPJiKe4
         e1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r5Pf27EYmY3rBtqc75kC82+zV4ukf34OCg9xmpmqAus=;
        fh=LXSvZrgUZRNgNN9xFyD9Jfm+81Lrnb62rt3ijX73HLo=;
        b=lGa3Es9BA1R45VI+6pQlv/ubq4doXCHKHs75iN/opCXz6HFIEaJlTxAU53+GjyLyFK
         W4o0wGID1TQF8F7Ez9l1fnXtYRrV0Oe8gRu+p3vHJIj5w6yqddm91REtqm8grtaCPK45
         BF38xD13PnRDBRxOEFOal7fmBwB9bGLnrM9YtQJsN62MccOEJC0qlD63nAzNMxQbHjcb
         0ozx3dG95NpP4rvZXXHBw0Emtqad0sPczNdXff5HQNNbxfwXkDT67Ae4VZyS+7dAS1AK
         LLUJ3QZtQle98MEZWJLH/aTteYKXlxtFt67YCUWv9sYSQ+szgLaaIhLMcK2Eck6ZcPGW
         5YAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776143011; x=1776747811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5Pf27EYmY3rBtqc75kC82+zV4ukf34OCg9xmpmqAus=;
        b=k9UhoHTvwzyqW/zmjESMuicoMoBBYBtJZXWbq6QFAeMa4+SEzlP6xCid/jUtzhFNq3
         xJyIyFiHJqJBGmq6f4Ky9U44OV4gO45TCYbUBhdVkQgRk0UOyIW4aLZGwJkQoWb01xih
         L3eOsn1bPR/InfQYoUdHiO8laGxXIXZU4L1Tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776143011; x=1776747811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r5Pf27EYmY3rBtqc75kC82+zV4ukf34OCg9xmpmqAus=;
        b=QmVIWykpGa1ohh0ylJviWYUbHJE6vNnriiW1nCtOZcDdLB0o8Arn97H1gKCd74gSeX
         BeoKBG5RKep3lyO6Ue28vd3R5nOUv3Eh+1nSEfOQJhXmNd6g01ieljDBC0s6rcufTdus
         CE/+iZA2rn55kTE40HD4bT6JUWzR9T4MTa6iuIiCJzFK1bY11NL5GEo1b9qrUo0v8+Ae
         m0frmCHlGHDgQ8BzpeI65wbkMhZZYKcqkasCg8b+o8gXQ8mos5duPZvRr8z4Ffyx/GUQ
         Fy3tbCD0NjbJ2l8iv62XOfYYlhsnVMK9DwzxYaHp2lxvlkNlP7FbguHKR7GHImJsCWWr
         XJ6A==
X-Forwarded-Encrypted: i=1; AFNElJ8MCpdgwdpNbtI6AHi2Mr06pqClB0J9LVXAT5B1y7FSBaqcU94IKVCuV/XtW0JCe1Cd1alRObsnibg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlAm5Re+aRqVLsKmwBn1eJlqJdf88iPPMw00CbsAOV17rcxDYd
	t2oDcXAoTvlPaiIHi+1ovd2afEnoIIEoGSaCg4uhT7nBu/2Co65aHZ9zXFsUxm4gzUbbIB+FJkw
	nP1KgC0ECtJr6YetktQ4eXqh9UENSfatqzp66ZCUf
X-Gm-Gg: AeBDies7nLrTJRGU3BE5DOD44IwICV6Ntf66fAWFmn01rmJMj6MBm5tclHL9lbUOKEr
	PPLxb555sKTDhfpIS6woghd3fuahqQxLs8CM8MgLM9L104hiUw+fTJLyTCXkmUkqph9K/yzGFMO
	SJ6YhbgPQVwrrQOkkN4gV43OfjKahkcRZ2Pdv3JQKGZP5gDSy6aYHB+HjO//qNmb9OX+YTUhN29
	n4YEsmUds8iA4gdIgM/6jdUqOO7br+T1FEbZCuIAtZQQO4bOQWM0+Cpfk7D6pCCrnzC6OS8djAo
	TQGsBMPAnTGdutnHG9UVszmVVM/ZiGp2512qw4tMEPfcjYTt
X-Received: by 2002:a05:6512:3d07:b0:5a2:bebd:45b5 with SMTP id
 2adb3069b0e04-5a3ef702ba7mr4942397e87.4.1776143011315; Mon, 13 Apr 2026
 22:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com>
 <20260413075459.GA2626902@google.com> <fpcs4p62f35a5qyqwgm5ysa73stbysxcr62tkmmkrrcvsuf4t4@4ivukyqjey57>
 <eeytuhqpgdz4do4tgtbmfntub2femtyq7bij7svhodpyjwaylx@j3gmvq2a2zqc>
In-Reply-To: <eeytuhqpgdz4do4tgtbmfntub2femtyq7bij7svhodpyjwaylx@j3gmvq2a2zqc>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 14 Apr 2026 13:03:19 +0800
X-Gm-Features: AQROBzBGpczfuo3hb4EM0V1LAlLdphdlu-SZQrzKHBW63mwHzThEUJagiFr7yFk
Message-ID: <CAGXv+5E=tujhtZjwi6Qm7hk3Ks74UzTQHWq82NiTEw1+vYod5g@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Add support for handling PCIe M.2 Key E connectors
 in devicetree
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, 
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

On Tue, Apr 14, 2026 at 12:08=E2=80=AFAM Manivannan Sadhasivam <mani@kernel=
.org> wrote:
>
> [Resending as my previous reply got bounced]
>
> On Mon, Apr 13, 2026 at 07:33:12PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Apr 13, 2026 at 03:54:59PM +0800, Chen-Yu Tsai wrote:
> > > Hi,
> > >
> > > On Thu, Mar 26, 2026 at 01:36:28PM +0530, Manivannan Sadhasivam wrote=
:
> > > > Hi,
> > > >
> > > > This series is the continuation of the series [1] that added the in=
itial support
> > > > for the PCIe M.2 connectors. This series extends it by adding suppo=
rt for Key E
> > > > connectors. These connectors are used to connect the Wireless Conne=
ctivity
> > > > devices such as WiFi, BT, NFC and GNSS devices to the host machine =
over
> > > > interfaces such as PCIe/SDIO, USB/UART and NFC. This series adds su=
pport for
> > > > connectors that expose PCIe interface for WiFi and UART interface f=
or BT. Other
> > > > interfaces are left for future improvements.
> > >
> > > Thanks for working on this. I started playing with it now that it is =
in
> > > -next. The PCIe part works fine. I'm looking into how to fit the pwrs=
eq
> > >
> > > A couple questions:
> > >
> > > - Given that this connector actually represents two devices, how do I
> > >   say I want the BT part to be a wakeup source, but not the WiFi part=
?
> > >   Does wakeup-source even work at this point?
> > >
> >
> > You can't use the DT property since the devices are not described in DT
> > statically. But you can still use the per-device 'wakeup' sysfs knob to=
 enable
> > wakeup.

I see. I think not being able to specify generic properties for the devices
on the connector is going to be a bit problematic. Another use case I have
requires specifying a bounce buffer / SWIOTLB for the PCIe WiFi card. The
PCIe controller does not have an IOMMU behind it.

> > > - Are there plans to do the SDIO part?
> > >
> >
> > No, not at the moment. Feel free to take it up if you have the hardware=
 and
> > motivation :)

Ack. I think I still need to figure out what the plan is after mmc-pwrseq
is deprecated.

> > > - The matching done in the M.2 connector driver for pwrseq_get() seem=
s a
> > >   bit naive. It simply checks if the remote device in the OF graph is
> > >   the same as the requesting device.
> > >
> > >   I think this would run into issues with USB hubs. If I have a USB h=
ub
> > >   and two M.2 connectors, with both connectors connected to the same
> > >   hub, pwrseq_get() is going to always return only one of the instanc=
es.
> > >   This is because the USB hub has one device node with multiple OF gr=
aph
> > >   ports.
> > >
> >
> > Yeah, this is a known limitation. I'm trying to improve this part now a=
nd have
> > the WIP commits here: https://github.com/Mani-Sadhasivam/linux/tree/pwr=
seq-bt-en-fixes
> >
> > Once the merge window closes, I'll submit these.

I couldn't tell which commit would help with this.

In my head I think we would need to extend pwrseq_get() to add something
like an index parameter that the provider is free to interpret. The M.2
connector driver could interpret it as the USB port number on the remote
end.


Thanks
ChenYu
