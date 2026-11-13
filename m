Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586665;
	b=lGUeFjer0zQfsINskrAlWdoOpQnUYAehmy3ha+e0ZrcbzCR0GBlILrC/idBOtrSaMmj8
	 6x0WeTuGc/1JV/JOKYoH8fVz4ksHsW7kNX63BmMUlAYcz24tkCXI1ENRK14ILQyHjH/rx
	 GZscKwbbn700Z7i+JmKh4nWbVy2XYbPnZ9XSITRQus8ds3CCyAIPP/29Di4pqeNu2V71i
	 i3+obVl2soFit+RstLvGhjlHPdEtwURySrzJhaO9VanXI0i1uz+quQ0JFrEg0Ys7nak5n
	 8YSN4NZBbZdNeR/QIDWQsLmKon5JHx1sj5oL87PIolrlnF8skfgbCzianySot7z02PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586665;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=07DDAqi5jXuAZ5tD6WNu4TNE10HQBGSmuS9KSWqF5f0=;
	b=J/T/5lsS77tJZebOKFXJvBcLZMF+tfDy5X4UES7EGcc3JNYf3K/8XB2KDhTddZNo0gUg
	 YYViVvCuTGxuihAytJ0nxyP5UIUQj303t3v48BBkPJEXTBMhFvr0E69d416ub8k1L8vfC
	 sKIcaTiymlAl6cMW2tnaFoJK/Pu1jwZJWTn6tyw/JZr7hAbrpffBEtKLeBhF9rVknYbnj
	 LK+ID0rEMAajWP8fk365LVU8PhU4yj4IBaXbe2CQA2v3G2bPz4gVIabRO/enzBrcvOiW3
	 idVQgMm31QuFeHKJLPeN2mS3XejWM4ivE88m6lifVAkVa70Kw0hRG/tf1QM9/S0IyeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UP3iRfnN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA789606B5C4
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UP3iRfnN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86D41F00925
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 16:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794586665;
	bh=07DDAqi5jXuAZ5tD6WNu4TNE10HQBGSmuS9KSWqF5f0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UP3iRfnNQrQGSiNIp6w+6flT9KSUoUMKC0Z5owz+KWHvq+o7kwFCw34OanpEGcufS
	 LhCj1yLWeHggKugNkQGiKAEqgG3h52h4cHDaIuqQn9Zfq9r7r6LPTR5vzjPtl4B2QA
	 BelwHsJJJbcQu9eYuAP5LkLrOyIRJnRmAo2xCJSjQxZ8SW3PESdWCKHc4Yepar1ujo
	 YP5GQo80I63bHz3Sq7um7txMqk6jCOesu8ZnB+tz23IodrTiUk4qPBRCzgPztImjAe
	 EpUZljGI+IJgOxbRNxTbrkbWoFp/e9pPPZDVrWhFTI/h+yKDmPQTFXvMvI76csYJnp
	 uefCeo9JPBSRQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3adfc004920so17282991fa.3
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 08:17:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFuU5emDVkLJOg02+zpGA5Pgde0vM0Uf6Uj8LtGibU4l2ZkQ2XgmeenzxdEsGD6vlWoqINd96YGaZk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8JCMg/BmodjstSdfnaBvWO5L1LIz5uved2ZxqUlRWYoOrwokYB
	hAFNwyZ/fWVs1U0og+kuuAq9jVVEnRujh/zm9T6a4hJUbRQsHk01hWmtwmXbkKdr/I7NAhU15Pt
	d6Xlrth0HypvAXc1IvN+/GNfir7sXYtc=
X-Received: by 2002:a05:651c:41d1:b0:3ab:1207:bd2f with SMTP id
 38308e7fff4ca-3ae2b4bad8cmr14071971fa.11.1794586663709; Fri, 13 Nov 2026
 08:17:43 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794567577.git.ukleinek@kernel.org>
In-Reply-To: <cover.1794567577.git.ukleinek@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 17:17:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jC5YXsLgB6Qd55KNCU0oCsN86X5WpRfL+Ycz0MJ8vGqA@mail.gmail.com>
X-Gm-Features: AclHuK8x25sOZXVMSbQCD89ASNTaRnpnKVCTik8ql8SNDsY_N4yuXW7y6aXTE5U
Message-ID: <CAJZ5v0jC5YXsLgB6Qd55KNCU0oCsN86X5WpRfL+Ycz0MJ8vGqA@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] ACPI: Use named initializers for acpi_device_id arrays
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Len Brown <lenb@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Ira Weiny <iweiny@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Zhang Rui <rui.zhang@intel.com>, 
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

On Fri, Nov 13, 2026 at 12:14=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capable=
 Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> From: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
>
> Hello,
>
> this series is about preparing drivers/acpi for a change to struct
> acpi_device_id. The idea is to replace .driver_data by an anonymous
> union, see
> https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre=
.com/
> for more details. (The linked example is about platform_device_id, I
> intend to apply it acpi_device_id and several others, too.)
>
> Before this union can be added, all initializers must use named
> initializers (C99 calls them designated initializers), which IMHO is a
> nice cleanup that can stand for itself as it makes the code easier to
> read.
>
> Pawel sent a similar series earlier, find it at
> https://lore.kernel.org/all/20260727-acpi-refactor-v1-0-ff900aa326ee@theg=
oodpenguin.co.uk/.
> Compared to that the patch splitting is done differently and the base
> here is newer.
>
> I checked for the other *_device_id and for these there is nothing to do
> below drivers/acpi because the few instances already use named
> initializers.
>
> The last patch in this series is just some cosmetic to align the coding
> style. If you consider it churn, just drop it.
>
> It would be great to get this series in soon, as keeping it up to date
> for a later resend is an annoying effort. Thanks for your cooperation.
>
> Best regards
> Uwe
>
> Uwe Kleine-K=C3=B6nig (The Capable Hub) (4):
>   ACPI: Unify acpi_device_id list terminators
>   ACPI: Drop unused .driver_data initializers in acpi_device_id arrays
>   ACPI: Use named initializers for acpi_device_id arrays
>   ACPI: Unify *_device_id list terminators

All patches applied as 7.5 material, thanks!
