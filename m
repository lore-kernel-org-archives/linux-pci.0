Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C73F870C
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621793; cv=none; b=J+DtB/5w23fedM/eJJK9Cq02dsgJZwf3Y/vY5EZvyCFn1Chb+Mt/VpK27CxTpSUzrtXCdIKrlhR5sRv+uNcb2Qx1rXgug4DeatrGGFra5Be5fONPhXR33euDgCdZz3vyomRCjFInAmwrqJSDkPNlBW3IRfwpOmFLni+NoPepL8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621793; c=relaxed/simple;
	bh=n7rrWwU0s9ggul7JuiFbx+85HACZBLjrWg3YZUUQI4M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTb3cp6ZGNksgKJCc3ZtocHQuxcpgTUzpTlMt/INwilcXIxC2MLZaaChmMqqOri0CXxsJPQl7snrxUCZf7TkQo2sT9gzCKXMfoOeyiI/4EUCYXhoB46yaXmhwcF/gVgE7cOF97t4XreZUnvlORqnF6GGHSl56cnXTbgEgqBG9h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGwHOVMr; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGwHOVMr"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff72474fso11201145e9.3
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 11:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621788; x=1791226588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UlGFsX/Ls46WgCFLV1KYmW3Gnb4dDClBQv1c5lbc9ow=;
        b=FGwHOVMrY0LNjRNgnB8Y41Iicam17g4Em7db71S7O8ZIAyNEwVT78P+a6utI9g1DhC
         E/SXuucY3LJWPpVPxtbkN81NqbrCwz+08eAFPS0hHhe+1ZMhbfUX+zGf3U1zs78VkCTp
         tXSyhvp/bmlcpQ91+V1fA8YIaSJIdgEyASClk/lnfslrZVBnVQx45LmhIWwmA84iflLG
         GC4/bv/QgeU4Yt6FES1Uv6DpDtdqy5wa2CkkV52YQgjMdxp5up/2/y1EOTGe6XgsHbW6
         3K6+pRv4W4ve+ZIR+unK1Kth3sH7GlTgjY9Cs+S/Dfgrpj0iKue56pwKsOM6gvhSDULI
         BaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621788; x=1791226588;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UlGFsX/Ls46WgCFLV1KYmW3Gnb4dDClBQv1c5lbc9ow=;
        b=Tq8ciC16/zI9KEakISKGMdaHxWia3ITB1+FxKAXT6HYyhJfB/TUT1vGD8JcfDWrQ0t
         Wc8Yopl/uQLplF0cGTXJKNwMb9nuLCYPl8POZV4rLO/V9psRZyqmkKwQfvX6r9KaUh25
         t1jSWiMMySI32koCw9jDUz/FMB1XnByHQXmtehBaRJU6G8wbcRR47m1hFXSC1vKHqYRe
         dKngBVsyRHZ55wZjJ7Q6HO0nNlfhcHJOUzO9crQEto28JDz5M4E4qkS0fnk3YDQh8OWE
         jahpwRrYl4LDwdnl70w7/MtgouhSC169t9uDVfYcuT6oilGqiibhu2EU+TqpKGCXoWzN
         XMXw==
X-Forwarded-Encrypted: i=1; AKwUvBxLq1X6+JU9dyzFf2JKQDVpC8ATLojBcTuSp32SeRLSg2RQF9M5RF7B/IqQBbnxY6dvzPOl5jEQo6A=@vger.kernel.org
X-Gm-Message-State: AFuF++nd5nwAHa7GA8VZNGVaX9xaeP/ndnAPV4YK7m8XSCjAibm9hLc4
	7g9wMlyjpVFp/dLqWBP6kqX7lHcjEXQJpwdNfAtkbzc2Tvf0p3X6oJGp
X-Gm-Gg: AYBFou0tVXt1Hccal/yXW5BPMU/6taAFR1oNVQo0gyPnp6uhxpuQC49PfqHIog5lILt
	iQE7n5ZRkAKrGAuDodf7YFmTI7T9YCcHzcgWt/OlVf5oY4LubuMwdlwenZ0v7C+WfQMfnNYAKnE
	g9S/96vHHoVqfsVNU6jnEADqbCFAjzXN77hGJ2xg7mNysX+n7LxoDirHfCxWZKP7TVhA1W++3h4
	xITQR6N3RQ8UkbV3uPF/+ApKCbVMGsCqLtM8H8klP1P6h2ILqTNnlA9xFrnjbDPFWW1CUK9KQ0N
	NQDPCNIA1YE7gtxo05IpZ4FmUiMbE3BK0rgEOE8f7TVYJFZShm5Hx4nerMM8tEVK4H0Bes9HNbc
	OPE3TOe6+VG9mFK5yGJl41xM1HMMgyyCqP5Fny0CbIy2VNGa9m6K0hLgJ2KymuocKBIGd+2qC0R
	W3hV04U+wWkqpGHlk0N2279AP2dpcpFz44HvufSO9dr48AokonDUDfbz4JwEqi4ygu0U6RIX6Y9
	15nKkxvVBjfU5v4LUOfOnCuN4y+Su0Ny5M=
X-Received: by 2002:a05:600c:3b98:b0:49f:ce78:3564 with SMTP id 5b1f17b1804b1-49fe66f187cmr271554715e9.21.1790621788116;
        Mon, 28 Sep 2026 11:56:28 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00d0f66cfsm12682225e9.14.2026.09.28.11.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:56:27 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:56:26 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Maciej Grochowski <Maciej.Grochowski@sony.com>,
 Nikolas Joshua Britton <nbritton@exabit.io>, Geramy Loveless
 <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>, Alexey Fomenko
 <alexey.fomenko@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo
 Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
 linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] PCI/quirks: Avoid certain BAR 0 address with igb
Message-ID: <20260928195626.1e878a20@pumpkin>
In-Reply-To: <77f7d79b-d3fb-0576-0b6d-eef4efd8d634@linux.intel.com>
References: <20260924202056.GA2001522@bhelgaas>
	<447e3daa-c8a5-2b0c-2c6d-3f3eb92e94cc@linux.intel.com>
	<20260928141936.2539ad5f@pumpkin>
	<77f7d79b-d3fb-0576-0b6d-eef4efd8d634@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Sep 2026 17:30:41 +0300 (EEST)
Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Mon, 28 Sep 2026, David Laight wrote:
>=20
> > On Mon, 28 Sep 2026 15:20:13 +0300 (EEST)
> > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> >  =20
> > > On Thu, 24 Sep 2026, Bjorn Helgaas wrote:
> > >  =20
> > > > [+cc Rafael, ACPI resource question]
> > > >=20
> > > > On Wed, Sep 23, 2026 at 04:17:55PM +0300, Ilpo J=C3=A4rvinen wrote:=
   =20
> > > > > While testing the resource placement changes, my tests hit a case=
 where
> > > > > igb fails to probe when BAR 0 is placed at 0x9c000000:
> > > > >=20
> > > > >    90000000-9cffffff : PCI Bus 0000:a0
> > > > >   -  90000000-902fffff : PCI Bus 0000:a1
> > > > >   -    90000000-900fffff : 0000:a1:00.0
> > > > >   -      90000000-900fffff : igb
> > > > >   -    90100000-901fffff : 0000:a1:00.0
> > > > >   -    90200000-90203fff : 0000:a1:00.0
> > > > >   -      90200000-90203fff : igb
> > > > >   +  9be00000-9c0fffff : PCI Bus 0000:a1 =20
> >=20
> > Is that valid?
> > I'm no expect but I wouldn't expect an address range to cross a power o=
f 2 boundary. =20
>=20
> Hi,
>=20
> Bridge windows are defined by a base/limit pair, both with 1M granularity=
.=20
> There's nothing that disallows a bridge window crossing a power of 2=20
> boundary in the spec (AFAIK).
>=20
> Note that after this quirk is applied reshuffling the device BAR=20
> resources, the same crossing is still there and the device works.
>=20
> Perhaps you mixed this up with BAR resources that indeed must to be=20
> naturally aligned.
>=20

I did say I wasn't an expert :-)
The PCIe book I've got is just over 20 years old (only 1000 pages).
I know rather more about the TLPs - we had a problem with some fpga logic
that didn't like getting two completions for a single read.

But it would be consistent with something 'not liking' BAR0 being at
9bxxxxxx and BAR1 at 9cxxxxxx.

David


