Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FE937C0F6
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 03:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786073063; cv=pass; b=ZLHOBpgEHRh/jzuk9BVM4Af8Cm1ECjNVLcJTq8btXY8vp+LkkeUYGJotlKZnyz4JXtaTv9UJviRRuie2EuNOsrk1gtu9rxl4/lXhaLFSCPD5WkgOvGwIBwPILD9XV2KSlEhZdZIB8whDHiYdi+zcoQ98UNc6L7JzuQ+0cO1gmjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786073063; c=relaxed/simple;
	bh=DwhFItc7Uza+jOSDpnxs4kuIhVwWoyQzPZCblQUNSGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTlS8s5UQzGDcqhhGqeg0NCXK70KptgcdFyO4eD8KzCWrT92q1IPBj76awe+X3wOhGRKGOeLaa9SU2u19XNDhOljOL6fu9MCNPqVVdyrZLS0IXvJ1qvhIAL21Rtcm21V8rqSymyLOtK/B/VYETFnwhAMygoJvNbAgJ/8Q6/lr5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RT9LSj0k; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RT9LSj0k"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7ff05e5d009so34586407b3.1
        for <linux-pci@vger.kernel.org>; Thu, 06 Aug 2026 20:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786073061; cv=none;
        d=google.com; s=arc-20260327;
        b=nYjJOtdbp0EQbMzDW95Tfk1nNu+Z7gEwesBlfVO1h/MQ2kSLCC3dthdCpgbOe3dMXX
         8Gche9yPKX2Otx3DwFFGuNQCNYROJskbe1JxRA7QT1b1nH/7zPk4pGTJQZxKm3PZyWGV
         v50qxbCdtvhTcz7I5TgDF4Jr4yMMze6x+FiXWqe3ko/2tKoT7E4gHftOkf1zVgKx6O8L
         dBS0SAjNqiRUsCufNsXudxMBa/cE02JwwDiC+ULNp4raMiGOOeQiEXmfQKXYZJduKZY6
         PHd34TCHPT2IjiGNWpxq9Y4UyNQmYsREwW/FOxdPC1rjSZiGWnDNOX5d4Jr6VQsHDPAG
         fqtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2Rxym6s8p5fdNkShVSkwaV8afJle+IJgpasiGsN9DyY=;
        fh=/3KjEQEEPci2MYFTo0a+bNQ+6XObD9BVtkSVnXz9OGw=;
        b=Htto2k8mnubTrEd9rKnyrj8oMGK2c9n97m/PFiB78aPVE46obnPI86JPh7rweomhFo
         +m1Grqn7kY89Rk8ZP6KCPpZz6ZJtfhWmTqOUzZW1onhA8SniRncBNuvyT0IGoXOsl1Ih
         YlTkKRqoOnHeeRX4/iJuUNjCQ6ESWlmwJT02z/9q8FruMb+C1CjOWU5WyMwO17f+iU1I
         iwPaLHY6SA10lW1MxcM9jZBCkcjZVNj29TCNG5YKefN9Xp0Zsi4R5Ik8+LbNu9D20Sba
         0fqgVKSG31O7hvQIyBXTLas4722jRK1SNoAehjPk72ZHJ/qon9UyK2Inhaqdlnvyumw6
         2pEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786073061; x=1786677861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2Rxym6s8p5fdNkShVSkwaV8afJle+IJgpasiGsN9DyY=;
        b=RT9LSj0khGrH/Q9IfIU54pWiJe2KWnNA6vNrqTexJD22Yn3k4e/Az8AVvYWBjbTnve
         TtPhSE86a1mpfoMm1xdKRCTOpIs1OVaM5+EeTVkBmzKW3nKKvfUKj+UitccXqkGjL2KQ
         xSUmsOVS8qU2mpoSasH/v6VhWLFysy5Z93jAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786073061; x=1786677861;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Rxym6s8p5fdNkShVSkwaV8afJle+IJgpasiGsN9DyY=;
        b=nwZwfCy+0KB4iC0BhyWinCLLI8gNuNekuTxhCMWP61EHNCiL3EPSLsviJfA8/1nSYH
         ygWi+6Th0UAaX3qkpHryOxSp6YDbB7Q5Rm6BYdFRmoZAjZw8PQKcIQy1DfNGnyMOLoL+
         GnMgMMyzjP5v6N53werfdLhIyJJTArjhdZ+HJkTWbFqaeq7a5AfK495wnewhQpKgOlzP
         CxaVejqbqSLLZBiJoVMviXGW5/o3JZrtvXJBjBespUxGT9j2vAYx0CheF4nW44lOJkHG
         ieue53K2YXsI163HLgkxOqt3FpyI0/vAUAtp7yTzl7h5BHzN4atF6cWLI6ycnD4Rfgam
         Q5TA==
X-Forwarded-Encrypted: i=1; AHgh+RrNSkPric1UedCM/Dl01297r497sNn0c2QshwyxGzn6IoUWJ0aMrlsagk7FD4dDn8KSB07r2jsr7Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZAmaLhwXWmWbCrTGM50LppGErCJFjjaVPzqbX/KtDjKmuUk+o
	2fZQAlNBnh7ks2QgILibWjiR6pi550bi6xH9g6DWjvDYzQ2EU7tF0MIFsgioxetfOiux7f/6rsl
	Hrg1No6ylWLkNoGeX1fTO42A/CYjZ0PSBQj6nW2cY
X-Gm-Gg: AR+sD11FN2kqGZeCxAL8jtT9VCzoKmYSIyjEWYvr649f0WG5hU5wviud9M0rJttEEsT
	q+FdmAcgP74vde3oGShCA14+kVHBELoQCN00bicbJBFSoIWHKgsxiT0+ODxxnDxVqo05850dgbh
	eNt+FuG1qW/6KTZ4NQFmnq5DY/irwvG5/UHa1IJKH9eDwIH5iBZ1g8SzvpsmMqdpp+gp+41Qa0s
	/NE8XnCDVB/vlrutgW/j8gklRois3lKmfdJxyK0f9aF7Xgy2r/+OUYs8mCGP39R3KaLhSgJkHS1
	H0QVb3DO/w/yWeJDIFs7NjSUrgTsP2mt5FkTxAN86spHAPngCyDlCMIEnJMebdNB0K4ANmTdmA5
	5iNFnXWbq7Q==
X-Received: by 2002:a05:690c:3192:b0:821:1013:b420 with SMTP id
 00721157ae682-8211013b613mr61043287b3.2.1786073060720; Thu, 06 Aug 2026
 20:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806165334.7328-1-ansuelsmth@gmail.com>
In-Reply-To: <20260806165334.7328-1-ansuelsmth@gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 7 Aug 2026 11:24:09 +0800
X-Gm-Features: AUfX_mzUdOGgxWn32vBMs4t6vRLtbHLODUQScOwpqh6tGHGYlgOK1wG3cJKPIgA
Message-ID: <CAGXv+5HrDw8GWb9zp1AaQU9UW+0FGcr7jOV2jt_zi_2KgfgBqA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] PCI: mediatek-gen3: Add 2-lanes mode support + clock
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ryder Lee <ryder.lee@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Jianjun Wang <jianjun.wang@mediatek.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 12:53=E2=80=AFAM Christian Marangi <ansuelsmth@gmail=
.com> wrote:
> This small series introduce support for 2-lanes mode for Airoha AN7581

Just a nitpick, but I would probably name this something else, like
"cross-controller lane-bonding mode" or "lane stealing"? PCIe already
has 2x lanes as a standard feature, so this naming is a bit confusing.
It's not like dual-LVDS display in which LVDS is only a single lane.


ChenYu

> SoC. This is needed for correctly functionality of Eagle WiFi Card
> normally attached to this SoC that require a 2-line PCIe card to
> correctly work (and give the proper performance)
>
> The first 2 patch address a limitation of the PCIe implementation
> where the PERSTOUT reset were indirectly asserted and deasserted
> all at the same time (for all the 3 PCIe card) with PCIe
> enable and disable.
> The 2 patch address this and introduce correct reset to control
> reset line for the relevant PCIe line.
>
> The last 2 patch add additional logic and support to assert
> and deassert the PERSTOUT and also apply the required configuration
> for 2-lanes mode.
>
> 2-lanes mode is implemented in DT by adding the required property
> and by defining the "num-lanes" to 2.
>
> Changes v5:
> - Address formal comments from Bjorn
> - Drop clk patch (handled in separate series)
> - Add reference to clk changes
> Changes v4:
> - Improve DT split patch (drop unneeded property)
> - Handle power_down PERSTOUT
> Changes v3:
> - Add Ack from Krzysztof
> - Improve commit description of PCIe patch
> - Use pcie->num_lanes instead of possible uninit variable num_lanes
> Changes v2:
> - Address typo regs -> reg in Documentation
> - Address typo lan -> lane in Documentation
> - Apply a suggested fix from Airoha for PCIe MUX configuration
>   before PHY init
> - Parse secondary reg in probe
> - Add missing reset_status handling for inverted bits
> - Move SCU to local handling in power_up
> - Add check for max num-lanes for EN7581
>
> Christian Marangi (2):
>   dt-bindings: PCI: mediatek-gen3: Split Airoha schema and document
>     2-lanes
>   PCI: mediatek-gen3: Add 2-lanes mode support for Airoha AN7581
>
>  .../bindings/pci/airoha,en7581-pcie.yaml      | 244 ++++++++++++++++++
>  .../bindings/pci/mediatek-pcie-gen3.yaml      |  77 +-----
>  drivers/pci/controller/pcie-mediatek-gen3.c   | 106 ++++++--
>  3 files changed, 338 insertions(+), 89 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/airoha,en7581-p=
cie.yaml
>
> --
> 2.53.0
>
>
