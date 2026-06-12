Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990FA371048
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275410; cv=pass; b=EHIv0iER/GxvaQRUYsicDUoTLc9zF8eRQ+pKVrXlVAdlDQSP6mXjyAnHCPJh2FtH4QrGbBfGsLl7DgCq3cCD9+7i8HLeUDzXxQTLXrv2bGp5IGs2hIvEKjHSLZoSTTWomYZd5koLwKQWNX6HCw1r+E1ztyu3dR+/fwSA7NYVMTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275410; c=relaxed/simple;
	bh=w2nfYxYASA0giwl+BZunFh4T1jMKsr4eozLXGQlfC2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgRqhz4k54OrT9ACSbwr0AFkPa06Eo3qt3smlE9JGPj3irTjw4tSI/hsHh3H5IIOki3ptT4wGGfRrzWuBlZkjPNlbrfipjegBxfdPUpnYCUBK5A5d+eHEggsCItgJL++/d7PSf9ZYzJzhcgVomBb1PY0kamJdBfCXkV+UOlypkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sOj0cjiU; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOj0cjiU"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6607048fa62so1079935d50.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 07:43:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781275409; cv=none;
        d=google.com; s=arc-20240605;
        b=ZfXHvruS4BUo6sdANx5N/yCdWTzeS6+ZHx9qsZ2M8Q8949QQf7KF3Ao7yi5G82WhDS
         lVlVfI91e8uiYM6iGJTVWV55qlfsb6ntebHJAt9QeCT7ksZO/u8CChqnPW8RND3n3R/0
         exMvxRLyFc4FxtrhrWXI3q745JUHUT5t4OypQgjaMJJMBW1I+nqo2CKr3Ve9EgwihpLk
         PslpMTE6f4966EQ0VlawBspW1yH5s0zvQV4bNi0eS2IsL1bhsFa7d3M+B8zv7zKD2EMR
         2N+ytcO60GDgc3m0GgkaEz8wxUEyv07NqXH7/5gH6IQRhkeHm2KbCF0TPwRkRzapxijy
         eFyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k6VIcBkgcxYBFEz2ZSEGflERwIhJmjq3dpuCUDCSMSg=;
        fh=tFG4r7dEh4KwLRx1Boj0fq9/0ZcjguolXt6VlubDfiQ=;
        b=TwyVBmnoYr6YlcSm/CeBpbmQBigY+hzrIKCSuy+V+D0I/yIUeBzvuorzhNcVrmG2n2
         ApwmIc9crblHzD3wzoMXVYzgG5GH41y/0+fOAOW4JvwNYBpBcuFWU7XqcrhpFS5ojcp/
         yzouxmayCNbp111AxJNCEW+TuMB+iK8KvCyk09E1O6ph94kjfguvedjA5C/pJ+0fZ2Hl
         M2y549E/kjcJzP6FIrnBj8Ijzp9BqQIU0seAaIxvm6FDABY61dMjuBQF9Zl+02iehfcI
         Hi4nxCCog+8USV1SYSC1Gz5MEg6r4SoMQY8HKt1r/eE7u4VahaCJsXAIgx0Mx6Duf2kp
         /5ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781275409; x=1781880209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6VIcBkgcxYBFEz2ZSEGflERwIhJmjq3dpuCUDCSMSg=;
        b=sOj0cjiU+oLii5kZ9YJ8er3Dz6GyDX9pBlxk57B6nDm7XGOvW2TuGYLkv6TmGrSE8b
         NWkk5Xsph/9a26Cnxc/UO2L1qEk+5dJUGXlj4vmr5QlMPi+SeivvADfupo+VaqDQnCsT
         8iVfHCr2Kzlx4uUVA6Hu1gUrYPR79kYKxVFtCUjV8iUq3hUARiOzr/UDT06CEFP3pFoH
         cYRXDCrkpcf2b1WXlOs0lGzpSvVa4rkp4dOTDXTbK466jLGi3SoRG2UglC/hok+twPbb
         ly0NXwvO9FLa38hAYEMW8o5cejprOjEtkmzO2iNY637RpKToJCPK5cYH7k7p+Yk4ygL/
         X4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781275409; x=1781880209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k6VIcBkgcxYBFEz2ZSEGflERwIhJmjq3dpuCUDCSMSg=;
        b=KX82TBoz+SMXfQGHxQpROeO4/YwUNcroR2vtXvrYZGHKgU/BaxFqg5ly1LraHJs/i7
         I5FHTAkr5l4FtQawuM9ZOfAfsbwZWlT6InrkfM9aWLe/KgZx208qFMVORwcbVv/lna1W
         A79iJ/fRcrw3Zvo+30xjNeaDRsdTZV0LCpIBqpBS1r/StfAUboK3X96meHJed+tk+TZN
         XIEBsV4hliKr5BFNFkapuvTqVaOqsS4UxRMgFYc2IPXkPzKm2IyhgEDSIZNbE+mbLRrD
         lFE4qG2pV20BLnax3S5cbk6dKEEo7o2iRlosgPt8id4Irl+kCS3Eh6yTWhbgpn+B8rvA
         ysjw==
X-Forwarded-Encrypted: i=1; AFNElJ9VJUEf/c8m0a4DDyrJ9Yv+zrw14tzgYPFyVhqK4TCBPBB5XRcblfCUEj/3lqSPlcjObXzbwVNBZ7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlHJCmJQghxkYtMZvEG96hYMHUsWGb7kcTzgUVJnoUbpklmpjY
	FKwVROIdp84zpKMQBYtkez6OHg0b5eCRUhau1G6Rn0M8hhTn14t42v4b1SVN4UJkkOrFAXHuYpU
	5DhZ7Y/KziZMf6mqsN6Rij4oSYSOzdjc=
X-Gm-Gg: Acq92OG3Udut+ISkufEKZOVyFAUomHT4o0X2IP88zN2pFH9FfeyzrR4oYr2IjMDhDUk
	WX/cdkA92EfkdyRGQSGB5ZqyNZIgwu9hs0PxA0XEb5BxZTSbesJfaASZX4WxFFuTvXgb4UJ/hro
	5c0OKw9e8h6nIxRO/M6pmTC17BU9wSU2+G9Cla9uXwLGJavrGiN9rzsRaZbACtId+BxnfjKzgS1
	7/AjypNZ/DSbrw4diL7OVxvtkCjo/ZQDh62r97OPqvJOwydX7JGcDnarelk5UuFQlC9tJN3b6ZM
	JG54jlUE3YEAzo0hJ1qT9kKOEilg06yxAPToY7RRoBLU1Aug6GSPU/ptJ80H7Ow7zfOS2r2E9+g
	CCYtf
X-Received: by 2002:a05:690e:b45:b0:660:d0a6:935e with SMTP id
 956f58d0204a3-662782cf742mr2320722d50.40.1781275408429; Fri, 12 Jun 2026
 07:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZJY68zrRO49VEtgEVzQfqVY9QZzwUuc8VoKkAAeKUwAOw@mail.gmail.com>
 <20260612142839.GA598449@bhelgaas>
In-Reply-To: <20260612142839.GA598449@bhelgaas>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 12 Jun 2026 11:43:15 -0300
X-Gm-Features: AVVi8CcNNJ7VW_uXeCu9TvXEetVXekrhRt_l2XVfoJETDiDudc5tf7WtnqOKGeo
Message-ID: <CABBYNZK9e8T_gVyhvyU3EyGqUs7=1BDuTdaUkZPoJCygNUq1sw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: hci_core: Add reset_type parameter to
 hdev->reset() callback
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, linux-bluetooth@vger.kernel.org, 
	linux-pci@vger.kernel.org, bhelgaas@google.com, 
	ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Fri, Jun 12, 2026 at 11:28=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Fri, Jun 12, 2026 at 11:08:06AM -0300, Luiz Augusto von Dentz wrote:
> > On Thu, Jun 11, 2026 at 10:29=E2=80=AFPM Chandrashekar Devegowda
> > <chandrashekar.devegowda@intel.com> wrote:
> > >
> > > Add a u8 reset_type parameter to the hdev->reset() callback to allow
> > > userspace to select the reset method via sysfs. Writing 1 to
> > > /sys/class/bluetooth/hci0/reset triggers a Product Level Device
> > > Reset (PLDR), while any other value triggers a Function Level Reset
> > > (FLR).
> > >
> > > The reset_type values are:
> > >   0 - Function Level Reset (FLR)
> > >   1 - Product Level Device Reset (PLDR)
> >
> > This should probably be treated as a generic level at the sysfs level,
> > then each vendor can interpret according to its own needs, for
> > btintel_pcie that would result in the above levels.
>
> Are you suggesting that this should be implemented in the
> pci_dev_reset_methods[] framework in drivers/pci/quirks.c, so the
> PCI-generic /sys/bus/pci/devices/.../reset interface could do the
> PLDR?

This is the Bluetooth sysfs reset entry, not the PCI one, which was
created for Bluetooth-specific reset methods like the one above. If
you think the generic level could be applied to the PCI sysfs level
that is perhaps a different suggestion.

> That sounds worth exploring, although I really don't know anything
> about the unusual multi-function model of some of these devices.
> And the /sys/class/bluetooth/hci<index>/reset attribute already exists
> and probably couldn't be removed.

Yeah, I suggested just treating the parameter as generic levels, so we
don't define its domain and leave it for each driver to decide how to
interpret it. The sysfs entry is not transport-specific (pci, usb,
uart), so using pci terminology in the documentation may lead to the
assumption that it is PCI-specific when it is not.

--=20
Luiz Augusto von Dentz
