Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12A5481653
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555669; cv=pass; b=c0h1PdVXNynYuIM3+Qo9G8LAjIhQYRgSev40cvhSg/mHRXplm2FdyCFOsLnyr/2kDJSWAaeAgh5r12sc8/2cx1tT+9ObUKcinU3hEpBTASJBi5FkC6RbotbQ8r9VpGfFD4q4JD8W13shTiiXt7sDbLddwsjtbLbUQ3LO1ClL1o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555669; c=relaxed/simple;
	bh=YfpJerSZNcEs9ES51CQUrX40G1QuMUASx0dNHuE8DLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDfFd9WTnLzYvhM3lRUk1jFRtmxXmbMkir/0WPQ0rLi5zPOZTsdw3WGKsMHsZpTJnZglngZlvfK1cSVvvpSJmw9MAaUxRNjT3+EAt0LTJCNc3TDeZDBh+yPA8Hh4EVg0XDukwjL6lAlrqFCTN1adiBiRyVTIDs0AU9aMhsSi0Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=QB9+RNri; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="QB9+RNri"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d1872504cbso3317869a34.0
        for <linux-pci@vger.kernel.org>; Tue, 03 Mar 2026 08:34:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772555667; cv=none;
        d=google.com; s=arc-20240605;
        b=defyCSaFX2Po1fxwWkDxEal8B4We3aSe2tQcwAuGiqFUiNJlUKxFnx+1FXlxombREH
         uNXXZDyUzqpbjTa66B0K6EQ1nUE7JIjPURGuSpFRHuUuYxQmx+m56RMWlIsuR/ajHEFN
         WAVwtIFsq4wdp2gEQum50XgecSrPChc01FIYEbE0CkHY473Ypzn7o/hFMqb0JzoLEKsH
         MgUBVehtKqCR/7mu6JSnCq25AJdfQu1tjM0RmXPfQYcGqpqa3MClMaPza6FnfskHkHVx
         zxu6rbbI60ZISbVccMsZDCzsaI39dplIsZNrn4nZs/jZf6KwkJQ97cH/XVOAkdrRnATc
         +HkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OInpfxdiwHy6VQDY2/Hp0QyT65G097CPkyEA74gq5QQ=;
        fh=9xaGfteqIgskJWuQNovlWI+edXDuv0d970QTTH8e8g0=;
        b=j23n0I1faOBWIO14591Ky1SWk8F4T28/xP0MczbmRPJAc+reBt57fWJVP+VuTIaMTs
         mZ73KaNZOzaZ0z70Fw6xvLrme67fITKYTyLQJlTgevrIaS5Wd9D7xAptQ+yGjPuxxwr8
         3KPPtTATEJ0gIzGioN9gFBCNQs7IYhKleBZWwGHlnxowVFzr6rtQ6UbAdlfy/aG6F0Vh
         LU9JOmF8i2rh/V6X6D0M2iDgC3/AYm+uVqRiM4UjI4vb8VqZmjHV7+EHZCtWMt6uMj4K
         g0gGaoXbndslS4xFMQjd94u2lLi4y0OU5Eq5gg3Ny91zP8QbcH47ft1B36q0dKilnQ/3
         ADgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1772555667; x=1773160467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OInpfxdiwHy6VQDY2/Hp0QyT65G097CPkyEA74gq5QQ=;
        b=QB9+RNriJikd34SwQhGkWYqT8qnwF6meud8PMSQY9Z05kGarjncDw8bJndIrcvl4c0
         yeFtokwx1HJcePyS0Wk6SqqkkAw2hG7CpMUjyVCpeY877vU6E1ud/+bHVGGZZwHChIl0
         hxCvy4wfMD+cnDgcrzCn0TJNgIifggqj2nWLrNr3w7psNvgai60AtuBWG8QKchnCtFOn
         krRTZT8btna518vwgfyQJtI1EaPY5bd0A0dlmgQ8gwq8kicsXAl+d4QMg4ieqcbFoN47
         WYzU8fiqFLhUhw/JMajMQ8/Zxtgs4vTvR+T06wzVvbzfpdp4eho/jG4CaG7rbpHp5H78
         DxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772555667; x=1773160467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OInpfxdiwHy6VQDY2/Hp0QyT65G097CPkyEA74gq5QQ=;
        b=BSbUb6kWEgvx4hEBtlPAvmQ7zK8g/+3/Aadg47G+qaztjZOXaMBtaLoON/jn7ddJwj
         a58V6z6Q2CW+EnSsU5bBvITaxKTrXRLSyx1uxn78uzcVQ/1SonRcmDWO609W6NI/4KDu
         gcG9Jf2Sncepmu4rAbBPSx2oA6+0r4392sOKUkpjHb8tlkJ2qCrG8MJT7mW/Ulxl65Xl
         xlauCHvSEP3dEvoXc2tGWsPW2XCUDR1oXUkLXHrPCmHma2QdqGEfeiMHQ1LI9kJf3m9W
         e+NVgh0mmiBTiqQ9x0r6fNJUZk6heDz9DojJHIpCqtfYirxvMQWMjzh1uxggv1N7cAoK
         bxBw==
X-Gm-Message-State: AOJu0Yx67fBm1zspkNnKIqXN56YG/ZaGkZdmieDntoE9OoKcDqsMZr6p
	xnZegLj4B6MaSpfm/BWsOPIay41Xnvfy4NaFtWQjufpx+14ArllMphSziF6I/PqgZd71/SiB6lZ
	DlMeSTRqj+gXjVMMd641d4t5dXUQBYnXMGdetrjx3/oopgfQW/kuf
X-Gm-Gg: ATEYQzxE7Fb9nfZPeCNj+3l5H6Anwhw+TBpYTHA8OKfhaCN6h9gzXcOtIKVZyRoZkaI
	45yEW/IZuK5XrDq/C2Wsr76DwzR4chZmdalT6vpeJIKhDF+mb+6QiRqdok0oIvy/Xm+YRz3XiHD
	rcp7kr2k6flPUB6lSvlfxHZks+Xgny+scG/woTcrHH8RhNDbrUOOUdZ0IrHLYy5pAkj8cB9seqt
	av/BiG1K/pA0g2IMlP6KYC7TnSozHDmjATIn6+h2BWrzS7leqjNxhRAntIAv2Kv5B3tdFdG71m8
	2cP012I=
X-Received: by 2002:a05:6830:6e54:b0:7d4:8c9d:dd2b with SMTP id
 46e09a7af769-7d5be1fc888mr1174689a34.0.1772555666720; Tue, 03 Mar 2026
 08:34:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23024521.EfDdHjke4D@steina-w>
In-Reply-To: <23024521.EfDdHjke4D@steina-w>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 3 Mar 2026 08:34:14 -0800
X-Gm-Features: AaiRm50Px49HlJBebz525BmL7mRczLSo_5VnSZhLsGQrektayrJby8PDCB-XxsA
Message-ID: <CAJ+vNU1m6Uw8GrXO5+o6UGRUwcXrVJJ0BSUF4rrqLN+RsL6Mrw@mail.gmail.com>
Subject: Re: i.MX8M Plus PCIe link regression
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, Richard Zhu <hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 4:38=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi,
>
> these days I noticed that there is a PCIe link regression on my i.MX8MP
> platform (TQMa8MPxL) running next-20260227.
> I could bisect it back to commit 9c03e30e3ade3 ("PCI: imx6: Skip link up
> workaround for newer platforms"). I always get the following errors:
>
> imx6q-pcie 33800000.pcie: Link failed to come up. LTSSM: CFG_LINKWD_START
> imx6q-pcie 33800000.pcie: probe with driver imx6q-pcie failed with error =
-110
>
> Connected is a Gen1 PCIe -> Ethernet adapter. Interestingly a Gen2 device=
 is
> detected without issues.
>
> Reverting 3c96a61dd2e098dda8dcac3dce3d38a3c87afbfc and
> b9a8d28ebbf118bb3eac953f4a37abbd341257ab "fixes" my platform, both Gen 1 =
and
> Gen 2 devices are detect. Commit 3c96a61dd2e098dda8dcac3dce3d38a3c87afbfc=
 is only
> required for conflict free revert.
>
> Here is a summary with outputs:
> Gen 1 device
> > 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> > 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> > RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 01)
>
> Gen 2 device
> > 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> > 01:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9128 PCIe SA=
TA 6
> > Gb/s RAID controller (rev 20)
>
> output of "dmesg | grep imx6q-pcie". Common part for all tests:
> > imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 ranges:
> > imx6q-pcie 33800000.pcie:       IO 0x001ff80000..0x001ff8ffff ->
> > 0x0000000000
> > imx6q-pcie 33800000.pcie:      MEM 0x0018000000..0x001fefffff ->
> > 0x0018000000
> > imx6q-pcie 33800000.pcie: config reg[1] 0x1ff00000 =3D=3D cpu 0x1ff0000=
0
> > imx6q-pcie 33800000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K, limit =
16G
>
> next-20260227
> Gen 1
> > imx6q-pcie 33800000.pcie: Link failed to come up. LTSSM: CFG_LINKWD_STA=
RT
> > imx6q-pcie 33800000.pcie: probe with driver imx6q-pcie failed with erro=
r -110
>
> Gen 2
> > imx6q-pcie 33800000.pcie: PCIe Gen.2 x1 link up
> > imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00
>
> next-20260227 + reverts
> Gen 1
> > imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
> > imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
> > imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00
>
> Gen 2
> > imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
> > imx6q-pcie 33800000.pcie: PCIe Gen.2 x1 link up
> > imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00
>
> What can we do here? I'm wondering why Gen 2 trains correctly, while Gen =
1
> doesn't.
>
> Best regards,
> Alexander

Hi Alexander,

Does your link partner perhaps suffer from some errata?

Ironically I have had PCI link issues that required the patch you are
needing to revert on IMX8MP with specific switches.

Best Regards,

Tim
