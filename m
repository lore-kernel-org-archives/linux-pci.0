Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2282332D0F0
	for <linux-pci@vger.kernel.org>; Sun,  1 Feb 2026 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769946165; cv=none; b=W4FOC5yVDmertJgC8yHh0jqK7D+OfpoHbTZCY94ZiX7pPpAMbseXPFN+u0ty2WgSaPAjYwuNmzS104TFw3xFRKE1DTTHYqDmfWl6XSAtOkgGttiTUNsc5n1GNwKkUY33ezNET/hjKUoisBm/7/yYUxeEW7kpDIxKulL1QcUjNl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769946165; c=relaxed/simple;
	bh=IT4JR0prKa0OCOwFNNDgH78mXPijBfUxl0EpG3hii7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSmECsJogg4WCnzIqb99+Nv2D/2uXgCR/nZq2lpcTO6eeuny+LLidms0OUlIXIlc3CCkYjGD/sxmxcEiYIFtoF+SOClcTP8xN8XfBKmIsmXuz4DdEHEalU3bw9ueEUept5LqPKupfVtWB5exDP2BHMp9yaQjf0h2Vf8wxnT0bvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXPB6nNi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXPB6nNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E05C2BCFA
	for <linux-pci@vger.kernel.org>; Sun,  1 Feb 2026 11:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769946165;
	bh=IT4JR0prKa0OCOwFNNDgH78mXPijBfUxl0EpG3hii7c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eXPB6nNi4rySZrCZdyaQsdojN50SKzueA6NYEJ0yP3LzBB6/7uSAKgRuifOrIAkba
	 +Ul0DJuh3dM3k4u4FFQRnOvvjq1KISyKGjahAsVWwDemaIWZ8M0Q5gd5+9PSTRvf56
	 RtEbz3fpJrhJxmC9lzPKWxdPaerjV1fEvE+tyeaOYR/ophfJQUjHoK8/Y91EjFYo1b
	 p0tTkHVaai3uRGt/Siu7HyqzXgjpTAEuCZJSLGecSuCL5c3MGcLjb6B6jZR0xAtA+j
	 CsG4V2QivqiDEWP1JyLXlvvtzdpel18pgJlj3/5KzqzK/LRy2XY7u1X98gQ+nJwPop
	 wGeJb2H4D1JmQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4043b909ed4so2251876fac.3
        for <linux-pci@vger.kernel.org>; Sun, 01 Feb 2026 03:42:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWWsC44/VOXZdt6oISDJlN/PwmXM8xGxDvEC5wBgYjGmSWNtp2U4584GpPtAUgOqM1dEzOd8+wVa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWNFx6PN9x8tLy1cBVSToPwzmYYHufYvlhruPxHM6oD6wfaZjm
	pI/DHt3MdmRpmSkr5HBVDUarV5u3WT3EEZNDbvSYhUGhCFlz85BdcgQViByJO6RshmR5g+RFYo1
	yoz1UwGtcvOAVrsT/YA6HFgWCilsfQAU=
X-Received: by 2002:a05:6820:2008:b0:662:f764:9064 with SMTP id
 006d021491bc7-6630f3850d7mr3448575eaf.48.1769946163562; Sun, 01 Feb 2026
 03:42:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113094129.3357-1-spasswolf@web.de> <87h5spk01t.ffs@tglx>
 <bc20529d7520e7db7de2022bf9c96a1bc3a2f0df.camel@web.de> <87v7h5ia3d.ffs@tglx>
 <99f1aaba32030d2b9285dbd983fdf8518a181a8d.camel@web.de> <82b4d69a5b943aa5e8aa7cc33fcc00bce02e557c.camel@web.de>
 <630a4020c87c122c004321971e43c334fd7aceb4.camel@web.de> <2a4e5667-ae24-403f-8fbd-cb37bd66f055@gmx.de>
In-Reply-To: <2a4e5667-ae24-403f-8fbd-cb37bd66f055@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 1 Feb 2026 12:42:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i+7yCP-H1snkd-+h-jqXa53fMyJ3bLB6H-1u+P-KuONg@mail.gmail.com>
X-Gm-Features: AZwV_QhE6FdYk90VCTuNf4rJKUHvyfE-AQ-aLS-eKFM9kup3-2BqSx_MCuon4vA
Message-ID: <CAJZ5v0i+7yCP-H1snkd-+h-jqXa53fMyJ3bLB6H-1u+P-KuONg@mail.gmail.com>
Subject: Re: crash during resume of PCIe bridge from v5.17 to next-20260130
 (v5.16 works)
To: Armin Wolf <W_Armin@gmx.de>, Bert Karwatzki <spasswolf@web.de>
Cc: Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	regressions@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, 
	acpica-devel@lists.linux.dev, Robert Moore <robert.moore@intel.com>, 
	Saket Dumbre <saket.dumbre@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Clemens Ladisch <clemens@ladisch.de>, Jinchao Wang <wangjinchao600@gmail.com>, 
	Yury Norov <yury.norov@gmail.com>, Anna Schumaker <anna.schumaker@oracle.com>, 
	Baoquan He <bhe@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, Dave Young <dyoung@redhat.com>, 
	Doug Anderson <dianders@chromium.org>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Joanthan Cameron <Jonathan.Cameron@huawei.com>, Joel Granados <joel.granados@kernel.org>, 
	John Ogness <john.ogness@linutronix.de>, Kees Cook <kees@kernel.org>, 
	Li Huafei <lihuafei1@huawei.com>, "Luck, Tony" <tony.luck@intel.com>, 
	Luo Gengkun <luogengkun@huaweicloud.com>, Max Kellermann <max.kellermann@ionos.com>, 
	Nam Cao <namcao@linutronix.de>, oushixiong <oushixiong@kylinos.cn>, 
	Petr Mladek <pmladek@suse.com>, Qianqiang Liu <qianqiang.liu@163.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Sohil Mehta <sohil.mehta@intel.com>, 
	Tejun Heo <tj@kernel.org>, Thomas Zimemrmann <tzimmermann@suse.de>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Ville Syrjala <ville.syrjala@linux.intel.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Yunhui Cui <cuiyunhui@bytedance.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 1, 2026 at 11:20=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 01.02.26 um 01:36 schrieb Bert Karwatzki:
>
> > I found the error, the commit
> > ("drm/amd: Check if ASPM is enabled from PCIe subsystem")
> > has been applied twice first as cba07cce39ac and a second time
> > as 7294863a6f01 after it had been superseeded by commit
> > 0ab5d711ec74 ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per devi=
ce")
> > This effectively disables ASPM globally after the built-in GPU (which d=
oes not
> > support ASPM) is probed. This is the reason for the crashes and loss of=
 devices
> > errors which on average occur after ~1000 resumes of the discrete GPU.
> >
> > snippet from git log --oneline drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c =
in linux-next:
> > 158a05a0b885 drm/amdgpu: Add use_xgmi_p2p module parameter
> > 7294863a6f01 drm/amd: Check if ASPM is enabled from PCIe subsystem  <--=
- This does not belong here!
> > b784f42cf78b drm/amdgpu: drop testing module parameter
> > 0b1a63487b0f drm/amdgpu: drop benchmark module parameter
> > cec2cc7b1c4a drm/amdgpu: Fix typo in *whether* in comment
> > 0ab5d711ec74 drm/amd: Refactor `amdgpu_aspm` to be evaluated per device=
 <--- This removes the code from the previous commit.
> > cba07cce39ac drm/amd: Check if ASPM is enabled from PCIe subsystem  <--=
- The first time the commit was applied.
> > dfcc3e8c24cc drm/amdgpu: make cyan skillfish support code more consiste=
nt
> >
> > The fix is simply to revert commit 7294863a6f01.
> >
> > I sent a patch for linux-next (unfortunately without CC'ing stable) and=
 a seperate patch for
> > v6.18.8, I hope this does not cause confusion ...
> >
> > Bert Karwatzki
>
> Good work! Thank you for researching the faulty commit that lead to this =
strange behavior.

Yes, nice work, thanks!

I wish all of the reporters of kernel issues were so persistent.
