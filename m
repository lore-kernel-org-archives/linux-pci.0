Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5954D245012
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 10:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774346732; cv=pass; b=niSIkpqT/nLdW4ocQF1/wEk8SkYJQEH4bIlQffXE/uW6im8ETgNY+FQTpjrF5+QyM/8qcssbPN6x+PuXBLYLblHkig8xCujVPm1lhFdFDskTNrXaEg05BAfCRwDiSY7NJxsP6T52Jnfc8Jg8ztwq3mLtNwPty50As8KnSqDVvkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774346732; c=relaxed/simple;
	bh=nQfXP7Ff+3v+RxM+HwFb8hTfc8NE+iWzY4oUurkevcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PS7g3lkbRUeGg82vfk/L0rAHoEdptY4YGHvhKF79yFBFJBrHz141O28b4pkFxCDoMEC0TCWtKIwTGvdsObZomUFGENhsZwMkwkoRIgHaBlfWxxTBy5J/EjExyEuyyaOEnDgxYaw1XmSI5MsK0fLtUBBydiBY5Ni0V6JQbCKecRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpttrJVH; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpttrJVH"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35c05d7e0e9so310713a91.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 03:05:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774346731; cv=none;
        d=google.com; s=arc-20240605;
        b=KjUNjCkKpTRxDeDEpDUqU9ou8qgVL/y8+TaC/fONbaGT95dKY2Q8JbdGJ1g7msvzjp
         bMR44YchPj0Wvk3CGDjCBAX8T7M09pa+Mr7UIs+ClHgDwuzfTV/fYA2aJqYBtsYGoEQk
         vHA/U3IOAGv1KCo0tS+gIfTXr26Ym9MCC4F1hS/0TQSk0gJm+WHGq2fPFWhpvjgjUSEK
         fu0VIw+Z0y35flvdC/3oEdzgufemvdi3EadCgN43eyOmj4hUGivhdO7QFfHN0/MLZlD9
         NCDK45z6Fm2nXcv7uyNeEvc0b9qLS8yzQoJwZ3CIB+o5YB9jCQk5YUBZifSAIX8+KPFi
         HCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RSdp4GdmS7dcx/gGc+xtumbt9Ss6dGNt9JneyzIm5sQ=;
        fh=xP97dLef6OpbjhGDe9GeEKsF1CJ/3Awg2/F1Zj5bwYM=;
        b=Sk6tl/3TUmmno1QjGjAsavUaZEmCKRSM5PgkmGgzjY2+pBR9IM1aw23KZyFdPGrkFH
         SuVluToAjn2hSY+viXiCQYJ/wGCBsn5ARR3dAoktg9JwAdRZhdOCi8JFTsMC4wNccJt8
         DulK/TfyuXC21qTGf8z952qZ8mL2NSHHkV4P+WErqIuRY8b+tFuH8JVBAV85+r+JRa5i
         OwPMdqyO/IBPZAGZQ9f+FRsEAMYhCjp6pzoqJUSZ91rpYT7JIA0ygiw/18Yd9/ZHuWFD
         ryaI97+oGAWDjqq055snTEhBgcTIstb9YRe/Wgeiybk10EiBVieavxfG77HfT6jXm1g4
         fiKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774346731; x=1774951531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSdp4GdmS7dcx/gGc+xtumbt9Ss6dGNt9JneyzIm5sQ=;
        b=KpttrJVH9HL4xUXB8IrXyr5JJCu+NIwvvi3z6tJoHhbnR2R8MCcOToQOEHtMsgBkJl
         SmJVKJ47ja12xqW5X97IWfdzoVAirJzwIGOOURjRHMX7tX0Pl5ZpcjnuzCAlzRnH7cmu
         Ru271f5NfUYBvLqcP+6BSn3zEluySAGMivQ5Bh+9lKscZ+YzCZkN2MwpsibgZn9KPXkH
         QwelehB+Ru7fdWYOc+DHD7Avhkxya1gwjJ3E0boJp4BeBGsrrX8OMnVPl3MhodtzUUIc
         bWHK6YqYGNdV2vkHsta6ThYQsAWABWnWXdcpLSHhAOki5waDDCfXLff743HuDrfkoKDz
         gBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774346731; x=1774951531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RSdp4GdmS7dcx/gGc+xtumbt9Ss6dGNt9JneyzIm5sQ=;
        b=PnXbx6aneMfTDzNVMH8osbhfOkcaLN+g4Q7YVM6FaJXqawTUTae7qVbF8etBkGyH11
         RpQyLl0I/42BQg0tVgls+a9hvqcfwepF4Ma5RDKThmiDjpAM7vJ9pZr0uJz7mk0XnBaT
         KUNktiB2o+Gw792j7PguYnJWxeBeKiTH+mGtgMddBjDH7gtKGTVs10HsqtotMCEnIMp1
         b9FhFGiSHp8K1joNg+cGIZHcVNUuAkO8oX/NVvV1+2NA+cNbkKS3K0vIcugK3Q4V3QQk
         JvvRegNqxQV4TF/HBiCWvCJ3hHxdeVq4q6XC/LyAyqrxW49cuxwvvoG9KMM7eqW+aPbe
         C6TQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7nlpbHPbulLbDdBj69dLTbzoZ+S5FEyu/HHMAjSUQ72XLdaRZwmm+TNbQ1h5yHWgyd4I+9FyLglM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQarSIFUkbd4e1ucvtVk5Sm7k1ttrc9xDKCm/Oux67DQr74tO2
	HO2PDul6vpIEZUqjisQbfvZEh/LDBtQLy/XfuZPSBuYEh0i45gXhp9W++k9RafFGHbSAwzQw5IX
	lniD6S2wujZ38Fov8au0ymqCcdnqiO3U=
X-Gm-Gg: ATEYQzymKcXb4x7CF1aKswXgtWUTNAGA7pOAQwxTV0Ax9w/PgD9BLeTV55upLD0wCm6
	0egAAxzq90qU84qH0q3pwJeBI4d1BFNKOf5xt/vEzFaKpcVRPQHJL1NEp88YkJEzXVRPckG4N8T
	FgC1tojxPcpRgP4Nn+oUVBU5MetS721x8PiwtewnMBqf7bsvVybt2ingXTJZqSH0t0iQsoIugJb
	75wV+nkjYIxfF/YdKV7hAhp16h9wzYS7+3tOQvPtfPszIjs/8eg1CpyS0oduRZypJlF6naRYhRm
	ADeHiueMFegzdLByJQ==
X-Received: by 2002:a17:902:d2c1:b0:2b0:603e:e147 with SMTP id
 d9443c01a7336-2b0827313b4mr158093125ad.22.1774346730414; Tue, 24 Mar 2026
 03:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323-pwctrl-v1-1-f5c03a2df7fb@gmail.com> <20260323205713.GA998251@bhelgaas>
In-Reply-To: <20260323205713.GA998251@bhelgaas>
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 24 Mar 2026 18:05:18 +0800
X-Gm-Features: AaiRm534J3kGIuGxhdZZJZwvNuer5rvapG2lLpWFfDSGic2PGReO9I2IT6Jw5w0
Message-ID: <CAN4SLj2PRsaZnO_WptYQaQH4-DajrVd9L_=KXwTuOZj0kyLrOw@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctrl: Fix device node leak in pci_pwrctrl_is_required()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 4:57=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Mon, Mar 23, 2026 at 07:05:22PM +0800, Felix Gu wrote:
> > The for_each_endpoint_of_node() macro requires calling of_node_put() on
> > the endpoint node when breaking out of the loop early.
> >
> > Add of_node_put(endpoint) before the early return to properly release
> > the reference.
> >
> > Fixes: cf3287fb2c1f ("PCI/pwrctrl: Ensure that remote endpoint node par=
ent has supply requirement")
> > Signed-off-by: Felix Gu <ustc.gu@gmail.com>
>
> cf3287fb2c1f appeared in v7.0-rc5, so I put this on pci/for-linus for
> v7.0, thanks!
>
> Would you also take a look at pwrseq_pcie_m2_match()?  It can
> similarly return early from a for_each_endpoint_of_node() loop, so I'm
> concerned it may have a similar issue.
Hi Bjorn,
pwrseq_pcie_m2_match should be fine, endpoint is marked as __free(device_no=
de),
it will be called of_node_put() automatically when returning early.

Best regards,
Felix
