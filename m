Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6955388E7B
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394007; cv=pass; b=tT34+O2UfcmVuL3U3wrwYQY8TKWRoDGQDkPj/g6QacLk18hMI2WsNHtJGoGoxVj9m/uq9I3LJkvpdPeihcyTtTlvONLVNr/rqvu9C8JjACxth/zZsTa8peD95R/L9uAzaMrrpX/sKzBEGDH9+N1zZ+HxNp9nHbQ9RMpysRypRJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394007; c=relaxed/simple;
	bh=9zhdSL5TZ0+7QU3R0xnxIo4ImepctE4X0d6M5LPIqcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhYQsGu5/wiusSyJnc2m7dmdtmAjTP+KEUUdbtlHlSZYiPHhg7RH7yaWhQqwbtZmvj6HSVP0cNerwUGeIrARUMYvP7PREGu7kXhEhXoUngftru4S/NH6pujbI04SZKaTXNtfcTKxDeaPBQJ3N5SYlR/PB4b8z5BSLfHm8wJ/fNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NY5KiRfZ; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NY5KiRfZ"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-661b16ac011so3421254a12.2
        for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 02:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773394004; cv=none;
        d=google.com; s=arc-20240605;
        b=O20FSf7KZUHi7cYgc7xcQLiRyu2r92sIaFg53PjI1CpvLB+a6/SiZUZmIYz/5eFjb4
         JA6foHacVR3dQKvFvtIBf5qe2N2eLxXVZfSIqMMeUdUEJ6vkuXO1xRehKIybgZ08GzCS
         ffRji5WwVgY4eXmhILgDDNbyKHqQT1A0N/kjfKi68AK06WhMIQwsrH+N+2/D/3dN0MGU
         8kPLbnxnKIFv5Owbuo3d1tetnf0fIOpRXR3WLeJgg3C0otlMXU3IzrWXz1GL0u7i37FL
         okboqWMIKT68GDPyaMGoOWGJrpvHMytkj+JS1ZtJk3cOMoX2BHB2sAedF28DPHCurwhk
         uXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9zhdSL5TZ0+7QU3R0xnxIo4ImepctE4X0d6M5LPIqcs=;
        fh=T7uWcXCV6O/eE4GtnTykZ3+q30dH1fdDa/nVU4kjXWs=;
        b=WllH5LLaXXhdR1ZmJPeyuRYHZjxybALLvzKV4Nu95dsfChZPqRPMu/mFVnxpm6K0La
         vmLx33EXOfZ1nDMw+BpZPASaUXUJRaHLY/wzf1HLUCS1+Vzm0Cp2OMLQeerKqAoN5WM2
         LT0nfzD6Mbpddy4DjeNBa0cMj8nzmkSQlZhaLQCwh9uy6vZ/eL+oA5/I6vVR4VwwssCs
         4S/cH7pIVpq2BeKLQd02daRrY7ZtFKOfTQ8NWuFseImtd2OEXvBgmSvPOTrkMr2tDt9O
         iuAkB7cBU0wm2srlMbdvU2uqRF/exSJG2GYNsYp7HOpLa7epjkKzRrSpMeyCFX7zxjE5
         invA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773394004; x=1773998804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9zhdSL5TZ0+7QU3R0xnxIo4ImepctE4X0d6M5LPIqcs=;
        b=NY5KiRfZQA5ozvJ77ADkag8VKxVG1ZSTm7a3kRieZ0fTnep6uoKzYoti6jjvuhiFwR
         bPGQEBzNF9BxRYcXOpjX8Xy84tDjc4PNCYBsxTl9csApTS76YfXz3Ud675ZDBcfq2VsH
         LUK3Yy1X4X6QOTB3KY7saZCcWtoeI9eWWq5A8NZ+eFmhzizqSX0VUPHsf+U6zf3AFsU9
         8Ch+7+aTU5iVCAxAePmrn3bsc9gBVBkDXJCgFUEMpSvXRnIRpd4xmLFy84RmPmNOCM3n
         VjSk+6JU8Szzjh5H6Nkw6bG3z/H4geRvkd6HDPXvGOnrhHTDTg+2yfw5dwmdL7L/P1f1
         qurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773394004; x=1773998804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zhdSL5TZ0+7QU3R0xnxIo4ImepctE4X0d6M5LPIqcs=;
        b=X7lQcQxvAHZC/z/Joa2POYLYbYZvCK/MhB56ClsNhbJNdzWK+VtfTPNyybbFoDxNDr
         4DI/QLRHo/q7Y+ezYMuEHsF0BZjLI35w/oU8BT+Bpyo6wW48AHbkuo71nqEJI00fyPht
         XkDT34ybC2z/FT5E0nlph+1njYznUVhHsoGeNk/9jpqpFljlwRHgJXNroEiPbvVIVliI
         LGm1CO5z3gBshVjX5UDTcXFK7b1qj1CNSfJeJa46ye8W2CcnadhlvpidEYpVG1lZ0Mpk
         2Q5MvWFIhlSRsZx6zHieqr6lKwcaYjSJkJ7flf4zmaBPM8sL4NvsafymBJOE5ix/iK6E
         hzkA==
X-Forwarded-Encrypted: i=1; AJvYcCXdSGy6DKnZVOkz+PH88qST8ntZEg6i6A1fjjMOiC1DM840tXAaFZ0PHN/OhgSJz2B0bZJNjZwXcIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCx50sFQAbLQ+QmZFeKBT/25MrFoth6ncXgjyjxhnhvWOFdz8f
	h6MN+EWIvPQqcA80ab7aqwydSSHWJzQ0xOEbg1ax04xlFkFEw4XgbwKzs+xEjgOTjgWJ1LuFpxn
	90UBDMBctVWuQ4OY9QVBsvnIGYx2bopI=
X-Gm-Gg: ATEYQzzIagUhqUDCNMVpyr7L998oSBknUl0mruTM3uvvlP1e7LAZMthWQX3CWX9/5M4
	kPUMWIeAc6B915+EunD0kl5MGnFv5QR/zTvTY7/tR1S+bQprYM6EiqYavK+ugYYSS9d63uAU3R7
	sPaGcALyZPGtyI9nO7eM0LixD9bW2HBso9eEclDoCcHaPJ68kWH4uxK2LVwkqOAlZ+0NFvwxMnM
	q3WjW7gYNvEsAugBv0MHxQapZMum0pBczL9XAp5CYiAuaivOZPjPVRAAQ0/kWcgrJXE91ab256x
	LvNjQg==
X-Received: by 2002:a17:907:6d24:b0:b95:53ff:5e00 with SMTP id
 a640c23a62f3a-b97651ec2fcmr160615366b.58.1773394003605; Fri, 13 Mar 2026
 02:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226101032.1042-1-linux.amoon@gmail.com> <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
 <87bc37ee-234c-4568-b72e-955c130a6838@arm.com> <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
 <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com> <qwanhqrpztzkudik5fmberhabnzaly7v53677dohqzj5nq4wi2@6ndpiubyxcbi>
 <DGZXF3LPSRK6.2QYN63QTKUQAX@kernel.org> <cp5uktfqdf6zs53qsye57ior2ikmssgevxxdtevkzpisaif22h@7mrxspkuibow>
 <DH09EDBW3X6T.2996UB1CFCAW2@kernel.org> <7b5592e7-8a9d-2cf0-bb3e-e306a6337165@rock-chips.com>
 <CANAwSgTaZqsHYXD_ACkJGGLgk4knc7N72f4qrJaaenE-cXM8BA@mail.gmail.com> <DH0S7TSFKDJV.2YPSBH9F142LL@kernel.org>
In-Reply-To: <DH0S7TSFKDJV.2YPSBH9F142LL@kernel.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 13 Mar 2026 14:56:28 +0530
X-Gm-Features: AaiRm53rZCLp_kErJJxBMXMWmeLwePiSPPATSICps4w1XibNQCvpnT-mxDnWsvY
Message-ID: <CANAwSgQCQ4z7p7Z8qe2mRqUY7zKe0w0wE+1RfYtD4NePzoit3A@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
To: Danilo Krummrich <dakr@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Niklas Cassel <cassel@kernel.org>, Hans Zhang <18255117159@163.com>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Grimmauld <grimmauld@grimmauld.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	driver-core@lists.linux.dev, Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"

Hi Danilo,

On Thu, 12 Mar 2026 at 17:24, Danilo Krummrich <dakr@kernel.org> wrote:
>
> On Thu Mar 12, 2026 at 12:40 PM CET, Anand Moon wrote:
> > I've reproduced the issue on my end. Following Danilo's suggestion,
> > I used PROBE_FORCE_SYNCHRONOUS to resolve the warning.
>
> I did not propose to add PROBE_FORCE_SYNCHRONOUS, I just noted that we should
> not force all subsequent drivers into async probe() by adding
> PROBE_PREFER_ASYNCHRONOUS before the issue is resolved.

My apologies,Thanks for clarifying. I misunderstood your point.

Thanks
-Anand
