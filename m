Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1036225417
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 10:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951877; cv=pass; b=WH4oa202GNvGhdM5btNcnVKFh0E2lCxJvV0adebcw1aqtNaC8Ilp8ZOqUNZnYqXMHs77heScTuef7sOt5KVHQOxs0cmzdXwDFFwMFx+BtxN9K41DgqfSxMXqQGiOHBu+QfP3i971cPCt647Bi+UAQJXMLQXESBdN9aFkrQjyhns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951877; c=relaxed/simple;
	bh=BuB9OAdchbjZ2fJnCBi8+LXdUDK8kDhBZoLPIaO+/7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgWuRjkooqnwOD+k/JChz0mquhlDe3G5hTUooqLRfcpxAB4AAOgvE0ZiBHDzTx3sDooWhxVnAhydR6A19hSgqZs2vBT2TA7pl2OTL6naIu/d5WmFzBmRsE/n8a5V2Ap+saYSVlHfQLPzTHsjuTnvnV/ejNkgDHgTtSbpOQwAeng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLPAX4bZ; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLPAX4bZ"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c6f5574d07so49786eec.0
        for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 03:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774951875; cv=none;
        d=google.com; s=arc-20240605;
        b=jcnWMp2ErQvbfbsoEHjFZ4Epk0+gb1YYUzWkdl9llClyZVDuRGHxPFSMu2wWtrVnw6
         HfwnpqTU6Aw++hDWR7TUv5eBjlGdqkx33c6KveJaOPfZHiCZ149HD8UU1U7NJ7fT8liA
         JslhLdh3HnuYgag4H1cOj9hg8k6f5jzeDQLSZCMsp6SAxWZfpj9c5wmJTQUlLVN/6tp0
         1UO72fE5bl6GSq4hDYri91qTksvByGVMJeyk4clGs2GNhHuCwncdPyQouREGySU+InSn
         AUW3xSWziaSh747fSvvBSgFbuhzOpaUuajWw4fJluE+DXALx57Ok3Wih63B17AMyW1JE
         sFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BuB9OAdchbjZ2fJnCBi8+LXdUDK8kDhBZoLPIaO+/7o=;
        fh=G274MwQLyAvQZx8zDE4GGgwNzOLp5u0HR1kiWJWkiwI=;
        b=eunx3k3rWCRyUzZ0Xxb5swThESTRPGMn21cPvZ1wW0n/JXpaD2IRnKsGV8Gk2Q96Bx
         AyqGH/QpMAPBQeD5npeEasqVlZdpo43ekcnECnnLirSMjJ/DCWMxR8wcgc2QqAseCCJ2
         dnYGhppYjKiEkUtEP4pPsIjfr/RQq4t6RT1OWuJNF+p/MtQi40nOhTCGcGQ2vwHdEX3e
         CRNAyRGKxkkpoc0mTIcAKbmHJtd0PpB1U4+emR7NQIWJS74Bw++2H8cRq5e0Oum94rVh
         7eFjHcrnZg5++QdbFvOhTQtMRD3V5enrkKdypb7j+xshtMYrwNr7s4S5evsBk/Reqcx9
         AjpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774951875; x=1775556675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuB9OAdchbjZ2fJnCBi8+LXdUDK8kDhBZoLPIaO+/7o=;
        b=gLPAX4bZLbFDe3BIjvh5WgrKtT0qiVHFwz77EYihWbT+/wS88EkaOi/k9qahFqDuuy
         +/lG8jZqDIRN1FLDJKrp3gwNmxeI/YuhDW3ZDQEaqGHNnZC+rV5xPMfXl1ERodmAPrmt
         wzXyZKtRY4IibVuRmGYKAFbGKxSVYVo/3DfCA/rPYisZPFgB6A0AbpmUvjO6+teO32zK
         91vhUc4uH5zxJP+vtaudDq5bRBG0CRsHV085wicgYmOi+R1AuBBxT34kRcVgkpCown1V
         psxK+v/3/BDxFMMpsuPhfVW/WDNsp8Z0SQIFg9vyc/VeeiVfNv/fOv29JbZen0cNP7xO
         3iEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774951875; x=1775556675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BuB9OAdchbjZ2fJnCBi8+LXdUDK8kDhBZoLPIaO+/7o=;
        b=AHxDaVHF6khBqvSeX3rz+2oM2d6SRpsWqlfIz7gclG7lz7JBN/zs6SMHYVZTW4mMuk
         nzGhEm8QS+u/R6pvF1fxlC/eeYBDq0Z5UEN6rh2EUNgQCkm9lhfRFi+yuzrPswedg9gm
         HsIVlw1Hm0v4fOZX4dJjHD9wTJTjLWcoTMgGs9PkjZVng8yoBBUtKD63jrT65oZyhpr1
         DyPMXHzM7Kb2GyHlrP8Xbn6dtj27RuK/dCismEHQA1rBNCO670tNRpl4Iva6W3cObhIH
         SRVlS/69diFG/x67mSaJm2Mnb+pcjuBzcdBFdc43C93lKABgFu0kc389r4eoMyiAlHLk
         5dwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnX8jkvMUoELFG+Fw6kAhA6KF1zgTDtuRuICDij7euAhCAOXdJ4qbHUn68tDlmecAQcevx3LC+rBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygfBJnL5NPYQmZZLEoUVPMizvwqZ7rg/C1gi9cZRdYak2JMkRO
	RqN5YU1M9POilCItfAtOqNZ08UweMGc4Yx9BX272OXmUVdfW450CeWyh1dvu/ml+6n7aSn9rTId
	SzzztFo4EZTDvVKxC3hbekWwmqg+OIZQ=
X-Gm-Gg: ATEYQzy1SoSF5/oySBWfF/FzBNHF5GbHH/TrUWdF2aXLGNIjcqMkgobZunuPYvGFGnF
	Juvsn5RfsRCCBVcqAtlTSoRX/81aNsLIFZ1n6BGii4VtwgyXoam0PeVMVVORGVh3EHvjlVLcoId
	TPhDVQ7fVGqtkjoQJT8XFoH6qgbb9AaYT5aw9s7o5ZNJMIVW3JzPoG63kDjpCH7L2OwDaL0CIU4
	DNntkqBs5XirASXpEqp5G4MJhX9NrV42m73sreZLn1nKZ+jsWOSMYE4plUIeA5THbaPAha0duYr
	W2r9Jbbfgl0d6ZXQNrNTqEeLFUCK7J8061gGVT9KOZo3bFozaJictb7bU9/v+Mb/xosClR6oOeZ
	CGq5myprAot/wIEIyF8OmM30=
X-Received: by 2002:a05:693c:3008:b0:2be:298c:a11 with SMTP id
 5a478bee46e88-2c185edf989mr4029939eec.3.1774951874996; Tue, 31 Mar 2026
 03:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-23-alistair.francis@wdc.com> <20260303150040.00007458@huawei.com>
 <CAKmqyKM6CBucDEo0aKZVWrKtozbT_ddk0PaZFtHyEMMMx558JA@mail.gmail.com>
In-Reply-To: <CAKmqyKM6CBucDEo0aKZVWrKtozbT_ddk0PaZFtHyEMMMx558JA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 31 Mar 2026 12:11:02 +0200
X-Gm-Features: AQROBzDcDwr7GVEqtGjVwGa12fqkwc3LQ0Ho8hFkYoop4Cj9bvScGclhoV9SimU
Message-ID: <CANiq72nOt1E8=GYdh2T5BWNvG7J8sZRF+60taghoxKm8fkadHg@mail.gmail.com>
Subject: Re: [RFC v3 22/27] lib: rspdm: Support SPDM certificate validation
To: Alistair Francis <alistair23@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, bhelgaas@google.com, lukas@wunner.de, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	wilfred.mallawa@wdc.com, aliceryhl@google.com, 
	Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 5:30=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> Yep, same thing. My way is the Rust-y way to do it

Hmm... In what way? I would say it is the other way around.

Clippy should be flagging this, too.

Cheers,
Miguel
