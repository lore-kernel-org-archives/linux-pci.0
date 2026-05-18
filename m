Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487C7379979
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 19:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779133685; cv=none; b=WATK55SxCK9TswmKFFc8jDh0TEN4pJ99J/H129JfQONaW5HD7AA2FYYI36HJZV/7vAP4FKWTbhrXO/o0/U/m+M/hadiJMg/cLiD4j6TxLCnC7t4R8boDDQM5rj+Q6/ScI1fmrpndaVF/JFwlFli1C9F9gRW82x6a5Kn/CvBRAdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779133685; c=relaxed/simple;
	bh=JJBXgBmmzWg8FSPGScIk0gkmttQWRvYqTPJxsWlV6Ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6POoG4YQAfwiXqqaJmh2ch9wPHMBjMFgGPaweo3xNr1VuHbaoVyeQ5nE/3CFQ/zXxw+bznCJBsQZmqRcqZgfnLLob+Mh1tT+vdlvc5Xy+DbkZD4j9P9dWVRhDvRGbwA5av5CmVCH0BNGlPXG5W5Px57raMHzAIz9PuDJJlq40I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbAtLCDB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbAtLCDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08844C4AF0C
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 19:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779133685;
	bh=JJBXgBmmzWg8FSPGScIk0gkmttQWRvYqTPJxsWlV6Ys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GbAtLCDBDAjuwVOPV9E8qQZOCMvrCGlW4bJcJCeMTqnqreoJwi4JhtiqazMcUoQs2
	 muqQkOfRdLmrnaOuYjpqi3MMghtQUzZ5s3w2sA2MMhuNmIsxMzDQGGewwLYwnAPRc3
	 MRGicMivKLqJbIGjfeaFPsnLjmg7wDL1qbGXZC9wNe08WvN0L4kRZHS418/oLFiACD
	 Dj9mv91kfJcoHTpuzChwty4+eZyD19mhyWDUoEWZ6voS+FCZvag/zecANnxZopwgbz
	 9gV+R/0KC97YmTeqXrvJO7haJEax7YbQTjh3xYu90AEfWPQ09kanpB8OLbQQQhNTgR
	 PWYMVJM0etoyQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa0cf8bca3so2821191e87.0
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 12:48:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+ZsGl4QHHVdzXoU0F7hkphMLljMVYLNoRhFknKEBSOSGDezfw7Lt112mkI1GuDjp9KuDtNZfrFWHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxcC5VUoPNaz3kmmraJQFi9ryCO6kXIhtdAidKbNwUuoGttVDa
	emrkBpT7q8BiXu4NcF81fPsjg+fEshr2QT+RwFf0Ags1TIybGVFbYCFdCsQqL+ay1zrleRXr7g5
	u7BTr/oDryJ6HDPlOkQnCjXaR6zhPo2c=
X-Received: by 2002:a05:6512:2248:b0:5a8:f03b:a406 with SMTP id
 2adb3069b0e04-5aa0e73d743mr6119036e87.16.1779133683308; Mon, 18 May 2026
 12:48:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518191220.636213-1-bhelgaas@google.com> <20260518191220.636213-3-bhelgaas@google.com>
 <CAJZ5v0iU=0SHXK9RngiYCwz5XZ0mJ+L5iy-FSWhytNgJbCam0A@mail.gmail.com> <agtsbplSM7ozZcHF@wunner.de>
In-Reply-To: <agtsbplSM7ozZcHF@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 May 2026 21:47:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gRDcX_oMmZ0zmJhHafCFN=B15yQoivz9=dQBwEKR4TCQ@mail.gmail.com>
X-Gm-Features: AVHnY4JXLVJ0gmBRC8V5auHIB4Fgx5rDe6U2l09fiwjKs0oqhkCfffag5vbr5oE
Message-ID: <CAJZ5v0gRDcX_oMmZ0zmJhHafCFN=B15yQoivz9=dQBwEKR4TCQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: Wait for device readiness after D3hot ->
 D0uninitialized transition
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
	Marco Nenciarini <mnencia@kcore.it>, Michal Winiarski <michal.winiarski@intel.com>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Eric Chanudet <echanude@redhat.com>, 
	Jean Guyader <jean.guyader@gmail.com>, Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>, 
	Mario Limonciello <superm1@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 9:46=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Mon, May 18, 2026 at 09:38:12PM +0200, Rafael J. Wysocki wrote:
> > On Mon, May 18, 2026 at 9:12 PM Bjorn Helgaas <helgaas@kernel.org> wrot=
e:
> > > +++ b/drivers/pci/pci.c
> > > @@ -1341,10 +1352,19 @@ int pci_power_up(struct pci_dev *dev)
> > >         pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
> > >
> > >         /* Mandatory transition delays; see PCI PM 1.2. */
> > > -       if (state =3D=3D PCI_D3hot)
> > > +       if (state =3D=3D PCI_D3hot) {
> > >                 pci_dev_d3_sleep(dev);
> > > -       else if (state =3D=3D PCI_D2)
> > > +               if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET)) {
> >
> > Hmm.  The pmcsr value here is from before the pci_write_config_word(),
> > so AFAICS it should be updated after the write.
>
> The No_Soft_Reset bit is RO (PCIe r7.0 sec 7.5.2.2), so its value should
> never change when writing zero to the Power Management Control/Status
> Register.

Oh right, I confused it with something else.
