Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C838D440A3E
	for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 22:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790373971; cv=none; b=YTkENeONA2lEGhe6EYbz9lcJh4qCyUHxLCd5HikseR3M0wd45IQpu/DV7W52O7bD/VjwDrP3RpbI1FoBDyeAxzOvPjX2D1evUSASe3l0DAxXk5LC/8UBePwoRs6cjZKX+WQLyPo/waP7h+yjTF6P5ubSjXlVSEwmrRyP/8IfksM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790373971; c=relaxed/simple;
	bh=eUT08NXlal1aio0O0dE8v8ucqBjaWELZBPGpyOtKUBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ed/a40jDaTUdYAwJV/Lb5ui1joUp/4YbsEkUmt8FSq0Wy4AnXH50iP3uEH/4JlNF+0+4X7wOWrjFmi4Xelb6MBkYQLTlpKMCOQhmRFM8hdo5kMHY3lJ3FryDZFQ6jLqYjMbN5wqcKXtmq4jg07fqUAONrn1qMjkhfC8v8gK+rtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpnDVkLH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpnDVkLH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4DA1F0089F
	for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 22:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790373969;
	bh=akTRCZfxAXfNBZ4KIMjBWZ0psXD2E8XGJgCbxx6huPQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bpnDVkLH6BOz1wKCo+BfK+BDWZG4qIUGh1duco4Mi+ieKVKilMXGrfIWpP+H5hYgn
	 m1ZBm5RBiB5okwKg+8BtTKr3rVGJstMFDa76USW17R9sH2FTMfVwsLWlnV+wpzCGug
	 gPsQplEVfpBjYmh5q5PUXU9KLx70SgWBlEEf3Iq4SfvZBlU/bOKrmu6XSqTzAPDhxY
	 WBT3Q7ByU0yxSVLNOaArZrO61/ZgnRtdFEI1agf37jShUM/Ukltw1NvD7Q9523UsGB
	 MEe78bqyD3rIWaRIl+b2j+QJHs8vAQ4R2W+6NxSc0SnAn3GF+j4tYGPsp8M7egnOXX
	 i42xmdzi2JQ5A==
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aae1f2cedfso1731357a12.3
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 15:06:09 -0700 (PDT)
X-Gm-Message-State: AFuF++mgTBqtl36Zw17HCX4a3/mgmcSn7Zj+40YJkuo2cNldn+y6Kk5E
	7ho7lrQS+eD43WFgZ3vr/9TVc56MtaN70LlXpuL+6lmNdgTiiGZJ3ufmwx0AMfy3vvBO0/S6RE6
	YPNlUrlgRzpsp25oUJYK61/Au7YL7cA==
X-Received: by 2002:a05:6402:44db:b0:6a5:f4e6:eba5 with SMTP id
 4fb4d7f45d1cf-6aac8f40c2dmr4924503a12.2.1790373968114; Fri, 25 Sep 2026
 15:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925203039.110653-1-marek.vasut+renesas@mailbox.org> <20260925203039.110653-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260925203039.110653-2-marek.vasut+renesas@mailbox.org>
From: Rob Herring <robh@kernel.org>
Date: Fri, 25 Sep 2026 17:05:56 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ6NhVEDBZqwvr4TRFMK36v1K9n+_WysCRDQ5mkEpTV5Q@mail.gmail.com>
X-Gm-Features: AclHuK9aAl_Ukdn4jihhsX1vhjj4xdO35vUAoCJf1jNcqM3HZNsoFnZOqj1ZOcY
Message-ID: <CAL_JsqJ6NhVEDBZqwvr4TRFMK36v1K9n+_WysCRDQ5mkEpTV5Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: PCI: rcar-gen4-pci-ep: Fix reset-names
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 3:30=E2=80=AFPM Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Drop maxItems: from reset-names, since the entry already contains items: =
.
> Fixes the following warning detected by DT checker:
> "
> Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml: properties:r=
eset-names: {'minItems': 1, 'maxItems': 2, 'items': [{'const': 'pwr'}, {'co=
nst': 'core'}]} should not be valid under {'required': ['maxItems']}
>         hint: "maxItems" is not needed with an "items" list
>         from schema $id: http://devicetree.org/meta-schemas/items.yaml
> "
>
> Fixes: 173cc7417848 ("dt-bindings: PCI: rcar-gen4-pci-ep: Document Applic=
ation/Local register reset")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Krzysztof Wilczy=C5=84ski" <kwilczynski@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
