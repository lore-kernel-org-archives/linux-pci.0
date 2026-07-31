Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB8C411F87
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504482; cv=none; b=cEBtRlcjIIV3YAsyBXnG41SiuRqAtdeqi/FNLgZBOZr+s5+OGaeZdigsRQBmIGBhXNahxIIFlPtaNe0XyYgvJv8FsQM9eMMxQhnN+/GN2QUrs34rPZF6lJa018CNg1Rqm0aT6zcXYmzWu9/6KKuwwTi038d5R1CH2R+cNckf0pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504482; c=relaxed/simple;
	bh=BdWRFs4osWaaJzMBzKIKTHPcsMgJqciu7jcoPmTxYec=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5v8YAahvjz+fkOitcSqUdJCt3N5DI+b54txlO3KOVkkP56vLrU2rOImIVsGOSeQhonEVNykYnzbBRDctvq88Th4TN0dHRwtBcuZ8Nzd9ZGely2KLrgmoVquTOwd8l76xKWh4cUe1cp/rekYKbSLQgGv7w/8w/29ahtYGrhly+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgm9xkTh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgm9xkTh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40711F00ADE
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 13:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504480;
	bh=BdWRFs4osWaaJzMBzKIKTHPcsMgJqciu7jcoPmTxYec=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=fgm9xkThoqF1bQfPKO65FXat8RPLvTXA1XKtS4lux6x04EWgf5FH13BC8cyLHazPr
	 dxzEQEnZ2Df/Tppmr2j3vLpLLS9qa9ha2qu+qXjQ6azhAt7sq6IF2eqHqW93C5RyoK
	 TzXsDCJ6Ybn/MAaTz0O9nq2rCBocCM3nN5zK6lrw6dP/aHfYjN95ceIZnBoqnWhx1k
	 WW3n99WPKLtRFqFe7BJZA5sk06HwbHzVF9HYWaljlWJJy+T9hsK7wQj88oCou57s59
	 0KAgsXS/e9JqHF1A8NTB/9+4ixHnqSaTU7hPdlftVqNQKKsGa186j1PFolfZL1F7g4
	 cxNxbc1EdJa0g==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aeb24c0807so674353e87.0
        for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 06:28:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rri2LVbvK4WX6qZbbTlvpUcE/5YRizYR/12EJOiEzr9DerwDESHlOInNh4HNSVhhqHqesqcJvf1jck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB+jFGYkhv2Sg/Ibp3/Enx6tbIxQM+Sz4FaPDRmwgoixi25U/K
	ocklvGSP0VDTSKk7sn0K1eR6jDAqKLHDVuBwsJBIgIPKJ+LT4mJ+eQjVpgWGslmRL42HsHUKpnk
	J6wOW5pRYhzj0x+Wmkq6NwcPA4bNUAWqlM+18Zag3qA==
X-Received: by 2002:a05:6512:3d9f:b0:5b2:a1f2:466e with SMTP id
 2adb3069b0e04-5b2e1fc8295mr456344e87.10.1785504479286; Fri, 31 Jul 2026
 06:27:59 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 31 Jul 2026 06:27:58 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 31 Jul 2026 06:27:58 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAMRc=McA3BqoazxvGDu1_WoT9x0ujXT_80jKPp+5Jb0Rda9zOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731-pwrseq-vote-rename-v2-1-480357946e00@oss.qualcomm.com>
 <CAFEp6-3X+PCXZdEy1p47XUDs7cT16JDjt0=928Jjkeik_haaQw@mail.gmail.com> <CAMRc=McA3BqoazxvGDu1_WoT9x0ujXT_80jKPp+5Jb0Rda9zOA@mail.gmail.com>
Date: Fri, 31 Jul 2026 06:27:58 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdA6dTDvp=kQ+k2Jf=kyZBK7VTJCX=0Qvq2MOvQVOQDsQ@mail.gmail.com>
X-Gm-Features: AUfX_my4-vcUkFt6J5bi893LfoyHoVCDYEQ_iJ8oHk7wCMSuijA_BdfQPo-2B_Q
Message-ID: <CAMRc=MdA6dTDvp=kQ+k2Jf=kyZBK7VTJCX=0Qvq2MOvQVOQDsQ@mail.gmail.com>
Subject: Re: [PATCH v2] power: sequencing: rename pwrseq_power_on/off() to pwrseq_enable/disable()
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti <luigi.santivetti@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jeff Johnson <jjohnson@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chen-Yu Tsai <wens@kernel.org>, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-pci@vger.kernel.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Jul 2026 15:04:30 +0200, Bartosz Golaszewski <brgl@kernel.org> said:
>>
>> Nit: s/pwrseq_disble/pwrseq_disable ?
>>
>
> Ah dang it, how did I miss it, I test-built it. :/
>
> Thanks for catching it.
>

Ah right, makes sense, it builds fine, it's just my sed script was wrong and
renamed it like this everywhere.

Bart
