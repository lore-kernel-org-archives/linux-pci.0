Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794334909;
	b=31S9I57Rdj3HHrRI5mrdDSQSoAPolINuy5TV/vNnmBePbaUTU/jX0Cadj3Z6ywl5dVtx
	 e43moEjuW/0e5L3oLJobCZfn3IFyh0wbxf0oCaVhOBFjAKIX3z3lcYxoLM/8WGAbrrrp5
	 lGH3PA31Xg8xId+turE36gRABFe/NU+jLHxRLjvrHiJIUm/W8DFSdAMDcqG2TVy8RLjGD
	 F85W102dlcAV9nQ3SmZp+f7ae08GpayqZVS45V/A2dn4AGWkxnkvK07PabyRkyKU3j0jg
	 VzsIxh76f0WM8rg/GASTrC81w+h1Ft7CXqmM09sO9DGUPdrFdTL7czBMHEJcXJmQfKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334909;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KkrLPYmWHC65m+X7h2ibulaxDmjHUX/XoIkIgUVS8Ng=;
	b=JVLGJECIDI53888S4KSkX72H+7Q1iA07awDBsQUKNrExXU5MsiRTkMNTCpI1scdQE1C7
	 dyE4h2XLpt5L2gl9gH/Iy4f1kNRaLRr2oedbOz5dhUZf9UleSfucAeFzIhQrsVxyHoEQq
	 nI8dAcu6+gZ26ad5OTCF8uv2kaQfHDevHXajF1C/g0AfB81Ly/bNRo4Bpkc7E6585wW0n
	 t05dIHVjw9XMyZdNdZ579ldMaALohdSyKpXs3Ix7VV6lqQXBfIYFn9ks8KtjLitleaXaE
	 OWRlHT6stDjcAWZndNXfTygo96EuOEFQ6FkQ+1Nhqnab6zSmUmnAiMXus4WtPodMHwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oLderkLY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC7F60A2604
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 18:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EC7F60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oLderkLY
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6767d92cde6so2654450d50.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 10:21:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794334908; cv=none;
        d=google.com; s=arc-20260327;
        b=nkngMbQfhsSJER62VE8z1VZXUFi8n+hdBP+WKM73M6d66cR3lhmUFXUN8oSuQAQV2c
         gJQXhSDwsvu1b5e59u6xnM7UIDDG1ZC+kwrLn8ZKDXwuuVoJ+YyyQlHLD56Yfq42m/2i
         uEwPdX1oRFSFGm9DnGOYR1A+nMsE9JQGMkRCg+FNUJ1HmgYtMk+TzSgAHBBwh2r3jpmY
         sieMBSJ8BpiiC5kKGyjpU7Pu49E8AU64pNw57Hgc7NiLA1MhYTB5F1uEhN+EKHKwtL3k
         Z4CeVr/d1oZpuPGpOBlX7SMYF9fzNHmH6wYFhNzS9B9v5h9ZKxUe/ZDuerxU0ouHWhnu
         MUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KkrLPYmWHC65m+X7h2ibulaxDmjHUX/XoIkIgUVS8Ng=;
        fh=OMm0m1UDjcMYH+yBXP8q/F/YyM0yyAksvKdDQfjmFdw=;
        b=cA1ZknGuCyHWEvoGULleYuxYovndVmQ7QFCH3wQ6lsjgYO3HENI7713Nj8CRj2nHWZ
         lOgd/39RSU5P4IqQOSWVWOLx8x66Q5ITYZqPfH/xnd/5REhWvH/wO/RiIVNFHDTCMlg1
         +zA4wGmP1aHb9NWq7KsyvwE5/zuJm5xnx4FgmIQEfsLlkcYj6QH4Q20JrNNF6L9pNwdR
         cVFofb9YtM+CGz0ZOT8kiMt+P1r0V6Sx0TDnDs2HkUYVu3NOHVg7wIWOQLDEuslCmBmF
         aDYlk2oiRxH4I0sqaZkHazKZPDZZDcTmAVmUuhkJ28mlBvkRJkE8piP+8VlK+Bu2J/9G
         RREA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794334908; x=1794939708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KkrLPYmWHC65m+X7h2ibulaxDmjHUX/XoIkIgUVS8Ng=;
        b=oLderkLYcEHCbi7yY3JjZ7h9pvZK3k30YegFifhZRqRIAOLdTLhCHoXdpFEkUAVxh0
         DXkg0ASYrOUFYhj+5C2RNqfSvPnf31jErlZwU5fCqEwxK6r6tETOgKciACZB+YJJjzfj
         oV3n0Tr74DDtT4rqcpzhYLgJpzGb4BJsOUQslqdRytugGP2duQtNq9Ohh6+SGrw0GRpK
         wgn1DSayDUJpHZeccfrDSb14EEmI75TLN1Fvs4vfeoyjPhF3nKmO17b+2qnqN5d8/RGD
         w4RjgSGSNGjplTFlfF1W9OL9VaxHehmfu5ml9EVLewSthlvCZml5ZyUPdh+ErRmqQ970
         W0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794334908; x=1794939708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KkrLPYmWHC65m+X7h2ibulaxDmjHUX/XoIkIgUVS8Ng=;
        b=X6PpxPrwpBQmQKfi7NunP+wcprDP7/hX4FRf06e8IJ3sikQY9dJFyjqS+v/Bf8lu54
         NbPXVDBaD3cqk2NKdxEmluPhUHou4Hujn0AxQxz43C9sOjRk4LX954ejaEYbb6eNa7VM
         hjT0t1EmdIA4+3or/bDARmyusTFvhWyBEhTZXHoSshlzWYTeBDhWYhswAg+wSMDAra2Q
         YScANwCkn/S+aHDyWknHtHwr5hs+fwL9XHjMZ6rGH/2NRi5hs9vs6O3Z/SMRzFvi9Qby
         O+oHrR5E4YiVQxSPHCMNPKb9kWWkQW84csQiOVioN4mKNWvK0DvJYoGNYPzUDSuO3JHr
         Xg6A==
X-Forwarded-Encrypted: i=1; AL+hErGvHD054kUmK+8+/0kMbfsDb4Fzv+fI7B+bgYcERCFVbZZa/2dTTEyLV56/wnA0CtPeZf7TEV4xl6E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OflGLpaIynXIn6LVGM1UMl9CAXE1xJZkOyDS0DbzepfDwvTgN
	P5kXvDAjarAHRxrYg2/Pm5akZSM9lNIXGoC74XC5/KknTGS8FiuM+hcrwW1y4XWqqU3HfviRwpc
	EJXXJhzQXbTaXgfwd8c8T/3K11wEfknY=
X-Gm-Gg: AYBFou3uqdCTBVzgWXMjTNLMRdEGg0a7rg4PndKTjcAZwXoAgXulF5Gxw5CXjfuTNSo
	zCd+austcRayaH5YlK3xOQnCfxC/RpAxIYPETdydk63fkDYTjuYjnOU/VXJiHvZk/x70N3lNSoZ
	wHiPSbQl6a2E9/CMynk1+xWhwLH6wcvqiTH7sC8Od2wJ1CKywkJFRqJKroohtbn7gL6SwmQ73s+
	fREB/6KgTAxkai7/RnwQGBZ1ha2imzDe2wnwiWaSkdB88BYRKjjiSo1+Vs97v0421kgndJoSTFs
	aPOJTUxnYgUyTLEiY+ca+jvX7Oc9GZO+L3xFKsivfJsnXf5YZuOdNGDdZ/O4dlQMMuWN7X4df8r
	Ct2ckA8/3ZlocvapeSdCX2CsWO6FKHAGVYxP99/DnmcUJr1h2YeZ/91WIFbZLsy2ATewh
X-Received: by 2002:a05:690e:4594:10b0:67c:7c1:bda4 with SMTP id
 956f58d0204a3-67c67cb9d9dmr70993d50.10.1794334908283; Tue, 10 Nov 2026
 10:21:48 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109-r730-disabled-rom-fail-head-v1-1-88ef813d125e@gmail.com> <7b7f0266-693d-7a9e-88f6-e3c60ec5c3fa@linux.intel.com>
In-Reply-To: <7b7f0266-693d-7a9e-88f6-e3c60ec5c3fa@linux.intel.com>
From: Kameron Markham <kameron.markham@gmail.com>
Date: Tue, 10 Nov 2026 10:21:37 -0800
X-Gm-Features: AclHuK_aO1WoLf_mc6s3Q_9KJC6d4UFmp61bf8g8NhbTYYKqft1g36X2w17Wz5Q
Message-ID: <CACpBZmUoSU8Emvego8sEce5AbB4+48yMLbs=E-5HKMh=65Zq=A@mail.gmail.com>
Subject: Re: [PATCH] PCI: Don't add failed disabled ROM BARs to fail_head
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-pci@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Nov 2026, Ilpo J=C3=A4rvinen wrote:

> So all resources that were assigned prior to starting were assigned
> succesfully? Which would mean there was nothing wrong with the fail_list =
&
> ROM resource handling.
[...]
> This might be more a quirk territory if the resources were assigned just
> fine but some device fails / crashes when given a valid address for its
> BAR(s).

Thanks for the review. You were right, so please drop this patch. I went
back and captured the end state, and it is quirk territory: the final
assignment is valid as far as anything the OS can see, but the address
it picks for the I350 is already decoded by a PCH function that the BIOS
hides.

Dell R730, BIOS 2.19.0, SR-IOV Global disabled, v6.17:

- With igb blocked (initcall_blacklist=3Digb_init_module) the machine
  stays up. After "No. 2 try", the bridge windows and BARs read back from
  config space match the kernel's resources exactly, e.g. 00:1c.4 (PCH
  root port [8086:8d18]) window [mem 0x92200000-0x924fffff], I350
  07:00.0 BAR 0 at 0x92200000 with memory decode enabled.

- A single 32-bit read of 07:00.0 BAR 0 + 8, without any driver, resets
  the platform. The iDRAC logs the same ME error and CPU IERR as when
  igb probes.

- With pci=3Drealloc=3Doff (firmware layout) and only 00:1c.4 and the I350
  moved by hand: at 0xa0000000 the I350 reads back fine (STATUS
  0x0028038f); at 0x92200000 the same read resets the platform.

- In the firmware layout nothing visible owns 0x92200000, yet reading it
  returns data instead of ~0. Exactly 0x92200000-0x92200fff decodes
  (0x92201000 onwards reads ~0), and the contents match the PCH thermal
  reporting registers as laid out in intel_pch_thermal.c: TEMP 0xa0
  (30C), TSC 0x80, TSEL 0x81, TSREL 0x01, TSMIC 0x80, CTT 0x12c (100C).

- The thermal function (00:1f.6 on C610/Wellsburg) is hidden: it isn't
  enumerated, and conf1 reads find no device at 00:1f.6 while 00:1f.0
  [8086:8d44] and 00:16.0 [8086:8d3a] answer. Its BAR keeps decoding.
  Neither the DSDT/SSDTs nor e820 mention the range.

- Its address follows the firmware layout: it is on the first 1 MB
  boundary after the last firmware-assigned MMIO below 4G, i.e.
  0x92200000 with SR-IOV Global disabled and 0x92600000 with it enabled.
  A fixed per-DMI range would therefore be wrong.

- Stock v6.17 with igb enabled plus memmap=3D4K$0x92200000 boots
  normally. The second pass still runs and places 00:1c.4's window at
  [mem 0x92300000-0x925fffff], and igb comes up.

Before v6.15 these bridge windows were never moved, so the overlap never
happened.

So the fix I have in mind is a quirk that reserves the hidden thermal
BAR before resources are assigned. What I don't know is how to find it
properly: with the function hidden, its BAR can't be read through normal
config space. Is there a supported way to unhide D31:F6 temporarily on
C610/X99, similar to what drivers/platform/x86/p2sb.c does for P2SB on
newer PCHs? Or would you prefer a different approach? I'm happy to write
and test whichever you think is right, and I can run any test you want
on the machine.

As this is a regression from v6.14, for tracking:

#regzbot introduced: 96336ec70264
#regzbot title: PCI: Dell R730 resets after realloc moves the I350
window over the BIOS-hidden PCH thermal BAR

The serial logs, register dumps and test scripts will go to
https://bugzilla.kernel.org/show_bug.cgi?id=3D222253 once bugzilla is
back.

--=20
Kameron

The investigation and these tests were done with the help of an AI
coding assistant (Claude, by Anthropic); I ran them on the hardware and
checked the results.
