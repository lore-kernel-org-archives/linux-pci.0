Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CA62DBF75
	for <linux-pci@vger.kernel.org>; Sun,  9 Aug 2026 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786284890; cv=pass; b=IMKUFmgDGLgvBg+PP1Yybt3U74rchHPkeOWZutU1mbf0E084+GZ812GD0WfOiq0yZlKc8MrnsbJhXzLHHjXf/jlOynGV5OLNLQnjNQuUFXl1NshUP/rw3xPwCtZAPlRHBn/ngXeRcmbNW7fXM7B2+j56xUmkMzU2lhBHT1sGNzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786284890; c=relaxed/simple;
	bh=rlbS8rmt2cYpD1ter3Cf3FlZcyNn+LlDqDW3OC/XsAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4SpCRN4va/+n9Tg0H4IFkY41hzA6+V6HGZOJNIKHrX+SJjVmXsplBTuDoVFz7chSrRjMSSjcQ4kcZqj3pcfz2WNKLPGDg2+aJwSPA+F6IIQyQLCkv/YPf3NdwBkFCJGJTlX9Y9MqKpCzYBbs0WJ5GcTxZ9fLv/Z/eCy4bs3tF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n/5l6BmV; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/5l6BmV"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51bfad59921so6495781cf.0
        for <linux-pci@vger.kernel.org>; Sun, 09 Aug 2026 07:14:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786284888; cv=none;
        d=google.com; s=arc-20260327;
        b=DuNEcx2t6g26zjAu6w2f85/zcuZnjZvzjRQBw/byfqEkWTJc7jaJ/rm0AGUX1yGdsW
         4LGuHs5p9Mt5I5vLxfwK7T5c4tQ2karg/pl7Wno80KtSeJ0AiRGou7JzEusHyvyq+2QS
         DvQMTl0r4GlTTmjvTss+32hq+kwcky3++aObtFO1BFq7KCdxGhJlMLYXMlbofrEUHNBr
         1iU9woVNTAX6ddxqryLHwKHSH6FErKOV//mgX/tlNRz8IyFh8l+DKIXzTxoCn4WNFbmQ
         OAyU4dQo9C1qyGHCRi7mozefnzjV/+6at/lK+Ny+ThlgG15X5S7LKrW+QMGRzQcOMkfl
         gAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rlbS8rmt2cYpD1ter3Cf3FlZcyNn+LlDqDW3OC/XsAU=;
        fh=hVR74hwHuT8nhGv1FA4vRLT6O6LGx0aiu/ZIvSnESeY=;
        b=q1GYorvp47Y463XBdwqnNtbtE/YhzUEbjuyRo0N1OgoAbhEwSF2hWJb3PaAHOkoZ+P
         jAmCX2HJJ1slmqh1J4Uh0dIs4y3Zrw28/xW+NwQkUeqNOMQgKXTVCKxEnLrjIEXnuYax
         nIsXL3H7wnex5Mg+qfcUOg+jp4wgmVv3HDmgRh6JUhOoY6U2fPJ76JI9DWtL0ZGOmwLA
         7ddycqpi17z4vfcODQheJY9rOK1I2GEudsftIcLjLQJLngVb+BeIMvmXt7o4upzMIOnr
         LgddUzNNZKGDYsXYPX46IclbeFy8Jj2jFTr0nku5UWnojMMTi31QD1nQRra0lrPQq8gr
         5ggw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786284888; x=1786889688; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rlbS8rmt2cYpD1ter3Cf3FlZcyNn+LlDqDW3OC/XsAU=;
        b=n/5l6BmVWlKn9JYBAzaLg9Ra5UJZ55D82ajE4AAjTaORkP/M0hk7dqs8/aTvvkfG5y
         HdTraXRqF6YSHV7ZDzItsI0ssyK8gbdTxn9FWGtcIq9mm8HskMdmcLwW35UKI2sAxSh7
         HDwk0J2gLl4IBnQpJzC8ICTkDK7l30eBoT1FmjoyqXqT/qs03NIDMlBodmJwLJLhswDg
         0AMyZOuUQDvaC0ju4F22pQBQNGmDgwegsGOeS5Qpxjw8sYa4B2V6tHWMYyFhkxe9pg0M
         LpCjgRhcoe7S+wK3LmD12KscuahrZ23OhQ7/bXUENtDRhk1GDs4ZEvnebbL7QP8BMsC8
         onxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786284888; x=1786889688;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rlbS8rmt2cYpD1ter3Cf3FlZcyNn+LlDqDW3OC/XsAU=;
        b=pO5mdohIh+EXHswgygQcTJpo6NONkTaNxoy0K50OHB/1Pu5DVTf5wy4pY7ExLDmwGu
         j6z+tJ72uppOB5P8oM9kpSgXGikucLat41atAHnQMd4HKe1XXTOZU/fYkaH63o6czp7c
         CLHR1TyRJ/DLXqqV0MV1cV5wGClkfqlUU+exV+bxaAjEG8D7r+gWkByqp22tiinT1VzL
         HVJlZscfKj3o8SLwlLJdFbpwj+6ZxFdxAJ5+OpBLzouIM6npWHt+b+LaST1+F8mEf0eJ
         tx0QRBngqFnTKCYfVXqtDntmDShIy8K3we8Tc0E4eu7ajynMw5kgV3vN5ll4bKsxgUmi
         Apwg==
X-Forwarded-Encrypted: i=1; AHgh+Ron6u5KlkULXts4CV3zWZSKw5OloGHd8weLlx22qPfj6b1JTZpQTz+J/I1bv0ZXgtf2GWvXsH1DR1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXUwrdvczVQT3ksZTI+O6gXR7H0UP6J23d/Vqpoasy2Wzk/65O
	TMNSExFTrMDvyYWkPdP04UuA9fJcP1KtYtA+S1rvXxNqEadjc92sFG3t4xA+P+94hocNWwNfcZa
	aE+UR3GerOq1FC0MTDLtivqSbrqgo2RI=
X-Gm-Gg: AR+sD13aCfxGnAkufmOak9C2SlXElbl+sBC2t8OsK7XpW84zI3MfUYyVQWofsPtxWdy
	uqR1RVwHkXIaiE5OjFmDptVenhEKl2YaC76yf4TSF4VZCNm+RUte7Wn9F84HefGdfA+FRu+eD5u
	pXCfz5dqNFWreBymP3tCyQeOpr5jTTF4kcWELqRpwEusnPFo52DY3BFv/qS0gASYmH2gywwIHkz
	XAjiPudLOZ+aTgzEiqg9hrEoEqCfPWB9tRtaRz63mUt3Ckl5SEMGkeA12ODBzmsLJW0EMZXvEoV
	lo51Dyeq5sry3Mm3wcN2fLIxIK6nKSZVt8ee/JIVDQ==
X-Received: by 2002:ac8:5cc8:0:b0:51c:6e:ef23 with SMTP id d75a77b69052e-52ce61b5defmr411182591cf.32.1786284887884;
 Sun, 09 Aug 2026 07:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGXv+5HrDw8GWb9zp1AaQU9UW+0FGcr7jOV2jt_zi_2KgfgBqA@mail.gmail.com>
 <20260807152059.GA39821@bhelgaas> <CA+_ehUxQfWRRec4q2ZvC12nYAeV2VGm1xCFrTWeN6sEL+qkXBw@mail.gmail.com>
 <e41835ae-b575-4364-855f-6708b15b4db0@genexis.eu>
In-Reply-To: <e41835ae-b575-4364-855f-6708b15b4db0@genexis.eu>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Sun, 9 Aug 2026 16:14:36 +0200
X-Gm-Features: AUfX_mwchdsWKWBSl5_tblgDoEXHgnY_TIC1M0M_ze9LfMJB60Ic6Q5YNmA7c28
Message-ID: <CA+_ehUy6bAq564+1c6KMV+egnXO8S2GGaLrRq1aDik9gWrrKyg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] PCI: mediatek-gen3: Add 2-lanes mode support + clock
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
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

Il giorno dom 9 ago 2026 alle ore 16:08 Benjamin Larsson
<benjamin.larsson@genexis.eu> ha scritto:
>
> On 09/08/2026 14:12, Christian Marangi (Ansuel) wrote:
> > Il giorno ven 7 ago 2026 alle ore 17:21 Bjorn Helgaas
> > <helgaas@kernel.org> ha scritto:
> >>
> >> On Fri, Aug 07, 2026 at 11:24:09AM +0800, Chen-Yu Tsai wrote:
> >>> On Fri, Aug 7, 2026 at 12:53=E2=80=AFAM Christian Marangi <ansuelsmth=
@gmail.com> wrote:
> >>>> This small series introduce support for 2-lanes mode for Airoha AN75=
81
> >>>
> >>> Just a nitpick, but I would probably name this something else, like
> >>> "cross-controller lane-bonding mode" or "lane stealing"? PCIe already
> >>> has 2x lanes as a standard feature, so this naming is a bit confusing=
.
> >>> It's not like dual-LVDS display in which LVDS is only a single lane.
> >>
> >> I suggested the "2-lane" and "x2" terminology because I assumed the
> >> result is what the PCIe spec would describe as a "x2 Link" consisting
> >> of two Lanes.
> >>
> >> If that's not the case, maybe "cross-controller lane-bonding mode" or
> >> "lane stealing" would be more accurate, but I don't know what those
> >> mean, so if we use them I would also like to know what the result
> >> looks like in standard PCIe terms.
> >>
> >
> > Mhhh I don't really like the term lane stealing. Also cross-controller
> > lane-bonding
> > might be a first. Even if correct it would complicate identification
> > of the feature
> > that at the end of the day configures the HW to provide a 2 lanes PCIe.
> >
> > Consider that in such mode, the other PCIe controller gets disabled (th=
is is
> > handled in DT) so it's effectively enabling the standard PCIe 2x lanes
> > and apply the HW configuration for it.
> >
> >>>> SoC. This is needed for correctly functionality of Eagle WiFi Card
> >>>> normally attached to this SoC that require a 2-line PCIe card to
> >>>> correctly work (and give the proper performance)
> >>>>
> >>>> The first 2 patch address a limitation of the PCIe implementation
> >>>> where the PERSTOUT reset were indirectly asserted and deasserted
> >>>> all at the same time (for all the 3 PCIe card) with PCIe
> >>>> enable and disable.
> >>>> The 2 patch address this and introduce correct reset to control
> >>>> reset line for the relevant PCIe line.
> >>>>
> >>>> The last 2 patch add additional logic and support to assert
> >>>> and deassert the PERSTOUT and also apply the required configuration
> >>>> for 2-lanes mode.
> >>>>
> >>>> 2-lanes mode is implemented in DT by adding the required property
> >>>> and by defining the "num-lanes" to 2.
> >
>
> Hi. Isnt this just pcie bifurcation?
>
> Logically bifurcation would need to be disabled when using 2 lanes in
> one slot and enabled when 2 lanes are split between 2 pcie slots.
>
> But I'm not really sure what value a bifurcation property would add.
> Isnt the current schema enough?
>
> The mt7987 will need the same logic as it can also bifurcate one pcie slo=
t.
>

The documentation is not so kind on these kind of details... and no registe=
r
for bifurcation... maybe it's the mux one? But the mux settings comes from
reverse as in documentation that SCU register is a good 7:0 bits of
data value...
