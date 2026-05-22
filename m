Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A6336F8EA
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779473280; cv=pass; b=LyuOWUvd2si+0lQtzRzF5WjHcy076HHY0bj8f2upVqG1VsdVFzaL8DemoBHaXOBB031ErsYd3UGdlunXOx/Jbkq3nrc87IxXoDNy2Eew3NpOQQY10rFk9XFIGy3YRODSXrguVS3cBRFWE710vLsbi8UNPTQa5BnA08bVWmV0A6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779473280; c=relaxed/simple;
	bh=MDd64Rn6knYwkPwXNffQKODVkuxF0Aba8Wwr7ELMdyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ER4ygEkRo/e5/q0csTzsO/Bx6xtkxW4OjOb64+p4DfYdZCaK3b7ZSL1WBGFFxRM4gbgcmF8BLxL3QrT4o17hVyFmLFBN0gZCHPu58KG0vhfvpHmjkPSJWiE608Pp+87mI3jLzVf/GLTLrekGQZOoieWE+x8QgNmpZmtu79Wbo+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PiVx8VgJ; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PiVx8VgJ"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12db2e415a7so3808643c88.1
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 11:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779473269; cv=none;
        d=google.com; s=arc-20240605;
        b=R/Eju+UoS411kJB8wR/V8xcYBjmYU+QDi4Db6r9H8tWj+W9+tM6v8GrJkb5tU9IKMX
         qxYWG6NAq4rXoJq6Um92X3QRPk5TJ4ORF3jrTiTqJi5nz9bVMmxq+sMYQtyrAHLcmQpx
         RgIIKdL2314ZiSO+wNc7MVipoQYqOzZvLDrUCwzDHVoZhLlfHerEzSiecWmNYzEFKZst
         suqdi8ptdHT6XNbKpam9YRJ9XpGja2AjyR957aCWX6iVraDOyzKSTFVWoC0iesYYD/Hi
         WFp+o5TzONgJmhgEdvrs4taKNKZtDcvmxy83fF5zxgQ7BymdPw3XxBziS1vPFNcZ9hVc
         Vyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z+XS59x4mW+gcdVuYMoKcEzUvLfDzChrrzvvmZUFTjA=;
        fh=ATQ+q7CSUerrwaQiXa+e9EiFHP+w5/dRtBm6WJuRKZ8=;
        b=RgJrgHLSMhBz5XAeubFf5oyTfEXU+DOzNUpMdgvf2MhGDA15V86NZriPGxbqPt6qyl
         72K+3flT05ihzt552z4AiU7aYsZyqAjkn26csFfWhxg8KDd9LiYwK0WzrRtfN2C/v3Kb
         TBpIs/I5+LPEW5PyoBzX0Tx+pbIbVihJSoUyuODKf6dZYLez4PCSZswD2O1vulx3Wijw
         1RJ0JK0KohJ9sFKT1c73s6TgBYm3IB6PmSgCt/x1IdFaJqd3FwxemwtsC3rW6zLUuQ3c
         ug9B1ftmh6bkYdxZHFlxp1iy2T+rO7DNtEW3FnUMGo+Vztr3sV3E3Y/mx1MqEif09xAW
         DmeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779473269; x=1780078069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+XS59x4mW+gcdVuYMoKcEzUvLfDzChrrzvvmZUFTjA=;
        b=PiVx8VgJAM2w4/LA+HdXsLYPc0uU7tjoNGyns7O2v/A45zS0YhhsCBdBg+/oUQ/I0p
         vm8m+AXQYYRxnnEtANaSzrpQDGYSNDFCWo6fONGAi5RnN3TIyQgaFF3gl9UH6dt3imnS
         W4p/oJ1l5CydXZXwoh0236NAXe54HMn5bh/27pUImujjSwYw5Q09iKWU6Qgt+uYK89sy
         ScN1p6ZGDdRxCUho36CBodh5y0O06YTeuOVfNyN2phFnvosAFcuvqjKv0RUsgpVpJKlJ
         ulL28h40Ox3MQh5ixZLiBuD4toHn3SsCDkOHzpDlaRwxk0XC97TVM9ijlrNL1YLBM2mk
         k7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779473269; x=1780078069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z+XS59x4mW+gcdVuYMoKcEzUvLfDzChrrzvvmZUFTjA=;
        b=bwaPqJT3XLP3sX2dCd/o6NcXqzCRrtPpWwBql1MnKtFajMwF6sDNlxc2Z8KxT9cY+r
         Y0Y/cBtceMoz/gTFC2oMBISCqpwQjY9Zm52bmS+t/ehnoWNJy9Js2eLqxew+C8wX3OWu
         c85b65HJbl5fPRXreEmEqd4RPsg2JCfQOjbNRsfAu1B2t4d/sMylVjZ9tedtGtR8nsHg
         GJsrdlYw6BL0kzlCjTtoNydTXF7TJyHBlM/ceCY18L6FE9GL+7FKfi2TcHWFoRiiikBV
         z0M8oXapCotSsEs91x/xQm41F3Ko5OR6ah94/v4AZnVD5MtMIOi0ITTotSpywwGsQhPu
         TxqA==
X-Forwarded-Encrypted: i=1; AFNElJ+pItx7cJ2hCzCx+xIkv3DgQPqhExQ0IsUtUT9HA+rH4tJtK/CCroQSYAp7am06LCWblhToXFiwIEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH12Pv8MAnCySoI/20gXsEWWhoXI4hy1F5Rr3B4PKurqV8yF4d
	CrxTzLGo2YgkR67ut1tVaxxvWRBgC/hTkSNKwastIIRXVj2fy9e73pCQoRNdidTcMguCFRKpGtW
	03F5+WZcHw/AF1NOckup+XtJFCkoesJXEoKNELijUOOG7VIqRYhQ4QRer
X-Gm-Gg: Acq92OF1r3Ldlr0ESPp7znJ6uxZ5qVkAcbeZO2kIfzb9X7SK+xW12ulFbnPO4IqY4pK
	LuSbPDQ2fM51kMMCFtQjcuwouHh8yoYvU8YECFCPQKogFAt6g+nQzrCLuHkw/Y1Bn0U39JDocWH
	cCpQM3qocgDIcuMtCg9LUuwgUDNYTOHiHiKjAekoL9rkDG7nC13ZibRf9LPM/oMrhEsR8vf+Ab7
	9gqbMA1hsC2ASq3MFoUGnsxjKSE8lT/hvlxYfn4nHlv84URpwBLeHA6gTV6hn+4alkkr4ng4JOh
	aPRK6B05Lsr9vY1Hjw==
X-Received: by 2002:a05:7022:4389:b0:127:366f:8bb7 with SMTP id
 a92af1059eb24-1365fb42bc7mr1819801c88.25.1779473268539; Fri, 22 May 2026
 11:07:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <agYRd0xQs0r8OOKA@google.com> <20260522175755.GA231746@bhelgaas>
In-Reply-To: <20260522175755.GA231746@bhelgaas>
From: David Matlack <dmatlack@google.com>
Date: Fri, 22 May 2026 11:07:21 -0700
X-Gm-Features: AVHnY4IBRkkx9GaAizC206BO1dRg9LDjKqpxgskMN3l4JRz54CwwdaiR9o3pFEU
Message-ID: <CALzav=eDB6kFdsHPWGjpq4RAO_dxjD5cxgLCnpj1mEjxOUTwsQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] PCI: liveupdate: Track outgoing preserved PCI devices
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 10:57=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Thu, May 14, 2026 at 06:16:23PM +0000, David Matlack wrote:
> > On 2026-05-14 12:31 AM, sashiko-bot@kernel.org wrote:
> > ...
>
> > > >  static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args=
)
> > > >  {
> > > > - struct pci_ser *ser =3D args->obj;
> > > > + struct pci_flb_outgoing *outgoing =3D args->obj;
> > > >
> > > > - WARN_ON_ONCE(ser->nr_devices);
> > > > - kho_unpreserve_free(ser);
> > > > + WARN_ON_ONCE(outgoing->ser->nr_devices);
> > > > + kho_unpreserve_free(outgoing->ser);
> > > > + kfree(outgoing);
> > >
> > > If a driver fails to unpreserve a device before the FLB is torn down,=
 this
> > > WARN_ON_ONCE triggers, but the memory is still freed.
> > >
> > > Does this leave dev->liveupdate.outgoing pointing to freed memory?
> >
> > Yes, if a driver unpreserves a device without notifying the PCI core
> > then that would lead to the PCI core having a pointer to freed memory.
>
> Just a curiosity, I guess: How is this possible?  Is the driver
> responsible for doing a generic unpreserve and also a PCI unpreserve?
> Seems like it should do a single unpreserve, which should internally
> take care of whatever PCI/IOMMU/etc unpreserve is needed.

When userspace unpreserves a file (e.g. VFIO device file), LUO calls
the driver's liveupdate_file_handler unpreserve() callback. The driver
needs then to notify the PCI core of which PCI device got unpreserved
by calling pci_liveupdate_unpreserve(). If the driver doesn't, it
would be a bug, and it would result in LUO later notifying the PCI
core to free its outgoing FLB while the PCI core thinks a device is
still preserved.

> I guess the requirement is explained in "[02/11] PCI: liveupdate:
> Track outgoing ...":
>
>   + * ... Drivers must call
>   + * pci_liveupdate_unpreserve() from their struct liveupdate_file_handl=
er
>   + * unpreserve() callback to ensure the outgoing struct pci_ser is allo=
cated.
>
> I just don't know what the driver changes will look like.

Right that's why that line is there. And the WARN_ON_ONCE() above aims
to catch future buggy drivers that do the wrong thing.

The VFIO driver changes can be found here that build on top of this
series can be found here:

  https://lore.kernel.org/kvm/20260511234802.2280368-5-vipinsh@google.com/
