Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D1C53C3A3
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174703; cv=none; b=kQAMe8YMLfq+LYlZfB0Ldl0rrWbqMFzueL/M+vSF6KAsP9bhiE+E5tLT+XnBQiYQTn34R5I/HzPkcqnevdkSMdt47zB0vtaaTqKltyPGhQLAg5TCSVuVKALd3NQkWqy6PsWUHytgh+qmjTW/IdY1Xp1sRomjYBX6OZlUTpv3FRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174703; c=relaxed/simple;
	bh=3TLe6kRKBSJnsibexn5+IiCkeA/haOJI1wirpsmGWwM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEw2LggG6CQzrH2zDsIXWmiaWU/Gkx1boDlfwwqaSELjfx2hB3PHCPEbANoZNRimdGfPayeNdxTZrfA2lv+Hitspf6IbK7vV7xrheh+7vDLGCxaJpHkFadIvGJ8e2FKHDXiXR1tv4hefFyp27qlT6ql7MbMblHMGDXA6OVMoIQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYd5SS81; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYd5SS81"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4DB1F008A2
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 14:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790174701;
	bh=3TLe6kRKBSJnsibexn5+IiCkeA/haOJI1wirpsmGWwM=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=eYd5SS81BwAfsi5uGZ8lEJkSn2MFrsWYjE4GtlvlMCPvkG8ZY59zvuDE4rApvetff
	 mvVzzfX+HBZKp0HX6Yu0qglro/iQpFWXxuwmG8C2b3fK5uP2jArNlZzUyHhzp9Fkpi
	 /S9TtqeCcxqycerIaPobX726MY2RwigqP3l3uaqOGyiFTGSZeFoM76T8kLelRGKgnK
	 mWDxKx/L10JXCKkXAjykYLxQvtG/Z8V8uNoSRchQX/KsiGH0HnaF9bsckWKreV7UTp
	 skF5MgsSRpxDOYe2HanOe/Sl16oO5gRsmkRWNKyf0MZsdhiU/AzvE+cYRPbMdD2WYO
	 H0fB4IwfTSu/w==
Received: by mail-lr2-f16.google.com with SMTP id 38308e7fff4ca-3a2ff176d5bso8010771fa.2
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 07:45:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzuCncF9/Rw6+I05t+Lq6N/6AyQ36D9JIk1DkpZ6y+fx9GTWE6/8Q1SmDPhgtDSDXopx+XZROFIxJA=@vger.kernel.org
X-Gm-Message-State: AFuF++ldvlxzEODXBmAN9K3Y9j+8L3PwTditvt9n2hDYddDV+vkpKDrE
	dIYui+ndTT3/cqh2LagIcnQ8FiAubZ40K7Goq+J7dwIn6j3r8mnOr3DOTJP72L+ZdUui/VUi7bt
	jPtqqKN3U9s+/ogkRPosFP8VcHyP1IcPBXoc292y48A==
X-Received: by 2002:a2e:a596:0:b0:3a5:f6e2:47d2 with SMTP id
 38308e7fff4ca-3a6306d0b08mr6707781fa.29.1790174700057; Wed, 23 Sep 2026
 07:45:00 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Sep 2026 10:44:56 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Sep 2026 10:44:56 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <fratyclnf6t232dg5s2kvsysw3gbovkwnrzfhnlblsax3wb6qy@debn6qdpp7jh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909-pci-tc9563-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com>
 <20260909-pci-tc9563-aux-v5-2-c9b33f56c8d3@oss.qualcomm.com> <fratyclnf6t232dg5s2kvsysw3gbovkwnrzfhnlblsax3wb6qy@debn6qdpp7jh>
Date: Wed, 23 Sep 2026 10:44:56 -0400
X-Gmail-Original-Message-ID: <CAMRc=MdG7utcnAhJrUxmzXJSesxdE1YwuiLOzf1dj3sCa4J3_w@mail.gmail.com>
X-Gm-Features: AclHuK-1NrbUD-b8prOdv3m_D16A91O6WyLEueGcB5ws0m81E_q6V2lDVkDKCTU
Message-ID: <CAMRc=MdG7utcnAhJrUxmzXJSesxdE1YwuiLOzf1dj3sCa4J3_w@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] gpio: tc9563: Add support for the embedded GPIO controller
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Alex Elder <elder@riscstar.com>, Daniel Thompson <daniel@riscstar.com>, 
	Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Sep 2026 18:18:53 +0200, Manivannan Sadhasivam
<mani@kernel.org> said:
> On Wed, Sep 09, 2026 at 04:55:54PM +0200, Lorenzo Bianconi wrote:
>> From: Alex Elder <elder@riscstar.com>
>>
>> Add a driver for the GPIO controller embedded in the Toshiba TC9563
>> PCIe switch (and the Qualcomm QPS615). The device implements 35
>> GPIOs using two register banks: three registers control the first 32
>> GPIOs (20 and 21 are reserved) and three more control GPIOs 32-36.
>> GPIOs 22-24, 27-28, 31, and 34 are input-only.
>>
>> The driver is registered as an auxiliary device driver. The TC9563
>> power controller creates the auxiliary device and provides a regmap
>> that gives access to the GPIO registers, so the gpio-regmap helpers
>> are used to implement the GPIO chip.
>>
>> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>> Co-developed-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>
> Linus, Bart, what is the merge strategy for this patch? Since Bart has Acked
> this patch, can I assume that this along with pwrctrl patches can be merged
> through PCI tree?
>

Yes, I don't think the rist of conflict is that great here. Please take it.

Bart
