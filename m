Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D002D7DC4
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408898; cv=none; b=jHcIJsxH0bWvfKEntjMb+ePsxaZvYhDRi/m7v3FKPndi83vBfAy5eSYsxznCA4kiXWABgH1S9f0yNjoyBopYixv3mN5DZmEl9/k8yk91amsnYfBguomjUxiLeZNVfyNeis5vyAC+USY6XsU8iaHLZK3urgWlBilaY8jUNcKDuzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408898; c=relaxed/simple;
	bh=m58O7PVPOQr0/+2MnMIyHDol0SFhNpA2733D8qV8B5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4RA5lHFXHZoU99cNGzRpAmDSKml7SMNVJlDxX2rBqqfnYsvjNAfKJJ/6BNqHEwd94aHlxbVejnCdN8LG8BjMcPP1Q1z1dte2MT7k4GJqUAOgWTVx0o2/NkTAEtNcRU1IX6xasAaNyAiNP6EGJRWppgzzQqd894AGHKDvOWSTRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBIWtVEa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBIWtVEa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2556EC2BCB5
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 10:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771408898;
	bh=m58O7PVPOQr0/+2MnMIyHDol0SFhNpA2733D8qV8B5A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FBIWtVEagYxNybbLeWFhSmozTuipcKaksil5psxnXXKZdeZ6TH1QB+vUnDzAZe2Eq
	 3Jr9UZKg0+Wm02q4UCDdV7yNRPCmqPpJJrFM6QYPNexflgnjrbU6rUWwXi4IYGPPEb
	 FzAduE8g5S3AzZ/AEbbZuolWfEd6LXqZGw4WuNkeOud+uFEyjTGHXV/QOO5h5qntgs
	 76TlLr2pfgNnzLry0jn8uafDfjMDItJSjHGRZ4Inqq6qxrohI15UmpwtHR6uRgszQa
	 uChviY2PLQ/sLRCfTlx/rx41TK11jnVlhCElVfs20ZbaNl3WHCYNNMQ8SvRJFsZxVr
	 DAxjEmVdTTTRQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59e646a4b9eso5548352e87.3
        for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 02:01:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfYKlCGDCv7rCMuPfE5VR9YecTDbR467ORpOHsEcj5yJyH9gW340IzfhOM8sfrrSoBleMIVj1vdQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiS8l0VfzwOoAeL1vDknrhvJhIJRIdHJ/ETPuhe4HGvAzn3m1A
	JBEV2FpJweKGqxVbEsHSNA8+4tW0Uonkc61PPwrEeBft1LD0b5d6kCKJ9zs27ED6rsrDu0BGE92
	NbXZr13s/ruDvAt5NxTkRjVC+E9kP1ZQ6V54NzOayKA==
X-Received: by 2002:a05:6512:39cb:b0:59f:6a01:c18a with SMTP id
 2adb3069b0e04-59f6d38d6c2mr5090738e87.50.1771408896561; Wed, 18 Feb 2026
 02:01:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218-wakeirq_support-v7-0-0d4689830207@oss.qualcomm.com>
In-Reply-To: <20260218-wakeirq_support-v7-0-0d4689830207@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 18 Feb 2026 11:01:23 +0100
X-Gmail-Original-Message-ID: <CAMRc=MdF92kriuT_-Fbk3pj6YeJiNv6RSiDE7aB0AKL9oFZg5w@mail.gmail.com>
X-Gm-Features: AaiRm53iJbAvCfNi8W89R1ZOmelHBmdb900XClGvZBpW4TQR7OEInUOA7xLLbTI
Message-ID: <CAMRc=MdF92kriuT_-Fbk3pj6YeJiNv6RSiDE7aB0AKL9oFZg5w@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] PCI: Add support for PCIe WAKE# interrupt
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij <linusw@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-gpio@vger.kernel.org, quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, 
	sherry.sun@nxp.com, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 9:12=E2=80=AFAM Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:
>
> PCIe WAKE# interrupt is needed for bringing back PCIe device state from
> D3cold to D0.
>
> This is pending from long time, there was two attempts done previously to
> add WAKE# support[1], [2]. Those series tried to add support for legacy
> interrupts along with WAKE#. Legacy interrupts are already available in
> the latest kernel and we can ignore them. For the wake IRQ the series is
> trying to use interrupts property define in the device tree.
>
> This series is using gpio property instead of interrupts, from
> gpio desc driver will allocate the dedicate IRQ.
>
> WAKE# is added in dts schema and merged based on this patch.
> https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.=
qualcomm.com/
>
> [1]: https://lore.kernel.org/all/b2b91240-95fe-145d-502c-d52225497a34@nvi=
dia.com/T/
> [2]: https://lore.kernel.org/all/20171226023646.17722-1-jeffy.chen@rock-c=
hips.com/
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>
> ---

This spans three subsystems, how do you want to get it upstream?

Bartosz
