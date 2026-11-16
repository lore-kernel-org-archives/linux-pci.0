Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794852963;
	b=WYZpa0uZhEr4FiEZx/M7jqTGePJgZzlqUhqLpJz6++FXg4YPT07Ah0X7IHbY6sETMp/e
	 l9KGgPBEsgvzW6kGQr9QxXBJHgm6lPDpv8g5H7e4GzRIpN6/TMfFarfIsxZ7YaPzKHcTL
	 DiHke4aUMVPHlpp28QcQIiJDajBQxGyStmZunpnR9/kP4xO5tVXreV5Fygwq+cHHgbZ0v
	 PRR5MBasI69Z5kOxt6Utx6WoalZtf8fHoX6JAZTTz70MQg1iYqHfsJbh8nZgTmy6/+WTn
	 fc5gODByI436yeeb+0PNS2ywKqN5rD8i/8aDw+Pw4Gqp3ONoT0PWUOKQEyH2uq1su1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794852963;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZzX9V4TTBmSlkYz6J8Lbn80e+REH2S26Di72JYTGVqM=;
	b=vPDIG1CwVPicvfO157kJexTxt9BJUPpKJM85IsthpbxvHksGOQqMQorb0GfyGnd/jhjd
	 r0NNebP2Sk20dXqaPPOlO1UrsRD8MUXRWnyP43rGxgSMhAxDcFf38RT8OLTscgwjc+1K+
	 CZUUoOX3kPpIhdnNXHSr53U+uGeaLYtL65cW6Yq2Oxt5BiAn1lkHg+exwXGv5c12h60Gn
	 xbx/aRu52gAojYzkbiq9g2D4Q9OAq+V9EXdGaVf4HeOjUae3MTZtkFLFbGFlke3jl/LMh
	 kfUWvgYPqjLNHraJz933UgNjuFrTbMTvxWuXwDD0SYThfNvgnEuj0GMq+8I1vRGxqNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCzVDl+y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FFD606A329
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCzVDl+y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24F61F000CF
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 18:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794852963;
	bh=ZzX9V4TTBmSlkYz6J8Lbn80e+REH2S26Di72JYTGVqM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mCzVDl+yp3QvxGGoIjHphlloyP6gjkTnuxpM2RxkYOo/ep9guqhucHVwPPvPJGxNA
	 rtFCxx/KcWPxELoKUCqQmsifn4XZnuibROwGxzkD/eROMt7okJNbOUHiTSzIBS10BV
	 iuGOXWSM0bno7C9iqM5+X7rB12dJ0XEvDTdUkNPDfd1Bywm3i/KWbUz3xFxtgJwV0Z
	 NgBEGKNWYmWkeEf+0x6MLhZ1voYpMXemD8SmaBqjrLIHfzV62AEbTTrweiex8JfjNW
	 TTrx9UjJQhRWWpos6Di4eagD4qqGz66bOjSOLYQKSq/os5JQJki75W1b9OapwBZIsY
	 td6rcOdbZlyTw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3adfcafaabbso38979471fa.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 10:16:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE5GK9rM4Kiss3kAXobKKgB/hwtBgWzSUqzEufndaaa3scFI6U3NIHUIhrd5vuoRWhH3RBPSAtxxwI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+XY4BocDSEcjilxMJfYSZwc86FzUV+BarkTL2oSt63wN2Q/Lw
	svyJ9ypr4qPWOSdHO6SMF2GIiYKr1KtKmdu5mAi4EHMzkHS0IBuq7rVuguiJEJKlEjolnE66wzA
	wi3ycqPa25lbmIjy18Jkdaol4YHHqFwA=
X-Received: by 2002:a05:651c:e0a:b0:3ab:3bf3:1604 with SMTP id
 38308e7fff4ca-3ae2b522732mr39554201fa.26.1794852961071; Mon, 16 Nov 2026
 10:16:01 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794567577.git.ukleinek@kernel.org> <CAJZ5v0jC5YXsLgB6Qd55KNCU0oCsN86X5WpRfL+Ycz0MJ8vGqA@mail.gmail.com>
 <avs5thXfoZA4TBnE@monoceros>
In-Reply-To: <avs5thXfoZA4TBnE@monoceros>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 16 Nov 2026 19:15:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iSJVszOCLCuK+ifCzTgx1RgDAExaYUbij=jaWmaTsb8Q@mail.gmail.com>
X-Gm-Features: AclHuK94GxXVADZ_eYaxYKF2omkpVW60DdECEGw9yQWKt3TSZ2-Rx4HqR0isNuY
Message-ID: <CAJZ5v0iSJVszOCLCuK+ifCzTgx1RgDAExaYUbij=jaWmaTsb8Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] ACPI: Use named initializers for acpi_device_id arrays
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Ira Weiny <iweiny@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Zhang Rui <rui.zhang@intel.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, Saranya Gopal <saranya.gopal@intel.com>, 
	Gergo Koteles <soyer@irl.hu>, Jakob Riemenschneider <riemenschneiderjakob@gmail.com>, 
	Yauhen Kharuzhy <jekhor@gmail.com>, Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, nvdimm@lists.linux.dev, 
	linux-pci@vger.kernel.org, Kai-Heng Feng <kaihengf@nvidia.com>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Chu Guangqing <chuguangqing@inspur.com>, Andy Shevchenko <andy@kernel.org>, 
	Mika Westerberg <westeri@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 6:16=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capable =
Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> Hey Rafael,
>
> On Fri, Nov 13, 2026 at 05:17:30PM +0100, Rafael J. Wysocki (Intel) wrote=
:
> > > Uwe Kleine-K=C3=B6nig (The Capable Hub) (4):
> > >   ACPI: Unify acpi_device_id list terminators
> > >   ACPI: Drop unused .driver_data initializers in acpi_device_id array=
s
> > >   ACPI: Use named initializers for acpi_device_id arrays
> > >   ACPI: Unify *_device_id list terminators
> >
> > All patches applied as 7.5 material, thanks!
>
> While rebasing these patches (as part of my wip tree that contains a lot
> more similar patches) to next-20261113 I hit some merge conflicts. If
> you tell me where you applied it, I can take a look and provide my merge
> conflict resolution to allow double checking.

I've rebased a couple of patches on some material merged previously.

Please see

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/=
?h=3Dlinux-next&id=3D58d4ba8979133c41cd491dff1dab40626daa924a
