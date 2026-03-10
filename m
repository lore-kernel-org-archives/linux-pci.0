Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD3E36B076
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773176210; cv=pass; b=HyZDjeZ8mbQJOw/HZjKEaUn5+MCWLs8n4nE6G9dJhcBKSUeKW+tWx7ZowIraOY9zUTWpwCHLe5Tw/+zLM9nRMNtQ0JiEOSROr0pux5fwaTLq4WjXSDRz0jafC+YKKcAmG1FBAo5z8OAv+Y3kU2cdJknkrhUGp8HBjYq6b24lemY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773176210; c=relaxed/simple;
	bh=f72wjpNgEgNamRmNtdbOQrlzEKRfJ3FmqBDUFz3IaWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnrxtMHPbuoSP0iaaxHYZUtMyLNzwcXCyPMx93WmBJh8ElGcr6OolaQSlAFnTLk5agpuA+LWLmlpefP2oKrc2i3/tRqFrENE7BaoZhHO9/P8AJFd16fn6js44TWIxS+AQ1Jp7Ss1tCo466AuCqKiV7vd04BqWljLiyBW6aUvQZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UD/qqksJ; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UD/qqksJ"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-662b42ca0daso3775177a12.3
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 13:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773176207; cv=none;
        d=google.com; s=arc-20240605;
        b=bPfCdfFA2dyMdKsjBQ0tRdsH7zj12Et65zB1H6PpQsrXwCsxbLVpTGy9kGeGE1WCMN
         XNlTOUeQkb75jYTJrtQKWVOJQSeRdLLDbN6AOu6wOcpMGlI6LO2S1REu388FZI1+AxAz
         AvkLqAHXAegO1BT6w0dS+8XR55fEQNfd61gKTdY7e/22Jmbuo/Lt20pA7YQCEiXKHaiT
         ASVVpzJubfFyXGW/+v1OLQnMgOryejPhmbEy1v9BY8E6oAn94eWLu9ppAgqZDcqyHcNf
         Pcsy5FyygPW4l07rcwRip14n3u6l8TOMIRSlp/j+mFyybCJndBYxPQnQxTToPDgikJm7
         thRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=92IQ3OxIlqXQ24Msh0zjAETeUAMXd63hfolx3FgN2xI=;
        fh=nvDGRlEaA871WPjK/4HHYuhzohh/0Gif/bNGOGTEwL0=;
        b=RYGfyhFtxb6G8BEUcwGEaq5VHU88nPppx6Bc7C2PQB55r4I9VLL3cMaUYKyj6hq/3N
         gVHOoqMXAaBqUQ/g5H5AFJpOr+lXLu61rFcBl2oY/Jc7IIIGe90YO4MoXuK14bTLxjBZ
         zZapdL5FrMHXsX8aM8HnLtDhP0zjqRwtqNXzxL1LgNRv7Fmst8LtWRgOmIv3mpS9KeGi
         jk2rCa4C2ZjBZr/iLOthf9QosHJraHg0IXYWRe/uIFkOi8Svh+jyMN5Ta425t4Qc1dsI
         I/Ez76AJm+suxBqzyohW76uQEnH1KUqx9WzOdeFRx7MDNoqirgR+/+k8Ru9Bbil2EX+8
         IYKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773176207; x=1773781007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92IQ3OxIlqXQ24Msh0zjAETeUAMXd63hfolx3FgN2xI=;
        b=UD/qqksJzgavFsVsLg5YAUNFvficMKnmG9qkqDUuYdwPlX1WGPn7chiccf/NiyRvCJ
         ZYeJRr9CrYNZnsi1rZdLxNo8CvbSYRFQUU4mMUt1kUjjZQl17GKJrccPjEw7HI3KYEfz
         xEYWlU+zVu+sdV8TJg2o1R/UwDMgyHZkkXrr9taoJ2jsvQdJAQRoceMhaf5BVzFje48S
         DaN+3CHEUJS2AjpxcdEYEcEa8EN/904lrUQmfVbKAJjprF2DMbk/TbxUBzvooLpZbBAk
         EOCjilRVEQnwEhZlDkRvJgqfQI5bV9dF1Q/B9UFSxM8IAblK0VLICRDbgVYgl0Pv5IPr
         1doQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773176207; x=1773781007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=92IQ3OxIlqXQ24Msh0zjAETeUAMXd63hfolx3FgN2xI=;
        b=t12h8em4Z5TsrU8hkmGmQGanJT/LwJmHU7EHm/tUnrsM3ZiiTGLwn3MvU7xjSAQXB6
         BNh0CPe9CAZ/aMH2dj7D0CmTH4KwpzO+tY4t4Z7pT3lypZF2/MWUDhSuNWUBaTVdHEUO
         LJylo8FJWSbmB3p4k9WCbYKz1TtlhDRdnhn5uYxamrwBQZnP/ifWO7jtriHSq2LX+OfO
         lp64oqoVDaF3cRUL3ADdarl30QaKECpls3yUxRFUXNLpt3SW4M2cTuTp0QrFx71Xzpaq
         MA8pzOplaUd+zc6kz2nigYea7XhWhJ4LfIt1KLwMp5zG9IouD50wcYNNdeyfY3O6Qfub
         7v/A==
X-Gm-Message-State: AOJu0YzraZU/j+RZevSH7c3zPpcRZ0ZNKlU20rurYh+IH4TkCgEZpa79
	bvthsPJGaKAwLBc1AESKriEIbSe6rtNLObuEHP9Lhwb855Mj/tk8IjNLwvPjTV0nRYihM2UPZ9g
	4eN5ut/b1JVd2u1LOdj+fB17dR9zSbMoReeYJFmU=
X-Gm-Gg: ATEYQzw7WO9cc9lkAEuNT5T3CUL5GTFt/zeWSDD/AC7aJYnR5OAclqJ9CoYs/yASzDw
	Smr8OexEFnGFp1NpLRjDi6u9lg5ZV19IFtRGmlLWajrBvumyygvMJ2DzJ9f47mxkT776aff6uXS
	ZohfwdL6e+RCFOHEOMff8Wsda1jwb8Nh2T7Ack1nx7WjgOxSt/c6YMy8qUBnChTR9ysjLd+xSNW
	1Og0J/xcxNTEiOPQ9ShoLYQJZOTe0hRbODJqbx3PgfymLbzJtEZyUPvObKWh2MQoAkolq/msSlT
	TT5D861N+038UFVJU5wj9rhOOhzB2R6Ii6ctKc+y9fKcxtfwarJ5uAcmf5VP8L+4nCZxuArguEU
	LexNmlf5utC7VzU85hHMT2FntMKbHzwkCSWDM//JU29VB0VR3xBQpdfb2Y6xlvt2TlORJCMVgsy
	nlFwB0LZ+k1o0mnjwniYefbCA8ReMDVYUT7RMBVQ==
X-Received: by 2002:a17:907:3e86:b0:b87:2f29:2060 with SMTP id
 a640c23a62f3a-b972e22efbfmr146166b.26.1773176207000; Tue, 10 Mar 2026
 13:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bug-221205-41252@https.bugzilla.kernel.org/> <CABhMZUWESYKvKxeRvXhF2gkXxAakV0zWR4hjE=50-teHRLLgug@mail.gmail.com>
In-Reply-To: <CABhMZUWESYKvKxeRvXhF2gkXxAakV0zWR4hjE=50-teHRLLgug@mail.gmail.com>
From: Xifer <xiferdev@gmail.com>
Date: Tue, 10 Mar 2026 13:56:35 -0700
X-Gm-Features: AaiRm53R2wRVF-YSEWhR5i2qB54lEIdisToCNlyHEn93bJtGflsdvxZFgcsaSns
Message-ID: <CAFuFVQp6DOEF90YO1OB7UyzKFW2b8ZDEZtnY9B5V8cjmzL2dZQ@mail.gmail.com>
Subject: Re: [Bug 221205] New: pci=relloc fails on 6.18.16 and 6.19.6
To: bjorn@helgaas.com
Cc: Linux PCI <linux-pci@vger.kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your quick response and help.

I've attached
dmesg 6.18.13 (working)
https://bugzilla.kernel.org/attachment.cgi?id=3D309614

dmesg 6.18.16 (broken)
https://bugzilla.kernel.org/attachment.cgi?id=3D309615

to https://bugzilla.kernel.org/show_bug.cgi?id=3D221205.


On Tue, Mar 10, 2026 at 9:46=E2=80=AFAM Bjorn Helgaas <bjorn.helgaas@gmail.=
com> wrote:
>
> [to Ilpo and linux-pci for visibility, reporter in bcc]
>
> [xiferdev: Sorry about the regression and thanks for the report and
> debugging.  It's best if you can attach the complete dmesg logs
> instead of extracting just the things that look related.  If you can
> attach the dmesg logs from the newest working kernel and the oldest
> broken one, that would be helpful as well.]
>
> ---------- Forwarded message ---------
> From: <bugzilla-daemon@kernel.org>
> Date: Tue, Mar 10, 2026 at 8:01=E2=80=AFAM
> Subject: [Bug 221205] New: pci=3Drelloc fails on 6.18.16 and 6.19.6
> To: <bjorn@helgaas.com>
>
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D221205
>
>             Bug ID: 221205
>            Summary: pci=3Drelloc fails on 6.18.16 and 6.19.6
>            Product: Drivers
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: xiferdev@gmail.com
>         Regression: No
>
> Created attachment 309606
>   --> https://bugzilla.kernel.org/attachment.cgi?id=3D309606&action=3Dedi=
t
> 6.18.16 pci errors
>
> I've been relying on pci=3Drealloc to get an Nvidia P40 24GB running on a=
n Ivy
> Bridge system with DSDT modification.  This system also has an Nvidia 107=
0 8GB
> but that one doesn't rely on pci=3Drealloc.
>
> Arch updated linux to 6.19.6 and linux-lts to 6.18.16 recently and the P4=
0
> fails to work on both of them.  dmesg had logs about "can't assign; no sp=
ace"
> and "failed to assign" (see attached).
>
> I downgraded back to 6.18.13 and 6.12.75-1 and both work fine again.
>
>
> Perhaps the problem is related to this recent change?
>
> 6.19.6:
> commit 5bd7c96a61cfa147b0039399f3cd7ec8e15f38c5
> Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Date:   Fri Dec 19 19:40:14 2025 +0200
>
>     PCI: Fix bridge window alignment with optional resources
> [ Upstream commit 7e90360e6d4599795b6f4e094e20d0bdf3b2615f ]
>
> 6.18.16:
> commit 995240f823a320ecb16afe0429b23793145dfab2
> Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Date:   Fri Dec 19 19:40:14 2025 +0200
>
>     PCI: Fix bridge window alignment with optional resources
> [ Upstream commit 7e90360e6d4599795b6f4e094e20d0bdf3b2615f ]
>
>
> Happy to help test and can pull more detailed logs if they'd be helpful.
>
> --
