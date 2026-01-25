Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584CB30C617
	for <linux-pci@vger.kernel.org>; Sun, 25 Jan 2026 21:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769377301; cv=pass; b=PY3w3Jda34CxC0X1bBGKsDfV89ptjnsBPyhbSSJ9duKwI/Iu6ja4lcTpEAS1xLCT+8W6Z9qlHFrQiAkjVFV+OasW5OOA62R09iMbuEPE5US+iZClJl7LnAgZYs5UaOsezmrkhwLs2F3Tie6Eq0nPbB90oC+TjpUe5cWgj/bSXNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769377301; c=relaxed/simple;
	bh=CUJyJdkPJFr+qzK/2iHOhlqvG4D2dajcsiQFu5TyavI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggKbaVcr1JtRz24ShP21NomU/FYneLHMQs9OcTNdEVyX8m5tfPOLnJTlRleSbaAY5R1R3nEWiExwSunkAnB9iPvjAixWgYt5EfpICBOa/h18H+X0ueKjmVO95o9IPyex9sxoXB+TN85l5m07V73/d7hfSyROiOKdBCCrMiy99kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oz+GZocd; arc=pass smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz+GZocd"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8c655e0ee70so515318085a.3
        for <linux-pci@vger.kernel.org>; Sun, 25 Jan 2026 13:41:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769377299; cv=none;
        d=google.com; s=arc-20240605;
        b=JzBXigx4vTD5PhYyk7OJtW13+BeU8aYGawsWrTsV/7oxXpbGeeiLCpAUvJoqmmfWuU
         L1sfLhOH/jrHlqRKdyCMGpSnyNDVA8qAZaTGnh8/4G8lV0WGpjEyH7T4esZ2XgOT/MtN
         x0m4bfSq0DlDcowGr4pq4CvX7BJ79e8ZmV3GGvCihKyicWO4f2SiKrl/nbq1oNUU86Qf
         01eu/QXGx64qbUl5oV3+sANPuV+x8OYB6ACF4RWVfPUihMvh6OX4Wv1Irlops9WRNDtr
         zOrd/TPhD9GpZXU8LhhCsGw1OSfXUr6I+Bge16Ziy+3ohHUUTUXWfYe1VL+0tsXhs6zc
         oChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GghexN9v9Tl4rIdwgV34PPZYEF7bLOxK+iXkN8X340s=;
        fh=YMf4z+pXuuChzBOHAb+tLbIYfq8cLhS2s73uDHBuB8k=;
        b=Wba+EzaJEyOO1illb4gxCeW3A8cNqG5gsQT97Y947udHaDCH6PdkvtTcCclCmlOUK+
         rCqJI8DMCnUKqLpQtgK3xwKq5xu28SO/Xl61FfPeVYn0dZlZHaLD/3OBEmIfY9oby+Kq
         cjhclRKkKOQLeVfoug7ldob8T5nPWoKi0t2cjr6qzQVq5YsVAyzAH9QyGBqwQhVnvROq
         FtmXLxcWAVKd32fzGHFTJebfkuJafPcgsGc/3Lv10LiX/MTFoqIvfvJ89MZJt0Or28Tx
         nlZpiazwFGQGCWAQiix63B2F0jZpi27KySwqKiDtAaqaNicW4L4qVbt7WZAgoHtGggA0
         V+pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769377299; x=1769982099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GghexN9v9Tl4rIdwgV34PPZYEF7bLOxK+iXkN8X340s=;
        b=Oz+GZocdZ0Wkk/cWMts6zOjcPWNmBO5xBBM9MOAwkiL1mH2ctv6qa3qtIHxXnWvYGX
         lQ8OnZnlMGYjJWA90QJKpFuAT9rw0GsMa/WUTGhmu6yE1E7H5Slv20GaS8ZnQoWHupMD
         JQWUO/HXy06Zdxxm4VymK/bnQQsX3W31TIrldyq3srQz8pcdu9gej0eBM/oYu7O941U9
         Hpw+b0tUh1Ihin3b+KxVEx+kMfe0SDAiBHI5uoylKZc8kg/422lkrzxP+TI1CuawY5wc
         bAmf2xAGtxK868EgTSD8ppKj58OMWiWUHHYDJy+gbkNbS2lScgllC9xF9IVK792LJo2q
         6ZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769377299; x=1769982099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GghexN9v9Tl4rIdwgV34PPZYEF7bLOxK+iXkN8X340s=;
        b=jzpNAPlrQtDcXXEsUhMsjtY7Gg+ax3VLYuoxd+43yQhGKJfdyekgfakqGJVNLHS1gU
         eCEShwc6w/Ba1F07m8i23o3x6Qk8qS0o2eB3/2q8MWPDqG8QGXFVmqomBmx+mtKLfpEp
         /G6xTpXacR+Fw2qj/Wo7rSXxfNrkJi0lzN25FUz+29Bf5KKHRfGLzP3E2+DCLNG2QUGO
         W26y8MJG6h0wFhhQLXLSg85waeZmDxVK8QFHji1zIlgdr0UpmXyiUCSSe4qRO80MtQPM
         5nOm2oEe4yvidsqwAr48E2IHsS2lt2GFK8Qqi6g5gAzVnsWNapM5y00BsZdPwEhGcuUz
         I3zg==
X-Forwarded-Encrypted: i=1; AJvYcCWvuGlAykjk46mIJ3wUI+wa1hhS7XBnLbaVs0pR14GEVTNFe6vHoxwFwiZRu7eTjUG12gt1+yeLuac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0MLYB8o7TMQ5fpIrep1/5OnePTskdbUKoJHxE4mWBIgvfk+Jp
	I+1s5nWBk2pLwlhe1ycnlW8FSv+x3QHW8htCmQNuO1FYtvvSC/MurhgiGjrha2LwoGr+qoLDL9Z
	GqnRmYUgIIBwYmO6IehJuZplujYytajA=
X-Gm-Gg: AZuq6aIiP2/h9lgMO3/R8wEyDJzcs81aPsGoeWIU+yc5ALsfkOdfhwsKPLDHmBTG1Us
	IQvFmNeJpRUGtuLvY3xOOPrcuqN74iTmvSyNs3QhgB+lWqDuSko/VaZylKODPcNWfvXMLK1YfCl
	398UlTlQKardg6VCljm+uL+fs05qB6+tG3L8NUzZQP4Z4zx/RZ85QfUqLHTVbXt8K+iTm+h+zVy
	Z4gNbQZy0yLI2UI6rKY4H1hnK4ZD1SnvAZE5idkqV7PV6tdScKfU72o0w64puHlxpXne//XQlNz
	nDaxrqgsFXAT/LJsWPklB3Bnt9QJ3uv5anjLU4a/OHkUQqPoPXfTJl5M3Pbv
X-Received: by 2002:a05:620a:172a:b0:8c6:ac96:f5e5 with SMTP id
 af79cd13be357-8c6f96e6cdemr280705485a.83.1769377299320; Sun, 25 Jan 2026
 13:41:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADkSEUjyXH74izTrsfhdAjh=n-jnGx=tXbqPx86M9OYqjXj0PA@mail.gmail.com>
 <20260125181125.GA209392@bhelgaas>
In-Reply-To: <20260125181125.GA209392@bhelgaas>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sun, 25 Jan 2026 13:41:28 -0800
X-Gm-Features: AZwV_QjfdD5BNg849bWJiQdew-9LUzyZdNbSnd1c07lERk8YVDkD-hDCRqejbYg
Message-ID: <CADkSEUiwQTq=175VZ7Trm4Mf2o7_ckcAkPouoawC5s4oumdcdQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethernet: neterion: s2io: remove unused driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Jon Mason <jdmason@kudzu.us>, Jonathan Corbet <corbet@lwn.net>, 
	Linas Vepstas <linasvepstas@gmail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Danilo Krummrich <dakr@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	=?UTF-8?Q?Martin_Kepplinger=2DNovakovi=C4=87?= <martink@posteo.de>, 
	Pavel Machek <pavel@ucw.cz>, MD Danish Anwar <danishanwar@ti.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Huacai Chen <chenhuacai@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, Takashi Iwai <tiwai@suse.de>, 
	Eric Biggers <ebiggers@google.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>, 
	Ard Biesheuvel <ardb@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Dong Yibo <dong100@mucse.com>, 
	Lukas Bulwahn <lukas.bulwahn@redhat.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 25, 2026 at 10:11=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
> What is the value in removing the IDs?
>
> The values can never be reused for new hardware, so removal doesn't
> make room for anything in the future.  Unlike the removal of driver
> code, removing the IDs doesn't reduce complexity or improve
> readability or maintainability.

Understood. I'll send an updated patch which retains the device IDs.
